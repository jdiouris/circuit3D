import processing.data.*;
import processing.core.*;
import java.lang.Integer;
import java.util.Vector;


class Circuit
{
  Vector<Block> content;
  Circuit()
  {
    content=new Vector<Block>();
  }
  
  void clear()
  {
    content.clear();
  }
  
  Block get(int i)
  {
    return content.get(i);
  }
  
  void add(Block b)
  {
    content.add(b);
  }
  
  int size()
  {
    return content.size();
  }
  
  void removeBlock(int i)
  {
    content.removeElementAt(i);
  }
  
  void removeSelectedBlock()
  {
    int ii=-1;
    for (int i=0; i<content.size(); i++)
      if (content.get(i).selected) ii=i;
    
    if (ii>=0) content.removeElementAt(ii);
  }
  
  void setBoardSize(float x1, float x2, float x3)
  {
    get(0).set(0,str(x1));
    get(0).set(1,str(x2));
   // get(0).set(2,str(x3));
    
  }
  
  void disp()
  {
    for (int i=0; i<content.size(); i++)
      content.get(i).disp();
  }
  
  //boolean isNumber(int i)
  //{
  //  try{
  //      Integer.parseInt(prog.get(i));
  //      return true;
  //  }catch(NumberFormatException e){
  //      return false;
  //  }
  //}
  
  //int toInt(int i)
  //{
  //  int v=Integer.parseInt(prog.get(i));
  //  return v;
  //}
  
}
