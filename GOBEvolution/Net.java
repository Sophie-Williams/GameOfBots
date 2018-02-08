public class Net { //a fully connected neural net for GOB
    float[][] l0 = new float[10][10];
    float[][] l1 = new float[l0[0].length][3];
    public Net() {
        for (int i=0; i<l0.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                l0[i][j] = (float)(Math.random()*2)-1;
        }
        for (int i=0; i<l1.length; i++) {
            for (int j=0; j<l1[0].length; j++)
                l1[i][j] = (float)(Math.random()*2)-1;
        }
    }

    public Net(float[][] ol0, float[][] ol1) {
        l0 = ol0;
        l1 = ol1;
    }

    public float[] update(float[] input) {
        if (input.length != l0[0].length)
            return new float[0];
        float[] layer = new float[input.length]; 
        for (int i=0; i<input.length; i++) {
            for (int j=0; j<l0[0].length; j++)
                layer[i] += input[i]*l0[i][j];
        }
        float[] out = new float[l1[0].length];
        for (int i=0; i<l1[0].length; i++) {
            for (int j=0; j<l1[0].length; j++)
                out[i] +=
                layer[i]*
                l1[i][j];
        }
        return out;
    }
}