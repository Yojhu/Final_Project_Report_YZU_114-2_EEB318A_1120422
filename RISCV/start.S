.section .text.init
.global _start

_start:
    li sp, 8192     # 設定堆疊指標至 8KB RAM 頂端
    call main       # 呼叫 C 語言主程式
1:  j 1b            # 當 main 結束時進入死迴圈