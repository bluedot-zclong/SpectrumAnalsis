package bluedot.spectrum.utils;

import org.apache.commons.math3.fitting.PolynomialCurveFitter;
import org.apache.commons.math3.fitting.WeightedObservedPoints;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;


public class AlgorithmFittingUtils{

	/**
	 * 执行
	 */
	public static  double execute(String listPointString, String standardPoint){
		JSONArray list = JSON.parseArray(listPointString);
		JSONArray standard = JSON.parseArray(standardPoint);
		final double[] standard_coeff = coeff(standard);
		final double[] list_coeff = coeff(list);
		double leastSquares = leastSquares(standard_coeff, list_coeff);
		return leastSquares;
	}

	/**
	 * 拟合函数
	 * 
	 * @param points
	 * @return
	 */
	private static double[] coeff(JSONArray points) {
		final WeightedObservedPoints obs = new WeightedObservedPoints();
		points.forEach(i -> {
			JSONObject point = (JSONObject) i;
			double x = point.getDoubleValue("x");
			double y = point.getDoubleValue("y");
			obs.add(x, y);
		});
		final PolynomialCurveFitter fitter = PolynomialCurveFitter.create(5);
		final double[] coeff = fitter.fit(obs.toList());
		return coeff;
	}

	/**
	 * y = Ax^5 + Bx^4 + Cx^3 + Dx^2 + Ex^1 + F //F 为常数系数
	 * 
	 * @param standard
	 * @param list
	 * @return
	 */ 
	private static double leastSquares(double[] standard, double[] list) {
		if (standard.length != list.length)
			return 0;
		double sum = 0;
		for (int i = 0, len = standard.length; i < len; i++) {
			sum += Math.pow((standard[i] - list[i]), 2);
		}
		return sum;
	}

}
