# Circuit 3D
Circuit 3d allows to design 3D printed boards for simple electronic circuits. It is coded in Processing language.
You can draw your board using layout for resistors, transistors, capacitors, ICs...  
Then a 3D file can be generated and the OPENSCAD software can be used to obtain a stl file for the 3D printer.

## Help

- NEW : generate a new design (board with 4 holes).
- SIZE : change the size of the board in mm.
- ADD : add components. The component files are txt files. Select components and deplace them with the mouse. 
- SUP : suppress the selected component
- TEXT : Add  text at the clicked position of the mouse
- WIRE : Add wires. This wires will not be printed but can be used as an help to connect the components.
- GEN : generate the OPENSCAD file
- SAVE : save the circuit in a file
- LOAD : load a circuit
- QUIT : quit the software

## component Layout

Component layout are defined in txt file in the cpt folder as a list of drawing instructions:
For example, to obtain a hole in position 0, 0 with diameter 1.5mm the instruction is:

0
0
1.5
HOLE

Other instruction are TRACE and TEXT. See examples in the cpt folder.


