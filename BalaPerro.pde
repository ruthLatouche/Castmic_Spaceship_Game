class BalaPerro{
 
  PImage imagen;
  PVector coordenadas;
  float angulo, crecimiento, tamano;
  boolean existe;
  
  
  public BalaPerro(int ang, PVector pos){
    angulo = ang;
    coordenadas = new PVector(pos.x, pos.y);
    crecimiento = 2;
    tamano = 1;
    existe = true;
    imagen = loadImage("BalaPerro.png");    
  }
  
  void dibujar(){
   pushMatrix();
   translate(coordenadas.x, coordenadas.y);
   scale(tamano);
   rotate(radians(angulo-90));
   imageMode(CENTER);
   image(imagen,0,0);
   popMatrix(); 
  }
  
  void mover() {
  coordenadas.x = coordenadas.x + cos(radians(angulo)) * crecimiento;
  coordenadas.y = coordenadas.y + sin(radians(angulo)) * crecimiento;
  
  tamano -= 0.001;
  
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
  
  void quitarBala(){
   existe = false;
  }
  
  
  
}
