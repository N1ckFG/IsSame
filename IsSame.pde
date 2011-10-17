int width,height;
int numFrames = 121;
String readDir = "frames";
String readName = "foo_";
String readFormat = "tga";
int startNum = 0;
String writeDir = "render";
String writeName = "write_";
int writeNum = 0;
String writeFormat = "tga";
int counter = 0;
PImage[] framesArray = new PImage[numFrames];
PImage currentFrame,previousFrame;

void setup() {
  for(int i=0;i<framesArray.length;i++) {
    String temp = readDir+"/"+readName+(i+startNum)+"."+readFormat;
    framesArray[i]=loadImage(temp);
    println("read " + temp);
  }
  width=framesArray[0].width;
  height=framesArray[0].height;
  size(width,height);
  currentFrame=createImage(width,height,RGB);
}

void draw() {
 if(counter<framesArray.length){
  previousFrame=currentFrame;
    image(framesArray[counter],0,0);
  currentFrame = get(0,0,width,height);
  
  if(!isSame(currentFrame,previousFrame)){
    String temp = writeDir + "/" + writeName + writeNum + "." + writeFormat;
    saveFrame(temp);
    println("saved " + temp);
    writeNum++;
  }
     counter++;
  } else {
    println("frames in: " + counter + "   frames out: " + writeNum);
    stop();
  }
}


boolean isSame(PImage image1, PImage image2) {

  boolean allSame=true;
  PImage diff = createImage(image1.width,image1.height,RGB);

  for(int i=0;i<diff.pixels.length;i++) {
    diff.pixels[i]=abs(image1.pixels[i]-image2.pixels[i]);
  }

  for(int i=0;i<diff.pixels.length;i++) {
    if(allSame) {
      float r = red(diff.pixels[i]);
      float g = green(diff.pixels[i]);
      float b = blue(diff.pixels[i]);
      color rgb = color(r,g,b);
      if(rgb!=color(0,0,0)) {
        allSame=false;
      }
    }
  }
  if(allSame) {
    return true;
  } 
  else {
    return false;
  }
}

