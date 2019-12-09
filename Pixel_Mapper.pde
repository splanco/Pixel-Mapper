import java.util.*;

PImage base;
PImage transfer;

int loc;
//Image mode = 0, Pallete mode = 1
int mode = 0;

//RGB values for the two images
float []baseRGB = new float[3];
float []transferRGB = new float[3];
float []comboRGB = new float[3];

//Averaged RGB values
//Set to very large values initially so there is always something smaller
float rDist;
float gDist;
float bDist;


void setup() {
  size(400, 400);
  background(0);
  base = loadImage("Insert Image 1 Here");
  transfer = loadImage("Insert Image 2 Here");
  transfer.resize(width, height);
  base.resize(width, height); //<>//
}

void draw() {
  loadPixels();
  base.loadPixels();
  transfer.loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      loc = x+y*width;
      //RGB values for base image
      baseRGB[0] = red(base.pixels[loc]);
      baseRGB[1] = green(base.pixels[loc]);
      baseRGB[2] = blue(base.pixels[loc]);
      
      rDist = 9999;
      gDist = 9999;
      bDist = 9999;
      //Loop through all the pixels in transfer and find the one that most closely matches the one in the base picture
      for (int i = 0; i < transfer.pixels.length; i++) {
        //RGB values for transfer image
        transferRGB[0] = red(transfer.pixels[i]);
        transferRGB[1] = green(transfer.pixels[i]);
        transferRGB[2] = blue(transfer.pixels[i]);
        
        //If the rgb values of one pixel are closer to that of the original, update the smallest distance and the corresponding rgb values
        if (dist(transferRGB[0], 0, baseRGB[0], 0) < rDist && dist(transferRGB[1], 0, baseRGB[1], 0) < gDist && dist(transferRGB[2], 0, baseRGB[2], 0) < bDist) {
          rDist = dist(transferRGB[0], 0, baseRGB[0], 0);
          gDist = dist(transferRGB[1], 0, baseRGB[1], 0);
          bDist = dist(transferRGB[2], 0, baseRGB[2], 0);
          
          comboRGB[0] = transferRGB[0];
          comboRGB[1] = transferRGB[1];
          comboRGB[2] = transferRGB[2];
        }
      }
      
      pixels[loc] = color(comboRGB[0], comboRGB[1], comboRGB[2]);
    }
  }
  updatePixels();
  save("product.jpg");
}
