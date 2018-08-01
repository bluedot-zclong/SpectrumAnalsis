package bluedot.spectrum.algorithm;

import java.io.Serializable;

import org.junit.Test;

import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.commons.vo.SpectrumFile;
import bluedot.spectrum.service.AlgorithmService;
import bluedot.spectrum.service.impl.AlgorithmServiceImpl;
import bluedot.spectrum.service.impl.SpectrumServiceImpl;

public class AlgorithmServiceTest {

	@Test
	public void testAlgorithmServiveCheckAlgorithm(){
		AlgorithmServiceImpl algorithmService = new AlgorithmServiceImpl();
		String msg = null;
		
		boolean flag = algorithmService.checkAlgorithm("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180515/SNV.java", msg);
		System.out.println(flag);
		System.out.println(msg);
	}
	
/*	@Test
	public void testAlgorithmServiveLoaderAlgorithmClass(){
		AlgorithmServiceImpl algorithmService = new AlgorithmServiceImpl();
		algorithmService.loaderAlgorithmClass("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317");
		SpectrumServiceImpl spectrumServiceImpl = new SpectrumServiceImpl();
		SpectrumFile spectrumFile = spectrumServiceImpl.resolveSpectrum("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2.txt");
		spectrumFile = algorithmService.pretreatmentAlgorithm("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317",spectrumFile);
		System.out.println("");
	}*/
	
	
}
