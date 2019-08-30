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
  
  void removeSelectedBlock()
  {
    int ii=-1;
    for (int i=0; i<content.size(); i++)
      if (content.get(i).selected) ii=i;
    
    if (ii>=0) content.removeElementAt(ii);
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
