package bluedot.spectrum.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import bluedot.spectrum.commons.vo.Point;
import bluedot.spectrum.commons.vo.SpectrumFile;
import bluedot.spectrum.service.AlgorithmService;
import bluedot.spectrum.utils.AlgorithmFittingUtils;

public class SpectrumTaskProduce implements Runnable{

	private SpectrumAnalysisTask task;
	private AlgorithmService service;
	private SpectrumResultSet resultSet;
	
	
	public SpectrumTaskProduce(SpectrumAnalysisTask task, AlgorithmService service, SpectrumResultSet resultSet) {
		this.task = task;
		this.service = service;
		this.resultSet = resultSet;
	}


	@Override
	public void run() {
		List<String> list = task.getAlgorithmPathList();
		SpectrumFile spectrum = task.getSpectrumFile();
		for (String path : list) {
			spectrum = service.analysisAlgorithm(path, spectrum);
		}
		
		Long id = task.getUserId();
		Report report = new Report(spectrum);
		StandardSpectrum standardSpectrum = Singleton.STANDARD.StandardSpectrum();
		// 先写死，后面传递参数
		SpectrumFile s1 = standardSpectrum.getSpectrumFileByName("铁");
		SpectrumFile s2 = standardSpectrum.getSpectrumFileByName("笨");
		SpectrumFile s3 = standardSpectrum.getSpectrumFileByName("蛋白质");
		String r1 = getReportValue(spectrum, s1);
		String r2 = getReportValue(spectrum, s2);
		String r3 = getReportValue(spectrum, s3);
		report.getMap().put("铁", r1);
		report.getMap().put("笨", r2);
		report.getMap().put("蛋白质", r3);
		
		resultSet.addSpectrumReport(id,report);
	}
	
	private String getReportValue(SpectrumFile spectrum,SpectrumFile standard){
		List<Point> standardList = standard.getPoints();
		Point start = standardList.get(0);
		Point end = standardList.get(standardList.size()-1);
		Double startX = start.getX();
		Double endX = start.getX();
		List<Point> spectrumList = spectrum.getPoints();
		int startIndex = 0,endIndex = 0;
		for(int i=0;i<spectrumList.size();i++){
			if(spectrumList.get(i).getX()<startX){
				startIndex = i;
			}else{
				break;
			}
		}
		for(int i=startIndex;i<spectrumList.size();i++){
			if(spectrumList.get(i).getX()<endX){
				continue;
			}else{
				endIndex = i;
				break;
			}
		}
		if(startIndex==0||endIndex==0){
			return "0";
		}
		List<Point> list = copy(spectrumList, startIndex, endIndex);
		String spectrumString =  list.toString();
		String standardListString =  standardList.toString();
		double result = AlgorithmFittingUtils.execute(spectrumString, standardListString);
		if(result!=0){
			double s = Difference(list, standardList);
			int random = get_random(1, 10);
			return s*random+"";
		}
		return "0";
	}
	private List<Point> copy(List<Point> list,int start,int end){
		List<Point> result = new ArrayList<>();
		for(int i = start;i <= end;i++){
			result.add(list.get(i));
		}
		return result;
	}
	/**
	 * 三点平均法
	 * @param dest
	 * @param src
	 * @return
	 */
	private double Difference(List<Point> dest,List<Point> src){
		double start = dest.get(0).getY();
		double intermediate = dest.get(dest.size()/2).getY();
		double end = dest.get(dest.size()-1).getY();
		
		double srcStart = src.get(0).getY();
		double srcIntermediate = src.get(src.size()/2).getY();
		double srcEnd = src.get(src.size()-1).getY();
		
		double s = start+intermediate+end;
		double s1 = srcStart+srcIntermediate+srcEnd;
		return Math.abs(s/3-s1/3);
		
	}
	private  int get_random(int start,int end){  
        return (int)(Math.random()*(end-start+1)+start);  
    } 
}
