# 8-instruction single cycle MIPS32 CPU
### 1. 打开vivado，新建项目
### 2. 添加文件
``` 
Add or create design sources -> Add files -> Add Directories
```
### 3. 更改imem.v里指令文件和dmem.v里的rom 的读取路径
### 4. 仿真
```
Run Simulation 
```
这是解释代码的视频链接： [MIPS单周期CPU设计 # 视频中dmem.v未对数据存储器进行初始化 会导致lw出错 代码已经改正](https://www.bilibili.com/video/BV1rD4y1D7h9)  <hr/>
<img src="https://github.com/qing-2/CPU/blob/master/run.jpg"> 

# 常见问题
### 1. 运行不成功？
多半是imem.v的路径不对。使用绝对路径，并且 "\\" 换成 "\\\\"或"/"，路径中不要使用中文和空格。举个正确的例子 “D:/Downloads/CPU-master/imem.txt”

### 2. 为什么仿真波形里只出现了5条指令？
菜单栏help的下面有三个按钮，restart/ run all /run for 10us，点一下run for 10us它就会往后继续执行了，它不会因为指令不足而结束，如果指令读取完毕它只会变红报错

### 3. 在dmem的数据存储器代码中，为什么用 [31:2] 来寻址？
因为我们设定的是这样的。我们设地址是32位的，一个地址对应一个字节的内容。

但是呢，我们这里设的存储指令的数组的一个元素是32位，也就是4字节的。而我们用4字节存储每条指令。

所以，我们假设第一个指令的地址是0000，他对应的是ram[0]

第二个数的地址是0100，它对应的是ram[1]

第三个数的地址是1000，它对应的是ram[2]，

可以发现，数组的下标就是地址除以4，也就是去掉最后两位。

### 4. reg [n:1] RAM [m:1] 是什么意思？
定义了一个 名为RAM、包含 m个n位寄存器 的存储器

### 5. lw指令是有符号扩展，M4应该取2（根据decoder那个视频里的图看），为什么代码写的M4是取1？
因为我把它合并了，用 signed16 这个变量判断是否按符号扩展，m4的取值就只有0和1了，和那张图不一样了，在 module ext16 的代码里标注了，忘记在decoder那p视频里说了，sorry😥

### 6. 有朋友提到“用vivado仿真还是有点麻烦，主要是vivado现在越来越大了。推荐一个简单的仿真器，iverilog，windows和linux下都方便安装使用。可以搭配gtkwave看仿真波形。”
我试了一下感觉很好用， [icarus_gtkwave教程有详细介绍](https://brng.dev/blog/technical/tutorial/2019/05/11/icarus_gtkwave/)  ，其中`gtkwave wave.vd`写错了，应该是`gtkwave wave.vcd`
### 7. imem.txt 指令是什么含义？
（第一条sll指令相当于空指令，因为每次reset pc=0 npc就是4 就会错过第一条指令）<br/>
2022.4.12更新了imem.txt，现在包含全部8条指令，汇编代码如下
``` 
sll  $zero,$zero,0

goto:
addu $s2,$s1,$s0

subu $s3,$s2,$s0

ori  $s0,$s1,2

sll  $s1,$s3,2

lw   $s4,3($s0)

sw   $s4,4($s0)

beq  $s2,$s4,goto

j goto
``` 
### 8. 如何把汇编代码编译成机器码？
我知道两种方法：

a.  [MARS | MIPS Assembler and Runtime Simulator](http://courses.missouristate.edu/kenvollmar/mars/index.htm) 需要Java环境，加上配置Java环境不到半小时就能搞定，小巧简单好用（更推荐⭐）

b. 交叉编译工具链。[简介](https://www.bilibili.com/video/BV1Az4y117rY?spm_id_from=333.999.header_right.fav_list.click)
。《自己动手写CPU》里用的GNU，有详细讲解，但书里那个链接下载下来是坏的。它提供完备的编译工具，比如mips-linux-gcc（类似gcc）

### 9. MARS使用方式：
1）. 打开inst.asm
``` 
File -> Open -> inst.asm
```
2）. 把起始地址改成0，不然beq,j跳转不到想要的地方，因为咱们设置的cpu的指令的起始地址是0
``` 
Settings -> Memory Configration -> 选择 Compact,Text at Address 0
```
3）. 导出16进制机器码（Dump machine code）
``` 
蓝色箭头1010 -> Dump Format 选择 Hexadecimal Text -> Dump To File -> imem.txt or imem.data
```
