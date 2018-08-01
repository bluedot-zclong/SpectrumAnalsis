package bluedot.spectrum.commons.vo;

import java.io.Serializable;

/**
 * 
 * @ClassName: Point
 * @author WFP
 * @date 2018年2月1日 下午3:04:24
 * @Description: 光谱数据点X,Y
 *
 */
public class Point implements Serializable {
	private static final long serialVersionUID = -4608917027544344292L;
	private double x;
	private double y;

	public Point(){
		
	}
	
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
	}

	@Override
	public String toString() {
		return "{ \"x\": " + x + "," +"\"y\": "+ y + "}";
	}

	@Override
	public boolean equals(Object obj) {
		if (null == obj) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof Point) {
			Point point = (Point) obj;
			if (point.x == this.x && point.y == this.y) {
				return true;
			}
		}
		return false;
	}

	@Override
	public int hashCode() {
		double r = 32 * (x + 7) * (y + 11);
		return (int) r;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

}
