# Scrambler
This is the first phase of the IEEE 802.11a PHY layer implementation of the fpga/asics design course.
The modules are designed with a lot of simplifications and assumptions to make the design easier.
<img src="https://github.com/alireza-shirzad/Scrambler/blob/master/TX.png" align="left" height="250" width="200" >
## Design
The design is based on a simple FSM implemented in both TX and RX and the data is serially fed to modules.
<img src="https://github.com/alireza-shirzad/Scrambler/blob/master/TXState.png" align="left" height="250" width="200" >
## Test
Test is done using a high level matlab code for generating a random test vector and matching in RX output vs the Transmission input


**For more information read the Report.pdf**
