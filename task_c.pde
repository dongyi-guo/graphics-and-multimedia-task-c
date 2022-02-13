// COMP3419 Assignment (Option 1)
// Name: DongYi Guo
// Student ID: 470033070
// UniKey: dguo0006

// Task C: Duang-cing Ball
// Reference: 
// Week 8 Lab RotatingCube
// Week 8 Lab The Orbit

int l = 600;
public class Ball{
  float x,y,z;
  float xspeed, yspeed, zspeed;
  float decay = 0.99;
  float g = 0.90;
  PImage t;
  PShape shaped;
  boolean cped = false;
  Ball(float x_init, float y_init, float z_init){
    x = x_init;
    y = y_init;
    z = z_init;
    xspeed = random(-20,20);
    yspeed = random(-20,20);
    zspeed = random(-40,-10);
    init();
  }
  void init(){
    shaped = createShape(SPHERE,30);
    shaped.setStroke(false);
    String[] bgp = new String[10];
    bgp[0] = "./data/moon.jpg";
    bgp[1] = "./data/earth.jpg";
    bgp[2] = "./data/m.jpg";
    bgp[3] = "./data/moon.jpg";
    bgp[4] = "./data/reddust.jpg";
    bgp[5] = "./data/sea.jpg";
    bgp[6] = "./data/star.jpg";
    bgp[7] = "./data/scene.jpg";
    bgp[8] = "./data/smount.jpg";
    bgp[9] = "./data/orange.jpg";
    t = loadImage(bgp[int(random(0,10))]);
    shaped.setTexture(t);
  }
  void update(){
    yspeed += g;
    if(x - 30 < 0){
      xspeed = -xspeed;
    }
    if(x + 30 > 600){
      xspeed = -xspeed;
    }
    if(y - 30 < 0){
      yspeed = -yspeed;
    }
    if(y + 30 > 600){
      yspeed = -yspeed * g;
    }
    if(z - 30 < -600){
      zspeed = -zspeed;
    }
    if(z > 30){
      zspeed = -zspeed;
    }
    
    //Energy decay
    xspeed *= decay;
    yspeed *= decay;
    zspeed *= decay;
    
    x += xspeed;
    y += yspeed;
    z += zspeed;

    pushMatrix();
    translate(x,y,z);
    shape(shaped);
    popMatrix();
  }
  
  boolean collapse(Ball ball){
    // dist() - distance calc
    if(dist(ball.x, ball.y, ball.z, this.x, this.y, this.z) < 60){
      return true;
    }
    ball.cped = false;
    return false;
  }
  
  void collision(ArrayList<Ball> balls){
    for(Ball ball: balls){
      if(this == ball){
        continue;
      }
      if(this.collapse(ball) && !cped){
        this.xspeed = -xspeed;
        this.yspeed = -yspeed;
        this.zspeed = -zspeed;
        ball.xspeed = -xspeed;
        ball.yspeed = -yspeed;
        ball.zspeed = -zspeed;
        cped = true;
      }
    }  
  }
}

ArrayList<Ball> balls = new ArrayList<Ball>();
void setup(){
  size(600,600,P3D);
}
 
void drawCube(){
  
  pushMatrix();
  noStroke();
  beginShape(QUAD_STRIP);

  fill(99,99,99);
  vertex(0,0,0);
  vertex(0,0,-l);
  vertex(0,l,0);
  vertex(0,l,-l);
  
  fill(99,99,99);
  vertex(l,0,0);
  vertex(l,0,-l);
  vertex(l,l,0);
  vertex(l,l,-l);
  
  fill(30,60,70);
  vertex(0,0,0);
  vertex(0,0,-l);
  vertex(l,0,0);
  vertex(l,0,-l);
  
  fill(30,70,50);
  vertex(0,l,0);
  vertex(0,l,-l);
  vertex(l,l,0);
  vertex(l,l,-l);

  fill(150,150,150);
  vertex(0,0,-l);
  vertex(l,0,-l);
  vertex(0,l,-l);
  vertex(l,l,-l);
  
  endShape();
  popMatrix();  
}

void mouseClicked(){
  Ball ball = new Ball(mouseX,mouseY,0);
  println(ball.x,ball.y,ball.z);
  balls.add(ball);
}

void draw(){
  surface.setTitle("Task C");
  background(0);    
  lights();
  ambientLight(99, 99, 99);
  drawCube();
  for(int c = 0; c < balls.size(); c++){
    println(balls.get(c).x,balls.get(c).y,balls.get(c).z,balls.get(c).xspeed,balls.get(c).yspeed,balls.get(c).zspeed);
    balls.get(c).update();
    balls.get(c).collision(balls);
  }
}
