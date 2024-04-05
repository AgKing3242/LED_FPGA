# Interfacing the onboard clock on ZedBoard FPGA board to show LED patterns using VHDL. 

# Overview:
This project showcases the implementation of a Finite State Machine (FSM) on the ZedBoard FPGA development board to control LED patterns using the VHDL language.

# Functionality:

Utilizes onboard clock interface for synchronization of LED pattern transitions.
Implements various states within the FSM to define different LED patterns.
Enables seamless switching between patterns based on state transitions.

# Clock Divider Logic:

Addresses the issue of the onboard clock operating at 10 MHz, resulting in rapid pattern changes.
Integrates a clock divider logic into the program to extend the time period for LED pattern display to 0.5 seconds.
Enhances pattern visibility and effectiveness for observation and analysis.

# Usage:

Clone the repository and compile the VHDL program using suitable development tools.
Upload the compiled program onto the ZedBoard FPGA development board with suitable port mapping.
Observe LED patterns displayed on the board.
