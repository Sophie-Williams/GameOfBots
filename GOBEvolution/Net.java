public class Net { //a fully connected neural net for GOB
    //der eine ist die SpielerNummer
    float[][] l0 = new float[51][100];//1st layer:Playfield+1 * 1st internal
    float[][] l1 = new float[l0[0].length][100];//2nd layer:1st internal* 2nd internal
    float[][] l2 = new float[l1[0].length][5];//2nd layer:2nd internal* PlayerPlayfield
    public Net() {//initialize randomly from -1 to 1
        for (int i=0; i<l0.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                l0[i][j] = (float)(Math.random()*2)-1;
        }
        for (int i=0; i<l1.length; i++) {
            for (int j=0; j<l1[0].length; j++)
                l1[i][j] = (float)(Math.random()*2)-1;
        }
        for (int i=0; i<l2.length; i++) {
            for (int j=0; j<l2[0].length; j++)
                l2[i][j] = (float)(Math.random()*2)-1;
        }
    }

    public Net(float[][] ol0, float[][] ol1, float[][] ol2) {//copy other Net
        l0 = ol0;
        l1 = ol1;
        l2 = ol2;
    }
    
    public Net(float[][] ol0, float[][] ol1, float[][] ol2
    , float[][] old0, float[][] old1, float[][] old2) {//intitialize from two Nets by calculating the mean
        l0 = ol0;
        l1 = ol1;
        l2 = ol2;
        for (int i=0; i<l0.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                l0[i][j] = (l0[i][j]+old0[i][j])/2;
        }
        for (int i=0; i<l1.length; i++) {
            for (int j=0; j<l1[0].length; j++)
                l1[i][j] = (l1[i][j]+old1[i][j])/2;
        }
        for (int i=0; i<l2.length; i++) {
            for (int j=0; j<l2[0].length; j++)
                l2[i][j] = (l2[i][j]+old2[i][j])/2;
        }
    }
    
    public void randomize(double amount) {//randomize the layers by amount
        for (int i=0; i<l0.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                l0[i][j] = l0[i][j]+(float)((Math.random()*amount)-(amount/2));
        }
        for (int i=0; i<l1.length; i++) {
            for (int j=0; j<l1[0].length; j++)
                l1[i][j] = l1[i][j]+(float)((Math.random()*amount)-(amount/2));
        }
        for (int i=0; i<l2.length; i++) {
            for (int j=0; j<l2[0].length; j++)
                l2[i][j] = l2[i][j]+(float)((Math.random()*amount)-(amount/2));
        }
    }

    public float[] update(float[] input) {
        if (input.length != l0[0].length)
            return new float[0];
        float[] layer = new float[input.length]; 
        for (int i=0; i<input.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                layer[i] += input[i]*l0[i][j];
        }
        float[] internal = new float[l1[0].length];
        for (int i=0; i<l1[0].length; i++) {
            for (int j=0; j<l1[0].length; j++)
                internal[i] +=
                layer[i]*
                l1[i][j];
        }
        float[] out = new float[l2[0].length];
        for (int i=0; i<l2[0].length; i++) {
            for (int j=0; j<l2[0].length; j++)
                out[i] +=
                layer[i]*
                l2[i][j];
        }
        return out;
    }
}
