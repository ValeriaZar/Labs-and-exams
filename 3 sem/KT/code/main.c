#include <stdio.h>

typedef enum charType
{
    HexDigit,
    PascalPrefix,
    ZeroDigit,
    CPrefixX,
    Unknown
} char_t;

typedef enum state {
    error,
    expect_zero_or_dollar,
    expect_x,
    expect_hex,
    expect_hex_or_end
} state_t;

int transitions[5][5] = {{0, 0, 0, 0, 0},
                         {0, 3, 2, 0, 0},
                         {0, 0, 0, 3, 0},
                         {4, 0, 4, 0, 0},
                         {4, 0, 4, 0, 0}};

int finalState[5] = {0, 0, 0, 0, 1};

char_t getCharType(const char c)
{
    if (c == '0')
        return ZeroDigit;
    if (c == '$')
        return PascalPrefix;
    if (c == 'x' || c == 'X')
        return CPrefixX;
    if ( (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F') || (c >= '1' && c <= '9') )
        return HexDigit;
    return Unknown;
}

int isValidNumber(const char *str, const size_t size)
{
    state_t state = 1;
    for (int i = 0; i < size; ++i)
        state = transitions[state][getCharType(*(str + i))];
    return finalState[state];
}

void findSubStrings(const char *str, const int size) {
    for (int k = 0; k < size; ++k) {
        for (int j = k; j < size; ++j) {
            state_t state = 1;
            for (int i = k; i <= j; ++i)
            {
                state = transitions[state][getCharType(*(str + i))];
                if (state == 0)
                    break;
            }
            if (finalState[state] == 1) {
                for (int i = k; i <= j; ++i)
                    printf("%c", *(str + i));
                printf("\n");
            }
        }
    }
}

int main(void) {
    char str[30];
    int i = 0;
    printf("Enter your number: \n");
    scanf("%30[^\n]", str);
    while (str[i] != '\0')
        i++;
    if (isValidNumber(str, i))
        printf("\033[1;32mCorrect\033[0m\n");
    else
        printf("\033[1;31mWrong!\033[0m\n");
    findSubStrings(str, i);
    return 0;
}
