int lvl=4;
int corners=4;
ArrayList<String> iterationArray;

int angleDiv = 360/corners;
float theta = radians(angleDiv);
float drawLength=100;

void setup(){
  background(255);
  stroke(0);
  size(1800, 1000, P3D);
  iterationArray = setupSystem(lvl);

  noLoop();
}
void draw(){
  String production = iterationArray.get(lvl);
  translate(width/1.5, height/1.5);
  
  stroke(255,0,255,120);
  line(0,0,drawLength*2,0);
  stroke(0);
  
  float scaling = 0.5/lvl;
  
  
  int steps = production.length();
  for (int i = 0; i < steps; i++) {           
      char step = production.charAt(i);      
                 
      if (step == 'F') {
        //FORWARD
        //draw circle
        stroke(0,245,190);
        ellipse(0,0,drawLength*2*scaling,drawLength*2*scaling);
        
        stroke(0);
        //draw line forward
        line(0, 0, 0, -drawLength*scaling);      
        translate(0, -drawLength*scaling);
                                
      }else if (step == 'S') {
        //SKIP
        //draw circle
        stroke(0,145,220);
        ellipse(0,0,drawLength*2*scaling,drawLength*2*scaling);
        
        stroke(0);
        //draw line forward
        //line(0, 0, 0, -drawLength*scaling);      
        translate(0, -drawLength*scaling);
                                
      }else if (step == '-') {
        rotate(-theta);
      }else if (step == '+') {  
        rotate(theta);
      }
    }
    stroke(205,215,0);
    line(0,0,drawLength*2,0);
  
}

ArrayList<String> setupSystem(int level){
  ArrayList<String> alphabet = new ArrayList<String>();
  alphabet.add("F");
  alphabet.add("S");
  alphabet.add("-");
  alphabet.add("+");
    
  String axiom = "F-F-F-F--F+F+F+F";
  
  Map<String, String> rules = new HashMap<String, String>();
  rules.put("F","F+F--SF+F-F++SFF---F+F--F+F+F");
  
  GenericLSystem sys = new GenericLSystem(alphabet,axiom,rules);
  ArrayList<String> iterations = new ArrayList<String>(level+1);
  
  for(int i=0;i<=level;i++){    
    if(i==0){
      iterations.add(sys.axiom);
      System.out.printf("Iterated");
    }
    else
      iterations.add(sys.iterate());
      System.out.printf("Iteration("+i+") : "+iterations.get(i)+"\n");
  }
  return iterations;
}