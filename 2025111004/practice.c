#include <stdio.h>

_Bool alt_parity(int a[], int n)
{
    int prev = a[0]%2;
    for (int i = 1; i < n; i++)
    {
        int cur = a[i]%2;
        if (cur == prev) return 0;
        else
        {
            prev = cur;
        }
    }
    return 1;
}

int main()
{
}