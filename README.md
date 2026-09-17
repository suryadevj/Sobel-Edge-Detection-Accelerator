# Sobel Edge Detection Accelerator

A hardware implementation of the Sobel edge-detection filter, taken through RTL design, simulation, synthesis, and physical design (place-and-route).

## Overview

The design computes the Sobel edge-magnitude for a 3×3 pixel window using a 3-stage pipeline:

1. **Stage 1** — Compute horizontal (Gx) and vertical (Gy) gradients using the Sobel kernels.
2. **Stage 2** — Compute absolute values of Gx and Gy.
3. **Stage 3** — Sum the absolute gradients to produce the edge magnitude output.

## Repository Structure

```
rtl/       RTL source and testbench (Verilog)
  sobel.v      - Sobel filter module
  sobel_tb.v   - Testbench

reports/   Project documentation, reports, and flow screenshots
  sobel_project.pdf         - Project documentation
  sobel_project_report.pdf  - Detailed project report
  images/                   - Screenshots from RTL simulation, synthesis,
                              floorplanning, CTS, place & route, timing
                              analysis, power reports, and LEC
```

## Design Flow

The project covers the full ASIC design flow:
- RTL design & functional simulation (waveforms included)
- Logic synthesis (area, power, timing reports)
- Floorplanning
- Clock Tree Synthesis (CTS) with post-CTS timing checks
- Place & Route
- Post-route STA (setup/hold timing)
- Logical Equivalence Checking (LEC) at multiple stages
- SDF-based timing verification

See `reports/sobel_project_report.pdf` for full details and results.

## Module Interface

```verilog
module sobel (
    input clk,
    input rst,

    input [7:0] p1, p2, p3,
    input [7:0] p4, p5, p6,
    input [7:0] p7, p8, p9,

    output reg [11:0] edge_out
);
```

Inputs `p1`–`p9` represent the 3×3 pixel neighborhood (row-major order). The output `edge_out` is the computed edge magnitude, available 3 clock cycles after the inputs are applied.
