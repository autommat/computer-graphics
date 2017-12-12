float delta = 0;
ArrayList<Celestial> planets = new ArrayList<Celestial>();

void setup(){
  fullScreen();
  
  color mercuryColor= color(209,200,150);
  Celestial mercury = new Celestial(20, 150, -1/0.24, mercuryColor);
  planets.add(mercury);
  
  color venusColor = color(150,114,43);
  Celestial venus = new Celestial(60, 200, -1/0.62, venusColor);
  planets.add(venus);

  color earthColor = color(171, 224, 232);
  Celestial earth = new Celestial(100, 400, -1, earthColor);
  planets.add(earth);
  
  color marsColor = color(193, 138, 60);
  Celestial mars = new Celestial(70, 600, -1/1.88, marsColor);
  planets.add(mars);
  
  Celestial phobos = new Celestial(20, 60, -4, color(145, 120, 85));
  mars.moons.add(phobos);

  Celestial deimos = new Celestial(5, 100, -2, color(214, 192, 62));
  mars.moons.add(deimos);

  color jupiterColor = color(232,205,139);
  Celestial jupiter = new Celestial(350, 1200, -1/11.86, jupiterColor);
  jupiter.initialAngle= PI/8;
  planets.add(jupiter);
  
  color ioColor = color(255, 255, 0);
  Celestial io = new Celestial(36, 300, -2.4, ioColor);
  jupiter.moons.add(io);

  Celestial europa = new Celestial(30, 320, -1.7, color(229, 143, 45));
  jupiter.moons.add(europa);
  
  Celestial ganymede = new Celestial();
  Celestial callisto = new Celestial();
}

void draw(){
  background(255);
  noStroke();
  translate(width/4, height/2);    
  fill(239, 211 , 50);
  //ellipse(0,0, 70, 70);
  star(0, 0, 80, 100+(7*sin(20*delta)), 40);
  
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
  color planetColor;
  ArrayList<Celestial> moons = new ArrayList<Celestial>();
  
  void drawCelestial(){
    pushMatrix();
    rotate(delta*speed + initialAngle);
    translate(orbitalRadius, 0);
    fill(planetColor);
    ellipse(0,0,size,size);
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