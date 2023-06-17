
//GRAY = 62,66,73
// orange = 250, 141, 82
//yellow = 255 ,183, 36

import controlP5.*;


// BEGIN UI_RELATED DEFINTIONS

ControlP5 cp5;

Button releaseButton;
Button addButton;
Button startButton;
Button stopButton;
Slider sensitivitySlider;

int border = 10;

int controlPanelX = border;
int controlPanelY = border;

int controlPanelWidth = 200;
int controlPanelHeight = height - border * 2;

int aerialLeftX = border + controlPanelWidth + border; 
int aerialTopY = border;

InfoDisplay statusDisplay;

PImage logo;

// END UI_RELATED DEFINITIONS

// BEGIN SYSTEM_RELATED DEFINITIONS
PImage frame;

int threshold = 100;

boolean isAddingWaypoint = false;
boolean wayPointSet = false;
int waypointX;
int waypointY;

// END SYSTEM_RELATED DEFINITIONS




void setup(){
  size(800, 575);
  noStroke();
  
  cp5 = new ControlP5(this);
  buttonInit();
  updateSizes();
  
  
  surface.setTitle("FALCON System Control");
  surface.setResizable(true);
  //surface.setLocation(500, 100);
  logo = loadImage("logo.png");
  frame = loadImage("test.png");
  
  float statusX = controlPanelX + border;
  float statusY = controlPanelY + border;
  float statusWidth = controlPanelWidth - 2 * border;
  float statusHeight = controlPanelHeight/10; // Assuming releaseButton is the name of the button instance
  
  statusDisplay = new InfoDisplay(statusX, statusY, statusWidth, statusHeight, "Status", "Initializing");

  
}


void draw(){
  background(62,66,73);
  
  updateSizes();
  
  drawControlPanel();
  updateButtons();
  statusDisplay.display();
  
  drawImageWithMask(frame, aerialLeftX, aerialTopY, width - aerialLeftX - border, height - border * 2, 2);
  
  if(wayPointSet){
    drawWaypoint();
  }
  
  drawLogo();
  cp5.setGraphics(this,0,0);
}
