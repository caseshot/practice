# Codeforce
## Codeforce Global Round 10
### E. Omkar and Duck 题解
题目传送门:[E. Omkar and Duck](https://codeforces.com/contest/1392/problem/E, "E. Omkar and Duck")  
这是一道交互题,还是第一次遇到这种题,感觉有必要记录下这道题的题解  
这道题的大意是先给你一个整数n(n <= 25),然后你输出n行n列的整数a<sub>i</sub> (0 <= a<sub>i</sub> <= 10<sup>16</sup>), 接下来给你测试次数t, 每次测试根据你输出的数组输出一个路径和, 路径从左上角(1, 1)开始,在右下角(n, n)结束,你要打印这个路径  
如果你输出的路径路径和与给出的相同, 但路径与系统使用的路径不一致, 则你的输出错误 
### Example
**Input**
```
4




3
23







26







27







```
**Output**
```
1 2 3 6
4 6 2 10
9 0 7 3
2 8 8 2


1 1
1 2
1 3
2 3
2 4
3 4
4 4

1 1
2 1
3 1
3 2
3 3
3 4
4 4

1 1
1 2
1 3
1 4
2 4
3 4
4 4
```
### 官方题解
读懂题后想到的是用二进制位来表示每一层它走了哪几个数,用log<sub>2</sub>n + 1(向下取整)个二进制位表示一层它走了几个这层的数
```
(n = 3)时
00     01     10                    0   1   2
0000   0100   1100          ->      0   4   12
000000 010000 100000                0   16  32
```
但是这样的写法在n = 25时最后一行的数将远远超过10<sup>16</sup>(需要用125个二进制位表示),就算将这种写法改为单行为0, 双行用二进制位表示   
```
0   0   0
0   4   12
0   0   0
```
在n = 25时倒数第二行也要60个二进制位表示,依然超过10<sup>16</sup>, 失败了  
 
**官方给出的题解:**  
它每一步只能向右或下走  
设终点到起点的曼哈顿距离为k,则不管鸭子怎么走,路径上点起点的曼哈顿距离总是从 1变到 k,
将一个方向设为0,将另一个方向设为2<sup>k</sup>(将一个方向上值的k + 1位设为0,另一个方向上值的k + 1位设为1)

0	0   0   0  
2<sup>1</sup>	2<sup>2</sup>	2<sup>3</sup>	2<sup>4</sup>  
0	0	0	0  
2<sup>3</sup>	2<sup>4</sup>	2<sup>5</sup>	2<sup>6</sup>  
  
根据它和的每一位就可以知道它走了哪个方向, 就能打印出路径了