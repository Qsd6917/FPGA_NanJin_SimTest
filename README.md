# FPGA_NanJin SIM_TEST Project

## 项目概述

本项目是一个FPGA仿真测试项目，包含了RTL设计、仿真测试和Quartus II项目文件。主要用于学习和测试FPGA设计相关技术。

## 项目结构

```
SIM_TEST/
├── DOC/                # 文档目录，包含FPGA国赛相关题目
│   ├── 2023FPGA国赛能力测试题目.docx
│   ├── 2023FPGA国赛能力测试题目.pdf
│   ├── 2024国赛测试.docx
│   ├── 2024国赛测试.pdf
│   └── 基于2023年和2024年的FPGA国赛能力测试题风格.pdf
├── PRJ/                # Quartus II项目文件
│   ├── db/             # 综合和实现数据库文件
│   ├── incremental_db/ # 增量编译数据库
│   ├── output_files/   # 输出文件
│   ├── simulation/     # 仿真文件
│   ├── TOP.qpf         # Quartus II项目文件
│   ├── TOP.qsf         # Quartus II设置文件
│   └── TOP.qws         # Quartus II工作区文件
├── RTL/                # RTL设计文件
│   └── TOP.v           # 顶层设计文件
└── SIM/                # 仿真测试文件
    └── tb.v            # 测试基准文件
```

## 主要文件说明

### RTL/TOP.v

这是一个简单的数字时钟模块，实现了以下功能：

- 基于输入时钟的时间计数（小时、分钟、秒）
- 12小时制显示（AM/PM）
- 异步复位功能
- 时钟使能控制

**端口定义：**
- `i_clk`: 输入时钟信号
- `i_rst`: 输入复位信号（高电平有效）
- `i_ena`: 输入使能信号
- `o_pm`: 输出AM/PM指示（0=AM，1=PM）
- `o_hh`: 输出小时（BCD码，7:0）
- `o_mm`: 输出分钟（BCD码，7:0）
- `o_ss`: 输出秒（BCD码，7:0）

### SIM/tb.v

这是一个仿真测试文件，但**注意**：该测试文件的端口定义与RTL/TOP.v中的端口定义不匹配。当前tb.v文件似乎是为一个交通信号灯控制器设计的测试文件，而不是为数字时钟设计的。

**不一致之处：**
- tb.v中实例化的模块端口（clk, rst_n, ped_btn, main_light, ped_light）与TOP.v中定义的端口不匹配
- 测试场景也是针对交通信号灯的行人按钮功能，而不是数字时钟功能

### PRJ/TOP.qsf

Quartus II项目设置文件，定义了项目的基本配置：

- 设备：Cyclone IV E系列（EP4CE10F17C8）
- 顶层实体：TOP
- 仿真工具：ModelSim (Verilog)
- 包含的文件：../SIM/tb.v 和 ../RTL/TOP.v

## 使用说明

### 环境要求

- Quartus II 13.0 SP1 或兼容版本
- ModelSim 仿真工具

### 项目编译

1. 打开 Quartus II
2. 打开项目文件：PRJ/TOP.qpf
3. 点击"Start Compilation"按钮进行编译

### 仿真

1. 在Quartus II中，选择"Tools" -> "Run Simulation Tool" -> "RTL Simulation"
2. 或直接使用ModelSim打开PRJ/simulation/modelsim/TOP_run_msim_rtl_verilog.do脚本进行仿真

## 注意事项

1. **端口不匹配问题**：当前的tb.v文件与TOP.v文件的端口定义不匹配，无法直接进行仿真。需要根据实际设计需求修改其中一个文件。

2. **模块名称大小写**：TOP.v中模块定义为小写`top`，但在tb.v和项目设置中使用大写`TOP`，这可能导致编译错误。

3. **设计一致性**：如果要使用当前的tb.v文件，需要设计一个对应的交通信号灯控制器模块；如果要使用当前的TOP.v数字时钟模块，需要编写一个新的测试文件。

## 文档参考

DOC目录中包含了2023年和2024年FPGA国赛能力测试题目及相关分析，可以作为项目设计的参考资料。

## 联系方式

如果您有任何问题或建议，请随时联系项目维护者。