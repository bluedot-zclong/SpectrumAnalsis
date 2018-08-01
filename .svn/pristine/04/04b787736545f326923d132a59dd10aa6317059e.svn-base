package bluedot.spectrum.utils;

import java.util.ArrayList;

import bluedot.spectrum.commons.vo.Point;

public class MathUtils {
	/**
	 * x平均值  0-m的平均值
	 * @param list
	 * @param m
	 * @return
	 */
	private static double averager(ArrayList<Point> list){
		double result = 0;
		for(int i=0;i<=list.size();i++){
			result+=list.get(i).getX();
		}
		result = result/list.size();
		return result;
	}
	
	/**
	 * SVN
	 * @param list
	 * @param m
	 * @return
	 */
	public static double SVN(ArrayList<Point> list,int index){
		double average = averager(list);
		double result = 0;
		for(int i=0;i<list.size();i++){
			double k = list.get(i).getX();
			result += Math.pow(k-average,2);
		}
		result = result/(list.size()-1);
		result = Math.sqrt(result);
		result = (list.get(index).getX()-average)/result;
		return result;
	}
}
