package jxau.spectrum.frame.dataAccess.Utils;

import java.util.List;

public class StringUtils {
	/**
	 * 截取#{}中参数保存，替换成？
	 * @param sql
	 * @param list
	 * @return 
	 */
	public static String replaceSubString(String sql,List<String> list){
		while(sql.indexOf('#')!=-1){
			int c1 = sql.indexOf('#');
			int c2 = sql.indexOf('{');
			int c3 = sql.indexOf('}');
			String subString = sql.substring(c2+1, c3);
			list.add(subString);
			sql = sql.replace("#{"+subString+"}", "?");
		}
		return sql;
	}
	
	public static String toUpperFristChar(String string) {  
	    char[] charArray = string.toCharArray();  
	    charArray[0] -= 32;  
	    return String.valueOf(charArray);  
	} 
	
	public static String getListsubType(String signature){
		String type = null;
		int idx = signature.lastIndexOf("/");
		type = signature.substring(idx+1,signature.length()-3);
		return type;
	}
}
