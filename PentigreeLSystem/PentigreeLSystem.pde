import com.hamoid.*;
VideoExport videoExport;

Map<Integer, ArrayList<String>> data_points;
//GEOMETRY
int lvl=2;

int corners1 = 5;
int corners2 = 4;
int corners3 = 8;
int corners4 = 16;
float scaling = 0.4/lvl;
float scale = 1.0;

int angleDiv1 = 360/corners1;
int angleDiv2 = 360/corners2;
int angleDiv3 = 360/corners3;
int angleDiv4 = 360/corners4;
float theta1 = radians(angleDiv1);
float theta2 = radians(angleDiv2);
float theta3 = radians(angleDiv3);
float theta4 = radians(angleDiv4);

//COLORS
int[][] colors;
int nr_of_colors=3*3;
int color_count = 0;
int line_opacity = 12;
int fill_opacity = 6;

//VIDEO
int frate=24;
int refresh=frate*2;
int frame=0;

boolean recording=false;

void setup(){
  background(255);
  size(1800, 1000, P3D);
  //fullScreen();
  frameRate(frate);
  smooth();
  
  
  colors = generate_colors(nr_of_colors);
   
   
  data_points = prepare_systems(); 
   
  
  //noLoop();
  if(recording)
    videoExport = new VideoExport(this, "basic.mp4");
}

void keyPressed(){
  if(key =='r' || key=='R'){
    recording = !recording;  
  }  
}

void draw(){
  scale=scale+frame*0.001;
  
  clear();
  background(255);
  
  if(frame%4==0){    
    line_opacity+=2;
    fill_opacity+=1;
  }      
  //videoExport.saveFrame();
  
  drawSystem(data_points.get(1), lvl, theta1, scaling, width/3, height*8/10, 400/lvl, true);
  
  frame+=1;
  //System.out.printf("frame: "+frame);
  
  if( (frame%refresh)==0 ){    
    //nr_of_colors+=1;
    colors = generate_colors(nr_of_colors);    
    clear();
    frame=0;
    scale=1.0;
    background(255); 
    line_opacity = 12;
    fill_opacity = 6;
  }else{
    if(recording){
      saveFrame("output/frame_######.png");      
    }
  }
  
  
}

ArrayList<String> setupSystem(ArrayList<String> alph, String axiom, Map<String, String> rules, int maxlevel){       
     
  GenericLSystem sys = new GenericLSystem(alph,axiom,rules);
  ArrayList<String> iterations = new ArrayList<String>(maxlevel+1);
  
  for(int i=0;i<=maxlevel;i++){    
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

void drawSystem(ArrayList<String> iterationArray, int level, float theta, float scaling, int trw, int trh, int flength, boolean show_origin){
  String production = iterationArray.get(level);
  translate(trw, trh);     
  
  //ORIGIN
  if(show_origin){
    stroke(0);
    ellipse(0 , 0, 400, 400);
    line(0,0,500,500);  
  }
  
  int steps = production.length();
  for (int i = 0; i < steps; i++) {           
      char step = production.charAt(i);        
               
      if (step == 'F') {            

        //draw circles
        //stroke(0,245,190);
        stroke(colors[color_count%nr_of_colors][0], colors[color_count%nr_of_colors][1], colors[color_count%nr_of_colors][2]);
        
        point(0, 0);
        
        stroke(colors[color_count%nr_of_colors][0], colors[color_count%nr_of_colors][1], colors[color_count%nr_of_colors][2], line_opacity);
        fill(colors[color_count%nr_of_colors][0], colors[color_count%nr_of_colors][1], colors[color_count%nr_of_colors][2], fill_opacity);
        
        
        float radius = flength*scaling*scale;
        ellipse(0 , 0, radius, radius);
        

        //sphere(radius); //very slow
        
        color_count+=1;
        //stroke(0);        
        //draw line forward
        //line(0, 0, 0, -drawLength*scaling);      
        translate(0, -flength*scaling);                          
      
      }else if (step == '-') {
        rotate(-theta);
        //color_count+=1;
      }else if (step == '+') {  
        rotate(theta);
        //color_count+=1;
      }
    } 
    
    if(show_origin){
      stroke(0);
    }
    
}


Map<Integer, ArrayList<String>> prepare_systems(){
  
  Map<Integer, ArrayList<String>> point_map = new HashMap<Integer, ArrayList<String>>();
  //PENTIGREE
  ArrayList<String> alphabet1 = new ArrayList<String>();
  alphabet1.add("F");
  alphabet1.add("-");
  alphabet1.add("+");  
  //String axiom1 = "F";  
  String axiom1 = "-F-F-F-F-F";  
  Map<String, String> rules1 = new HashMap<String, String>();
  rules1.put("F","F-F++F+F-F-F");
  
  ArrayList<String> iterationArray1 = setupSystem(alphabet1, axiom1, rules1, lvl); 
  
  //FOURGREE 
  //String axiom2 = "F";  
  String axiom2 = "-F-F-F-F";
  
  Map<String, String> rules2 = new HashMap<String, String>();
  rules2.put("F","F-F++F+F-F-F+F-F");
  
  ArrayList<String> iterationArray2 = setupSystem(alphabet1, axiom2, rules2, lvl);

  point_map.put(1,iterationArray1);
  point_map.put(2,iterationArray2);
  
  return point_map;
}



int[][] generate_colors(int nr_of_colors){
   int [][] color_array = new int[nr_of_colors][4];
   for(int k=0;k<nr_of_colors;k++){
     int r = int(random(0, 255));
     int g = int(random(0, 255));
     int b = int(random(0, 255));
     int opacity = int(random(60, 255));
     color_array[k][0]=r;
     color_array[k][1]=g;
     color_array[k][2]=b;
     color_array[k][3]=opacity;
   } 
   //print();
   return color_array;
}