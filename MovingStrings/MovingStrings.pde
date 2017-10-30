/*
Standing Wave funtion and examples
Tudor Sabin Topoleanu
*/


int arr_size=100;
boolean looping;
float dx=0.01, dt=0.001, dy;
float startx, startt;


void setup(){  
  size(860, 540);
  background(255);
  fill(0);
  frameRate(100);
  noLoop();
  smooth();
  looping=false;   
  startx=0;
  startt=0;
}
void draw(){  
  
  if(looping){
    float[] xarr1 = new float[arr_size];
    float[] yarr1 = new float[arr_size];
    float[] xarr2 = new float[arr_size];
    float[] yarr2 = new float[arr_size];
    float[] xarr3 = new float[arr_size];
    float[] yarr3 = new float[arr_size];
    
    standingWave(startx,startt,10,0.5,200, xarr1, yarr1);     
    standingWave(startx,startt,10,1,200, xarr2, yarr2);       
    standingWave(startx,startt,10,1,400, xarr3, yarr3);   
    
    startx=startx+dx*arr_size;    
    startt=startt+dt*arr_size;
    
    renderWave(xarr1, yarr1, 2.5);
    renderWave(xarr2, yarr2, 2.0);
    renderWave(xarr3, yarr3, 1.5);
  }
  
}

/*
start x & t are positions from which to calculate y value
amp [pixels], freq [Hz] and wl[pixels] (wavelength) are parameters
X & Y are buffer arrays for calculation faster than the draw loop
*/
void standingWave(float startx, float startt, float amp, float freq, float wl, float[] X, float[] Y){        
    //variables   
    float x, t, y, y1 , y2;
    //constants
    Float PI2 = new Float(2*Math.PI);    
    float W = PI2*freq;
    float k = PI2/wl;  
    //print("Print me!");
    x = startx;
    t = startt;
    for(int i=0; i<arr_size; i++){
      x = x+dx;
      t = t+dt;
      y1 = amp*(sin(k*x-W*t));
      y2 = amp*(sin(k*x+W*t));
      y = y1+y2;
      //print("[x:"+x+"|y:"+y+"]");
      X[i]=x;
      Y[i]=y;      
    }            
}

void renderWave(float[] X, float[] Y, float div){    
  for(int i=0; i<Y.length;i++){ 
    point(X[i],height/div+Y[i]);
  }
}

void mousePressed() {  
  //loop/stop
  if(mouseButton == LEFT){
    if(!looping){
      loop();
      looping=true;
    }else{
      noLoop();
      looping=false;      
    }    
  }
  //reset
  if(mouseButton == RIGHT){
    looping=false;
    clear();
    background(255);
    fill(0);
    noLoop();
    startx=0;
    startt=0;
    //redraw();
  }
  
}