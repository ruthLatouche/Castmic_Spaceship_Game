class Perro{
 PImage imagen;
 PVector coordenadas;
 int tipo;
 float velocidad, velocidadAngulo, radio, angulo;
 
 public Perro(int clase){
  coordenadas = new PVector(width/2, 0);
  radio = 0;
  tipo = clase;
  
  if(tipo == 1){
    imagen = loadImage("SpritePerro1.png");
    velocidad = 2;
    velocidadAngulo = random(-1, 1);
  }
  else if(tipo == 2){
   imagen = loadImage("SpritePerro2.png");
   velocidad = 4;
   velocidadAngulo = random(-1*velocidad, velocidad);
    
  }
 }
  
  void dibujar(){
    float escala = map(radio, 0, height, 0, 1);
    imageMode(CENTER);
    pushMatrix();
    translate(coordenadas.x, coordenadas.y);
    scale(escala);
    rotate(radians(angulo-90));
    image(imagen,0,0);
    popMatrix();
  }
  
  void mover(){
    coordenadas.x = (width/2 ) + cos(radians(angulo)) * radio;
    coordenadas.y = (height/4 ) + sin(radians(angulo)) * radio;
    
    radio += velocidad;
    angulo += velocidadAngulo;
    
    if (coordenadas.x < 0 || coordenadas.x > width || coordenadas.y < 0 || coordenadas.y > height){ 
     coordenadas.set(width/2, 0);
     radio = 0;
    } 
  }
  
  PVector getPos(){
   return coordenadas; 
  }
  
}
