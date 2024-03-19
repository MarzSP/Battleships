//Startscsherm
int gridSize = 10;
int numberOfPlayers = 1;
int[][][] gridPlayer1;
int[][][] gridPlayer2;
boolean activeStartWindow = true; // veranderd naar False in MousePressedGame methode

// Wat er getekend wordt op het startscherm
void startWindow() {
  textAlign(CENTER, CENTER);
  textSize(36);
  fill(0);
  drawLabel("Zeeslag", width / 2, height / 14);

  // Aantal spelers
  textSize(18);
  drawLabel("Aantal Spelers:", width / 2, 2 * BUTTON_Y - BUTTON_SIZE);
  // Aantal spelers knoppen
  drawButton(BUTTON_X, 2 * BUTTON_Y, BUTTON_SIZE, BUTTON_SIZE, "-");
  drawButton(BUTTON_X + BUTTON_CENTER, 2 * BUTTON_Y, BUTTON_SIZE, BUTTON_SIZE, "+");
  // Aantal spelers gekozen
  drawTextButton(BUTTON_X + BUTTON_SIZE + BUTTON_SIZE / 5, 2 * BUTTON_Y, 30, BUTTON_SIZE, str(numberOfPlayers));
  // Speelveld grootte
  drawLabel("Speelveld:", width / 2, BUTTON_X / 2);
  drawSizeButtons(3, width / 2 - 3 * BUTTON_Y / 2, 4 * BUTTON_Y, 3 * BUTTON_Y / 2);
  // Knop Start Spel
  drawStartButton(width / 2, 2 * START_BUTTON_SIZE + 10, START_BUTTON_SIZE, START_BUTTON_SIZE / 3);
}

// De mousePressed events die tot de knoppen in startWindow behoren
void mousePressedStartWindow() {
  //println("Mouse X: " + mouseX + " | Mouse Y: " + mouseY);
  if (isMouseOver(mouseX, mouseY, BUTTON_X, 2 * BUTTON_Y, BUTTON_SIZE, BUTTON_SIZE)) {
     switchPlayers('-');
    println("player -");
  } else if (isMouseOver(mouseX, mouseY, BUTTON_X + BUTTON_CENTER, 2 * BUTTON_Y, BUTTON_SIZE, BUTTON_SIZE)) {
    switchPlayers('+');
    println("player +");
  }

  // Gridformaat/moeilijkheidskeuze
  for (int i = 0; i < 3; i++) {
    if (isMouseOver(mouseX, mouseY, width / 2 - BUTTON_Y + i * (BUTTON_Y + BUTTON_Y / 5) - BUTTON_Y / 2, 4 * BUTTON_Y - BUTTON_Y / 4, BUTTON_Y, BUTTON_Y / 2)) {
      gridSize = 10 + (i * 5);
    }
  }
  // Startknop functie
  if (isMouseOver(mouseX, mouseY, width / 2 - START_BUTTON_SIZE, 2 * START_BUTTON_SIZE + 10, 2 * START_BUTTON_SIZE, START_BUTTON_SIZE / 3)) {
    gridPlayer1 = generate(gridSize, gridSize);
    if (numberOfPlayers == 2) {
      gridPlayer2 = generate(gridSize, gridSize);
      currentPlayer = 1;
    }
    
    activeStartWindow = false;
    println("Test pass: Startknop is geclicked! activeStartWindow is nu False");
  }
}

// De functie voor spelerverandering naar aantal 1 of 2 (of meer)
void switchPlayers(char direction) {
  if (direction == '-' && numberOfPlayers > 1) {
    numberOfPlayers--;
  } else if (direction == '+' && numberOfPlayers < 2) {
    numberOfPlayers++;
  }
}

// Boolean of de muis zich op de knop bevind of niet
boolean isMouseOver(float mouseX, float mouseY, float x, float y, float width, float height) {
  return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
}
