#include <stdio.h>

int find_gcd(int a, int b){
    int temp = 1;
    if(b > a){
        while(temp > 0){
            temp = b % a;
            b = a;
            a = temp;
        }

        return b;
    }
    else{
        while(temp > 0){
            temp = a % b;
            a = b;
            b = temp;
        }

        return a;
    }
}

int main(){
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d ", find_gcd(a,b));
    int prod = a*b;
    int lcd = prod / find_gcd(a,b);
    printf("%d\n", lcd);
    return 0;
}