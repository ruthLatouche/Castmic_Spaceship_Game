class BalaGato{
 
  PImage imagen;
  PVector coordenadas;
  float angulo, radioProporcion;
  boolean existe;
  
  public BalaGato(float ang){
    angulo = ang;
    coordenadas = new PVector();
    radioProporcion = 1;
    existe = true;
    imagen = loadImage("BalaGato.png");
  }
  
  void dibujar(){
   float escala = map(radioProporcion, 1, -4, 1, 0);
   pushMatrix();
   translate(coordenadas.x, coordenadas.y);
   scale(escala);
   rotate(radians(angulo-90));
   imageMode(CENTER);
   image(imagen,0,0);
   popMatrix();
    
  }
  
  void mover() {
    coordenadas.x = width/2 + cos(radians(angulo)) * (width/4-50) * radioProporcion;
    coordenadas.y = height/2 + sin(radians(angulo)) * (height/4-50) * radioProporcion;
    
    radioProporcion -= 0.02;
    
    if (coordenadas.x < 0 || coordenadas.x > width || coordenadas.y < 0 || coordenadas.y > height){ 
     existe = false; 
    }
  }
  
  PVector getPos(){
   return coordenadas; 
  }
  
  boolean estaDentro(){
   return existe; 
  }
  
}
