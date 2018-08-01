package bluedot.spectrum.utils.spectrum;

import bluedot.spectrum.commons.vo.SpectrumFile;

public class SpectrumUtils {
	/**
	 * 取出光谱对象中的点，为double数组对象
	 * WFP
	 * @param spectrumFile
	 * @return
	 * 2018年3月17日
	 */
	public static double[][] getSpectrumFilePoints(SpectrumFile spectrumFile){
		double [][] points = new double[2][spectrumFile.getPoints().size()];
		
		for(int i=0;i<spectrumFile.getPoints().size();i++){
			points[0][i] = spectrumFile.getPoints().get(i).getX();
			points[1][i] = spectrumFile.getPoints().get(i).getY();
		}
		return points;
	}
	/**
	 * 将double数组对象，设为光谱对象中的点
	 * WFP
	 * @param points
	 * @param spectrumFile
	 * @return
	 * 2018年3月17日
	 */
	public static SpectrumFile setSpectrumFilePoints(double[][] points,SpectrumFile spectrumFile){
		for(int i=0;i<spectrumFile.getPoints().size();i++){
			spectrumFile.getPoints().get(i).setX(points[0][i]);
			spectrumFile.getPoints().get(i).setY(points[1][i]);
		}
		return spectrumFile;
	}
}
