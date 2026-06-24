## 1. 專題名稱
* 基於 RISC-V memory-mapped I/O 的 FPGA 互動式七段顯示器計算系統
## 2. 使用開發板
* **開發板型號**：Digilent Basys 3 FPGA Development Board
* **核心晶片型號**：Xilinx Artix-7 `xc7a35ticpg236c` 
## 3. 使用工具版本
* **硬體綜合與佈線工具**：Xilinx Vivado Design Suite v2020.1 或更新版本 (相容後續全系列版本)
* **硬體模擬工具**：Icarus Verilog (`iverilog`) v11.0 + `vvp` + GTKWave
* **韌體交叉編譯器**：GNU toolchain for RISC-V (`riscv64-unknown-elf-gcc`) v10.2.0 (或相容之裸機 32 位元編譯器工具鏈)
## 4. 專案資料夾結構
```text
RISCV/
├── Makefile                # 韌體自動編譯腳本
├── start.s                 # RISC-V 組合語言開機引導程式 (Boot暫存器初始化)
├── main.c                  # C 語言核心狀態機程式 (運算邏輯與 BCD 解碼)
├── top.v                   # SoC 頂層晶片外殼 (內含匯流排交握、防彈跳與七段驅動)
├── picorv32.v              # Picorv32 RISC-V CPU 核心電路
├── basys3_pins.xdc          # 實機物理腳位約束與電壓標準定義檔
└── firm.mem                # 最終編譯熔刻用的純淨十六進位機器碼檔案 (由 sw 編譯產出)
```
## 5. 如何載入或修改 RISC-V 程式
直接使用文字編輯器打開修改main.c
終端機進入main.c所在目錄執行編譯
產出的firm.mem會再通一目錄下
## 6. 如何產生 bitstream
創建vivado專案，將top.v、picorv32.v 跟 basys3_pins.xdc加入專案
執行Generate Bitstream
## 7. 如何燒錄到 FPGA 開發板
將Basys 3 開發板透過 Micro-USB 線連接至 Windows 電腦
執行Program Device
## 8. 如何操作與測試
```text
switch配置:
	switch15 主系統重置
		往下撥(0)處理器凍結，七段顯示器歸零
		往上撥(1)釋放重置狀態
	Switch(0~7)作為資料輸入端
Button配置:
	中間按鈕
		作為輸入數值鎖定按鈕 
	左邊按鈕
執行加法運算，將七段顯示器數值加上鎖定輸入數值
	右邊按鈕
執行減法運算，將七段顯示器數值減鎖定輸入數值
	上方按鈕
		執行歸零，將七段顯示器數值歸零
LED配置:
	LED0
用以確認數值鎖定是否成功，當按下中間按鈕，LED0亮起
	LED4
用以確認加法是否成功，當按下左邊按鈕，LED4亮起
LED5
用以確認減法是否成功，當按下右邊按鈕，LED5亮起
```
## 9. 已知問題
未包含硬體乘除法功能
## 10. 外部來源與授權說明
CPU 核心來源：本專案採用由 Clifford Wolf 開發並維護的開源 Picorv32 RISC-V 核心處理器單元。
硬體防彈跳與顯示外設：完全由手動編寫完成。
授權協議：本專案硬體代碼及軟體韌體，完全基於 MIT License 開源協議授權。
