float delta = 0;
ArrayList<Celestial> planets = new ArrayList<Celestial>();

void setup(){
  fullScreen();
  color venusColor = color(150,114,43);
  Celestial venus = new Celestial(60, 200, 1.5, venusColor);
  planets.add(venus);


  color jupiterColor = color(232,205,139);
  Celestial jupiter = new Celestial(700, 700, 1.2, jupiterColor);
  
  color ioColor = color(196,  196, 58);
  Celestial io = new Celestial(36, -750/2, 1, ioColor);
  
  jupiter.moons.add(io);
  planets.add(jupiter);
  
  
}

void draw(){
  background(255);
  noStroke();
  translate(width/2, height/2);    
  fill(239, 211 , 50);
  ellipse(0,0, 70, 70);
  
  color mercuryColor = color(209,200,150);
  pushMatrix();
  rotate(delta);
  translate(100, 0);
  fill(mercuryColor);
  ellipse(0,0,24,24);
  popMatrix();
  
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
  float size;
  float orbitalRadius;
  float speed;
  color planetColor;
  ArrayList<Celestial> moons = new ArrayList<Celestial>();
  
  void drawCelestial(){
    pushMatrix();
    rotate(delta*speed);
    translate(orbitalRadius, 0);
    fill(planetColor);
    ellipse(0,0,size,size);
    for(Celestial moon : moons){
      moon.drawCelestial();
    }
    popMatrix();
  }
}