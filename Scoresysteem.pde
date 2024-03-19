// Score systeem
int getScoreForShip(int[][] echtbord, int row, int col) {
  int shipType = echtbord[row][col];

  // Check voor hele schepen
  int wholeBoats = 1;

  //Check horizontaal voor schepen naar beneden in het grid, om hele schepen te vinden
  for (int i = col + 1; i < echtbord[row].length; i++) {
    println(row+","+i);
    if (echtbord[row][i] == shipType) {
      wholeBoats++;
    } else {
      break;
    }
  }
  //check horizontaal ook terug voor een boot om hele schepen te vinden
  for (int i = col-1; i >= 0; i--) {
    if (echtbord[row][i] == shipType) {
      wholeBoats++;
    } else {
      break;
    }
  }

  // Check  verticaal voor schepen en punten naar beneden toe, om hele schepen te vinden
  for (int i = row + 1; i < echtbord.length; i++) {
    if (echtbord[i][col] == shipType) {
      wholeBoats++;
    } else {
      break;
    }
  }
  // Check verticaal ook terug voor punten naar boven toe, om hele schepen te vinden
  for (int i = row - 1; i >= 0; i--) {
    if (echtbord[i][col] == shipType) {
      wholeBoats++;
    } else {
      break;
    }
  }
  // Bereken score per schip type
  int score = 0; // Score begint op 0

  println("length: "+wholeBoats); // Score check in console
  
  switch (shipType) {
  case SLAGSCHIP:
    if (wholeBoats == 4) {
      score = 4;
    }
    break;
  case KRUISBOOT:
    if (wholeBoats == 3) {
      score = 3;
    }
    break;
  case TORPEDO:
    if (wholeBoats == 2) {
      score = 2;
    }
    break;
  case ONDERZEEER:
    if (wholeBoats == 1) {
      score = 1;
    }
    break;

  default:
    break;
  }

  return score;
}
