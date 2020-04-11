/*Problem Description
数列的定义如下：
数列的第一项为n，以后各项为前一项的平方根，求数列的前m项的和。
 

Input
输入数据有多组，每组占一行，由两个整数n（n<10000）和m(m<1000)组成，n和m的含义如前所述。
 

Output
对于每组输入数据，输出该数列的和，每个测试实例占一行，要求精度保留2位小数。*/
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

int main()
{
    int m;
    double temp,n;
    while (cin >> n >> m)
    {
        temp=n;
        double ans=0;
        for(int i=0;i<m;i++)
        {
            n=temp;
            ans+=n;
            temp=sqrt(n);
        }
        printf("%.2f\n",ans);
    }
    return 0;
}