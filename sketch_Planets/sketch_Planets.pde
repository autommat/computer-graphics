float delta = 0;
ArrayList<Celestial> planets = new ArrayList<Celestial>();
PShape torusObj;

void setup(){
  fullScreen(P3D);
  torusObj = loadShape("shuttle.obj");
  
  float year = 1;
  boolean slowDownMoons = true;
  
  color mercuryColor= color(209,200,150);
  Celestial mercury = new Celestial(24, 150, -year/0.24, mercuryColor);
  planets.add(mercury);
  
  color venusColor = color(150,114,43);
  Celestial venus = new Celestial(60, 200, -year/0.62, venusColor);
  planets.add(venus);

  color earthColor = color(171, 224, 232);
  Celestial earth = new Celestial(100,350, -year, earthColor);
  planets.add(earth);
  
  Celestial moon = new Celestial(20, 100, -year/0.0748, color(155,152,149));
  earth.moons.add(moon);
  
  color marsColor = color(193, 138, 60);
  Celestial mars = new Celestial(70, 550, -year/1.88, marsColor);
  planets.add(mars);
  
  Celestial phobos = new Celestial(18, 60, -year/0.0008, color(145, 120, 85));
  mars.moons.add(phobos);

  Celestial deimos = new Celestial(5, 100, -year/0.00346, color(214, 192, 62));
  mars.moons.add(deimos);

  Celestial torus = new Celestial(70, 700, year/1.88, color(255,255,255));
  torus.shape=torusObj;
  planets.add(torus);

  color jupiterColor = color(232,205,139);
  Celestial jupiter = new Celestial(350, 1100, -year/11.86, jupiterColor);
  planets.add(jupiter);
  
  color ioColor = color(255, 255, 0);
  Celestial io = new Celestial(36, -200, -year/0.00484, ioColor);
  jupiter.moons.add(io);

  Celestial europa = new Celestial(32, -270, -year/0.0097, color(229, 143, 45));
  jupiter.moons.add(europa);
  
  Celestial ganymede = new Celestial(52, -360, -year/0.0196, color(165, 147, 127));
  jupiter.moons.add(ganymede);
  Celestial callisto = new Celestial(48, -420, -year/0.0457 ,color(51, 62, 91));
  jupiter.moons.add(callisto);
  
  for(Celestial jm : jupiter.moons){
    jm.initialAngle+=PI/2;
  }
  
  for(Celestial planet: planets){
    planet.initialAngle+=PI/8;
  }
  
  if(slowDownMoons){
    phobos.speed/=100;
    deimos.speed/=100;
    io.speed/=100;
    europa.speed/=100;
    ganymede.speed/=100;
    callisto.speed/=100;
  }
  //earth.xlr8=-1;
}

void draw(){
  pushMatrix();
  if(mousePressed){
    lights();
  }
  directionalLight(255,255,255,0,-1,0);
  pointLight(255, 255, 255, width/4, height/2, -100);
  translate(0,0,-100);
  background(0);
  noStroke();
  translate(width/4, height/2);    
  //fill(239, 211 , 50);
  emissive(239, 211 , 50);
  //ellipse(0,0, 70, 70);
  //star(0, 0, 80, 100+(7*sin(20*delta)), 40);
  sphere(70);
  
  emissive(0,0,0);
  for(Celestial planet: planets){
    planet.drawCelestial();
  }
  popMatrix();
  
  delta+=0.01;
  
}


class Celestial{
  Celestial(){}
  Celestial(float size, float orbitalRadius, float speed, color planetColor){
    this.size = size;
    this.orbitalRadius = orbitalRadius;
    this.speed = speed;
    this.planetColor = planetColor;
  }
  
  float initialAngle=0;
  float size;
  float orbitalRadius;
  float speed;
  float xlr8= 0;
  color planetColor;
  ArrayList<Celestial> moons = new ArrayList<Celestial>();
  PShape shape;
  
  void drawCelestial(){
    pushMatrix();
    rotate(delta*delta*xlr8+delta*speed + initialAngle);
    translate(orbitalRadius, 0);
    fill(planetColor);
    if(shape!=null){
      rotateZ(-PI/2);
      shape(shape,0,0,size,size);
    } else {
      sphere(size/2);
    }
    for(Celestial moon : moons){
      moon.drawCelestial();
    }
    popMatrix();
  }
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}