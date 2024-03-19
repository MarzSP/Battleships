 // Hier worden de speelvelden automatisch gegenereerd met boten en schepen er in
final int WATER = 6;
final int MIJN = 5; // 10% van speelveld
final int SLAGSCHIP = 4; // x1
final int KRUISBOOT = 3; // x2
final int TORPEDO = 2; // x3
final int ONDERZEEER = 1; // x4


// boolean isEmptySpace controlleerd of het vakje leeg is of niet. Als het vakje bezet is gaat deze naar het volgende vakje.
boolean isEmptySpace(int[][] speelveld, int x, int y, int length) {
  for (int offset = 0; offset < length; offset++) {
    
    if (speelveld[x+offset][y] > 0) {
      return false; // zoek opieuw naar plaats voor een schip
    }
  }
  return true;
}

// generateBoat plaatst een schip op een random plek binnen het kader van het speelveld
int[] generateBoat(int length, int type, int[][] speelveld, int sizeX, int sizeY) {
  int x;
  int y;
  do {
    x = int(random(0, sizeX - length+1));
    y = int(random(0, sizeY));
  } while (!isEmptySpace(speelveld, x, y, length));

  for (int offset = 0; offset < length; offset++) {
    speelveld[x+offset][y] = type;
  }

  int[] boatDetails = {x, y, length, type};
  return boatDetails; // geeft een array met de geplaatste schepen
}

// De boten die in het speelveld moeten worden geplaatst
int[][][] generate(int sizeX, int sizeY) {
  int[][][] speelveld = new int[2][sizeX][sizeY];

  generateBoat(4, SLAGSCHIP, speelveld[1], sizeX, sizeY);

  generateBoat(3, KRUISBOOT, speelveld[1], sizeX, sizeY);
  generateBoat(3, KRUISBOOT, speelveld[1], sizeX, sizeY);


  generateBoat(2, TORPEDO, speelveld[1], sizeX, sizeY);
  generateBoat(2, TORPEDO, speelveld[1], sizeX, sizeY);
  generateBoat(2, TORPEDO, speelveld[1], sizeX, sizeY);

  generateBoat(1, ONDERZEEER, speelveld[1], sizeX, sizeY);
  generateBoat(1, ONDERZEEER, speelveld[1], sizeX, sizeY);
  generateBoat(1, ONDERZEEER, speelveld[1], sizeX, sizeY);
  generateBoat(1, ONDERZEEER, speelveld[1], sizeX, sizeY);

 

  // Op 10% van de overgebleven velden worden mijnen geplaatst
  int numberOfMines = sizeX*sizeY / 10;
  for (int mineIndex = 0; mineIndex < numberOfMines; mineIndex++) {
    generateBoat(1, MIJN, speelveld[1], sizeX, sizeY);
  }

  return speelveld; //geeft het speelveld mee
}
