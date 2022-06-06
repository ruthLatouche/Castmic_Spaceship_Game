//Ruth Latouche e Isora Hernández
//2019027049 y 2019205139

//Importacion de libreria y musica
import ddf.minim.*;
Minim minim;
AudioPlayer musicaPortada, musicaJuego, musicaGameOver; 
AudioSample disparo1, disparo2, choque, siguiente;

//Fondo y personaje principal
MapaEstrellas fondo;
Catsmic gato;
int escenario;

//Lechita fortalecedora que sube la vida
ArrayList<Leche> leches;
long instanteLeche;
int intervaloLeche;

//Componentes graficos de escenarios
PImage gatito, perrito, titulo, versus, terminado, muerte, win, boss, ganar;
PFont regular, bold;

//Enemigos
ArrayList<Perro> perros;
long instantePerro;
int intervaloPerro;
int cantidadPerros;

//Variable que permite sacar grafico cuando se cambia de nivel
CambioNivel pop;
long intervaloCambio;
int instanteCambio;

//Variables que controlan en que nivel se encuentra el personaje
int nivel;
boolean esCambioNivel;

//Explosiones y colisiones
ArrayList <Explosion> explosiones;

//Jefe final
Jefe dogBoss;

void setup(){
  fullScreen();
  perros = new ArrayList<Perro>(1);
  explosiones = new ArrayList<Explosion>();
  dogBoss = new Jefe();
  
  leches = new ArrayList<Leche>();
  
  escenario = 1;
  fondo = new MapaEstrellas();
  gato = new Catsmic();
  
  nivel = 1;
  pop = new CambioNivel();
  esCambioNivel = false;
  
  gatito = loadImage("GatoPortada.png");
  perrito = loadImage("PerroPortada.png");
  titulo = loadImage("SpritesTitulo.png"); 
  versus = loadImage("Vs.png");
  terminado = loadImage("GameOver.png");
  muerte = loadImage("Muerte.png");
  win = loadImage("Win.png");
  boss = loadImage("Fake.png");
  ganar = loadImage("Ganar.png");
    
  minim = new Minim(this);
  musicaPortada = minim.loadFile("Portada.mp3");
  musicaJuego = minim.loadFile("Juego.mp3");
  musicaGameOver = minim.loadFile("GameOver.mp3");
  musicaPortada.play(); 
  musicaPortada.loop(); 
  
  disparo1 = minim.loadSample("Piu1.mp3");
  disparo2 = minim.loadSample("Piu2.mp3");
  choque = minim.loadSample("Boom.mp3");
  siguiente = minim.loadSample("NextLevel.mp3");

  
  regular = createFont("Quicksand-Regular.ttf", 30);
  bold = createFont("Quicksand-Bold.ttf", 50); 
}

void draw(){
  if(escenario ==1){
   portada();
  }
  else if(escenario == 2){
   juego();
  }
  else if(escenario == 3){
   gameOver(); 
  }
  else if(escenario == 4){
   win(); 
  }
  else if(escenario == 5){
    historia();
  }
}

void portada(){
 background(#213E62);
 fondo.dibujar();
 imageMode(CENTER);
 image(gatito, width/4, height*3/4);
 image(perrito, width*3/4, height*3/4);
 image(titulo, width/2, height/4);
 image(versus, width/2, height*3/4);
 
 textFont(bold);
 fill(#FB9D4B);
 textAlign(CENTER);
 text("Presionar Barra Spacial", width/2, height/2);
 
}

void playPortada(){
   musicaJuego.pause();
   musicaGameOver.pause();
   musicaPortada.play(); 
   musicaPortada.loop(); 
   
}

void historia(){
 background(#213E62);
 fondo.dibujar();
 
 pushMatrix();
 noStroke();
 fill(#D59CC0);
 rectMode(CENTER);
 rect(width/2, height/2, width, height/2);
 popMatrix();
 
 pushMatrix();
 noStroke();
 fill(255);
 textAlign(LEFT,CENTER);
 textFont(regular);
 String texto = "Existía en un universo lejano dos especies enemigas; gatos y perros. Los gatos eran seres relajados y amistosos, mientras los perros eran agresivos y rencorosos, por el contrario de lo que se creía de ellos.";
 text(texto,width/2, height/2, width/3, width*5/6);
 popMatrix();
 
 pushMatrix();
 noStroke();
 fill(255);
 textAlign(LEFT,CENTER);
 textFont(bold);
 String textito = "Presione barra espacial";
 text(textito ,width/2, height*3/4-50);
 popMatrix();
 
 pushMatrix();
 imageMode(CENTER);
 image(gatito, width/6, height/2);
 popMatrix();
 
 pushMatrix();
 imageMode(CENTER);
 image(boss, width*5/6, height/2);
 popMatrix();
}

void juego(){
  background(#213E62);
  fondo.dibujar();
  
  gato.dibujar();
  
  if(esCambioNivel){
     pop.dibujar(nivel);
     
     if (millis() - instanteCambio > intervaloCambio) {
       esCambioNivel = false;
     }
  }
  
   for( int x=0; x<leches.size(); x++){
     Leche lechita = leches.get(x);
     lechita.dibujar();
     lechita.mover();
     
     if(gato.getPos().dist(lechita.getPos())<50 && lechita.existe()){
       lechita.quitar();
       gato.masVida(); 
     }
     
     if(!lechita.existe()){
      leches.remove(x); 
     }
   }
  
  //Pregunta para los primeros 3 niveles
  if(nivel <4){
    for(int x=0; x<perros.size(); x++){
      Perro perro = perros.get(x);
      perro.dibujar();
      perro.mover();
      
      //gato pierde vida cuando un perro chiquito se le acerca
      if(gato.getPos().dist(perro.getPos())< 50){
        explosiones.add(new Explosion(perro.getPos()));
        perros.remove(x);
        gato.quitarVida();
        choque.trigger();
      }
      
      // Gato dispara perros chiquitos
      if(gato.matar(perro.getPos())){
        explosiones.add(new Explosion(perro.getPos()));
        perros.remove(x);
        cantidadPerros += 1;
        choque.trigger();
      }
    }
     
    }
    
    // Crea un minimo perros segun cada nivel
    if(millis() - instantePerro > intervaloPerro){
      if(nivel == 1){
        if(perros.size() < 3){
          Perro otroPerro = new Perro(1);
          perros.add(otroPerro);
        }
        if (cantidadPerros >= 5){
         nuevoNivel();
         siguiente.trigger();
        }
      }
      else if(nivel == 2){
        if(perros.size() < 7){
          Perro otroPerro = new Perro(round(random(1,2)));
          perros.add(otroPerro);
        }
        if (cantidadPerros >= 7){
         nuevoNivel();
         siguiente.trigger();
        }
      }
       else if(nivel == 3){
        if(perros.size() < 3){
          Perro otroPerro = new Perro(2);
          perros.add(otroPerro);
        }
        if (cantidadPerros >= 7){
          nuevoNivel();
          siguiente.trigger();
        }
      }
      instantePerro = millis();
    }
  
  // EL JEFE
  else if(nivel == 4){
    dogBoss.dibujar();
    dogBoss.mover();
    dogBoss.disparar();
    
    // Perro toca gato
    if(dogBoss.getPos().dist(gato.getPos())<100){
     gato.quitarVida();
     choque.trigger();
    }
    
    // Perro balea gato
    if(dogBoss.matar(gato.getPos())){
     explosiones.add(new Explosion(gato.getPos())); 
     gato.quitarVida();
     choque.trigger();
    }
    
    // Gato balea Boss
    if(gato.matar(dogBoss.getPos())){
      explosiones.add(new Explosion(dogBoss.getPos())); 
      dogBoss.quitarVida();
      choque.trigger();
    }
  }
    
    //LECHES
   if(millis() - instanteLeche > intervaloLeche){
    Leche lechita = new Leche();
    leches.add(lechita);
    instanteLeche = millis();
    
   }
  
  //EXPLOSIONES
  for( int x=0; x<explosiones.size(); x++){
   Explosion boom = explosiones.get(x);
   if (boom.esta()){
    boom.dibujar(); 
   }
  }
  
  //Mostrar pantalla de game over
  if(!gato.estaVivo()){
   escenario = 3; 
   musicaJuego.pause();
   playGameOver();
  }
  
  //Mostrar pantalla de enhorabuena
  if(!dogBoss.estaVivo()){
   escenario = 4;
   
  }

}

//Funcion para crear nuevo nivel
void nuevoNivel() {
  esCambioNivel = true;
  instanteCambio = millis();
  nivel ++;
  cantidadPerros = 0;
}

//poner a andar la musica del juego principal
void playJuego(){
   musicaJuego.play();
   musicaJuego.loop(); 
   musicaGameOver.pause();
   musicaPortada.pause(); 
}

//pone a andar la pantalla de que el juego se acabo
void gameOver(){
 background(#753241);
 fondo.dibujar();
 imageMode(CENTER);
 image(terminado, width/2, height/4);
 image(muerte, width/2, height*3.5/4);
 
}

//pone a andar la musica triste de que el juego se acabo
void playGameOver(){
   musicaJuego.pause();
   musicaGameOver.play();
   musicaGameOver.loop();
   musicaPortada.pause(); 
}

//Muestra la pantalla de que el juego fue ganado
void win(){
  background(#45B6D0);
  fondo.dibujar();
  imageMode(CENTER);
  image(win, width/2, height/4);
  image(ganar, width/2, height*3.5/4);
  
}

//Restaura los valores predeterminados para comenzar una nueva partida
void reset(){
 gato.reset();
 dogBoss.reset();
 intervaloPerro = 1000;
 instantePerro = millis();
 instanteCambio = millis();
 intervaloCambio = 2000;
 instanteLeche = millis();
 intervaloLeche = 10000;
 perros.clear();
 nivel = 1;
 playJuego();
 cantidadPerros = 0;
 explosiones.clear();
 
}

void disparo(float tipo){
 if(tipo ==1){
  disparo1.trigger(); 
 }
 if(tipo ==2){
  disparo2.trigger(); 
 }
}

void keyPressed(){
  if(escenario == 1){
   if(key == ' '){
    escenario = 5;
    return;
   }
  }
  
  if(escenario == 5){
   if(key == ' '){
    escenario = 2; 
    reset();
    return;
   }
  }
  
  if(escenario == 2){
    if(key == ' '){
      gato.disparar();
      disparo(round(random(1,2)));
      return;
    }
    
    if( keyCode == RIGHT){
      gato.moverDer();
      return;
    }
    else if( keyCode == LEFT){
     gato.moverIzq();
     return;
    }
  }
  
  if(escenario == 3 || escenario == 4){
   if(key == ' '){
     escenario = 1;
     playPortada();
     return;
   }
  }
}

void keyReleased(){
 gato.quieto(); 
}
