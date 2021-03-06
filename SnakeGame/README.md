# 基于Basys3的贪吃蛇游戏

本设计实现了一个基于Basys3平台的贪吃蛇游戏。利用Basys3上的VGA接口连接显示器作为游戏界面，利用Basys3板卡上的按键进行控制，实现了贪吃蛇游戏的基本功能，同时添加了“奖励机制”，随机掉落一些奖励如加分、减缓速度等，丰富了游戏体验。

## 系统设计

### 1. 硬件部分

硬件部分主要由一块Basys3开发板和一台VGA显示器组成。

本设计使用了Basys3开发板的四个按键控制“蛇”运动方向，使用数码管显示当前的得分，游戏的主体界面则由VGA显示器来显示。

![](https://i.loli.net/2019/06/21/5d0c458bbadfc23980.png)

### 2. 软件模块设计

本设计的软件部分以Verilog HDL硬件描述语言完成，其整体结构如图所示：

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519133529.png)

#### 1. 游戏控制部分

游戏控制部分主要由 snake_moiving、game_status_control，apple_generator 三个模块实现。

snake_moving 模块负责控制蛇的运动状态，主要完成以下四个功能：

1. 通过输入的四个按键信号实现对蛇的上下左右的移动：本长度位移动的下个坐标为下一个长度位当前坐标
2. 检测是否撞到墙或自己身体：蛇头的x、y坐标与墙壁或任意身体长度出的坐标相等则发生了碰撞。
3. 对身体长度信息的存储；蛇的最小长度为3，最大长度为16，身体长度存储在一组寄存器中，每个寄存器存储这一长度的蛇的身体坐标，并存储这一体长是否存在。

game_status_control 模块负责判断和控制当前的游戏状态，分别输出 START、PLAY、DIE和RESTART四种状态提供给其他模块。此模块通过按键信息判断是否进入游戏，通过输入“撞到墙”和“撞到身子”信号的有无判断是否结束游戏并重新开始。

apple_generator 模块负责苹果的生成：

1. 通过判断苹果的坐标与输入的蛇头的坐标是否重合来检测是否“吃到”苹果
2. 在吃到苹果后随机生成新的苹果，随机数采用计数器和加法来实现，分别以数字的高5位和低4位作为新生成的苹果的坐标。

#### 2. “奖励道具”控制部分

奖励道具控制部分主要由 reward_random_generator、reward_logic、reward_display、reward_information四部分实现。

reward_logic 是这一部分的顶层模块，负责通过蛇头的坐标和生成的奖励道具的坐标判断是否吃到道具，并在吃到后输出相应的信号并以定时器的方式维持不同的时间。

reward_random_generator 模块负责利用随机数算法随机生成奖励的出现时间、类型和坐标，伪随机数的生成算法是基于线性反馈移位寄存器（LFSR）生成。

reward_display 模块负责显示奖励，通过输入点的VGA像素坐标和生成的位置坐标对比，在一定区域内显示闪动的黄色方块来完成。

reward_information 模块负责在蛇吃到道具之后显示这一奖励道具的类型和作用的剩余时间，并将奖励类型以24*24像素的黑白图片显示：使用 Block Memory Generator IP核，通过先将图片扫描转化为coe文件，读入IP核中并例化即可显示图片。

#### 3. 时钟和驱动部分

其余的模块主要是时钟和VGA、按键等板上资源的驱动。

clock模块是负责系统时钟，并以计数器的方式利用板上100MHz的时钟信号产生另一路4Hz的低频时钟信号，clock_unit 模块则通过分频和调用PLL实现VGA所需的25MHz时钟。

seg_display 模块是数码管的驱动模块，vga_display是VGA显示器的驱动模块，buttons是Basys3板上按键的扫描驱动模块

## 游戏介绍

游戏开始前，显示贪吃蛇游戏的logo：

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519145026.png)

按下任意按键即可开始游戏，由Basys3开发板上的四个按键控制蛇的运动，红色的方块代表苹果，当蛇吃到苹果后身体长度加一，同时蛇的移动速度会加快，以增加游戏难度。游戏过程过程中会随机出现闪动的黄色方块，代表奖励道具。

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519150810.png)

吃下奖励道具后，界面的右上角会提示道具的类型和剩余的作用时间，当右侧的进度条走完后道具的作用效果消失。

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519150836.png)

吃下“无敌”道具后出现盾牌标志，在作用时间内蛇碰到墙壁或自己的身体后不会结束游戏。

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519150900.png)

吃下“减速”道具后蛇的移动速度会变慢一段时间，游戏难度降低。

![](https://picture-1256315926.cos.ap-shanghai.myqcloud.com/img/20190519150920.png)

吃下“加分”道具后可以额外增加一分。

![1558249783716](C:\Users\Admin\Dropbox\Markdown\Assignments\1558249783716.png)





