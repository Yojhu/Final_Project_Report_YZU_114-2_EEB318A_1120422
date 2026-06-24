#define MMIO_IN_PTR  ((volatile int*)0x40000000)
#define MMIO_OUT_PTR ((volatile int*)0x50000000)

#define BTN_C (1 << 7) // 中央鈕：0x80 鎖存當前開關數字
#define BTN_U (1 << 6) // 上方向鈕：0x40 系統歸零
#define BTN_L (1 << 5) // 左方向鈕：0x20 加法運算
#define BTN_R (1 << 4) // 右方向鈕：0x10 減法運算

volatile int accumulator = 0;    // 總累計值
volatile int input_operand = 0;  // 由中央鈕鎖存的當前輸入值
volatile int last_btn_state = 0;

// 將整數解碼為七段顯示器專用 BCD 碼
unsigned int encode_display(int result) {
    unsigned int encoded = 0;
    int is_negative = 0;
    
    if (result < 0) {
        is_negative = 1;
        result = -result; 
    }

    int d0 = result % 10;
    int d1 = (result / 10) % 10;
    int d2 = (result / 100) % 10;
    int d3 = (result / 1000) % 10;

    encoded |= d0;
    encoded |= (d1 << 4);
    encoded |= (d2 << 8);
    
    if (is_negative) {
        encoded |= (0xC << 12); // 最左側顯示負號 「-」
    } else {
        encoded |= (d3 << 12);
    }
    return encoded << 16;
}

int main() {
    accumulator = 0;
    input_operand = 0;
    last_btn_state = 0;
    
    // 開機強制更新顯示為 0
    *MMIO_OUT_PTR = encode_display(accumulator);

    while(1) {
        int raw_input = *MMIO_IN_PTR;
        int current_sw = raw_input & 0xFF;              
        int current_btn = (raw_input >> 8) & 0xFF; 

        // 偵測按鈕正緣觸發
        int edge_btn = current_btn & (~last_btn_state);
        last_btn_state = current_btn;

        int op_led = 0;
        int triggered = 0;

        // 1. 上方向鈕：全面軟體歸零
        if (edge_btn & BTN_U) {
            accumulator = 0;
            input_operand = 0;
            op_led = 0;
            triggered = 1;
        }
        // 2. 中央鈕：鎖存當前開關的數字
        else if (edge_btn & BTN_C) {
            input_operand = current_sw;
            // 點亮 LD0 (0x01) 代表系統已成功將當前的開關數值鎖存鎖死
            *MMIO_OUT_PTR = (*MMIO_OUT_PTR & 0xFFFF0000) | 0x01;
        }
        // 3. 左方向鈕：執行加法
        else if (edge_btn & BTN_L) {
            accumulator = accumulator + input_operand;
            op_led = (1 << 4); // LD4 亮
            triggered = 1;
        }
        // 4. 右方向鈕：執行減法
        else if (edge_btn & BTN_R) {
            accumulator = accumulator - input_operand;
            op_led = (1 << 5); // LD5 亮
            triggered = 1;
        }

        // 更新七段顯示器與指示燈
        if (triggered) {
            *MMIO_OUT_PTR = encode_display(accumulator) | op_led;
        }

        for(volatile int delay=0; delay<5; delay++); 
    }
}