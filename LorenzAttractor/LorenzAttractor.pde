/*
Lorencz Attractor funtion and example
Tudor Sabin Topoleanu
*/

float xd, yd, zd;
float beta, sigma, rho;
float x, y, z, dt;
int count = 100;
float [] xarr, yarr, zarr; 
float scale = 5;

void setup(){
  size(860, 540, P3D);  
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 100);
  
  //set initial state/conditions
  x=0.1;
  y=0;
  z=0;
  
  //set time step
  dt=0.001;
  
  xarr = new float[count];
  yarr = new float[count];
  zarr = new float[count];
  
  //set parameters
  sigma = 10.0;
  rho = 28.0;
  beta = 8.0/3.0;
  
  background(255);
    
  noSmooth();

}

void draw() {    
  calculateLine();
  renderLine();  
}

void calculateLine(){    
  for(int i=0;i<count;i++){
    xd = x+(sigma * (y-x))*dt;
    yd = y+((rho-z)*x - y)*dt;
    zd = z+(x*y - beta*z)*dt;
    x = xd;
    y = yd;
    z = zd;
    //print("[x:"+x+"|y:"+y+"|z:"+z+"]");
    xarr[i]=x;
    yarr[i]=y;
    zarr[i]=z;
  }
  
}

void renderLine() {
  for(int i=0;i<count;i++){
    fill(0);  
    point(width/2+(xarr[i]*scale),height/2+(yarr[i]*scale),-100+(zarr[i]*scale));
  }
  
}