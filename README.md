# Circuit 3D
Circuit 3d allows to design 3D printed boards for simple electronic circuits. It is coded in Processing language.
You can draw your board using layout for resistors, transistors, capacitors, ICs, arduino shield...  
Then a 3D file can be generated and the OPENSCAD software can be used to obtain a stl file for the 3D printer.

## How to install the software?
Download the project folder on your hard disk. You must install Processing (https://processing.org/download/). Load circuit3d in processing and run the software.
Important notice : this is a simple software and a work in progress (so there is absolutely no guarantee).

## Help

- NEW : generate a new design (board with 4 holes).
- SIZE : change the size of the board in mm.
- ADD : add components. The component files are txt files. Select components and deplace them with the mouse. 
- SUP : suppress the selected component.
- TEXT : add  text at the clicked position of the mouse.
- WIRE : add wires. This wires will not be printed but can be used as help to connect the components.
- GEN : generate the OPENSCAD file.
- SAVE : save the circuit in a file.
- LOAD : load a circuit.
- QUIT : quit the software.

## Component Layout

Component layout are defined in text file in the cpt folder as a list of drawing instructions.
For example, to obtain a hole in position x=0 and y=1 with diameter 1.5mm the instruction is:

0

1

1.5

HOLE

Note that the x y positions are multiple of 0.1 inch and the diameter is in mm.
Other instructions are TRACE and TEXT. See examples in the cpt folder.


