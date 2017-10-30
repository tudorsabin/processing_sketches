import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Pattern;
import java.util.stream.Stream;
import java.util.regex.Matcher;


/**
 * @author Tudor Sabin Topoleanu
 * Generic LSystem
 * Produces a new string on interate 
 * from a given alphabet starting with an axiom 
 * based on production rules
 */
public class GenericLSystem {
  public ArrayList<String> alphabet = null;  
  public String axiom = null;
  public String current = null;
  public Map<String, String> production_rules = null;
    
  public Integer level = 0;
  
  /**
   * @param alphabet
   * @param axiom
   * @param production_rules
   */
  public GenericLSystem(ArrayList<String> alphabet, String axiom, Map<String, String> production_rules) {
    super();
    this.alphabet = alphabet;
    //TODO check if axiom is from alphabet 
    this.axiom = axiom;
    //TODO check if rules are from alphabet
    this.production_rules = production_rules;
  }
  
  /* reset function (sets level to 0)
   * current is erased
   */    
  public void reset() {
    this.level=0; 
    this.current=null;
  }
  
  public String iterate(){
        
    String searchMe = null;
    
    Map<Long,String> replacements = new HashMap<Long,String>();
    Map<Long, String> sortedReplacements = null;
    
    //initialize string to search
    if(this.current == null){
      //start with axiom
      this.current = this.axiom;
    }
    
    searchMe = new String(this.current);
    
      
    //look in searchMe for each production rule key    
    for (String key : this.production_rules.keySet()) {
            
      Pattern pattern = Pattern.compile(key);
      //count if found key
      Matcher mtch = pattern.matcher(searchMe);
      Long count = 0l;
      while (mtch.find()){
        count +=1;
      }
      
      Integer fromIndex = 0;
      
      while(count>0){
        //locate key in axiom
        Long location = (long) searchMe.indexOf(key, fromIndex);
        //put location with replacement string
        replacements.put(location, key);
        fromIndex = (int) (location+1);
        count-=1;
      }    
    }
    StringBuffer resultBuffer = new StringBuffer();    
    if(!replacements.isEmpty()){
      sortedReplacements = new TreeMap<Long, String>();    
      sortedReplacements.putAll(replacements);
      //System.out.printf("SortedReplacements: "+sortedReplacements.toString());
      //go through sorted Replacements
      //replace each location in searchMe
      Integer beginIndex = 0;
      Long lastLocation = null;
      for (Long location : sortedReplacements.keySet()){     
        //System.out.printf("Location: "+location+"\n");
        if(location.intValue()>beginIndex){
          //add part of axiom to resulting string
          resultBuffer.append(new String(searchMe.substring(beginIndex, location.intValue())));
          //adjust index (with key length of the rule)
          beginIndex = location.intValue();
        }
        
        //add rule for key to resulting string
        resultBuffer.append(new String (this.production_rules.get(sortedReplacements.get(location))));
        
        //adjust index (with key length of the rule)
        beginIndex += sortedReplacements.get(location).length();
        lastLocation = location+sortedReplacements.get(location).length();
      }
      //add end of axiom (if possible)
      if(lastLocation != null && lastLocation.intValue()<searchMe.length()){
        resultBuffer.append(new String(searchMe.substring(lastLocation.intValue(), searchMe.length())));          
      }
      
    }    
    this.current = resultBuffer.toString();          
    this.level+=1;
    return this.current;
  }
  
}