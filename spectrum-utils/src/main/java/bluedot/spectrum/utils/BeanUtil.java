package bluedot.spectrum.utils;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;

/**
 * JavaBean工具类(beanutils实现)
 * 
 * @author zclong 2018年1月20日
 */
public final class BeanUtil {
	// 驼峰与下横线写法互转
	public static final char UNDERLINE = '_';

	public static Class<?> forName(String className) {
		if (StringUtils.isBlank(className)) {
			throw new IllegalArgumentException("className can not be blank.");
		}
		try {
			return Class.forName(className);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}

	public static Object getBean(String className) {
		return getBean(forName(className));
	}

	public static <T> T getBean(Class<T> clazz) {
		try {
			return clazz.newInstance();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 将javaBean对象转为Map
	 * 
	 * @param bean
	 * @return Map
	 */
	public static Map<String, Object> beanToMap(Object bean) {
		try {
			return PropertyUtils.describe(bean);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static void mapToBean(Map<String, ?> map, Object target) {
		try {
			BeanUtils.populate(target, map);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 把Map转换成指定类型的javabean对象
	 * 
	 * @param map
	 * @param clazz
	 * @return
	 */
	public static <T> T mapToBean(Map<String, ?> map, Class<T> clazz) {
		T bean = getBean(clazz);
		mapToBean(map, bean);
		return bean;
	}

	/**
	 * 将驼峰变为下横线
	 * @param param
	 * @return
	 */
	public static String camelToUnderline(String param) {
		if (param == null || "".equals(param.trim())) {
			return "";
		}
		int len = param.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char c = param.charAt(i);
			if (Character.isUpperCase(c)) {
				sb.append(UNDERLINE);
				sb.append(Character.toLowerCase(c));
			} else {
				sb.append(c);
			}
		}
		return sb.toString();
	}

	/**
	 * 将下横线变为驼峰
	 * @param param
	 * @return
	 */
	public static String underlineToCamel(String param) {
		if (param == null || "".equals(param.trim())) {
			return "";
		}
		int len = param.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char c = param.charAt(i);
			if (c == UNDERLINE) {
				if (++i < len) {
					sb.append(Character.toUpperCase(param.charAt(i)));
				}
			} else {
				sb.append(c);
			}
		}
		return sb.toString();
	}
	
	/**
	 * 将map中带下滑线全部转换为大写
	 * @param map
	 * @return
	 */
	public static Map<String, Object> mapToCamel(Map<String, Object> map) {
		Map<String, Object> newMap = new HashMap<String, Object>();
		
		if(map == null || map.size() == 0) {
			return map;
		}
		for (Map.Entry<String, ?> entry : map.entrySet()) {
			String name = entry.getKey();
            if (name == null) {
                continue;
            }
            name = underlineToCamel(name);
            newMap.put(name, entry.getValue());
		}
		return newMap;
	}
}
