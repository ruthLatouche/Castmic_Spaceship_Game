class Jefe{
  
  PImage imagen;
  long instanteBala;
  int intervaloBala, angRotacion;
  PVector coordenadas, velocidad;
  ArrayList<BalaPerro> balas;
  int vida;
  PFont bold;
  
  public Jefe(){
    coordenadas = new PVector(width/2, height/2);
    velocidad = new PVector(5, 5);
    imagen = loadImage("Fake2.png");
    angRotacion = 90;
    intervaloBala = 1000;
    instanteBala = millis();
    balas = new ArrayList<BalaPerro>();
    vida = 20;
    bold = createFont("Quicksand-Bold.ttf", 25);
  }
  
  void dibujar(){
   pushMatrix();
   translate(coordenadas.x, coordenadas.y);
   rotate(radians(angRotacion-90));
   imageMode(CENTER);
   image(imagen,0,0);
   popMatrix(); 
   
   float escalaVida = map(vida, 20, 0, width-500, 500);
   strokeWeight(4);
   stroke(#D248BF);
   line(500,50, escalaVida, 50);
   
   textFont(bold);
   fill(#D248BF);
   textAlign(CENTER);
   text("Perro Alfa", width/2, 30);
   
  }
  
  void mover(){
   coordenadas.add(velocidad);
   if(coordenadas.x+100 > width || coordenadas.x+100 < 0){
    velocidad.x *= -1;
   }
   if(coordenadas.y+100 > height || coordenadas.y+100 < 0){
     velocidad.y *= -1;
   }
   if(vida < 10){  
   angRotacion -= random(-2,2);
   }
   else{
    angRotacion -= random(-360, 360); 
   }
  }
  
  void disparar(){
   if(millis() - instanteBala > intervaloBala){
    instanteBala = millis();
    BalaPerro nuevaBala = new BalaPerro(angRotacion, coordenadas);
    balas.add(nuevaBala);
   }  
   for(int x =0; x<balas.size(); x++){
     BalaPerro bala = balas.get(x);
     bala.mover();
     bala.dibujar();
     
     if(!bala.estaDentro()){
       balas.remove(x);
     }
    }
  }
  
  boolean matar(PVector pos){
    for( int x=0; x<balas.size(); x++){
     BalaPerro balita = balas.get(x);
     if(balita.getPos().dist(pos) < 50){
       balita.quitarBala();
       return true;
     }
    }
     return false;
  }
  
  boolean estaVivo(){
    if(vida > 0){
      return true;
    }
    return false;
  }
    
    PVector getPos(){
     return coordenadas; 
    }
    
    void quitarVida(){
     vida -=1; 
    }
  
    void reset(){
     vida = 20;
     balas.clear();
    }

}
