# RISC-V Single Cycle Processor (Verilog)
## Nguyễn Bá Thanh Minh 20240484E
## Tổng quan

Đây là mô hình vi xử lý RISC-V (RV32I) dạng single-cycle được xây dựng bằng Verilog, có thể **pass toàn bộ test SC1 và SC2** trên hệ thống tự động của môn học/giảng viên.

## Cấu trúc thư mục

- `ALU.v`             : Bộ tính toán số học-logic
- `ALU_decoder.v`     : Bộ giải mã điều khiển ALU
- `Branch_Comp.v`     : Bộ so sánh cho lệnh nhánh
- `DMEM.v`            : Bộ nhớ dữ liệu (RAM)
- `IMEM.v`            : Bộ nhớ lệnh (ROM)
- `Imm_Gen.v`         : Bộ tạo hằng số (Immediate Generator)
- `RegisterFile.v`    : File thanh ghi 32x32
- `control_unit.v`    : Bộ điều khiển tín hiệu
- `RISCV_Single_Cycle.v` : Module top kết nối toàn hệ thống

