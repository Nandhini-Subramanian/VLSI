#include<stdio.h> 
#include<stdlib.h> 
 
int main() 
{ 
    FILE *fifo_top_tb; 
    fifo_top_tb = fopen("fifo_top_tb.txt","wr");  
    int num[32]; 
    for(int n=0; n<32; n++) 
    {     
        num[n] = rand() % 4294967295;        /*The number needs to be 32-bit wide, hence the reminder will be between 0 and (2^32)-1. */
        fprintf(fifo_top_tb, "%08X%d\n", num[n] & 0xFFFFFFFF, n); 
        printf("%08X%d\n", num[n] & 0xFFFFFFFF, n); 
    } 
  