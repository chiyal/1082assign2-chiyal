PImage bgImg, soilImg, lifeImg, soldierImg, cabbageImg;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage startNormalImg, startHoveredImg, restartNormalImg, restartHoveredImg, titleImg, gameoverImg;

//boolean upPressed = false;
boolean downPressed, leftPressed, rightPressed = false;
boolean noPressed = true;

final int GAME_START = 0, LIFE_1 = 1, LIFE_2 = 2, LIFE_3 = 3, GAME_OVER = 4, GAME_WIN = 5;
int gameState = GAME_START;

final int GH_IDLE_STATE = 5, GH_DOWN_STATE = 6, GH_LEFT_STATE = 7, GH_RIGHT_STATE = 8;
int keyState = GH_IDLE_STATE;

final int BUTTON_TOP = 360, BUTTON_BOTTOM = 420, BUTTON_LEFT = 248, BUTTON_RIGHT = 392;

int grid = 80;
int skyToGround  = grid*2; // sky to ground distancedistance
int xLifeInterval = 70; //x axis life interval
int soldierX;
int groundhogIdleImgX, groundhogIdleImgY;
int groundhogSpeed = 80/16;  //framerate 60 to framerate 15

float soldierY = grid * floor(random (2, 6));  //random place
float cabbageX = grid * floor(random (0, 8)); 
float cabbageY = grid * floor(random (2, 6)); 

void setup() {
  frameRate(60);
  size(640, 480, P2D);

  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  lifeImg = loadImage("img/life.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png"); 

  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");  
  titleImg = loadImage("img/title.jpg");  
  gameoverImg = loadImage("img/gameover.jpg"); 
  
  groundhogIdleImgY = height / 6;
  groundhogIdleImgX = width / 8 - grid;
}

void draw() {
  
  switch(gameState){
   case GAME_START:
     downPressed = false;
     leftPressed = false;
     rightPressed = false;
     image(titleImg, 0, 0);
     if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
       image(startHoveredImg, 248, 360);
       if(mousePressed){
         gameState = LIFE_2;
        }
      }else{
        image(startNormalImg, 248, 360);
      }
  break;  
  case LIFE_3:
    //background image
    image(bgImg, 0, 0);  
    //draw the grass
    fill(124, 204, 25);
    noStroke();
    rect(0, skyToGround - 15, 640, 15); 
    //draw the sun
    fill(253, 184, 19); 
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(640 - 50, 50, 120, 120);
    
    //life*3
    image(lifeImg, 10, 10);
    image(lifeImg, 10 + xLifeInterval, 10);
    image(lifeImg, 10 + xLifeInterval * 2, 10);  
    image(soilImg, 0, skyToGround); //the soil would be renew each time 
    
    image(soldierImg, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
      
    //set soldier moving cycle
      if(soldierX>640){
      soldierX = -80; //emerge from the left
      } 

    image(cabbageImg, cabbageX, cabbageY);
    
    //when soldier meet the groundhog
     if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
       if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){          
          keyState = GH_IDLE_STATE;
          groundhogIdleImgY = height / 6;
          groundhogIdleImgX = width / 8 - grid;
          gameState = LIFE_2;
          noPressed = true;
       }
     }

     switch (keyState){      
      case GH_IDLE_STATE:
           if(noPressed == true){
           image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
           }
           
      break;
      case GH_DOWN_STATE:
           if(groundhogIdleImgX %80 == 0){  
             noPressed = false;
             leftPressed = false;
             rightPressed = false;
             image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgY += groundhogSpeed;
           
           if(groundhogIdleImgY %80 == 0){
             downPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
         
      break;
      case GH_LEFT_STATE: 
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             rightPressed = false;
             downPressed = false;
             image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX -= groundhogSpeed;
           
           if(groundhogIdleImgX %80 == 0){
             leftPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}

      break;  
      case GH_RIGHT_STATE:
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             leftPressed = false;
             downPressed = false;
             image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX += groundhogSpeed;
         
           if(groundhogIdleImgX %80 == 0){
             rightPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
       break;
    }

  break;   
  case LIFE_2:
    //background image
    image(bgImg, 0, 0);  
    //draw the grass
    fill(124, 204, 25);
    noStroke();
    rect(0, skyToGround - 15, 640, 15); 
    //draw the sun
    fill(253, 184, 19); 
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(640 - 50, 50, 120, 120);
    
    //life*2
    image(lifeImg, 10, 10);
    image(lifeImg, 10 + xLifeInterval, 10);
    image(soilImg, 0, skyToGround); //the soil would be renew each time 
    
    image(soldierImg, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
      
    //set soldier moving cycle
    if(soldierX>640){
     soldierX = -80; //emerge from the left
     }   
     
    image(cabbageImg, cabbageX, cabbageY);
    
    //add the life and cabbage disappear 
    if(groundhogIdleImgX + grid*4 +80 > cabbageX && groundhogIdleImgX + grid*4 < cabbageX + 80){
      if(groundhogIdleImgY + 80 > cabbageY && groundhogIdleImgY < cabbageY + 80){
         cabbageX = -80;
         gameState = LIFE_3; 
       }
     }
     
    //when soldier meet the groundhog
     if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
       if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){ 
          keyState = GH_IDLE_STATE;
          groundhogIdleImgY = height / 6;
          groundhogIdleImgX = width / 8 - grid;
          gameState = LIFE_1;
          noPressed = true;
       }
     }
     
     switch (keyState){      
      case GH_IDLE_STATE:
           if(noPressed == true){
           image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
           }
           
      break;
      case GH_DOWN_STATE:
           if(groundhogIdleImgX %80 == 0){  
             noPressed = false;
             leftPressed = false;
             rightPressed = false;
             image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgY += groundhogSpeed;
             
           if(groundhogIdleImgY %80 == 0){
             downPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
         
      break;
      case GH_LEFT_STATE: 
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             rightPressed = false;
             downPressed = false;
             image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX -= groundhogSpeed;
       
           if(groundhogIdleImgX %80 == 0){
             leftPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}

      break;  
      case GH_RIGHT_STATE:
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             leftPressed = false;
             downPressed = false;
             image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX += groundhogSpeed;
         
           if(groundhogIdleImgX %80 == 0){
             rightPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
       break;
    }

  break; 
  case LIFE_1:
    //background image
    image(bgImg, 0, 0);  
    //draw the grass
    fill(124, 204, 25);
    noStroke();
    rect(0, skyToGround - 15, 640, 15); 
    //draw the sun
    fill(253, 184, 19); 
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(640 - 50, 50, 120, 120);
    
    //life*1
    image(lifeImg, 10, 10);
    image(soilImg, 0, skyToGround); //the soil would be renew each time 
    
    image(soldierImg, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
      
    //set soldier moving cycle
    if(soldierX>640){
      soldierX = -80; //emerge from the left
     }
     
    image(cabbageImg, cabbageX, cabbageY);

    //add the life and cabbage disappear 
    if(groundhogIdleImgX + grid*4 +80 > cabbageX && groundhogIdleImgX + grid*4 < cabbageX + 80){
      if(groundhogIdleImgY + 80 > cabbageY && groundhogIdleImgY < cabbageY + 80){
         cabbageX = -80;
         gameState = LIFE_2; 
       }
     }
     
    //when soldier meet the groundhog
     if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
       if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){ 
          keyState = GH_IDLE_STATE;
          groundhogIdleImgY = height / 6;
          groundhogIdleImgX = width / 8 - grid;
          gameState = GAME_OVER;
          noPressed = true;
       }
     }
    
     switch (keyState){      
      case GH_IDLE_STATE:
           if(noPressed == true){
           image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
           }
           
      break;
      case GH_DOWN_STATE:
           if(groundhogIdleImgX %80 == 0){  
             noPressed = false;
             leftPressed = false;
             rightPressed = false;
             image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgY += groundhogSpeed;
           
           if(groundhogIdleImgY %80 == 0){
             downPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
         
      break;
      case GH_LEFT_STATE: 
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             rightPressed = false;
             downPressed = false;
             image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX -= groundhogSpeed;
           
           if(groundhogIdleImgX %80 == 0){
             leftPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}

      break;  
      case GH_RIGHT_STATE:
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             leftPressed = false;
             downPressed = false;
             image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX += groundhogSpeed;
         
           if(groundhogIdleImgX %80 == 0){
             rightPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
       break;
    }

  break;   
  case GAME_OVER:
    downPressed = false;
    leftPressed = false;
    rightPressed = false;
    image(gameoverImg, 0, 0);
    if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
      image(restartHoveredImg, 248, 360);    
       if(mousePressed){
         float restartSoldierY = grid * floor(random (2, 6));
         float restartCabbageX = grid * floor(random (1, 8));
         float restartCabbageY = grid * floor(random (2, 6)); 
         soldierY = restartSoldierY;
         cabbageX = restartCabbageX;
         cabbageY = restartCabbageY;
         gameState = LIFE_2;
        }
      }else{
        image(restartNormalImg, 248, 360);
    }
      
   break;
  }
}
  

void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      //case UP:
      //upPressed = true;
      //  if(upPressed){
      //  groundhogIdleImgY -= grid;
      //  }
      //  //boundary detection
      //  if(groundhogIdleImgY <= grid){
      //  groundhogIdleImgY = grid;
      //  }
      //break;
      case DOWN:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){    
        //boundary detection
        if(groundhogIdleImgY <= height - grid*2){
          downPressed = true;
          keyState = GH_DOWN_STATE;
        }
      }
      break;
      case LEFT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        //boundary detection
        if(groundhogIdleImgX + grid*3 >= 0){
          leftPressed = true;
          keyState = GH_LEFT_STATE;
        }   
      }
      break;
      case RIGHT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        //boundary detection
        if(groundhogIdleImgX + grid*6 <= width){
          rightPressed = true;
          keyState = GH_RIGHT_STATE;
        }   
      }
      break;   
    }
  }
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case DOWN:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(downPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
      case LEFT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(leftPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
      case RIGHT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(rightPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
    }
  }
}
