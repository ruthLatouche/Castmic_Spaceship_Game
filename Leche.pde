class Leche{
  
 PImage imagen;
 PVector coordenadas;
 float velocidad, velocidadAngulo, radio, angulo;
 boolean existe;
 
 public Leche(){
  coordenadas = new PVector(width/2, 0);
  radio = 0;
  velocidad = 2;
  velocidadAngulo = random(-1, 1);
  imagen = loadImage("Leche.png");
  existe = true;
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
  
  boolean existe(){
   return existe; 
  }
  
  void quitar(){
   existe = false; 
  }
  
   
 }
