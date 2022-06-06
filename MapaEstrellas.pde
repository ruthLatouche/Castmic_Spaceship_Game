class MapaEstrellas{
  ArrayList<Estrella> galaxia;

  long instante;
  int mil;
  int x;
  
  public MapaEstrellas(){
    galaxia = new ArrayList<Estrella>();
 
   instante = millis();
   mil = 300;
   x = 0;
  }
  
  void dibujar(){
   if(x < 200){
    if(millis()-instante > mil){
      Estrella nuevo = new Estrella();
      galaxia.add(nuevo);
      instante = millis();
      x ++;
    }
   }
   
   for(int y = 0; y < galaxia.size(); y++){
     Estrella nuevo = galaxia.get(y);
     nuevo.dibujar();
     nuevo.mover();
   }
  }
}
