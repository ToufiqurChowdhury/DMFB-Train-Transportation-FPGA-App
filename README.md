# Interface Microcontroller Design and Prototype Demo in FPGA/ALTERA DE2 board for DMFB Train-like Mass Transportation

System Introduction
===================
The embedded system with one hot micro-controller will be implemented once we design our system. DMFB chips can have the system for actuating the cells with level shifter to apply required voltage (22v in our case). 

Our desired embedded system will have address decoder module, voltage actuation module, pulse divider module and display module for voltage actuation using controller with FSM (Finite State Melay Machine) and datapath with all the logical modules. The voltage actuation and address decoder module is the interface for level shifter for real system. However, level shifter module can be implemented in next phase of this research and hence we have concentrated mostly on controller and logical datapath of the embedded system for the prototype implementation of  DMFB train transportation for fast manipulation.

System Design
=============
We implemented the system using an Altera DE2 board using seven segment display, red and green LEDs and input switches as well as push button.

Objectives of the System
========================
The objective of the system is to design a prototype for DMFB train transportation that employs the voltage actuation scheme for 2 droplet DMFB train movement from source to destination.
