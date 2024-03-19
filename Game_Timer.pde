// Bij 2 spelers loopt er een timer. Iedere speler krijgt 20s per beurt. Als de tijd verstreken is gaat de beurt automatisch door naar de volgende speler.

void checkTimer() {
  // Controleer op timeout
  if (millis() - lastClickTime > turnTimeout) {
    nextPlayer(); // Ga naar de volgende beurt als de timeout op 0 beland
  }
}

// Als er maar 1 speler speelt, hoeft er geen timer te zijn
void drawTimer() {
  if (numberOfPlayers == 1) {
    return;
  }
  
  // Bereken de resterende tijd
  int remainingTime = turnTimeout - (millis() - lastClickTime);
  if (remainingTime < 0) {
    remainingTime = 0; // Tijd kan niet negatief worden <0
  }

  // Tekst weergeven op het scherm
  textSize(16);
  textAlign(CENTER, TOP);
  fill(0);
  drawLabel("Tijd over: " + nf(float(remainingTime) / 1000, 0, 1), width / 2, height - BUTTON_SIZE); // Tijd in seconden
}
