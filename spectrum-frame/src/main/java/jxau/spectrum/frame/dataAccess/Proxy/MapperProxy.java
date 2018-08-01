package jxau.spectrum.frame.dataAccess.Proxy;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.HashMap;

import jxau.spectrum.frame.dataAccess.Utils.InterfaceAnnotationParseUtil;
import jxau.spectrum.frame.dataAccess.annotation.returnMapper;


public class MapperProxy {
	


	private String name;  //mapper名字
	private HashMap<String,String> map = new HashMap();
	private HashMap<String,MethodSqlInfo> methodMap = new HashMap();//mapper接口中所有方法的集合
	
	/**
	 * 构造函数，初始化接口名字和接口中所有的方法信息
	 * @param clazz
	 */
	public MapperProxy(Class clazz){
		this.name = clazz.getSimpleName();
		if(!clazz.isInterface()){
			//exception
		}
		
		Annotation[] classAnntation = clazz.getAnnotations();
		for(int i=0;i<classAnntation.length;i++){
			String[] array = ((returnMapper)classAnntation[i]).mapper();
			for (String str : array) {
				String[] s = str.split(":");
				if(s.length!=2){
					//异常
				}
				map.put(s[1], s[0]);
			}
		}
		
		this.name = clazz.getSimpleName();
		MethodSqlInfo[] array = InterfaceAnnotationParseUtil.parseInterfaceAnnotation(clazz);
		Method[] methods = clazz.getMethods();
		for(int i=0;i<methods.length;i++){
			String key = methods[i].getName();
			this.methodMap.put(key, array[i]);
		}
	}
	
	public MethodSqlInfo getMethodSqlInfo(String methodName){
		return methodMap.get(methodName);
	}
	public HashMap<String, String> getMap() {
		return map;
	}

	public String getName() {
		return name;
	}
	
}
