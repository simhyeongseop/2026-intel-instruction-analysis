/* 재심 전용 고정 실험. 임의 사용자 입력은 실행하지 않는다. Linux x86-64. */
#define _GNU_SOURCE
#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <unistd.h>

static int fault_pipe;
struct fault { int signal, code; uintptr_t address; };
static void handler(int signal, siginfo_t *info, void *context) {
    (void)context;
    struct fault record = {signal, info->si_code, (uintptr_t)info->si_addr};
    ssize_t count = write(fault_pipe, &record, sizeof record);
    (void)count;
    _exit(128 + signal);
}

static int memory_case(int kind, int distance) {
    long size = sysconf(_SC_PAGESIZE);
    if (size <= 0) return 1;
    unsigned char *base = mmap(NULL, (size_t)size * 2, PROT_READ | PROT_WRITE,
                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (base == MAP_FAILED || mprotect(base + size, (size_t)size, PROT_NONE)) return 1;
    int channels[2];
    if (pipe(channels)) return 1;
    pid_t child = fork();
    if (child < 0) return 1;
    if (!child) {
        close(channels[0]); fault_pipe = channels[1];
        struct sigaction action = {0};
        action.sa_sigaction = handler; action.sa_flags = SA_SIGINFO;
        sigemptyset(&action.sa_mask);
        sigaction(SIGSEGV, &action, NULL); sigaction(SIGBUS, &action, NULL);
        sigaction(SIGILL, &action, NULL);
        alarm(2);
        const void *ptr = base + size - distance;
        /* rdi 주소에서 DS에 null selector 로드. child에서만 DS를 변경. */
        switch (kind) {
        case 0: __asm__ volatile (".byte 0x8e,0x1f" : : "D"(ptr) : "memory"); break;
        case 1: __asm__ volatile (".byte 0x66,0x8e,0x1f" : : "D"(ptr) : "memory"); break;
        case 2: __asm__ volatile (".byte 0x48,0x8e,0x1f" : : "D"(ptr) : "memory"); break;
        case 3: __asm__ volatile ("movq (%%rdi), %%rax" : : "D"(ptr) : "rax", "memory"); break;
        }
        _exit(0);
    }
    close(channels[1]);
    int status;
    if (waitpid(child, &status, 0) < 0) return 1;
    struct fault record = {0};
    ssize_t count = read(channels[0], &record, sizeof record);
    close(channels[0]);
    int exit_status = WIFEXITED(status) ? WEXITSTATUS(status) : 128 + WTERMSIG(status);
    int expected_fault = distance < (kind == 3 ? 8 : 2);
    int at_guard = count == sizeof record && record.address == (uintptr_t)(base + size);
    int ok = expected_fault ? (record.signal == SIGSEGV && at_guard) : exit_status == 0;
    printf("{\"case\":\"mov_sreg_boundary\",\"variant\":%d,\"bytes_before_guard\":%d,"
           "\"exit\":%d,\"signal\":%d,\"si_code\":%d,\"fault_at_guard\":%s,\"pass\":%s}\n",
           kind, distance, exit_status, record.signal, record.code, at_guard ? "true" : "false", ok ? "true" : "false");
    munmap(base, (size_t)size * 2);
    return !ok;
}

static uint64_t lar_lsl(int kind, int rex, uint16_t selector, unsigned char *zf) {
    uint64_t value = UINT64_C(0x123456789abcdef0);
    if (kind == 0 && !rex)
        __asm__ volatile (".byte 0x0f,0x02,0xc1; setz %1" : "+a"(value), "=qm"(*zf) : "c"((uint64_t)selector) : "cc");
    else if (kind == 0)
        __asm__ volatile (".byte 0x48,0x0f,0x02,0xc1; setz %1" : "+a"(value), "=qm"(*zf) : "c"((uint64_t)selector) : "cc");
    else if (!rex)
        __asm__ volatile (".byte 0x0f,0x03,0xc1; setz %1" : "+a"(value), "=qm"(*zf) : "c"((uint64_t)selector) : "cc");
    else
        __asm__ volatile (".byte 0x48,0x0f,0x03,0xc1; setz %1" : "+a"(value), "=qm"(*zf) : "c"((uint64_t)selector) : "cc");
    return value;
}

int main(void) {
    struct rlimit core = {0, 0}; setrlimit(RLIMIT_CORE, &core);
    int failed = 0;
    for (int kind = 0; kind < 4; ++kind)
        for (int distance = 1; distance <= 8; distance = distance == 1 ? 2 : distance == 2 ? 8 : 9)
            failed += memory_case(kind, distance);
    uint16_t cs, ss;
    __asm__ volatile ("mov %%cs,%0; mov %%ss,%1" : "=r"(cs), "=r"(ss));
    uint16_t selectors[] = {0, cs, ss, 0xfffc};
    for (int kind = 0; kind < 2; ++kind) {
        for (int i = 0; i < 4; ++i) {
            unsigned char z0, z1;
            uint64_t v0 = lar_lsl(kind, 0, selectors[i], &z0);
            uint64_t v1 = lar_lsl(kind, 1, selectors[i], &z1);
            /* LAR bits 19:16은 SDM상 undefined. 그 비트는 동등성 비교에서 제외. */
            uint64_t mask = kind == 0 && z0 ? ~UINT64_C(0xf0000) : UINT64_MAX;
            int same = ((v0 & mask) == (v1 & mask)) && z0 == z1;
            printf("{\"case\":\"%s_width\",\"selector\":%u,\"r32_result\":\"%016lx\","
                   "\"r64_result\":\"%016lx\",\"zf32\":%d,\"zf64\":%d,\"pass\":%s}\n",
                   kind ? "lsl" : "lar", selectors[i], v0, v1, z0, z1, same ? "true" : "false");
            failed += !same;
        }
    }
    return failed ? 1 : 0;
}
