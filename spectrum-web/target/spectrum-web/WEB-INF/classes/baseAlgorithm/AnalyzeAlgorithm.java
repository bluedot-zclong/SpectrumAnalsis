
import java.io.*;


public class AnalyzeAlgorithm {
    public static void main(String[] args) {
        PretreatmentAlgorithm pretreatmentAlgorithm = new PretreatmentAlgorithmWFP();
        InputStream inputStream = System.in;
        OutputStream outputStream = System.out;
        try {
            ObjectInputStream objectInputStream = new ObjectInputStream(inputStream);
            double[][] points = (double[][])objectInputStream.readObject();
            for (int i=0;i<points.length;i++){
                for (int j=0;j<points[i].length;j++){

                }
            }
            inputStream.close();
            objectInputStream.close();
            points = pretreatmentAlgorithm.pretreatmentAlgorithm(points);

            ObjectOutputStream objectOutputStream1 = new ObjectOutputStream(outputStream);
            objectOutputStream1.writeObject(points);
            objectOutputStream1.flush();
            objectOutputStream1.close();

        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
