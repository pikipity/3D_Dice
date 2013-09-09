int[] windowSize={300,700};//Windows Size
boolean clickTag=false;//Control Click
int L=100;//Length of dice
int edge=10;//Space of figure
int[] initLocation={windowSize[0]/2,windowSize[1]-100,-50};//Initial Location
float defaultSpeed=600;
float initSpeed=defaultSpeed;//Initial Speed
float a=-300.000;//Acceleration
float[] InitPhase={0,random(-2*PI,2*PI),0};
PGraphics faceOne;
PGraphics faceTwo;
PGraphics faceThree;
PGraphics faceFour;
PGraphics faceFive;
PGraphics faceSix;
long currentTime=0;
long pastTime=0;
float speed;
float displacement;
float phaseX=InitPhase[0];
float phaseY=InitPhase[1];
float phaseZ=InitPhase[2];
float phaseSpeed=0;
int i=0;

void setup(){
  //Windows setting
  size(windowSize[0],windowSize[1],P3D);
  smooth();
  frameRate(30);
  //Define 6 faces
  drawFigure();
  //Init dice
  dice(initLocation[0],initLocation[1],initLocation[2],InitPhase[0],InitPhase[1],InitPhase[2]);
}

void draw(){
  if(clickTag){
    float t=(System.currentTimeMillis()-pastTime)/1000.000;//Calculate time for displacement
    speed=initSpeed+a*t;//calculate speed for phase Y
    displacement=Math.round((initSpeed*t+0.500*a*Math.pow(t,2))*100)/100.000;//calculate displacement
    if(displacement<0){displacement=0;}//make sure that displacement is not a negative number
    switch(i){
      case 1:phaseY=phaseY-PI/4*Math.abs(displacement)/phaseSpeed;break;
      case 2:phaseX=phaseX-PI/4*Math.abs(displacement)/phaseSpeed;break;
      case 3:phaseZ=phaseZ-PI/4*Math.abs(displacement)/phaseSpeed;break;
      default:println("i wrong");break;
    }
    dice(initLocation[0],initLocation[1]-displacement,initLocation[2],phaseX,phaseY,phaseZ);//draw dice
    //When displacement=0, rebound and initSpeed/2
    if(displacement==0){
      initSpeed=initSpeed/2;
      pastTime=System.currentTimeMillis();
      //if initSpeed<30, stop and redefine clickTag and initSpeed for next click
      if(initSpeed<30){
        clickTag=false;
        initSpeed=defaultSpeed;
      }
    }
  }
}

void mouseClicked(){
  if(!clickTag){
    phaseSpeed=random(500,1500);
    i=int(random(1,4));
    pastTime=System.currentTimeMillis();
    clickTag=true;
  }
}

void dice(float x,float y,float z,float phaseX,float phaseY,float phaseZ){
  background(255);
  translate(x,y,z);
  rotateX(phaseX); 
  rotateY(phaseY);
  rotateZ(phaseZ);
  drawDice();
}

void drawDice(){
   //face 1
   beginShape();
   strokeWeight(3);
   texture(faceOne);
   vertex(-L/2,-L/2,L/2,0,0);
   vertex(L/2,-L/2,L/2,L,0);
   vertex(L/2,L/2,L/2,L,L);
   vertex(-L/2,L/2,L/2,0,L);
   vertex(-L/2,-L/2,L/2,0,0);
   endShape();
   //face 2
   beginShape();
   strokeWeight(3);
   texture(faceTwo);
   vertex(L/2,-L/2,L/2,0,0);
   vertex(L/2,-L/2,-L/2,L,0);
   vertex(L/2,L/2,-L/2,L,L);
   vertex(L/2,L/2,L/2,0,L);
   vertex(L/2,-L/2,L/2,0,0);
   endShape();
   //face 3
   beginShape();
   strokeWeight(3);
   texture(faceThree);
   vertex(L/2,-L/2,-L/2,0,0);
   vertex(-L/2,-L/2,-L/2,L,0);
   vertex(-L/2,L/2,-L/2,L,L);
   vertex(L/2,L/2,-L/2,0,L);
   vertex(L/2,-L/2,-L/2,0,0);
   endShape();
   //face 4
   beginShape();
   strokeWeight(3);
   texture(faceFour);
   vertex(-L/2,-L/2,L/2,0,0);
   vertex(-L/2,-L/2,-L/2,L,0);
   vertex(-L/2,L/2,-L/2,L,L);
   vertex(-L/2,L/2,L/2,0,L);
   vertex(-L/2,-L/2,L/2,0,0);
   endShape();
   //face 5
   beginShape();
   strokeWeight(3);
   texture(faceFive);
   vertex(-L/2,-L/2,-L/2,0,0);
   vertex(L/2,-L/2,-L/2,L,0);
   vertex(L/2,-L/2,L/2,L,L);
   vertex(-L/2,-L/2,L/2,0,L);
   vertex(-L/2,-L/2,-L/2,0,0);
   endShape();
   //face 6
   beginShape();
   strokeWeight(3);
   texture(faceSix);
   vertex(-L/2,L/2,-L/2,0,0);
   vertex(L/2,L/2,-L/2,L,0);
   vertex(L/2,L/2,L/2,L,L);
   vertex(-L/2,L/2,L/2,0,L);
   vertex(-L/2,L/2,-L/2,0,0);
   endShape();
}

void drawFigure(){
  //Face 1 figure
  faceOne=createGraphics(L,L);
  faceOne.beginDraw();
  faceOne.noStroke();
  faceOne.background(255);
  faceOne.fill(0);
  faceOne.ellipse(faceOne.width*0.5,faceOne.height*0.5,faceOne.height*0.5,faceOne.height*0.5);
  faceOne.endDraw();
  //Face 2 figure
  faceTwo=createGraphics(L,L);
  faceTwo.beginDraw();
  faceTwo.noStroke();
  faceTwo.background(255);
  faceTwo.fill(0);
  faceTwo.ellipse((faceTwo.width-edge*3)/4+edge,faceTwo.width/2,(faceTwo.width-edge*3)/2,(faceTwo.width-edge*3)/2);
  faceTwo.ellipse(faceTwo.width-edge-(faceTwo.width-edge*3)/4,faceTwo.width/2,(faceTwo.width-edge*3)/2,(faceTwo.width-edge*3)/2);
  faceTwo.endDraw();
  //Face 3 figure
  faceThree=createGraphics(L,L);
  faceThree.beginDraw();
  faceThree.noStroke();
  faceThree.background(255);
  faceThree.fill(0);
  faceThree.ellipse((faceThree.width-edge*4)/3/2+edge,faceThree.width/2,(faceThree.width-edge*4)/3,(faceThree.width-edge*4)/3);
  faceThree.ellipse((faceThree.width-edge*4)/3/2*3+edge*2,faceThree.width/2,(faceThree.width-edge*4)/3,(faceThree.width-edge*4)/3);
  faceThree.ellipse(faceThree.width-edge-(faceThree.width-edge*4)/3/2,faceThree.width/2,(faceThree.width-edge*4)/3,(faceThree.width-edge*4)/3);
  faceThree.endDraw();
  //Face 4 figure
  faceFour=createGraphics(L,L);
  faceFour.beginDraw();
  faceFour.noStroke();
  faceFour.background(255);
  faceFour.fill(0);
  faceFour.ellipse((faceFour.width-edge*3)/4+edge,(faceFour.width-edge*3)/4+edge,(faceFour.width-edge*3)/2,(faceFour.width-edge*3)/2);
  faceFour.ellipse((faceFour.width-edge*3)/4+edge,faceFour.width-edge-(faceFour.width-edge*3)/4,(faceFour.width-edge*3)/2,(faceFour.width-edge*3)/2);
  faceFour.ellipse(faceFour.width-edge-(faceFour.width-edge*3)/4,(faceFour.width-edge*3)/4+edge,(faceFour.width-edge*3)/2,(faceFour.width-edge*3)/2);
  faceFour.ellipse(faceFour.width-edge-(faceFour.width-edge*3)/4,faceFour.width-edge-(faceFour.width-edge*3)/4,(faceTwo.width-edge*3)/2,(faceFour.width-edge*3)/2);
  faceFour.endDraw();
  //Face 5 figure
  faceFive=createGraphics(L,L);
  faceFive.beginDraw();
  faceFive.noStroke();
  faceFive.background(255);
  faceFive.fill(0);
  faceFive.ellipse((faceFive.width/2-edge*3)/3+edge,edge+(faceFive.width/2-edge*3)/3,(faceFive.width/2-edge*3)/3*2,(faceFive.width/2-edge*3)/3*2);
  faceFive.ellipse((faceFive.width/2-edge*3)/3+edge,faceFive.width-edge-(faceFive.width/2-edge*3)/3,(faceFive.width/2-edge*3)/3*2,(faceFive.width/2-edge*3)/3*2);
  faceFive.ellipse(faceFive.width-edge-(faceFive.width/2-edge*3)/3,edge+(faceFive.width/2-edge*3)/3,(faceFive.width/2-edge*3)/3*2,(faceFive.width/2-edge*3)/3*2);
  faceFive.ellipse(faceFive.width-edge-(faceFive.width/2-edge*3)/3,faceFive.width-edge-(faceFive.width/2-edge*3)/3,(faceFive.width/2-edge*3)/3*2,(faceFive.width/2-edge*3)/3*2);
  faceFive.ellipse(faceFive.width/2,faceFive.width/2,(faceFive.width/2-edge*3)/3*2,(faceFive.width/2-edge*3)/3*2);
  faceFive.endDraw();
  //Face 6 figure
  faceSix=createGraphics(L,L);
  faceSix.beginDraw();
  faceSix.noStroke();
  faceSix.background(255);
  faceSix.fill(0);
  faceSix.ellipse((faceSix.width-edge*3)/4+edge,(faceSix.width-edge*4)/3/2+edge,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.ellipse((faceSix.width-edge*3)/4+edge,(faceSix.width-edge*4)/3/2*3+edge*2,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.ellipse((faceSix.width-edge*3)/4+edge,faceSix.width-edge-(faceSix.width-edge*4)/3/2,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.ellipse(faceSix.width-edge-(faceSix.width-edge*3)/4,(faceSix.width-edge*4)/3/2+edge,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.ellipse(faceSix.width-edge-(faceSix.width-edge*3)/4,(faceSix.width-edge*4)/3/2*3+edge*2,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.ellipse(faceSix.width-edge-(faceSix.width-edge*3)/4,faceSix.width-edge-(faceSix.width-edge*4)/3/2,(faceSix.width-edge*4)/3,(faceSix.width-edge*4)/3);
  faceSix.endDraw();
}
