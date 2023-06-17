
void updateSizes(){
  controlPanelX = border;
  controlPanelY = border;
  
  controlPanelWidth = 200;
  controlPanelHeight = height - border * 2;
  
  aerialLeftX = border + controlPanelWidth + border; 
  aerialTopY = border;
}

void drawControlPanel(){
  fill(250, 141, 82);
  rect(controlPanelX, controlPanelY, controlPanelWidth, controlPanelHeight, border, border, border, border);
}

void drawLogo() {
  
  int area = (int)(width * height * 0.0205103499);
  float c = 62.8984063745 / 150; // height/width constant to convert to height from width
  
  int scaledWidth = (int)sqrt(area/c);
  int scaledHeight = (int)(scaledWidth * c);
  
  // Calculate the position to draw the logo at the bottom left of the applet
  int drawX = width - scaledWidth - border;
  int drawY = height - scaledHeight - border;
  
  // Draw the logo
  image(logo, drawX, drawY, scaledWidth, scaledHeight);
}

void drawWaypoint() {
  int waypointSize = 10; // Adjust the size of the waypoint as needed
  
  // Calculate the position to draw the waypoint
  int drawX = controlPanelWidth + waypointX;
  int drawY = waypointY;
  
  // Draw the waypoint
  noFill(); // Don't fill the circle
  stroke(255, 0, 0); // Red color for the circle
  strokeWeight(2); // Adjust the border thickness as needed
  ellipse(drawX, drawY, waypointSize, waypointSize);
}



void updateButtons() {
  int buttonWidth = (int)((controlPanelWidth - border * 3) / 2);
  int buttonHeight = (25 * height) / 575;
  
  releaseButton.setSize(buttonWidth * 2 + border, buttonHeight);
  releaseButton.setPosition(controlPanelX + border, height - buttonHeight - border * 2);
  
  addButton.setSize(buttonWidth * 2 + border, buttonHeight);
  addButton.setPosition(controlPanelX + border, height - buttonHeight * 3 - border * 4);
  
  startButton.setSize(buttonWidth, buttonHeight);
  startButton.setPosition(controlPanelX + border, height - buttonHeight * 2- border * 3);
  
  stopButton.setSize(buttonWidth, buttonHeight);
  stopButton.setPosition(controlPanelX + border * 2 + buttonWidth, height - buttonHeight * 2 - border * 3);
  
  sensitivitySlider.setSize(buttonWidth * 2 + border, buttonHeight);
  sensitivitySlider.setPosition(controlPanelX + border, height - buttonHeight * 4 - border * 6);
  
  stroke(100);
  strokeWeight(2);
  line(controlPanelX + border, height - buttonHeight * 3 - border * 5, controlPanelX + border + buttonWidth * 2 + border, height - buttonHeight * 3 - border * 5);
  noStroke();
  
  //cp5.setGraphics(this,0,0);
}

void buttonInit() {
  
  int buttonWidth = (controlPanelWidth - border * 2) / 2;
  int buttonHeight = (25 * height) / 575;
  
  releaseButton = cp5.addButton("release")
                     .setLabel("Release")
                     .setPosition(controlPanelX + border, height - buttonHeight - border * 2)
                     .setSize(buttonWidth * 2 + border, buttonHeight);
                     
  
  startButton = cp5.addButton("begin")
                    .setLabel("begin")
                    .setPosition(controlPanelX + border, height - buttonHeight * 2- border * 3)
                    .setSize(buttonWidth, buttonHeight);
                    
  stopButton = cp5.addButton("end")
                   .setLabel("end")
                   .setPosition(controlPanelX + border * 2 + buttonWidth, height - buttonHeight * 2 - border * 3)
                   .setSize(buttonWidth, buttonHeight);
  
  addButton = cp5.addButton("addWaypoint")
                  .setLabel("Add Waypoint")
                  .setPosition(controlPanelX + border, height - buttonHeight * 3 - border * 4)
                  .setSize(buttonWidth * 2 + border, buttonHeight);
  
  sensitivitySlider = cp5.addSlider("sensitivity")
                         .setLabel("Sensitivity")
                         .setPosition(controlPanelX + border, height - buttonHeight * 4 - border * 6)
                         .setSize(buttonWidth * 2 + border, buttonHeight)
                         .setRange(100, 255)
                         .setValue(150)
                         .setLabel("");

  //cp5.setGraphics(this,0,0);
}
