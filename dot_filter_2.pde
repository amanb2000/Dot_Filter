PImage img;

int dotSize = 50;
float space = dotSize+2;
float cutoff = dotSize;
void setup(){
  img = loadImage("test.jpg");//PUT YOUR IMAGE HERE
  size(1200, 800);
  loadPixels();
  float w = img.width;
  float h = img.height;
  
  float factor = -1;
  
  if(w/h > 1200/800){
     factor = 1200/w;
  }
  else{
    factor = 800/h;
  }
  
  
  
  img.resize((int)(w*factor), (int)(h*factor));
  //print(img.pixels[1]);
  frameRate(20);
}

void draw(){
  noStroke();
  dotSize /= 1.5;
  
  if(dotSize <= 0.1){
    dotSize = 12; 
  }
  space = (float) (dotSize*1.2);
  
  background(0);
  for(int i = 0; i < img.width - space - 1; i += space){
    for(int j = 0; j < img.height - space - 1; j += space){
      float sizeMult = getBrightnessInSpace(img, i, j, dotSize) / 255.0;
      //println(sizeMult);
      fill(255);
      
      float rectWidth = dotSize*sizeMult;
      //if(rectWidth < cutoff){
      //  rectWidth = 0;
      //}
      
      //rect(i, j, rectWidth*2.5, 5);
      rect(i, j, rectWidth, rectWidth);
    }
  }
  
  //updatePixels();
}



public float getBrightnessInSpace(PImage im, int cornerx, int cornery, int boxSize){
  float totalPixels = boxSize*boxSize;
  System.out.println("totalPixels: " + totalPixels);
  float totalBrightness = 0;
  for(int col = 0; col < boxSize; col++){
    for(int row = 0; row < boxSize; row++){
      totalBrightness += brightness(im.pixels[col+cornerx + (row+cornery)*im.width]);
    }
  }
  System.out.println("totalBrightness: " + totalBrightness);
  return totalBrightness/totalPixels;//scale of 0-255
}