int screen_length = 1800;
int screen_width = 1000;
int xcenter = screen_length/2;
int ycenter = screen_width/2;
int xsymmetry= screen_length/4;
int ysymmetry= screen_width/4;
int symmetry = 500;
int[][] colors;
int nr_of_colors=2;
int fill_color=0;

void setup(){
  size(1800, 1000, P3D); 
  background(255);
  //frameRate(10);
  noStroke();
  smooth(); 
  colors = generate_colors(nr_of_colors);
  //videoExport = new VideoExport(this, "basic.mp4");
}

void draw(){ 
  float rotate = 0;
  int count = 0;
   
  for(int i = 0; i<1000; i+=symmetry){
    for(int j = 0; j<1800; j+=symmetry){    
      print(count);      
      pushMatrix();
      
      translate(j,i);          
      mirror_flip(count,1);            
      random_draw(j,i, rotate,count);
      popMatrix();
      count +=1;                
    }    
    
  }
  if(frameCount==10){
    noLoop();
  }
  //videoExport.saveFrame();
}



void random_draw(int trans_x, int trans_y,float rotate, int count){
    //do background squares
    fill(colors[count%nr_of_colors][0], colors[count%nr_of_colors][1], colors[count%nr_of_colors][2]);
    rect(0, 0, symmetry, symmetry);
  
    //select colors
    stroke(colors[(count+1)%nr_of_colors][0], colors[(count+1)%nr_of_colors][1], colors[(count+1)%nr_of_colors][2]);
    fill(colors[(count+1)%nr_of_colors][0], colors[(count+1)%nr_of_colors][1], colors[(count+1)%nr_of_colors][2]);        
    
        
    line(0,200, 460, 200);
    line(40,150, 500, 150);
    
    ellipse(symmetry/2,symmetry/2,100%symmetry,20%symmetry);
    rect(20%symmetry,20%symmetry,40%symmetry,40%symmetry);
    
    noStroke();
    fill(0);
    rect(480%symmetry,480%symmetry,40%symmetry,40%symmetry);
    /*
    if(frameCount%100==0){
      fill_color=255-fill_color;
    }*/
    
    noStroke();
}
 
 int[][] generate_colors(int nr_of_colors){
     int [][] color_array = new int[nr_of_colors][4];
     for(int k=0;k<nr_of_colors;k++){
       int r = int(random(0, 255));
       int g = int(random(0, 255));
       int b = int(random(0, 255));
       int opacity = int(random(20, 192));
       color_array[k][0]=r;
       color_array[k][1]=g;
       color_array[k][2]=b;
       color_array[k][3]=opacity;
     } 
     //print();
     return color_array;
 }
 
 void mirror_flip(int count, int type){
   if(type==1){
     if(count%8==2 || count%8==3){
        translate(symmetry, 0);
        scale(-1,1);
      }                  
      if(count%8==5 || count%8==4){
        translate(0, symmetry);
        scale(1,-1);
      }
      if(count%8==6 || count%8==7){
        translate(symmetry, symmetry);
        scale(-1,-1);        
      }
    }
    if(type==2){
    
    } 
 }