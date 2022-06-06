class Explosion {
  
  SpriteSheet ani;
  PVector coordenadas;
  boolean activo;
  
  public Explosion(PVector _loc) {
    ani = new SpriteSheet("explosion/", 19, "png");
    coordenadas = _loc;
    activo = true;
    ani.noLoop();
    ani.play();
  }
  
  void dibujar() {
    imageMode(CENTER);
    ani.display(coordenadas.x, coordenadas.y);
    if (ani.isFinished())
      activo = false;
  }
  
  boolean esta() {
    return activo;
  }
}
