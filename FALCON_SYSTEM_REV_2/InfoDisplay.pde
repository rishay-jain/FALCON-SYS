public class InfoDisplay {
  private float x, y;
  private float w, h;
  private String name;
  private Object value;

  public InfoDisplay(float x, float y, float w, float h, String name, Object defaultValue) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.name = name;
    this.value = defaultValue;
  }

  public void updatePosition(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public void updateSize(float w, float h) {
    this.w = w;
    this.h = h;
  }

  public void updateValue(Object value) {
    this.value = value;
  }

  public void display() {
    
    fill(255 ,183, 36);
    rect(x, y, w, h, border, border, border, border);
    
    fill(100);
    rect(x, y, w, 16, border, border, 0, 0);
    
    fill(255);
    textAlign(CENTER);
    textSize(16);
    text(name, x + w / 2, y + 14);
    
    fill(0);
    textAlign(CENTER);
    textSize(24);
    text(value.toString(), x + w / 2, y + h / 2 + 16);
  }
}
