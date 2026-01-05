# FPGA-Based Stopwatch Using Xilinx Spartan-3E FPGA


## Project Objective
- Designed a **digital stopwatch using FPGA** (Xilinx Spartan-3E) with multiplexed 4-digit 7-segment display. The project demonstrates **real-time counting, clock division, hardware-efficient design, and FPGA-based implementation** suitable for embedded and control applications.


## Tools & Technologies
- **FPGA:** Xilinx Spartan-3E (~100K gates)
- **HDL:** Verilog
- **Simulation:** Testbench (`stopwatch_tb.v`) and waveform screenshot
- **Display:** 4-digit 7-segment multiplexed display
- **Development Tools:** Xilinx ISE, Basys FPGA Board
- **Other Components:** Push buttons (start/stop/reset), oscillator (50 MHz)


## Project Description
The FPGA stopwatch counts time in **tenths of a second, seconds, and minutes**, displayed on a multiplexed 4-digit 7-segment display.

- Uses **clock division** to generate 0.1-second ticks from the main oscillator.
- Implements **increment logic for all digits** with proper carry handling.
- Demonstrates **hardware-level time counting and display multiplexing**.
- Verified using a **Verilog testbench** and waveform analysis.


## Implementation Details

### Software Implementation
- Verilog HDL module `stopwatch.v` implements counting logic.
- Testbench `stopwatch_tb.v` verifies functional correctness.
- Multiplexed 4-digit 7-segment display logic implemented.
- Simulation waveform shows proper timing and digit incrementation.

### Simulation & Testing
- Functional correctness verified via **Verilog testbench**.
- **Waveform screenshot** included (`Simulation/waveform.png`) demonstrating accurate counting.
- Hardware execution validated timing, multiplexing, and digit carry-over.

### Hardware Implementation
- Synthesized and deployed on Xilinx Spartan-3E FPGA (Basys board).
- Push buttons connected to **start, stop, and reset** logic.
- 4-digit 7-segment display connected for real-time counting.
- The pin configuration was optimized for the Spartan‑3E, allowing the oscillator to run at 50 MHz.
- Hardware output verified with screenshots demonstrating correct operation.


## Learning Outcomes
- Practical FPGA design and deployment experience
- Proficiency in Verilog HDL and testbench verification
- Hardware-software interfacing on FPGA
- Understanding of clock division, multiplexing, and timing logic


## Project Nature
This is a **Mini Project** completed as part of the **Electronic System Design Laboratory**, evaluated for semester practical examination, focused on FPGA implementation, Verilog design, and hardware verification.
