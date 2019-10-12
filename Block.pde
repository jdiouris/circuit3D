import java.util.*;
import java.lang.*;
import processing.data.*;
import processing.core.*;



class Block
{
  public float x;
  public float y;
  public float xw;
  public float yw;
  public boolean selected;
  public int rotation;

  StringList content;
  
  Block()
  {
    content = new StringList();
    selected=false;
    rotation=0;
  }
  
  float toFloat(String s)
{
  return Float.parseFloat(s);
}
  
  Block(String lines[])
  {
    content = new StringList();
    selected=false;
    x=toFloat(lines[0]);
    y=toFloat(lines[1]);
    xw=toFloat(lines[2]);
    yw=toFloat(lines[3]);
    rotation=int(toFloat(lines[4]));
    for (int i=5; i<lines.length; i++)
    addString(lines[i]);
  }
  
  Block(StringList lines)
  {
    content = new StringList();
    selected=false;
    x=toFloat(lines.get(0));
    y=toFloat(lines.get(1));
    xw=toFloat(lines.get(2));
    yw=toFloat(lines.get(3));
    rotation=int(toFloat(lines.get(4)));
    for (int i=5; i<lines.size(); i++)
    addString(lines.get(i));
  }
  
  StringList  blockSave()
  {
    StringList resu=new StringList();
    resu.append("BLOCK");
    resu.append(str(x));
    resu.append(str(y));
    resu.append(str(xw));
    resu.append(str(yw));
    resu.append(str(rotation));
    for (int i=0; i<content.size(); i++)
      resu.append(content.get(i));
    return resu;
  }
  
  Block(float X, float Y,float XW, float YW)
  {
    content = new StringList();
     x=X; y=Y; xw=XW; yw=YW;
      selected=false;
      rotation=0;
  }
  
  void addString(String s)
  {
    content.append(s);
  }
  
  int size()
  {
    return content.size();
  }
  
  String get(int i)
  {
    return content.get(i);
  }
  void rot()
  {
    rotation++;
    if (rotation==2) rotation=0;
  }
  
  void set(int i, String s)
  {
    content.set(i,s);
  }
  
  String disp()
  {
    String s="Block("+x+","+y+","+xw+","+yw+") ";
   // s="Block size: "+size();
    for (int j=0;j<size(); j++)
    {
      s+=get(j)+" ";
      
    }
    println(s);
    return s;
  }
  
  boolean touche(float xx, float yy)
  {
    return ((xx>=x)&&(xx<=x+xw)&&(yy>=y)&&(yy<=y+yw));
  }
}
