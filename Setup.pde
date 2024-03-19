//Beroepsproduct Marianne Peterson 2136361
//Docent Ronald Schellekens Gestructureerd Programmeren
// 23/24 HAN

final color BACKGROUND_COLOR = #AEC1E0;
final float STROKE_WEIGHT = 2;
final String BACKGROUND_IMAGE_PATH = "zeeslag.jpg";
final float IMAGE_X = 0;
final float IMAGE_Y = 0;
PImage backgroundImage;

void setup() {
  size(800, 700);
  surface.setResizable(true); // Maakt het grafisch scherm schaalbaar
  
  //Om de unit testen aan te roepen, haal de comment weg hier onder:
  //test();
}

void draw() {
// Achtergrond kleur en dikte van randen
 background(BACKGROUND_COLOR);
 strokeWeight(STROKE_WEIGHT);

// Achtergrond image

  backgroundImage = loadImage(BACKGROUND_IMAGE_PATH);
    image(backgroundImage, IMAGE_X, IMAGE_Y, width, height);
// Logica voor spelverloop van startscsherm naar gamescherm naar eindscherm
  if (activeStartWindow) {
    startWindow();
  } else if (isGameOver) {
    proceedEndscreen();
  } else {
    drawGameScreen();
  }
}

// Logica voor alle mouse-pressed methodes van startscherm naar gamescherm naar eindscherm.
void mousePressed() {

  if (activeStartWindow) {
    
    mousePressedStartWindow();
  } else if (isGameOver) {
    
    mousePressedEndscreen();
  } else {

    mousePressedGame();
  }
}
