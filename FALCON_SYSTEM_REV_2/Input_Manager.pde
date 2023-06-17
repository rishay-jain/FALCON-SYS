

void release(){
}
void begin(){
}
void end(){
}


void addWaypoint() {
  isAddingWaypoint = true;
}


void sensitivity(int n){
  threshold = n;
}

void mouseClicked() {
  if (isAddingWaypoint) {
    // Calculate the coordinates relative to the top left of the image
    int imageX = mouseX - controlPanelWidth - controlPanelX - border;
    int imageY = mouseY - border;
    
    // Save the coordinates to global variables
    waypointX = imageX;
    waypointY = imageY;
    
    wayPointSet = true;
    
    // Reset the flag
    isAddingWaypoint = false;
  }
}
