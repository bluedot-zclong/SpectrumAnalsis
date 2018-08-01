package bluedot.spectrum.web.core;
/**
 * 利用枚举量来实现单例模式
 * 1、自由序列化；
 * 2、保证只有一个实例（即使使用反射机制也无法多次实例化一个枚举量）；
 * 3、线程安全；
 * @author zclong
 * 2018年1月16日
 */
public enum SingletonUtil {
	INSTANCE;
	private SingletonUtil() {
		
	}
	
	/**
	 * 创建资源处理类
	 * 2018年1月16日
	 * zclong
	 * @return
	 */
	public InternalResourceView buildInternalResourceView() {
		InternalResourceView internalResourceView = new InternalResourceView();
		return internalResourceView;
	}
	
	
}
