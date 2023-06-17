
void drawImageWithMask(PImage image, int left, int top, int w, int h, int mode) {
  
  fill(100);
  rectMode(CORNER);
  rect(controlPanelX + controlPanelWidth + border, controlPanelY, w, h, border);
  
  // Calculate the scaling factor based on the provided dimensions
  float scaleFactor = min(float(w) / image.width, float(h) / image.height);
  
  // Calculate the scaled dimensions
  int scaledWidth = int(image.width * scaleFactor);
  int scaledHeight = int(image.height * scaleFactor);
  
  // Calculate the position to draw the image
  int drawX = left + (w - scaledWidth) / 2;
  int drawY = top + (h - scaledHeight) / 2;
  
  // Draw the raw image if mode is 1
  if (mode == 1) {
    image(image, drawX, drawY, scaledWidth, scaledHeight);
  }
  // Apply blur and threshold if mode is 2
  else if (mode == 2) {
    // Create a copy of the image
    PImage processedImage = image.copy();
    
    // Apply blur to the processed image
    //processedImage.filter(BLUR, 5);
    
    // Process each pixel of the processed image
    processedImage.loadPixels();
    for (int i = 0; i < processedImage.pixels.length; i++) {
      // Get the color of the pixel
      color pixelColor = processedImage.pixels[i];
      
      // Check if the pixel is yellow
      if (isYellow(pixelColor)) {
        // Set the pixel to transparent
        processedImage.pixels[i] = color(200, 50, 200, 100);
      } else {
        // Set the pixel to translucent purple
        processedImage.pixels[i] = frame.pixels[i];
      }
    }
    processedImage.updatePixels();
    
    // Draw the original image
    image(image, drawX, drawY, scaledWidth, scaledHeight);
    
    // Draw the processed image on top
    image(processedImage, drawX, drawY, scaledWidth, scaledHeight);
  }
}

boolean isYellow(color pixelColor) {
  // Extract the red, green, and blue color components
  float r = red(pixelColor);
  float g = green(pixelColor);
  float b = blue(pixelColor);
  
  // Calculate the distance from yellow color (255, 255, 0)
  float distance = dist(r, g, b, 204, 102, 0);
  
  // Set a threshold value to determine if the color is yellow
  
  return distance < threshold;
}
