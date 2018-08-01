package bluedot.spectrum.utils.algorithm;

/**
 * 单例类加载器
 * @ClassName: AlgorithmClassLoaderSingleton
 * @author WFP
 * @date 2018年3月17日 上午9:32:08
 * @Description: TODO
 *
 */
public class AlgorithmClassLoaderSingleton {
	
	private static AlgorithmClassLoader algorithmClassLoader = new AlgorithmClassLoader("algorithmClassLoader");

	public static AlgorithmClassLoader getAlgorithmClassLoader() {
		return algorithmClassLoader;
	}
	
}
