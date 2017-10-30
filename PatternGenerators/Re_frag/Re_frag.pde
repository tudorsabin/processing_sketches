void setup(){
  size(1800, 1000, P3D); 
  background(255);
  frameRate(24);
}

void draw(){
  float rotator_speed=0.1;
  float radius1 = 120*rotator_speed*frameCount;
  float radius2 = 110*rotator_speed*frameCount; 
  float linemove = 0.08*frameCount;
  
  if(frameCount%4==0){
    ellipse(1800/2,1000/2,radius1,radius1);
    ellipse(1800/2,1000/2,radius2,radius2);
  }
  
  
  //ellipse(1800/2,1000/2,radius1-20*rotator_speed*frameCount,radius1-20*rotator_speed*frameCount);
  //ellipse(1800/2,1000/2,radius2-30*rotator_speed*frameCount,radius2-30*rotator_speed*frameCount);
  
  if(frameCount%8==0){
      line(1800/2+400,1000/2-100,1800/2+200,1000/2+100);
      line(1800/2-400,1000/2-100,1800/2-200,1000/2+100);
  }
  if(frameCount%2==0){
    line((1800/2+100),(1000/2-100)*linemove,(1800/2+100),(1000/2+100)*linemove);
    line((1800/2-100),(1000/2-100)*linemove,(1800/2-100),(1000/2+100)*linemove);
  }
  
  
  //update
  if(radius1>200){
    frameCount = 0;
    clear();
    background(255);
  }
}