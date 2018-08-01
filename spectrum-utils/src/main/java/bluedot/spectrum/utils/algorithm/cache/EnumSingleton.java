package bluedot.spectrum.utils.algorithm.cache;

import java.util.concurrent.ConcurrentHashMap;

import bluedot.spectrum.commons.algorithm.method.PretreatmentAlgorithm;

/**
 * 
 * @ClassName: EnumSingleton
 * @author WFP
 * @date 2018年3月10日 上午11:29:30
 * @Description: 枚举单例
 *
 */
public enum EnumSingleton {
	ALGORItHMCACHE;
	
	private ConcurrentHashMap<String, AlgorithmEntry<String, PretreatmentAlgorithm>> concurrentHashMap;
	
	private EnumSingleton(){
		concurrentHashMap = new ConcurrentHashMap<>(); 
	}

	public ConcurrentHashMap<String, AlgorithmEntry<String, PretreatmentAlgorithm>> getInstance() {
		return concurrentHashMap;
	}	
}
