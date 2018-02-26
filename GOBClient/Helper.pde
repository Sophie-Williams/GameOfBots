public static class Helper
{
  public static int[][] step(int[][] IDs, GOBClient GOB) {

    int[][] newIDs = new int[IDs.length][IDs[0].length];

    for (int i=0; i<IDs.length; i++)
      for (int j=0; j<IDs[0].length; j++) {
        if (IDs[i][j] != 0) {
          int neigbourCounter = 0;
          int[][] neigbours = getNeigbours(i, j);
          for (int k = 0; k < 6; k++) {
            int nI = neigbours[k][0];
            int nJ = neigbours[k][1];
            if (isInsideBoard(nI, nJ, GOB) && GOB.IDs[nI][nJ] != 0 && GOB.IDs[nI][nJ] != -1) {
              if (GOB.IDs[nI][nJ] > 0) //== IDs[i][j])
                neigbourCounter++;
              else if (GOB.IDs[i][j] == -1)
                neigbourCounter++;
            }
          }
          /*if (i==4&&j==4)
            println(neigbourCounter);*/
          if (neigbourCounter == 0)
            newIDs[i][j] = -1;
          else if (neigbourCounter == 1 || neigbourCounter == 2)
            newIDs[i][j] = IDs[i][j];
          else if (neigbourCounter == 3 || neigbourCounter == 4) {
            int[] neigbourCount = new int[8];
            for (int[] p : neigbours)
              if (IDs[p[0]][p[1]] != -1 && IDs[p[0]][p[1]] != 0)//Damit ein leeres Feld nicht betrachtet wird
                neigbourCount[IDs[p[0]][p[1]]+1]++; //Das +1 im index ist ein Workaround um die ID -1 zu erlauben
            newIDs[i][j] = getIndexOfLargest(neigbourCount)-1;// Das ist der meistvertretene Nachbar
          } else
            newIDs[i][j] = -1;//Das sollte die töten
        }
      }
    return newIDs;
  }

  public static int[][] getNeigbours(int i, int j) {
    int[][] nb = new int[6][2];
    if (j%2 == 1) {
      nb[0][0] = i;
      nb[0][1] = j-1;
      nb[1][0] = i+1;
      nb[1][1] = j-1;
      nb[2][0] = i+1;
      nb[2][1] = j;
      nb[3][0] = i+1;
      nb[3][1] = j+1;
      nb[4][0] = i;
      nb[4][1] = j+1;
      nb[5][0] = i-1;
      nb[5][1] = j;
    } else {
      nb[0][0] = i-1;
      nb[0][1] = j-1;
      nb[1][0] = i;
      nb[1][1] = j-1;
      nb[2][0] = i+1;
      nb[2][1] = j;
      nb[3][0] = i;
      nb[3][1] = j+1;
      nb[4][0] = i-1;
      nb[4][1] = j+1;
      nb[5][0] = i-1;
      nb[5][1] = j;
    }
    return nb;
  }

  private static boolean isInsideBoard(int i, int j, GOBClient GOB) {
    return i >= 0 && i < GOB.sizeX && j >= 0 && j < GOB.sizeY
      && GOB.IDs[i][j] != 0;
  }

  public static int getIndexOfLargest( int[] array )
  {
    if ( array == null || array.length == 0 ) return -1; // null or empty

    int largest = 0;
    for ( int i = 1; i < array.length; i++ )
    {
      if ( array[i] > array[largest] ) largest = i;
    }
    return largest; // position of the first largest found
  }

  public static int[][] fillIDs(int[][] IDs)
  {
    IDs[4][0] = 7;
    IDs[3][1] = 7;
    IDs[4][1] = 7;

    IDs[1][2] = 8;
    IDs[2][2] = 8;
    IDs[1][3] = 8;

    IDs[1][5] = 9;
    IDs[1][6] = 9;
    IDs[2][6] = 9;

    IDs[4][8] = 10;
    IDs[3][7] = 10;
    IDs[4][7] = 10;

    IDs[6][5] = 11;
    IDs[6][6] = 11;
    IDs[7][6] = 11;

    IDs[6][2] = 12;
    IDs[6][3] = 12;
    IDs[7][2] = 12;


    IDs[3][2] = -1;
    IDs[4][2] = -1;
    IDs[5][2] = -1;
    IDs[2][3] = -1;
    IDs[3][3] = -1;
    IDs[4][3] = -1;
    IDs[5][3] = -1;
    IDs[2][4] = -1;
    IDs[3][4] = -1;
    IDs[4][4] = -1;
    IDs[5][4] = -1;
    IDs[6][4] = -1;
    IDs[2][5] = -1;
    IDs[3][5] = -1;
    IDs[4][5] = -1;
    IDs[5][5] = -1;
    IDs[3][6] = -1;
    IDs[4][6] = -1;
    IDs[5][6] = -1;

    return IDs;
  }
}