class Catsmic{
 PImage catsmic;
 PVector coordenadas;
 float velocidad, angulo;
 ArrayList<BalaGato> balas;
 int vida;
 PImage vida10, vida9, vida8, vida7, vida6, vida5, vida4, vida3, vida2, vida1, vidaReal;
 
 public Catsmic(){
  balas = new ArrayList<BalaGato>();
  reset();
  catsmic = loadImage("SpriteGato.png");
  coordenadas = new PVector();
  
  //VIDAS
  vida10 = loadImage("Cora10.png");
  vida9 = loadImage("Cora9.png");
  vida8 = loadImage("Cora8.png");
  vida7 = loadImage("Cora7.png");
  vida6 = loadImage("Cora6.png");
  vida5 = loadImage("Cora5.png");
  vida4 = loadImage("Cora4.png");
  vida3 = loadImage("Cora3.png");
  vida2 = loadImage("Cora2.png");
  vida1 = loadImage("Cora1.png");
  vidaReal = loadImage("Cora10.png");
   
 }
 
 void reset(){
  angulo = 90;
  vida = 10;
  balas.clear();
 }
 
 void dibujar(){
   float anguloTemporal = angulo + velocidad;
   if(anguloTemporal <= 180 && anguloTemporal >= 0){
     angulo = anguloTemporal;
   }
   coordenadas.x = width/2 + cos(radians(angulo)) * width/4;
   coordenadas.y = height/2 + sin(radians(angulo)) * height/4;
   
    pushMatrix();
    translate(coordenadas.x, coordenadas.y);
    rotate(radians(angulo-90));
    imageMode(CENTER);
    image(catsmic, 0, 0);
    popMatrix();
    
    for (int x=0; x<balas.size(); x++) {
     BalaGato balaTemporal = balas.get(x);
     balaTemporal.mover();
     balaTemporal.dibujar();
     
     if(!balaTemporal.estaDentro()){
      balas.remove(x); 
     }
    }
    
    pushMatrix();
    translate(width-110, 25);
    imageMode(CENTER);
    image(vidaReal, 0, 0);
    popMatrix();
 
        
    if(vida == 10){
      vidaReal = vida10;
    }
    else if(vida == 9){
      vidaReal = vida9;
    }
    else if(vida == 8){
      vidaReal = vida8;
    }
    else if(vida == 7){
      vidaReal = vida7;
    }
    else if(vida == 6){
      vidaReal = vida6;
    }
    else if(vida == 5){
      vidaReal = vida5;
    }
    else if(vida == 4){
      vidaReal = vida4;
    }
    else if(vida == 3){
      vidaReal = vida3;
    }
    else if(vida == 2){
      vidaReal = vida2;
    }
    else if(vida == 1){
      vidaReal = vida1;
    } 
 }
    
  void disparar(){
    BalaGato balaNueva = new BalaGato(angulo);
    balas.add(balaNueva); 
 }
 
 boolean matar(PVector posPerro){
   for(int x=0; x<balas.size(); x++){
     BalaGato laQuePega = balas.get(x);
     if (laQuePega.getPos().dist(posPerro) < 30){
       balas.remove(x);
       return true;
     }
   }
   return false;
 }

 void quitarVida(){
  vida -= 1; 
 }
 
 void masVida(){
   if(vida < 10){
     vida += 1; 
   }
 }
 
 boolean estaVivo(){
  if(vida > 0){
    return true;
  }
  return false;
 }
 
  
 void moverIzq(){
     velocidad = 2;

 }
   
 void moverDer(){
   velocidad = -2;
 }
  
  void quieto(){
   velocidad = 0; 
  }
   
  PVector getPos(){
   return coordenadas; 
  }
  
}
