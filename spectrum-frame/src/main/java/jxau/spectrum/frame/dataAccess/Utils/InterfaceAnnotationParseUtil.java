package jxau.spectrum.frame.dataAccess.Utils;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.HashMap;

import jxau.spectrum.frame.dataAccess.ParamterHandle.Paramter;
import jxau.spectrum.frame.dataAccess.Proxy.MethodSqlInfo;
import jxau.spectrum.frame.dataAccess.annotation.Mapper;
import jxau.spectrum.frame.dataAccess.annotation.Value;

public class InterfaceAnnotationParseUtil {
	
	/**
	 * 返回一个接口类中所有的方法信息
	 * @param clazz
	 * @return
	 */
	public static MethodSqlInfo[] parseInterfaceAnnotation(Class clazz){
		
		Method[] methods = clazz.getMethods();
		MethodSqlInfo[] array = new MethodSqlInfo[methods.length];
		for(int i = 0;i<methods.length;i++){
			HashMap<String,Integer> param = new HashMap();
			Paramter paramter = new Paramter(param);
			int countNumber = methods[i].getParameterCount();
			Mapper mapper = methods[i].getAnnotation(Mapper.class);
			Annotation[][] annotations = methods[i].getParameterAnnotations();
			for(int j=0;j<annotations.length&&annotations[j].length!=0;j++){
				String name = ((Value) annotations[j][0]).name();
				param.put(name, j);
			}
			array[i] = new MethodSqlInfo(mapper.sql(),mapper.paramterType(),mapper.resultType(),paramter);
		}
		return array;
	}
	
	
}
