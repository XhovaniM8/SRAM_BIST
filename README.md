# SRAM Built-In Self-Test (BIST) Implementation

## Project Overview
This project implements a Built-In Self-Test (BIST) architecture for testing a 256x4-bit SRAM module. The BIST engine is designed to detect memory faults using various test patterns including March C-, March A, and Checkerboard patterns.

## Architecture
The BIST architecture consists of the following key components:

### 1. BIST Controller
- Manages the overall test process
- Implements a finite state machine with RESET and TEST states
- Controls test pattern generation and result analysis
- Clock Period: 83.0ns
- Area: 10.319 units

### 2. Counter
- 10-bit counter for address generation
- Supports both up and down counting
- Configurable initial value loading
- Clock Period: 180.0ns
- Area: 213.811 units

### 3. Pattern Decoder
- Generates various test patterns:
  - Checkerboard (0x55, 0xAA)
  - Reverse Checkerboard (0xF0, 0x0F)
  - Blanket patterns (all 0s, all 1s)
  - March C- patterns
  - March A patterns
- Area: 21.102 units

### 4. Comparator
- Compares expected vs actual memory output
- Provides equality and inequality indicators
- Area: 74.088 units

### 5. Multiplexers
- Address MUX (MUXA): 6-bit multiplexer for address selection
  - Area: 27.377 units
- Data MUX (MUXD): 8-bit multiplexer for data selection
  - Area: 34.108 units

### 6. SRAM Module
- 64x8-bit single-port RAM
- Synchronous read/write operations
- Clock Period: 116.0ns
- Area: 4387.734 units

## Implementation Results

### Top-Level Statistics
- Total Cell Area: 3618.173 units
- Total Net Area: 924.403 units
- Total Area: 4542.576 units
- Clock Period: 179.0ns

### Power Consumption
- Total Power: 3.16865e-03 W
  - Register Power: 57.67%
  - Logic Power: 18.29%
  - Clock Power: 24.04%

### Performance
- All timing constraints met with minimum slack of 0ps
- Maximum fanout: 76 (clock network)
- Average fanout: 2.6

## Test Results
The BIST implementation successfully:
- Executes various test patterns
- Detects memory faults
- Reports test results through the fail signal
- Completes testing within specified timing constraints

## Synthesis Details
- Target Technology: ASAP7 PDK (7nm)
- Tool: Genus Synthesis Solution 21.15-s080_1
- Operating Conditions: PVT_0P77V_0C

## Repository Structure
```
├── RTL
│   ├── bist_comparator.sv
│   ├── bist_controller.sv
│   ├── bist_counter.sv
│   ├── bist_decoder.sv
│   ├── bist_muxa.sv
│   ├── bist_muxd.sv
│   ├── bist_sram.sv
│   └── bist_top.sv
├── Testbench
│   ├── tb_bist_top.sv
│   ├── tb_bist_comparator.sv
│   ├── tb_bist_controller.sv
│   ├── tb_bist_counter.sv
│   ├── tb_bist_decoder.sv
│   ├── tb_bist_multiplexer.sv
│   ├── tb_bist_sram.sv
│   └── tb_bist_tester.sv
├── Constraints
│   ├── controller.sdc
│   └── mbist_test.sdc
└── Scripts
    ├── reports.tcl
    └── setup_run.tcl
```

## Testing and Verification

### Testbench Components
1. **Top-level BIST Testbench (tb_bist_top.sv)**
   - Full system integration test
   - Tests BIST functionality with configurable parameters
   - Clock period: 5ns
   - Monitors fail signal and dataout for error detection
   - Uses FSDB dump for waveform analysis

2. **Component-level Testbenches**
   - **Comparator (tb_bist_comparator.sv)**
     - Tests equality and inequality comparisons
     - Verifies all comparison conditions (greater, equal, less)
     - Tests various data patterns

   - **Controller (tb_bist_controller.sv)**
     - Tests FSM state transitions
     - Verifies reset functionality
     - Validates start/stop operations
     - Monitors NbarT and ld signals

   - **Counter (tb_bist_counter.sv)**
     - Tests up/down counting
     - Verifies load functionality
     - Checks counter enable/disable
     - Validates overflow conditions

   - **Decoder (tb_bist_decoder.sv)**
     - Tests all pattern generation modes
     - Verifies pattern sequences
     - Validates selector functionality

   - **Multiplexer (tb_bist_multiplexer.sv)**
     - Tests address and data multiplexing
     - Verifies mode switching (Normal vs BIST)
     - Validates signal routing

   - **SRAM (tb_bist_sram.sv)**
     - Tests read/write operations
     - Verifies memory addressing
     - Validates data retention
     - Tests all memory locations

### Verification Methods
1. RTL simulation with comprehensive testbenches
2. Static timing analysis
3. Power analysis
4. Area analysis
5. Quality of Results (QoR) analysis
6. FSDB waveform analysis
7. Assertion-based verification

## Future Improvements
1. Optimize timing for SRAM module to eliminate setup violations
2. Implement additional test patterns
3. Add error logging and diagnosis capabilities
4. Enhance power optimization

## License
TBD

## Contributors
- Xhovani Malixm (xxm202@nyu.edu)
