# RISC-V Single Cycle Processor (Verilog)
## Nguyễn Bá Thanh Minh 20240484E


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

## lệnh chạy test sc1 sc2
python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc1 ALU.v   ALU_decoder.v   Branch_Comp.v   DMEM.v   IMEM.v   Imm_Gen.v   RISCV_Single_Cycle.v   RegisterFile.v   control_unit.v

python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc2 ALU.v   ALU_decoder.v   Branch_Comp.v   DMEM.v   IMEM.v   Imm_Gen.v   RISCV_Single_Cycle.v   RegisterFile.v   control_unit.v