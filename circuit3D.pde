
import java.util.*;
import java.awt.*;
import javax.swing.JOptionPane;
import javax.swing.JList;

int black=0;
int white=255;
int gray=128;
int darkGray=64;
int lightGray=190;
String welcome = "Welcome to circuit3D V0.19.10.12";


void settings() 
{
   size(1000, 600);

}

void setup() {
  
 New(0);
 setMessage(welcome);
 appPath=sketchPath();
 appPath=join(split(appPath, '\\'), "/");
 println(appPath);
 cptPath=appPath+"/cpt/";
 circuitPath=appPath+"/circuits/";
 scadPath=appPath+"/scad/";
 println("Scad Path = "+scadPath);
}

String mmenu[]={"NEW","SIZE","ADD","SUP","ROT","TEXT","WIRE","GEN","SAVE","LOAD","QUIT"};

Circuit circuit= new Circuit();
int iselect=-1;
float xoffset;
float yoffset;

float boardWidth=20;
float boardLength=30;
float scale=20;
float x0=100;
float y0=100;

String message="";
int tempMessage=0;

Stack<String> stack= new Stack<String>();

String nFile="noname";
String appPath;
String cptPath;
String circuitPath;
String scadPath;

int fwire=0;
float xwire1;
float ywire1;
float xwire2;
float ywire2;

int ftext=0;

String fileName(String name)
{
  String resu="";
  int f=0;
  for (int i=1; i<=name.length(); i++)
  {
    if (f==0)
    {
      char c=name.charAt(name.length()-i);
      if ((c=='/') || (c=='\\')) f=1; else resu=c+resu;
    }
  }
  return resu;
}

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

void fileSelectedLoad(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    nFile=selection.getAbsolutePath();
    println("File : "+nFile);
    load();
  }
}

void fileLoad()
{
  selectInput("Select a file", "fileSelectedLoad");
}

void boardDim()
{
  //JList list = new JList(listeGroupes);
  //list.setSelectedIndex(0);
  String val=str(boardLength)+","+boardWidth;
 // setMessage(val);
   String s= JOptionPane.showInputDialog( null, "Board dimensions "+val, "Board dimensions", JOptionPane.PLAIN_MESSAGE);
   boolean ok=true;
   if (s!=null)
   {
   String e[]=s.split(",");
   float x1=0;
   float x2=0;
   float x3=2;
   if (e.length<2) ok=false;
   else 
   {
     if (isNumber(e[0])) x1=toFloat(e[0]); else ok=false;
     if (isNumber(e[1])) x2=toFloat(e[1]); else ok=false;
   //  if (isNumber(e[2])) x3=toFloat(e[2]); else ok=false;
   }
   if (ok)
   {
     println(x1);
     println(x2);
     //println(x3);
     
     circuit.setBoardSize(x1,x2,x3);
     println(circuit.get(0).disp());
     boardLength=x1;
     boardWidth=x2;
   }
   }
     
   //return s;

}

int menuwidth=90;
void menu()
{
  textSize(20);
   stroke(white);
  
  int sep=menuwidth/2-5;
  int ofx=(width-mmenu.length*menuwidth)/2;
  for (int i=0; i<mmenu.length; i++)
  {
    fill(204, 102, 0);
    if (mmenu[i].equals("WIRE"))
     if (fwire>0) fill(0);
     if (mmenu[i].equals("TEXT"))
     if (ftext>0) fill(0);
    
    rect(i*menuwidth+ofx,20,menuwidth-10,40,5);
    fill(white); 
    text(mmenu[i],i*menuwidth+sep-mmenu[i].length()*5+ofx,50);
  }
}

int testMenu(int x, int y)
{
  int n=0;
  int ofx=(width-mmenu.length*menuwidth)/2;
  if ((y>=20)&&(y<=60))
  {
    n=(x-ofx)/menuwidth+1;
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
int stackError;

String stackpop()
{
  String resu="0";
  if (stack.empty()) stackError=1;
  else resu=stack.pop();
  return resu;
}

int exe(float xx, float yy,String s, boolean selected, int rotation)
{
  stackError=0;
  if (s.equals("BOARD"))
  {
    float yw=toFloat(stackpop());
    float xw=toFloat(stackpop());
    fill(darkGray);  noStroke();
    rect(x0+5,y0+5,xw*scale,yw*scale);
    fill(gray);  stroke(gray);
    rect(x0,y0,xw*scale,yw*scale);
  }
  if (s.equals("HOLE"))
  {
    float d=toFloat(stackpop());
    float y=toFloat(stackpop());
    float x=toFloat(stackpop());
    if (rotation==1) { float z=x; x=y; y=z; }
    y=y+yy;
    x=x+xx;
    fill(black);
    if (selected) stroke(255,0,0);
    else stroke(white); 
    ellipse(x*scale+x0,y*scale+y0,d/2*scale/2.54, d/2*scale/2.54);
    
  }
  else if (s.equals("TRACE"))
  {
    float yw=toFloat(stackpop());
    float xw=toFloat(stackpop());
    if (rotation==1) { float z=xw; xw=yw; yw=z; }
    float y=toFloat(stackpop());
    float x=toFloat(stackpop());
    if (rotation==1) { float z=x; x=y; y=z; }
    y=y+yy;
    x=x+xx;
    
    fill(100);
    if (selected) stroke(255,0,0);
    else stroke(white); 
    rect(x*scale+x0,y*scale+y0,xw*scale,yw*scale);
  }
  else if (s.equals("CIRCLE"))
  {
    float d=toFloat(stackpop());
     float y=toFloat(stackpop());
    float x=toFloat(stackpop());
    if (rotation==1) { float z=x; x=y; y=z; }
    y=y+yy;
    x=x+xx;
    fill(100);
    if (selected) stroke(255,0,0);
    else stroke(white); 
    ellipse(x*scale+x0,y*scale+y0,d*scale,d*scale);
  }
  else if (s.equals("LINE"))
  {
    float y2=toFloat(stackpop())+yy;
    float x2=toFloat(stackpop())+xx;
    float y1=toFloat(stackpop())+yy;
    float x1=toFloat(stackpop())+xx;
    //println("Line "+x1+","+y1+","+y1+","+y2);
    if (selected) stroke(255,0,0);
    else stroke(10,20,100); 
    line(x1*scale+x0,y1*scale+y0,x2*scale+x0,y2*scale+y0);
    rect(x1*scale+x0,y1*scale+y0,0.1*scale,0.1*scale);
  }
  else if(s.equals("TEXT"))
  {
   // println(stack.toString());
    String ss=stackpop();
    float y=toFloat(stackpop())+yy+6/scale;
    float x=toFloat(stackpop())+xx;
     if (selected) fill(255,0,0);
    else fill(0);
    //println(ss+" at "+x+" "+y);
    textSize(int(1.5*scale));
    text(ss.substring(1,ss.length()),x*scale+x0,y*scale+y0);
  }
  
 return stackError; 
}

void drawCircuit()
{
  stack= new Stack<String>();
  int resu=1;
//  fill(darkGray);  noStroke();
//  rect(x0+5,y0+5,boardLength*scale,boardWidth*scale);
//  fill(gray);  stroke(gray);
//  rect(x0,y0,boardLength*scale,boardWidth*scale);
  for (int i=0; i<circuit.size();i++)
  { 
    Block b=circuit.get(i);
    for (int j=0;j<b.size(); j++)
    {
      String s=b.get(j);
      //println(s);
      if (s.charAt(0)=='"') stack.push(s);
      else
      if (isNumber(s)) stack.push(s);
      else 
      { 
        resu=exe(b.x,b.y,s,b.selected,b.rotation);
        if (resu==1) 
        { 
          JOptionPane.showMessageDialog (null, "Error in block. Block suppressed");
          circuit.removeBlock(i);
          j=b.size()+1;
          i=circuit.size()+1;
        }
      }
    }
    //if (circuit.isNumber(i)) stack.append(circuit.toInt(i));
  }
  
}

void draw() {
  background(60);
  //ellipse(mouseX, mouseY, 33, 33);
  menu();
  drawCircuit();
  textSize(20);
  fill(255);
  if (tempMessage>0) 
  {
    tempMessage--;
    text(message,10,height-10);
  }
  
  if (fwire==2)
  {
    stroke(0);
    line(xwire1,ywire1,xwire2,ywire2);
  }
 
}

void setMessage(String s)
{
  message=s;
  tempMessage=100;
}

void save()
{
  StringList lines;
  if (nFile.equals("noname")) nFile= circuitPath+JOptionPane.showInputDialog( null, "File Name", "Selection du groupe", JOptionPane.PLAIN_MESSAGE);
  PrintWriter output=createWriter(nFile);
  for (int i=0; i<circuit.size(); i++)
  {
    lines=circuit.get(i).blockSave();
    for (int j=0; j<lines.size(); j++)
          output.println(lines.get(j));
  }
   output.flush();
  output.close();
  setMessage("Saved in "+nFile);
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
  
 setMessage(nFile+" loaded"); 
}

void New(int f)
{
  circuit.clear();
  Block b;
  
  b=new Block(0,0,boardLength,boardWidth);
  b.addString(""+boardLength);
  b.addString(""+boardWidth);
  b.addString("BOARD");
  circuit.add(b);
  if (f==1) boardDim();
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
     if (menu.equals("NEW")) New(1);
     else if (menu.equals("ADD")) blockAdd();
     else if (menu.equals("SIZE")) boardDim();
     else if (menu.equals("SUP")) circuit.removeSelectedBlock();
     else if (menu.equals("ROT")) circuit.rotSelectedBlock();
     else if (menu.equals("SAVE")) save();
     else if (menu.equals("LOAD")) { circuit=new Circuit(); fileLoad(); }
     else if (menu.equals("QUIT")) exit();
     else if (menu.equals("GEN")) 
     {
       Generator generator=new Generator(circuit);
       String name=scadPath+fileName(nFile);
       generator.generate(name);
       setMessage(name+".scad generated");
     }
     else if (menu.equals("WIRE")) if (fwire==0) fwire=1; else fwire=0;
     else if (menu.equals("TEXT")) if (ftext==0) ftext=1; else ftext=0;
   }
   else // circuit
   if (fwire==1)
   {
     xwire1=xwire2=mouseX; //int((mouseX-x0)/scale/2+0.5)*2*scale+x0;
     ywire1=ywire2=mouseY; //int((mouseY-y0)/scale/2+0.5)*2*scale+y0;
     
     fwire=2;
   }
   else if (ftext==1)
   {
     String s=JOptionPane.showInputDialog( null, "Text", "", JOptionPane.PLAIN_MESSAGE);
     Block b=new Block((mouseX-x0)/scale, (mouseY-y0)/scale,2,1);
     b.addString("0");
    b.addString("0");
     b.addString("\""+s);
     b.addString("TEXT");
     circuit.add(b);
     circuit.disp();
     ftext=0;
   }
   else
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
  if (fwire==2) 
  {
    xwire2=mouseX; //int((mouseX-x0)/scale/2+0.5)*2*scale+x0;
    ywire2=mouseY; //int((mouseY-y0)/scale/2+0.5)*2*scale+y0;
  }
  else if (iselect>-1)
  {
    circuit.get(iselect).x=int(2*(mouseX-xoffset-x0)/scale)/2.0;
    circuit.get(iselect).y=int(2*(mouseY-yoffset-y0)/scale)/2.0;
  }
  
  
}

void mouseReleased() 
{
  if (fwire==2) 
  {
    fwire=1;
    float x1=(xwire1-x0)/scale;
    float y1=(ywire1-y0)/scale;
    Block b=new Block(x1,y1,1,1);
    b.addString("0");
    b.addString("0");
    b.addString(str((xwire2-x0)/scale-x1));
    b.addString(str((ywire2-x0)/scale-y1));
 
    b.addString("LINE");
    circuit.add(b);
    circuit.disp();
  }
}
