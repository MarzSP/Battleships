int cellSize = 25;
int[] scores = {0,0};
int currentPlayer = 0;
boolean debugView = false;
boolean isGameOver = false;
int lastClickTime; // Tijdstip van de laatste klik
int turnTimeout = 20*1000; // Timeout van 20 seconden

void drawGameScreen() {
  // setup van speelscherm
  textSize(22);
  textAlign(CENTER, TOP);
  fill(0); // Zwart
  text("Zeeslag", width/2, 10);

  // Tekst Speler 1 links
  textSize(16);
  textAlign(CENTER, TOP);
  fill(0);
      
  // Tekstlabels voor Speler 1 en Speler 2
  drawLabel("Speler 1", width / 6 + 5, height / 15);
  if (numberOfPlayers == 1) {
    drawLabel("Punten: " + scores[0], width / 6, height / 10);
  } else {
    drawLabel("Punten: " + scores[1], width / 6, height / 10);
    
    // Tekst Speler 2 rechts
    drawLabel("Speler 2", 2 * width/ 3, height /15);
    drawLabel("Punten: " + scores[0], 2 * width / 3, height / 10);
  }

  // Linkergrid Speler 1
  drawGrid(width / 6, 100, gridPlayer1);

  // Als er 2 spelers zijn, dan extra grid Speler 2
  if (numberOfPlayers == 2) {
    println("Spel met 2 spelers");
    drawGrid(width - width / 3 - 20, OFFSET_SCREEN, gridPlayer2);
  }
  drawTimer();
}


void drawGrid(float x, float y, int[][][] array) {
  int[][] zichtbaarbord = array[0];
  if (debugView) {
      zichtbaarbord = array[1]; // for debug
  }

  // Loop door de array en teken het grid op basis van de waarden in de verborgen array
  for (int row = 0; row < zichtbaarbord.length; row++) {
    for (int column = 0; column < zichtbaarbord[row].length; column++) {
      float cellX = x + column * cellSize;
      float cellY = y + row * cellSize;

      int cellValue = zichtbaarbord[row][column];
      int fillColor;

      switch (cellValue) { //Bij klik op vakje komt corresponderende kleur tevoorschijn in het hidden speelveld
      case WATER:
        fillColor = #079AF2;
        break;
      case SLAGSCHIP:
        fillColor = #956A27;
        break;
      case KRUISBOOT:
        fillColor = #FFA600;
        break;
      case TORPEDO:
        fillColor = #FFD500;
        break;
      case ONDERZEEER:
        fillColor = #ADFF00;
        break;
      case MIJN:
        fillColor = #FF2B00;
        break;

      default:
        fillColor = #FFFFFF;
        break;
      }

      fill(fillColor);
      rect(cellX, cellY, cellSize, cellSize);
    }
  }

  drawShipCount(x, y, array[1]);
}
// Hidden speelbord vergelijken met zichtbaar speelbord
void mouseCheckGrid(float x, float y, int[][][] array) {

  int[][] echtbord = array[1];
  int[][] zichtbaarbord = array[0];

  for (int row = 0; row < zichtbaarbord.length; row++) {
    for (int column = 0; column < zichtbaarbord[row].length; column++) {
      float cellX = x + column * cellSize;
      float cellY = y + row * cellSize;


      if (zichtbaarbord[row][column] == 0 && mouseX >= cellX  && mouseY >= cellY && mouseX < cellX+cellSize && mouseY < cellY+cellSize) {
        // Reset de timer voor nieuwe beurt
        lastClickTime = millis(); 
        
        switch(echtbord[row][column]) {
          case 0:
            zichtbaarbord[row][column] = WATER;
            break;
            
            // als speler 1 of speler 2 op een mijn klikt, dan is hun beurt voorbij en 1 minpunt
          case MIJN:
            zichtbaarbord[row][column] = MIJN;
            scores[currentPlayer] -= 1;
            nextPlayer();
            break;
            
          default:
             // boot ontdekt
            zichtbaarbord[row][column] = echtbord[row][column];
            scores[currentPlayer] += getScoreForShip(zichtbaarbord, row, column);
            
            if (clearedBord(array)) {
              isGameOver = true;
              proceedEndscreen();
            }
            break;
        }
   
      }
    }
  }
}
// Speler 0 = 1, Speler 2 = 1
void nextPlayer() {

  if (numberOfPlayers == 1) {
    return;
  }
  if (currentPlayer == 0) {
    currentPlayer = 1;
  } else {
    currentPlayer = 0;
  }
          
}


void mousePressedGame() {
  switch (currentPlayer) {
   case 0:
      mouseCheckGrid(width / 6, OFFSET_SCREEN, gridPlayer1);
      break;
   case 1:
      mouseCheckGrid(width - width / 3 - 20, OFFSET_SCREEN, gridPlayer2);
      break;
  }
  //Alleen de betreffende speelbord is klikbaar voor die speler (van de tegenstander) - geselecteerd speelveld
} 

// drawShipCount zet op de X en Y as het aantal velden dat bezet is door een schip
void drawShipCount (float x, float y, int[][] speelveld) {
  int rows = speelveld.length;
  int cols = speelveld[0].length;
  
  // Count ships in de rijen voor totaal aantal punten in die rij - horizontaal
  // R genoemd voor Rijen
  // C genoemd voor Kolommen
  for (int r = 0; r < rows; r++) {
    int shipCount = 0;
    for (int c = 0; c < cols; c++) {
      if (speelveld[r][c] != 0 && speelveld[r][c] != 5) {
        shipCount++;
      }
    }
    textAlign(CENTER, CENTER);
    fill(0);
    text(shipCount, x - cellSize / 2, y + r * cellSize + cellSize / 2);
  }

  // Count ships in de kolommen voor totaal aantal punten in die kolom - verticaal
  for (int c = 0; c < cols; c++) {
    int shipCount = 0;
    for (int r = 0; r < rows; r++) {
      if (speelveld[r][c] != 0  && speelveld[r][c] != 5) {
        shipCount++;
      }
    }
    textAlign(CENTER, CENTER);
    fill(0);
    text(shipCount, x + c * cellSize + cellSize / 2, y - cellSize / 2);
  }
}

// Controlleer op hele boten in het echt veld voor de score.
int getAllBoatCheckers(int[][] bord) {
  int wholeBoats = 0;
  for (int r = 0; r < bord.length; r++) {
    for (int c = 0; c < bord[r].length; c++) {
      if (bord[r][c] == 0 || bord[r][c] == MIJN) {
        continue;
      }
       
      wholeBoats++;
    }
  }
  return wholeBoats;
}
// Boolean voor of alle boten zijn gevonden
boolean clearedBord(int[][][] array) {
  int[][] zichtbaarbord = array[0];
  int[][] echtbord = array[1];
  
  return getAllBoatCheckers(zichtbaarbord) == getAllBoatCheckers(echtbord);
}
