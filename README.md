<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:4B0082,50:6A5ACD,100:9370DB&height=220&section=header&text=Advanced%20VLSI%20Design&fontSize=38&fontColor=ffffff&animation=fadeIn&fontAlignY=35"/>
</p>

# VLSI Logical Effort Optimization using HSPICE

<p align="center">

![HSPICE](https://img.shields.io/badge/HSPICE-Circuit%20Simulation-blue)
![CMOS](https://img.shields.io/badge/Technology-32nm%20CMOS-green)
![VLSI](https://img.shields.io/badge/Domain-Advanced%20VLSI-orange)
![Logical Effort](https://img.shields.io/badge/Methodology-Logical%20Effort-red)

</p>

---

## Overview

This repository contains the materials, HSPICE implementation, and reference solution for the second computer assignment of the VLSI course offered at the University of Tehran.

The assignment was designed to provide hands-on experience with transistor-level CMOS design, logical effort analysis, timing optimization, and power characterization using Synopsys HSPICE. Students are required to analytically derive optimal gate sizes, implement the complete circuit using parameterized CMOS logic gates, validate functionality through simulation, and investigate the tradeoff between delay and power consumption.

The project is based on a 32nm CMOS technology library and follows a complete VLSI design workflow, starting from theoretical delay calculations and ending with detailed circuit-level simulations.

Key concepts covered in this assignment include:

- CMOS transistor sizing
- Logical Effort methodology
- Delay optimization
- Path effort analysis
- Power-performance tradeoffs
- Rise and fall time characterization
- Propagation delay measurement
- HSPICE circuit simulation
- Multi-scenario design-space exploration using `.alter`

The repository includes both the assignment statement and a complete reference implementation developed for educational purposes.

---

## Educational Objectives

This assignment is designed to help students bridge the gap between theoretical VLSI concepts and practical circuit implementation.

After completing this project, students should be able to:

- Design CMOS logic gates at the transistor level.
- Calculate logical effort parameters for complex paths.
- Determine optimal gate sizing for minimum delay.
- Implement parameterized subcircuits in HSPICE.
- Measure propagation delay, rise time, and fall time.
- Analyze the impact of transistor sizing on circuit performance.
- Evaluate power-delay tradeoffs in digital CMOS circuits.
- Apply logical effort theory to real-world design optimization problems.

---

## About the Assignment

This project was developed as **Computer Assignment #2** for the VLSI course in the School of Electrical and Computer Engineering at the University of Tehran.

The assignment consists of three major parts:

### Part I — Logical Effort Analysis

Students manually derive the logical effort, parasitic delay, electrical effort, branching effort, and path effort of the given combinational circuit. Using these calculations, optimal gate sizes are determined to minimize the overall path delay.

### Part II — HSPICE Implementation and Characterization

The complete circuit is implemented using transistor-level CMOS logic gates, including:

- Inverter
- NOR2
- NOR3
- NAND2

The design is then simulated in HSPICE and characterized through waveform analysis, propagation delay measurements, rise/fall time extraction, and average power estimation.

### Part III — Delay Minimization through Stage Optimization

Students investigate the effect of adding additional inverter stages and use Logical Effort theory to determine the optimal number of stages required to achieve minimum delay.

---

## Project Objectives

The main goals of this project are:

1. Analyze a CMOS combinational circuit using Logical Effort theory.
2. Compute optimal gate sizes for minimum delay.
3. Implement transistor-level gate models in HSPICE.
4. Validate circuit functionality through waveform inspection.
5. Measure:
   - Propagation Delay
   - Rise Time
   - Fall Time
   - Average Power Consumption
6. Investigate the impact of gate sizing on:
   - Circuit speed
   - Power consumption
   - Delay-power tradeoff
7. Explore optimal stage insertion for minimizing overall path delay.

---

## Circuit Description

The design consists of multiple CMOS logic gates connected in a combinational path.

The circuit is implemented using transistor-level CMOS logic and includes:

- NOR2
- NOR3
- NAND2
- Inverter

The primary design objective is to optimize the critical path delay while maintaining reasonable power consumption. The output node is connected to a capacitive load derived from a sized inverter, creating a realistic design scenario for delay and power analysis.

The optimization target is the critical path:

```text
A → w → x → out
```

Logical Effort methodology is used to determine the optimal sizing of each gate along this path.

---

## Methodology

The project follows a complete VLSI design flow:

### Step 1 — Analytical Delay Optimization

Theoretical calculations are performed to obtain:

- Logical Effort (g)
- Electrical Effort (h)
- Branching Effort (b)
- Path Effort (F)
- Stage Effort (f)
- Total Delay (D)

Based on these calculations, the optimal input capacitance and gate sizing values are derived.

### Step 2 — Transistor-Level Design

Parameterized HSPICE subcircuits are created for:

- Inverter
- NAND2
- NOR2
- NOR3

Each gate is designed such that its pull-up and pull-down networks provide drive strengths comparable to the reference inverter.

### Step 3 — Circuit Simulation

The complete circuit is simulated using transient analysis.

Key measurements include:

- Propagation Delay
- Rise Time
- Fall Time
- Average Power Consumption

### Step 4 — Design Space Exploration

The size of the NOR3 gates is swept across multiple configurations using the `.alter` command.

This enables systematic evaluation of:

- Delay variation
- Rise/Fall time variation
- Average power consumption
- Delay-power tradeoffs

---

## HSPICE Features

The implementation demonstrates several important HSPICE capabilities:

- Parameterized circuit design
- Hierarchical subcircuit modeling
- Automated timing characterization
- Automated power measurements
- Design-space exploration using `.alter`
- Waveform validation using CosmosScope

Example parameter sweep:

```spice
.param size_nor3 = 5

.alter
.param size_nor3 = 5.5

.alter
.param size_nor3 = 6
```

---

## Performance Evaluation

The following timing metrics are measured throughout the project:

### Propagation Delay

```text
tpHL
tpLH
tpd
```

### Signal Transition Metrics

```text
Rise Time (trise)
Fall Time (tfall)
```

### Critical Path Delay

```text
A → w → x → out
```

The measurements are extracted automatically using HSPICE `.measure` statements.

---

## Power Analysis

Power consumption is analyzed for multiple gate-sizing configurations.

The study investigates:

- Dynamic Power
- Static Power
- Average Power Consumption
- Delay-Power Tradeoffs

By sweeping the NOR3 sizing factor, the relationship between circuit speed and power consumption can be observed and quantified.

This provides practical insight into one of the most important tradeoffs in modern digital integrated circuit design.

---

## Delay Optimization

The final phase of the project focuses on minimizing the overall path delay.

Using Logical Effort theory, the optimal number of stages is estimated by:

```math
N \approx \log_{3.59}(F)
```

Additional inverter stages are inserted and evaluated to determine whether the overall delay can be further reduced.

This section demonstrates how theoretical delay models can be validated through transistor-level simulation.

---

## Repository Structure

```text
vlsi-logical-effort/
│
├── docs/
│   ├── Assignment.pdf
│   └── Solution_Report.pdf
│
├── hspice/
│   ├── logical_effort.sp
│   ├── 32nm_bulk.pm.txt
│   └── simulation_outputs/
│
├── plots/
│   ├── delay_analysis/
│   ├── power_analysis/
│   └── waveforms/
│
├── figures/
│   └── circuit_diagram.png
│
├── README.md
│
└── LICENSE
```

---

## Tools and Technologies

- Synopsys HSPICE
- CosmosScope
- 32nm CMOS Technology Library
- Logical Effort Methodology
- Python (Data Analysis & Plotting)

---

## Results

This project demonstrates:

✅ Logical Effort based gate sizing

✅ Delay minimization through analytical optimization

✅ Accurate transistor-level CMOS implementation

✅ Automated timing characterization using HSPICE

✅ Power-performance tradeoff analysis

✅ Design-space exploration using parameter sweeps

✅ Validation of theoretical VLSI concepts through simulation

---

## Educational Value

This repository may be useful for:

- VLSI Design students
- Digital IC Design courses
- ASIC Design enthusiasts
- HSPICE beginners
- Researchers studying CMOS timing optimization
- Students learning Logical Effort methodology

It can also serve as a reference implementation for laboratory sessions, coursework, and self-study projects involving transistor-level digital circuit design.

---

## References

1. Ivan Sutherland, Bob Sproull, and David Harris, *Logical Effort: Designing Fast CMOS Circuits*
2. Neil Weste and David Harris, *CMOS VLSI Design: A Circuits and Systems Perspective*
3. Synopsys HSPICE User Guide

---

## Author

**Behzad Jannati**

Teaching Assistant (TA) — VLSI Course

School of Electrical and Computer Engineering  
University of Tehran


### Contact

- Email: Behzadjannati@ut.ac.ir
- GitHub: https://github.com/bhzadjnty7

---

## License

This repository is intended for educational and academic purposes.

Students are encouraged to study the implementation, understand the methodology, and use the material as a learning resource for VLSI design and HSPICE simulation.

## ⭐️ Support

If you find this repository useful, consider giving it a ⭐️
