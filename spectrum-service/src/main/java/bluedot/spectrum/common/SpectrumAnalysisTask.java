package bluedot.spectrum.common;

import java.util.List;

import bluedot.spectrum.commons.vo.SpectrumFile;
/**
 * 光谱分析任务
 * @author Aaron
 *
 */
public class SpectrumAnalysisTask{
	
	private Long userId; 
	private SpectrumFile spectrumFile;
	private List<String> algorithmPathList;
	
	public SpectrumAnalysisTask(Long userId, SpectrumFile spectrumFile, List<String> algorithmPathList) {
		this.userId = userId;
		this.spectrumFile = spectrumFile;
		this.algorithmPathList = algorithmPathList;
	}
	
	public Long getUserId() {
		return userId;
	}
	public SpectrumFile getSpectrumFile() {
		return spectrumFile;
	}
	public List<String> getAlgorithmPathList() {
		return algorithmPathList;
	}

}
