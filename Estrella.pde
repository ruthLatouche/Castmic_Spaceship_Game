class Estrella{
 
  PVector posicion;
  PVector velocidad;
  float tamano;
  
  public Estrella(){
   posicion = new PVector(random(width/2-20,width/2+20), height*3/4);
   velocidad = new PVector(random(-10,10), random(-10,10));
   tamano = random(1,6); 
  }
  
  void dibujar(){
    stroke(240);
    strokeWeight(tamano);
    point(posicion.x, posicion.y);
  }
  
  void mover(){
   posicion.add(velocidad);
   
   if(posicion.x < 0 || posicion.x > width || posicion.y < 0 || posicion.y > height){
     posicion.set(random(width/2-20,width/2+20), height*3/4);
     velocidad.set(random(-10,10),random(-10,10));
     tamano = random(1,6);
   }
  }
}
