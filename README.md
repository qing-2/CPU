# 计组实验课的Verilog代码
### 1. 打开vivado，新建项目
### 2. 添加文件
``` 
Add or create design sources -> Add files -> Add Directories
```
### 3. 更改imem.v里指令文件的读取路径
### 4. 仿真
```
Run Simulation 
```
这是解释代码的视频链接 [【计算机组成原理】MIPS单周期CPU设计 | Verilog](https://www.bilibili.com/video/BV1rD4y1D7h9)  <hr/>

# 常见问题
### 1. 运行不成功？
多半是imem.v的路径不对。可以尝试用相对路径，或者把绝对路径里的 "\" 换成 "\\"或"/"
### 2. 在dmem的数据存储器代码中，为什么用 [31:2] 来寻址？
因为我们设定的是这样的。我们设地址是32位的，一个地址对应一个字节的内容。

但是呢，我们这里设的存储指令的数组的一个元素是32位，也就是4字节的。而我们用4字节存储每条指令。

所以，我们假设第一个指令的地址是0000，他对应的是ram[0]

第二个数的地址是0100，它对应的是ram[1]

第三个数的地址是1000，它对应的是ram[2]，

可以发现，数组的下标就是地址除以4，也就是去掉最后两位。

### 3. reg [n:1] RAM [m:1] 是什么意思？
定义了一个 名为RAM、包含 m个n位寄存器 的存储器

### 4. lw指令是有符号扩展，M4应该取2（根据decoder那个视频里的图看），为什么代码写的M4是取1？
因为我把它合并了，用 signed16 这个变量判断是否按符号扩展，m4的取值就只有0和1了，和那张图不一样了，在 module ext16 的代码里标注了，忘记在decoder那p视频里说了，sorry😥
