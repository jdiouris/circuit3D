
import java.util.*;
import java.awt.*;
import javax.swing.JOptionPane;
import javax.swing.JList;

int black=0;
int white=255;
int gray=128;
int darkGray=64;
int lightGray=190;


void settings() {
   size(800, 600);

}

void setup() {
  
 New();

}

String mmenu[]={"NEW","SIZE","ADD","SUP","GEN","SAVE","LOAD","QUIT"};

Circuit circuit= new Circuit();
int iselect=-1;
float xoffset;
float yoffset;

int boardWidth=20;
int boardLength=30;
float scale=20;
float x0=100;
float y0=100;

Stack<String> stack= new Stack<String>();

String nFile="circuit.cir";

void fileSelectedAdd(File selection) {
String nFile;
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    nFile=selection.getAbsolutePath();
    String lines[]=loadStrings(nFile);     
    for (int i=0; i<lines.length; i++) println(lines[i]);
    Block b=new Block(lines);
    b.x=2;
    b.y=2;
    circuit.add(b);
  }
}

void blockAdd()
{
  selectInput("Select a block", "fileSelectedAdd");
}

String boardDim()
{
  //JList list = new JList(listeGroupes);
  //list.setSelectedIndex(0);
   return JOptionPane.showInputDialog( null, "Board dimensions", "Selection du groupe", JOptionPane.PLAIN_MESSAGE);

}

void menu()
{
  textSize(20);
   stroke(white);
  int ofx=(width-mmenu.length*100)/2;
  for (int i=0; i<mmenu.length; i++)
  {
    fill(204, 102, 0);
    rect(i*100+ofx,20,90,40,5);
    fill(white); 
    text(mmenu[i],i*100+45-mmenu[i].length()*5+ofx,50);
  }
}

int testMenu(int x, int y)
{
  int n=0;
  int ofx=(width-mmenu.length*100)/2;
  if ((y>=20)&&(y<=60))
  {
    n=(x-ofx)/100+1;
    if (n<1) n=0;
    if (n>mmenu.length) n=0;
  }
  return n;
  
}

float toFloat(String s)
{
  return Float.parseFloat(s);
}

boolean isNumber(String s)
{
  try{
        Float.parseFloat(s);
        return true;
    }catch(NumberFormatException e){
        return false;
    }
}

void exe(float xx, float yy,String s, boolean selected)
{
  if (s.equals("BOARD"))
  {
    float yw=toFloat(stack.pop());
    float xw=toFloat(stack.pop());
    fill(darkGray);  noStroke();
    rect(x0+5,y0+5,xw*scale,yw*scale);
    fill(gray);  stroke(gray);
    rect(x0,y0,xw*scale,yw*scale);
  }
  if (s.equals("HOLE"))
  {
    float d=toFloat(stack.pop());
    float y=toFloat(stack.pop())+yy;
    float x=toFloat(stack.pop())+xx;
    fill(black);
    if (selected) stroke(255,0,0);
    else stroke(white); 
    ellipse(x*scale+x0,y*scale+y0,d/2*scale/2.54, d/2*scale/2.54);
    
  }
  else if (s.equals("TRACE"))
  {
    float yw=toFloat(stack.pop());
    float xw=toFloat(stack.pop());
    float y=toFloat(stack.pop())+yy;
    float x=toFloat(stack.pop())+xx;
    fill(100);
    if (selected) stroke(255,0,0);
    else stroke(white); 
    rect(x*scale+x0,y*scale+y0,xw*scale,yw*scale);
  }
}

void drawCircuit()
{
  stack= new Stack<String>();
  fill(darkGray);  noStroke();
  rect(x0+5,y0+5,boardLength*scale,boardWidth*scale);
  fill(gray);  stroke(gray);
  rect(x0,y0,boardLength*scale,boardWidth*scale);
  for (int i=0; i<circuit.size();i++)
  { 
    Block b=circuit.get(i);
    for (int j=0;j<b.size(); j++)
    {
      String s=b.get(j);
      //println(s);
      if (isNumber(s)) stack.push(s);
      else exe(b.x,b.y,s,b.selected);
    }
    //if (circuit.isNumber(i)) stack.append(circuit.toInt(i));
  }
  
}

void draw() {
  background(60);
  //ellipse(mouseX, mouseY, 33, 33);
  menu();
  drawCircuit();
 
}

void save()
{
  StringList lines;
  PrintWriter output=createWriter(nFile);
  for (int i=0; i<circuit.size(); i++)
  {
    lines=circuit.get(i).blockSave();
    for (int j=0; j<lines.size(); j++)
          output.println(lines.get(j));
  }
   output.flush();
  output.close();
}

void load()
{
  String lines[]=loadStrings(nFile);
  StringList blockLines=new StringList();
  for (int i=0; i<lines.length; i++)
  {
    String s=lines[i];
    if (s.equals("BLOCK"))
    {
      if (blockLines.size()>0) 
      {
          Block b=new Block(blockLines);
          circuit.add(b);
      }
      
      blockLines=new StringList();
    }
    else blockLines.append(s);
  }
  if (blockLines.size()>0) 
      {
          Block b=new Block(blockLines);
          circuit.add(b);
      }
  
  
}

void New()
{
  circuit.clear();
  Block b;
  
  b=new Block(1,1,1,1);
  b.addString("0");
  b.addString("0");
  b.addString("3.1");
  b.addString("HOLE");
  circuit.add(b);
  
  b=new Block(boardLength-1,1,1,1);
  b.addString("0");
  b.addString("0");
  b.addString("3.1");
  b.addString("HOLE");
  circuit.add(b);
  
  b=new Block(1,boardWidth-1,1,1);
  b.addString("0");
  b.addString("0");
  b.addString("3.1");
  b.addString("HOLE");
  circuit.add(b);
  
  b=new Block(boardLength-1,boardWidth-1,1,1);
  b.addString("0");
  b.addString("0");
  b.addString("3.1");
  b.addString("HOLE");
  circuit.add(b);
  
  //String lines[]=loadStrings("rv3.txt");
  //b=new Block(lines);
  //b.x=2;
  //b.y=2;
  //circuit.add(b);
  //print(b.disp());
}

void mousePressed() {
   iselect=-1;
   int nm=testMenu(mouseX,mouseY);
   print(nm);
   // Menu
   if (nm!=0)
   {
     String menu=mmenu[nm-1];
     if (menu.equals("NEW")) New();
     else if (menu.equals("ADD")) blockAdd();
     else if (menu.equals("SIZE")) print(boardDim());
     else if (menu.equals("SUP")) circuit.removeSelectedBlock();
     else if (menu.equals("SAVE")) save();
     else if (menu.equals("LOAD")) { New(); load(); }
     else if (menu.equals("QUIT")) exit();
   }
   else // circuit
   {
     println((mouseX-x0)/scale,(mouseY-y0)/scale);
     for (int j=0; j<circuit.size(); j++) circuit.get(j).selected=false;
    
     for (int i=0; i<circuit.size(); i++)
     { 
       println(circuit.get(i).x,circuit.get(i).y);
       if (circuit.get(i).touche((mouseX-x0)/scale,(mouseY-y0)/scale))
       {
         println("Select block "+i);
         for (int j=0; j<circuit.size(); j++) circuit.get(j).selected=false;
         circuit.get(i).selected=true;
         iselect=i;
         xoffset=mouseX-(circuit.get(i).x*scale+x0);
         yoffset=mouseY-(circuit.get(i).y*scale+y0);
       }       
     }
   }
}

void mouseDragged()
{
  if (iselect>-1)
  {
    circuit.get(iselect).x=int((mouseX-xoffset-x0)/scale);
    circuit.get(iselect).y=int((mouseY-yoffset-y0)/scale);
  }
  
  
}

void mouseReleased() 
{
}