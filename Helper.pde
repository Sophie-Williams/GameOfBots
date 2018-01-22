public static class Helper
{
  public static int[][] fillIDs(int[][] IDs)
  {
    IDs[4][0] = 1;
    IDs[3][1] = 1;
    IDs[4][1] = 1;
    
    IDs[1][2] = 2;
    IDs[2][2] = 2;
    IDs[1][3] = 2;
    
    IDs[1][5] = 3;
    IDs[1][6] = 3;
    IDs[2][6] = 3;
    
    IDs[4][8] = 4;
    IDs[3][7] = 4;
    IDs[4][7] = 4;
    
    IDs[6][5] = 5;
    IDs[6][6] = 5;
    IDs[7][6] = 5;
    
    IDs[6][2] = 6;
    IDs[6][3] = 6;
    IDs[7][2] = 6;
    
    
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