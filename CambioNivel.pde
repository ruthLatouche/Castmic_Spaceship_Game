class CambioNivel{
  
  PFont bold;  
  int level;
 
  public CambioNivel(){
    bold = createFont("Quicksand-Bold.ttf", 75);

       
  }
  
  void dibujar(int nivel){
     level = nivel;
     pushMatrix();
     noStroke();
     fill(#D59CC0);
     ellipseMode(CENTER);
     circle(width/2, height/2, 400);
     popMatrix();
     
     pushMatrix();
     noStroke();
     fill(255);
     textAlign(CENTER,CENTER);
     textFont(bold);
     text("Nivel" +level, width/2, height/2);
     popMatrix();

    
    
  }
  
  
  
}
