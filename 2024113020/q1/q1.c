# include "stdio.h"

int main()
{
    int n;
    scanf("%lld",&n);
    int arr[n];
    for (int i = 0; i < n; i++){
        scanf("%lld",&arr[i]);
    }
    int parity;
    if(arr[i]%2 == 0){
            parity = 0;
        }
    for(int i = 1 ; i< n ; i++){
        if(arr[i]%2 == parity){
            printf("FALSE");
            return 0;
        }
        else {
            parity = (parity+1)%2;
        }
    }
    printf("TRUE");
    return 0;
}