import java.io.*;
class Generator
{
  Circuit circuit;
  StringList lines;
  Stack<String> stack;
  float scale=2.54;
  Generator(Circuit circuit)
  {
    this.circuit=circuit;
  }
  
  void gen(float xx, float yy, String s)
  {
    if (s.equals("BOARD"))
  {
    float yw=toFloat(stack.pop())*scale;
    float xw=toFloat(stack.pop())*scale;
    lines.append("    cube(["+xw+','+yw+",2]);");
  }
  if (s.equals("HOLE"))
  {
    float d=toFloat(stack.pop());
    float y=(toFloat(stack.pop())+yy);
    float x=toFloat(stack.pop())+xx;
    lines.append("    translate(["+x*scale+","+y*scale+",-0.1]) cylinder(h=10,d="+d+");");
    
  }
  else if (s.equals("TRACE"))
  {
    float yw=toFloat(stack.pop());
    float xw=toFloat(stack.pop());
    float y=(toFloat(stack.pop())+yy);
    float x=toFloat(stack.pop())+xx;
    lines.append("    translate(["+x*scale+","+y*scale+",1.5]) cube(["+xw*scale+","+yw*scale+",10]);");
    
  }
   else if (s.equals("CIRCLE"))
  {
    float d=toFloat(stack.pop());
    float y=toFloat(stack.pop())+yy;
    float x=toFloat(stack.pop())+xx;
    lines.append("    translate(["+x*scale+","+y*scale+",1.5]) cylinder(h=10,d="+d*scale+");");    
  }
  else if (s.equals("TEXT"))
  {
   // println(stack.toString());
    String ss=stack.pop();
    float y=toFloat(stack.pop())+yy;//-1.5/scale;
    float x=toFloat(stack.pop())+xx;
   // ss=ss.substring(1,ss.length());
    lines.append("    translate(["+x*scale+","+y*scale+",1]) linear_extrude(10) mirror([0,1,0]) text("+ss+"\",size=3);");
  }
  }
  
  //void saveLines(String name)
  //{
  //  try {
  //          // Assume default encoding.
  //          FileWriter fileWriter =
  //              new FileWriter(name);

  //          // Always wrap FileWriter in BufferedWriter.
  //          BufferedWriter bufferedWriter =
  //              new BufferedWriter(fileWriter);
                
  //              for (int j=0; j<lines.size(); j++)
  //              {
  //            BufferedWriter.write(lines.get(j));
  //              }
  //  }
  //  catch(IOException ex) {
  //          System.out.println(
  //              "Error writing to file '"
  //              + name + "'");
    
  //}
  
  void generate (String nfile)
  {
    lines=new StringList();
    stack=new Stack<String>();
     lines.append("$fn=50;");
    lines.append("translate([0,"+boardWidth*scale+",0]) mirror([0,1,0]) difference()");
    //lines.append("translate([0,"+boardWidth*scale+",0])  difference()");
    lines.append("{");
    
    for (int i=0; i<circuit.size(); i++)
    {
      Block b=circuit.get(i);
       for (int j=0;j<b.size(); j++)
        {
          String s=b.get(j);
          //println(s);
          if (s.charAt(0)=='"') stack.push(s);
          else
          if (isNumber(s)) stack.push(s);
          else gen(b.x,b.y,s);
    }
    }
     lines.append("}");
    
    // Ecriture fichier


  String[] s=lines.array();
  saveStrings(nfile+".scad",s);
  println();
   println(nfile+".scad generated");
  }
}
