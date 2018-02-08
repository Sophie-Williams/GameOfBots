public class GOBBot //a first Bot for GOB
{
    public Net net;
    int sizeX = 15;
    int sizeY = 15;
    int[][] IDs = new int[sizeX][sizeY];

    public GOBBot(float weight)
    {
        net = new Net();
    }

    /*public GOBBot(float weight, float[][] l0, float[][] l1, float r,float g, float b)
    {
    d=random(TAU);
    s=random(1);
    net = new Net();
    }*/
    void updaten() {
        float[] arr = new float[sizeX*sizeY];
        float[] array = new float[sizeX*sizeY];
        for (int i=0; i<sizeX; i++)
            for (int j=0; j<sizeY; j++)
                array[i*sizeX+j] = IDs[i][j];
        //println(net.update(array));
        arr = net.update(array);
    }
}
