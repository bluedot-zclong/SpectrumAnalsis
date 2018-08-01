package bluedot.spectrum.commons.vo;


import java.io.File;
import java.io.Serializable;
import java.util.List;

/**
 * 
 * @ClassName: SpectrumFile
 * @author WFP
 * @date 2018年2月1日 下午3:06:29
 * @Description: 光谱对象
 *
 */

public class SpectrumFile implements Serializable {
    /**
     * 序列化id
     */
    private static final long serialVersionUID = -7414430695439357006L;

    private String xAsix;// 光谱x轴单位,不为空,默认 波数
    private String yAsix;// 光谱y轴单位,不为空,默认 吸光度

    private List<Point> points;// 光谱数据点

    private Double minY = Double.MAX_VALUE;// 最小Y值
    private Double maxY = Double.MIN_VALUE;// 最大Y值
    private Point minPeaks;// 最小峰谷点
    private Point maxPeaks;// 最大峰值点

    private String fileDir; // 文件相对路径  WEB-INF/data/spectrum/2017/9/8
    private String fileName; // 文件名  三唑磷.txt

    /**
     * 对象特征自刷新，依照List<pints>
     */
    public void flush() {
        if (points == null || 0 == points.size()) return;
        minPeaks = points.get(0);
        maxPeaks = minPeaks;
        minY = minPeaks.getY();
        maxY = minY;
        for (Point point : points) {
            if (point.getY() > maxY) {
                maxY = point.getY();
                maxPeaks = point;
            }
            if (point.getY() < minY) {
                maxY = point.getY();
                minPeaks = point;
            }
        }
    }

	public String getxAsix() {
		return xAsix;
	}

	public void setxAsix(String xAsix) {
		this.xAsix = xAsix;
	}

	public String getyAsix() {
		return yAsix;
	}

	public void setyAsix(String yAsix) {
		this.yAsix = yAsix;
	}

	public List<Point> getPoints() {
		return points;
	}

	public void setPoints(List<Point> points) {
		this.points = points;
	}

	public Double getMinY() {
		return minY;
	}

	public void setMinY(Double minY) {
		this.minY = minY;
	}

	public Double getMaxY() {
		return maxY;
	}

	public void setMaxY(Double maxY) {
		this.maxY = maxY;
	}

	public Point getMinPeaks() {
		return minPeaks;
	}

	public void setMinPeaks(Point minPeaks) {
		this.minPeaks = minPeaks;
	}

	public Point getMaxPeaks() {
		return maxPeaks;
	}

	public void setMaxPeaks(Point maxPeaks) {
		this.maxPeaks = maxPeaks;
	}

	public String getFileDir() {
		return fileDir;
	}

	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SpectrumFile [xAsix=" + xAsix + ", yAsix=" + yAsix + ", points=" + points + ", minY=" + minY + ", maxY="
				+ maxY + ", minPeaks=" + minPeaks + ", maxPeaks=" + maxPeaks + ", fileDir=" + fileDir + ", fileName="
				+ fileName + "]";
	}

}
