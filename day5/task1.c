#include <stdio.h>
#include <stdint.h>
#include <string.h>

typedef struct Stack { char arr[256]; uint8_t head; } Stack;
void push(Stack* s, char ch) { if(ch>='A' && ch<='Z') s->arr[++s->head] = ch; }
char pop(Stack* s) { return s->arr[s->head--]; }

#define SWAP_CH(x,y) { char tmp=x; x=y; y=tmp; }
void reverse(Stack* s) {
    for(int i = 1; i<=s->head/2; ++i) SWAP_CH(s->arr[i], s->arr[s->head-i+1]);
}

int main()
{
    Stack stacks[256] = {0}; // stacks[0] and stacks[i].arr[0] are unused
    char buf[256]; // we assume that all lines fit in buffer

    char ch, sep, lastStack = 0;
    while(fgets(buf, 256, stdin) != NULL && buf[0] != '\n') { // read till empty line
        if(strlen(buf) == 255) { puts("too long line"); return 1; }
        uint8_t cur = 0;
        for(int i = 1; i<strlen(buf); i += 4) push(&stacks[++cur], buf[i]);
        if(lastStack == 0) lastStack = cur;
    }
    for(uint8_t i = 1; i<=lastStack; ++i) reverse(&stacks[i]);

    uint8_t n, from, to;
    while(scanf("%*s %hhu %*s %hhu %*s %hhu", &n, &from, &to) == 3) {
        for(uint8_t i = 1; i <= n; ++i) push(&stacks[to], pop(&stacks[from]));
    }
    for(uint8_t i = 1; i<=lastStack; ++i) printf("%c", stacks[i].arr[stacks[i].head]);
}
