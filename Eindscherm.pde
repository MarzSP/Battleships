// Eindscherm als het spel is afgelopen

void proceedEndscreen () {
  //Hier op staan het totaal aantal punten en optie om nog een keer te spelen
  textSize(24);
  textAlign(CENTER, CENTER);
  fill(0);
  
  drawLabel("GAME OVER!", width/2, height/5);
  String win = (scores[0] > scores[1]) ? "Speler 1" : "Speler 2";
  drawLabel("Winnaar: " + win, width / 2, height / 4);
  drawLabel("Score Speler 1: " + scores[0], width / 2, height / 2); 
  drawLabel("Score Speler 2: " + scores[1], width / 2, height / 2 + 8 * BUTTON_SCALE);

  drawReplayButton();
  drawCloseButton();
}

void mousePressedEndscreen() {
  if (isGameOver) {
    //muisklik op de knop "Opnieuw spelen"
    if (mouseX > width / 4 && mouseX < 3 * width / 4 && mouseY > 3 * height / 4 && mouseY < 3 * height / 4 + REPLAY_BUTTON_SIZE) {
      isGameOver = false;
      // Reset eventuele score(s)
      scores[0] = 0;
      scores[1] = 0;
      
      activeStartWindow = true; // Gaat terug naar methode startWindow() via de boolean activeStartWindow
      println("Opnieuwspelen check");
    }

    // muisklik op Sluiten
    if (mouseX > width - BUTTON_SCALE * 27 && mouseX < width - REPLAY_BUTTON_SIZE / 2 && mouseY > height - BUTTON_SCALE * 11 && mouseY < height - REPLAY_BUTTON_SIZE / 2) {
      exit(); // Exit window, het scherm sluit
    }
  }
}
