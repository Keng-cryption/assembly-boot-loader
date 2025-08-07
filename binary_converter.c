#include <stdio.h>
#include <math.h>

int main()
{
    int input[8];
    int result = 0;
    for (int i = 0; i < 8; i++){
        scanf("%d", &input[i]);
    }
    for (int i = 0; i < 8; i++){
        if (input[i] == 1){
            result = result + pow(2,i);
        }
    }
    printf("%d", result);
    return 0;
}
