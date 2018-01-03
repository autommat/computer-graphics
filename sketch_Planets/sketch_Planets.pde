float delta = 0;
ArrayList<Celestial> planets = new ArrayList<Celestial>();
PShape shuttleObj;
PImage textureJpg;
Celestial spot;
int firework=0;

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
  mercury.specular = color(0,0,255);
  
  color venusColor = color(150,114,43);
  Celestial venus = new Celestial(60, 200, -year/0.62, venusColor);
  venus.orbitAngle=-PI/8;
  planets.add(venus);

  color earthColor = color(171, 224, 232);
  Celestial earth = new Celestial(100,350, -year, earthColor);
  earth.texture = textureJpg;
  planets.add(earth);
  
  Celestial moon = new Celestial(20, 150, -year/0.0748, color(155,152,149));
  moon.orbitAngle = PI/2;
  earth.moons.add(moon);
  
  Celestial satellite = new Celestial(30, 100, year, color(0,0,255));
  earth.moons.add(satellite);
  satellite.specular=color(175,175,0);
  satellite.isBox = true;
  
  color marsColor = color(193, 138, 60);
  Celestial mars = new Celestial(70, 550, -year/1.88, marsColor);
  mars.spotL=color(255,0,0);
  planets.add(mars);
  spot = mars;
  
  Celestial phobos = new Celestial(18, 60, -year/0.0008, color(145, 120, 85));
  mars.moons.add(phobos);

  Celestial deimos = new Celestial(5, 100, -year/0.00346, color(214, 192, 62));
  mars.moons.add(deimos);
  deimos.orbitAngle=3*PI/4;
  deimos.isBox = true;

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
    jm.specular=color(0,0,200);
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
}

void draw(){
  //LIGHTS
  lightSpecular(255,255,255);
  directionalLight(255,255,255,-1,1,0);
  //if(mousePressed){
  lightSpecular(0,0,0);
  //}
  pointLight(255, 255, 255, width/4, height/2, -100);

  //firework
  if(!mousePressed){
    if((firework)%25==0){
      pointLight(0,255,0,width/2,height/4,-200);
    }
  }
  
  //STAR
  translate(width/4,height/2,-100);
  rotateX(3*PI/8);
  background(0);
  noStroke();
  //translate(width/4, height/2);    
  //star(0, 0, 80, 100+(7*sin(20*delta)), 40);
  emissive(239, 211 , 50);
  sphere(70);
  emissive(0,0,0);
  
  //SPOTLIGHT
  pushMatrix();
  rotateX(spot.orbitAngle);
  rotate(delta*spot.speed + spot.initialAngle);
  translate(spot.orbitalRadius, 0);
  spotLight(red(spot.spotL),green(spot.spotL),blue(spot.spotL),0,0,0,-1,0,0,PI/4,2);
  popMatrix();
  
  for(Celestial planet: planets){
    planet.drawCelestial();
  }
  delta+=0.01;
  firework++;
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
  color specular = 0;
  boolean isBox = false;
  
  void drawCelestial(){
    pushMatrix();
    rotateX(orbitAngle);
    rotate(delta*delta*xlr8+delta*speed + initialAngle);
    translate(orbitalRadius, 0);
    fill(planetColor);
    specular(specular);
    //if(spotL!=0){
    //  spotLight(red(spotL),green(spotL),blue(spotL),orbitalRadius,0,0,1,0,0,PI/4,2);
    //}
    if(shape!=null){
      rotateZ(-PI/2);
      shape(shape);
    } else if(isBox){
      box(size/2);
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