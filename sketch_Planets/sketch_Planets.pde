float delta = 0;
ArrayList<Celestial> planets = new ArrayList<Celestial>();
PShape shuttleObj;
PImage textureJpg;

void setup(){
  fullScreen(P3D);
  shuttleObj = loadShape("shuttle.obj");
  textureJpg = loadImage("earthmap.jpg");
  float year = 1;
  boolean slowDownMoons = true;
  
  color mercuryColor= color(209,200,150);
  Celestial mercury = new Celestial(24, 150, -year/0.24, mercuryColor);
  mercury.orbitAngle=PI/4;
  planets.add(mercury);
  
  color venusColor = color(150,114,43);
  Celestial venus = new Celestial(60, 200, -year/0.62, venusColor);
  venus.orbitAngle=-PI/8;
  planets.add(venus);

  color earthColor = color(171, 224, 232);
  Celestial earth = new Celestial(100,350, -year, earthColor);
  earth.texture = textureJpg;
  planets.add(earth);
  
  Celestial moon = new Celestial(20, 100, -year/0.0748, color(155,152,149));
  moon.orbitAngle = PI/2;
  earth.moons.add(moon);
  
  color marsColor = color(193, 138, 60);
  Celestial mars = new Celestial(70, 550, -year/1.88, marsColor);
  mars.spotL=marsColor;
  mars.orbitAngle=PI/4;
  planets.add(mars);
  
  Celestial phobos = new Celestial(18, 60, -year/0.0008, color(145, 120, 85));
  //phobos.orbitAngle=PI/2;
  mars.moons.add(phobos);

  Celestial deimos = new Celestial(5, 100, -year/0.00346, color(214, 192, 62));
  mars.moons.add(deimos);
  deimos.orbitAngle=3*PI/4;
  deimos.shape = createShape(BOX, 7);

  Celestial shuttle = new Celestial(70, 700, year/1.88, color(255,255,255));
  shuttle.shape=shuttleObj;
  shuttle.shape.scale(5);
  planets.add(shuttle);

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
  directionalLight(255,255,255,-1,1,1);
  pointLight(255, 255, 255, width/4, height/2, -100);
  translate(width/4,height/2,-100);

  rotateX(3*PI/8);
  //rotateX(PI/2);
  if(mousePressed){
    lights();
  }
  background(0);
  noStroke();
  //translate(width/4, height/2);    
  //fill(239, 211 , 50);
  emissive(239, 211 , 50);
  //ellipse(0,0, 70, 70);
  //star(0, 0, 80, 100+(7*sin(20*delta)), 40);
  sphere(70);
  
  emissive(0,0,0);
  for(Celestial planet: planets){
    planet.drawCelestial();
  }
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
  float xlr8 = 0;
  color planetColor;
  ArrayList<Celestial> moons = new ArrayList<Celestial>();
  PShape shape;
  PImage texture;
  float orbitAngle=0;
  color spotL=0;
  
  void drawCelestial(){
    pushMatrix();
    rotateX(orbitAngle);
    rotate(delta*delta*xlr8+delta*speed + initialAngle);
    translate(orbitalRadius, 0);
    fill(planetColor);
    if(spotL!=0){
      spotLight(255,0,0,orbitalRadius,0,0,0,-1,0,PI/2,6000);
    }
    if(shape!=null){
      rotateZ(-PI/2);
      shape(shape);
    } else if(texture != null) {
      rotateX(-PI/2);
      PShape textured = createShape(SPHERE,size/2);
      textured.setTexture(texture);
      shape(textured);
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