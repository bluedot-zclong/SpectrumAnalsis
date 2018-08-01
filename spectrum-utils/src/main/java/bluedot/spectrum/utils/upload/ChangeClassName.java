package bluedot.spectrum.utils.upload;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.UUID;

public class ChangeClassName {
	public static String[] chars = new String[] { "a", "b", "c", "d", "e", "f",  
            "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",  
            "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5",  
            "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I",  
            "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",  
            "W", "X", "Y", "Z" };  
  
    /**
     * 生成8位随机uuid
     * @return
     */
	public static String generateShortUuid() {  
	    StringBuffer shortBuffer = new StringBuffer();  
	    String uuid = UUID.randomUUID().toString().replace("-", "");  
	    for (int i = 0; i < 8; i++) {  
	        String str = uuid.substring(i * 4, i * 4 + 4);  
	        int x = Integer.parseInt(str, 16);  
	        shortBuffer.append(chars[x % 0x3E]);  
	    }  
	    return shortBuffer.toString();  
	  
	}
	/**
	 * 获取新的文件名
	 * WFP
	 * @param sourceFile
	 * @return
	 * 2018年3月16日
	 */
	public static String newFileName(File sourceFile) {
		
		String newClassName = "New"+generateShortUuid()+sourceFile.getName();
		
		//修改类名
		ChangeClassName(sourceFile, newClassName);	

		// TODO Auto-generated method stub
		String newFileName = sourceFile.getAbsolutePath();
		newFileName = newFileName.replaceAll(sourceFile.getName(), newClassName);
		newFileName = newFileName.replaceAll("\\\\", "/");
		return newFileName;
	}

	/**
	 * 修改类名
	 * WFP
	 * @param sourceFile
	 * @param newClassName
	 * 2018年3月16日
	 */
	public static void ChangeClassName(File sourceFile, String newClassName) {
		try {
			InputStream in = new FileInputStream(sourceFile);
			BufferedReader reader = new BufferedReader(new InputStreamReader(in,"UTF-8"));
			
			StringBuilder fileContext = new StringBuilder();
			String line = "";
			while ((line = reader.readLine())!=null){
				String className = "";
				if(line!=null && line.contains("class")){
					
					boolean flag = true;
					for (int i = line.indexOf(" class ")+7; i < line.length(); i++) {
						if(line.charAt(i)!=' '){
							className = className + line.charAt(i);
							flag = false;
						}else{
							if(flag==false){
								break;
							}
						}
						
					}
					 String[] newClassNameArray = newClassName.split("\\.");
					 if(newClassNameArray[0]!=null){
						 line = line.replaceAll(className,newClassNameArray[0]);
					 }
				}
				fileContext.append(line+"\r\n");
			}
			in.close();
			reader.close();
			
			OutputStream out = new FileOutputStream(sourceFile);
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(out,"UTF-8"));
			writer.write(fileContext.toString());
			writer.flush();
			out.close();
			writer.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 修改AnalyzeAlgorithm类内容
	 * @param sourceFile
	 * @param newClassName
	 */
	public static void ChangeMainClass(File sourceFile, String newClassName) {
		try {
			InputStream in = new FileInputStream(sourceFile);
			BufferedReader reader = new BufferedReader(new InputStreamReader(in,"UTF-8"));
			
			StringBuilder fileContext = new StringBuilder();
			String line = "";
			while ((line = reader.readLine())!=null){
				String className = "";
				if(line!=null && line.contains("PretreatmentAlgorithmWFP")){
					line = line.replaceAll("PretreatmentAlgorithmWFP", newClassName);
				}
				fileContext.append(line+"\r\n");
			}
			in.close();
			reader.close();
			
			OutputStream out = new FileOutputStream(sourceFile);
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(out,"UTF-8"));
			writer.write(fileContext.toString());
			writer.flush();
			out.close();
			writer.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
