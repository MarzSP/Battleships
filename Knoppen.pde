// Alle knoppen in het spel
final float BUTTON_X = 350;
final float BUTTON_Y = BUTTON_X / 7;
final float BUTTON_SIZE = BUTTON_Y / 2;
final float BUTTON_CENTER = 66;
final float BUTTON_SIZE_FACTOR = 0.5;
final float START_BUTTON_SIZE = 120;
final float OFFSET_SCREEN = 2 * BUTTON_Y; 
final float REPLAY_BUTTON_SIZE = 60;
final float BUTTON_SCALE = REPLAY_BUTTON_SIZE / 12;

final color GREY = #C9C9C9;
final color WHITE = #FFFFFF;
final color GREEN = #12FF03;
final color RED = #FF001E;

//Tekst labels
void drawLabel(String label, float x, float y) {
  text(label, x, y);
}

// Knop met text er in
void drawTextButton(float x, float y, float width, float height, String label) {
  drawButton(x, y, width, height, label);
}

// Knop met cijfers er in
void drawSizeButtons(int count, float startX, float startY, float spacing) {
  for (int i = 0; i < count; i++) {
    float xPos = startX + i * spacing;
    float yPos = startY;
    drawButton(xPos - 20, yPos - 10, BUTTON_Y, BUTTON_Y / 2, " " + (i + 2) * 5 + "x" + (i + 2) * 5);
  }
}

// Knop start-spel
void drawStartButton(float x, float y, float width, float height) {
  if (mouseX > x - width / 2 && mouseX < x + width / 2 && mouseY > y && mouseY < y + height) {
    fill(RED);
  } else {
    fill(GREEN);
  }

  rect(x - width / 2, y, width, height, BUTTON_SCALE);
  fill(0);
  textSize(18);
  text("START SPEL", x, y + height / 2);
}

// Knop +/- voor aantal spelers in startscherm
void drawButton(float x, float y, float width, float height, String label) {
  if (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height) {
    fill(GREY);
  } else {
    fill(WHITE);
  }
  rect(x, y, width, height, BUTTON_SCALE);
  fill(0);
  textSize(18);
  text(label, x + width / 2, y + height / 2);
}

// Knop opnieuw spelen in Eindscherm
void drawReplayButton() {
  fill(GREEN); // Groene kleur
  rect(width / 4, 3 * height / 4, width / 2, 12 * BUTTON_SCALE, BUTTON_SCALE); // Knop rechthoek
  fill(0);
  textSize(20);
  text("Opnieuw spelen!", width / 2, 3 * height / 4 + 6 * BUTTON_SCALE); // Knop tekst
}

// Knop Exit in Eindscherm
void drawCloseButton() {
  fill(RED); // Rode kleur
  rect(width - 27 * BUTTON_SCALE, height - 13 * BUTTON_SCALE, 2 * START_BUTTON_SIZE / 3, BUTTON_SIZE, BUTTON_SCALE); // Knop rechthoek
  fill(0);
  textSize(16);
  text("Sluiten", width - 19 * BUTTON_SCALE, height - 11 * BUTTON_SCALE); // Knop tekst
}
