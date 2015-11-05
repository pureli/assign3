PImage background1Img,background2Img,fighterImg,treasureImg,bloodImg,
enemyImg,start1Img,start2Img,end1Img,end2Img;

int x1;
int x2;
int x3,y3;//treasure
int x4;//blood
int x5;//enemy
float y5;//enemy
int x6,y6;//fighter
int fighterSpeed = 5;
float enemySpeed = floor(random(-8,8));
int gameState;
int GAME_START = 0;
int GAME_RUN  = 1;
int GAME_LOSE = 3;
int fighterStatus = 0;
boolean fighterUpPressed = false;
boolean fighterDownPressed = false;
boolean fighterLeftPressed = false;
boolean fighterRightPressed = false;

int enemyTeam1Y = 300;
int enemyTeam2Posy = 300;
int enemyTeam3Posy = 270;
int posTeam1X = -480;
int posTeam2X = -480;
int posTeam3X = -480;
boolean enemyTeam1 = true;
boolean enemyTeam2 = false;
boolean enemyTeam3 = false;

void setup(){  
  size(640,480);
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png"); 
  background1Img = loadImage("img/bg1.png");
  background2Img = loadImage("img/bg2.png");
  fighterImg = loadImage("img/fighter.png");
  treasureImg = loadImage("img/treasure.png");
  bloodImg = loadImage("img/hp.png");
  enemyImg = loadImage("img/enemy.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
  gameState = 0;

  x1 = 640;
  x2 = 0;
  x3 = floor(random(500));  
  y3 = floor(random(400));
  x4 = 20;
  x5 = 0;
  y5 = floor(random(400));
  x6 = 580;
  y6 = 240;

}

void draw(){
  //game start
  if(gameState == 0){
    image(start2Img,0,0);
  
    if(mouseX>1.0/3.0*width && mouseX<2.0/3.0*width && mouseY>3.0/4.0*height && mouseY<height){
      image(start1Img,0,0);
      
    if(mousePressed){
        gameState = 1;
      }
    }
  }    
  if (gameState == 1)  {
    //scroll background 
    image(background1Img,x1-640,0);
    image(background2Img,x2-640,0);
      
    x1 = x1+1;
    x2 = x2+1;
    
    x1 = x1%1280;
    x2 = x2%1280;
      
    //fighter
    image(fighterImg,x6-fighterImg.width*0.5,y6-fighterImg.height*0.5);
      
    //treasure
    image(treasureImg,x3,y3);
    
    //blood
    noStroke();
    fill(255,0,0);
    rect(33,15,x4*1.94,15);//blood bar
    image(bloodImg,20,10);
    
//three enemy team
      // enemy team1
      if(enemyTeam1 == true){
        int[] enemyTeam1Xs = {0,1,2,3,4};
        int unitX1 = 70;
        
        for (int i = 0; i < 5; i++){
            image(enemyImg,enemyTeam1Xs[i]*unitX1+posTeam1X,enemyTeam1Y);
            
            if(posTeam1X > width){
               posTeam1X = -480;
               enemyTeam1Y = floor(random(60,420));
               enemyTeam2 = true;
               enemyTeam1 = false;
            }
        }
        posTeam1X+=5;
      }
      
      if(enemyTeam2 == true){
      //enemy team2
        int[] enemyTeam2X = {0,1,2,3,4};
        float[] enemyTeam2Y = {0,-0.5,-1,-1.5,-2};
        int unitX2 = 70;
    
        for(int i = 0;i < 5; i++){
            image(enemyImg,enemyTeam2X[i]*unitX2+posTeam2X,enemyTeam2Y[i]*unitX2+enemyTeam2Posy);

            if(posTeam2X > width){
              posTeam2X = -480;
              enemyTeam2Posy = floor(random(140,410));
              enemyTeam3 = true;
              enemyTeam2 = false;
            }
        }
        posTeam2X+=5;
      }
      
      //enemy team3
      if(enemyTeam3 == true){
       int[] enemyTeam3X = {0,1,2,1,0,-1,-2,-1};
       int[] enemyTeam3Y = {-2,-1,0,1,2,1,0,-1};    
       int unitX3 = 70;
      
         for(int i = 0;i < 8;i++){
             image(enemyImg,enemyTeam3X[i]*unitX3+posTeam3X,enemyTeam3Y[i]*unitX3+enemyTeam3Posy);   

             if( posTeam3X > width*1.5){
               posTeam3X = -480;
               enemyTeam3Posy = floor(random(140,270));
               enemyTeam1 = true;
               enemyTeam3 = false;
             }
         }
         posTeam3X+=5;   
      }
      
    
    //scrollBack
    //x5 = x5%762;  
    if(x5>701){
      x5 = 0;
      y5 = floor(random(480));
     }
     
     
      //fighter position
      if(fighterUpPressed){
        if(y6>10){
          y6 = y6-fighterSpeed;
        }
      }
      if(fighterDownPressed){
        if(y6<height-60){
          y6 = y6+fighterSpeed;
        }
      }
      if(fighterLeftPressed){
        if(x6>10){
          x6 = x6-fighterSpeed;    
        }
      }
      if(fighterRightPressed){
        if(x6<width-60){
          x6 = x6+fighterSpeed;
        }
      }

    //fighter meet treasure
    int treasureDistX = x6-x3;
    int treasureDistY = y6-y3;
    int treasureDist = (int)sqrt(treasureDistX*treasureDistX+treasureDistY*treasureDistY);
    if(treasureDist <= fighterImg.width*0.5+treasureImg.width*0.5){
      if(x4 < 100){  
        x4= x4+10;
      }
        x3 = floor(random(400));
        y3 = floor(random(400));
    }
        
  }//state=1 condition end   
  
  
  //loseState
  if(x4 <= 13){
     gameState = 3;
  }

  //gameState = lose
  if(gameState == 3){
    image(end2Img,0,0);
    x5 = 0;
    y5 = floor(random(400));
    x4 = 20;
    if(mouseX>1.0/3.0*width && mouseX<2.0/3.0*width && mouseY>2.0/3.0*height && mouseY<3.0/4.0*height){
      image(end1Img,0,0);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }
  }      
      

} //draw end

void keyPressed(){
  if(keyCode == UP){
    fighterUpPressed = true;
  } 
  if(keyCode == DOWN){
    fighterDownPressed = true;
  }
  if(keyCode == LEFT){
    fighterLeftPressed = true;
  }
  if(keyCode == RIGHT){
    fighterRightPressed = true;
  }
}

void keyReleased(){
  if(keyCode == UP){
    fighterUpPressed = false;
  } 
  if(keyCode == DOWN){
    fighterDownPressed = false;
  }
  if(keyCode == LEFT){
    fighterLeftPressed = false;
  }
  if(keyCode == RIGHT){
    fighterRightPressed = false;
  }
}
