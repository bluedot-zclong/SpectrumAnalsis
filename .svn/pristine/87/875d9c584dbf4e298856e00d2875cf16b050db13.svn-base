package bluedot.spectrum.utils.upload;

import java.awt.Checkbox;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.utils.upload.FormData;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.CharSet;

public class ParseFile {
	
	/**
	 * 解析表单域
	 * WFP
	 * @param request
	 * @return
	 * 2018年4月8日
	 */
	public static Map<String, FormData> parseForm(HttpServletRequest request,FileDirType fileDirType){
		
		
		String savePath = request.getServletContext().getRealPath("/WEB-INF/uploadFile");;

		List<FormData> formDatas = new ArrayList<FormData>();  

		byte[] boundaryBytes = null;
		
		boundaryBytes = getBoundary(request).getBytes();
		
		int boundaryBytesLenth = boundaryBytes.length;
		
		BufferedInputStream bufferedInputStream = null;
		
		try {
			InputStream inputStream  = request.getInputStream();
			bufferedInputStream = new BufferedInputStream(inputStream);			 
/*			OutputStream outputStream = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2017暑假任务1.docx"));
			int flag ;
			while((flag=bufferedInputStream.read())!=-1){
				outputStream.write(flag);
			}
			outputStream.flush();
			outputStream.close();*/
			bufferedInputStream.skip(boundaryBytesLenth);
	        //查询该用户所有算法文件夹
	        User user = (User)request.getSession().getAttribute("userSession");
			recursiveParseFile(formDatas, bufferedInputStream, boundaryBytes,savePath,fileDirType,user.getUserId());
			
			Map<String,FormData> formMap =  formDatas.stream().collect(Collectors.toMap(FormData :: getName, Function.identity()));
			return formMap;
        } catch (IOException ioe) {    
            ioe.printStackTrace();    
        } finally {    
        	try {
				bufferedInputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
		return null;   
				
	}

	/**
	 * 获得边界
	 * WFP
	 * @param request
	 * @return
	 * 2018年4月11日
	 */
	public static String getBoundary(HttpServletRequest request){
		String boundary = null;
		String contentType = request.getContentType();
		if(contentType != null){
			boundary = contentType.contains("boundary=") ? contentType.split("boundary=")[1] : null;
		}
		return "--".concat(boundary);		
	}
	
	private static void recursiveParseFile(List<FormData> formDatas, BufferedInputStream bufferedInputStream,
			byte[] boundaryBytes, String savePath,FileDirType fileDirType,Long userID) throws UnsupportedEncodingException {

		FormData formData = new FormData();
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		int flag = -1;
		int flag1 = -1;
		try {
			while((flag=bufferedInputStream.read())!=-1){
				if(flag == 13){
					if((flag1 = bufferedInputStream.read())==10){
						if(byteArrayOutputStream.size()==0){
							continue;
						}
						String line = byteArrayOutputStream.toString();
						if(line.contains("Content-Disposition:")){  
							
					        String[] str = line.trim().split(";");  
					        if(line.contains("filename")){//文件表单域  
					        	formData.setFile(true);
					        	for(int i=1;i<str.length;i++){
					        		String filenameV = str[i].split("=")[1]; 
					        		if(str[i].contains(" name")){
					                    formData.setName(new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8"))); //设置属性，并去除"  
					        		}else if(str[i].contains("filename")){
					        			String[] fileName = new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8")).split("\\.");	//设置文件名、类型，去除" 
					        			formData.setFileName(fileName[0]);  
					        			formData.setFileType(fileName[1]); 
					        			formData.setFilePath(savePath);
					        		}		
					        	}
					        }else{//普通表单域  
					        	formData.setFile(false);
					        	for(int i=1;i<str.length;i++){
					        		String filenameV = str[i].split("=")[1]; 
					        		if(str[i].contains(" name")){
					                    formData.setName(new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8"))); //设置属性，并去除"  
					        		}
					        	}
					        }
					        byteArrayOutputStream.reset();
					        continue;
					    }else if(line.contains("Content-Type:")){  
					    	byteArrayOutputStream.reset();
					    	continue;
					    }else if(line.contains(new String(boundaryBytes,"utf-8"))){
					    	storeFormData(formDatas, byteArrayOutputStream, formData,boundaryBytes,fileDirType,userID);
							byteArrayOutputStream.reset();
							recursiveParseFile(formDatas, bufferedInputStream, boundaryBytes,savePath,fileDirType,userID);
							return;
						}
						
					}
					byteArrayOutputStream.write(flag);
					byteArrayOutputStream.write(flag1);
					continue;	
				}
				byteArrayOutputStream.write(flag);
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
    private static void recursiveParseFile1(List<FormData> formDatas, BufferedReader bufferedReader, byte[] boundaryBytes,String savePath){
    	
        FormData formData = new FormData();

    	String line = null;
    	StringBuilder stringBuilder = new StringBuilder();
    	try {
			while((line=bufferedReader.readLine())!=null){
				
				if (line.length() == 0) { //跳过空行分隔符  
			        continue;  
			    }else if(line.contains("Content-Disposition:")){  
			    	formData = new FormData(); 
			        String[] str = line.trim().split(";");  
			        if(line.contains("filename")){//文件表单域  
			        	formData.setFile(true);
			        	for(int i=1;i<str.length;i++){
			        		String filenameV = str[i].split("=")[1]; 
			        		if(str[i].contains(" name")){
			                    formData.setName(new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8"))); //设置属性，并去除"  
			        		}else if(str[i].contains("filename")){
			        			String[] fileName = new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8")).split("\\.");	//设置文件名、类型，去除" 
			        			formData.setFileName(fileName[0]);  
			        			formData.setFileType(fileName[1]); 
			        			formData.setFilePath(savePath);
			        		}		
			        	}
			        	continue;
			        }else{//普通表单域  
			        	formData.setFile(false);
			        	for(int i=1;i<str.length;i++){
			        		String filenameV = str[i].split("=")[1]; 
			        		if(str[i].contains(" name")){
			                    formData.setName(new String(filenameV.substring(1, filenameV.length() - 1).getBytes(),Charset.forName("UTF-8"))); //设置属性，并去除"  
			        		}
			        	}
			        	continue;
			        }            
			       
			    }else if(line.contains("Content-Type:")){  
					continue;
			    }else if(line.trim().equals(new String(boundaryBytes))||line.trim().substring(0, line.trim().length()).equals(new String(boundaryBytes).concat("--"))){
					/*storeFormData(formDatas, stringBuilder, formData);
					stringBuilder.replace(0, stringBuilder.length(), "");//读完一个分界后置空
					recursiveParseFile(formDatas, bufferedReader, boundaryBytes,savePath);*/
					return;
				}
				stringBuilder.append(line+"\r\n");
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    }

    /**
     * 保存文件
     * WFP
     * @param formDatas
     * @param stringBuilder
     * @param formData
     * @throws FileNotFoundException
     * @throws IOException
     * 2018年3月25日
     */
	private static void storeFormData(List<FormData> formDatas, ByteArrayOutputStream byteArrayOutputStream, FormData formData,byte[] boundaryBytes,FileDirType fileDirType,Long userID)
			throws FileNotFoundException, IOException {
		
		if(formData.isFile()){
			byte[] form = byteArrayOutputStream.toByteArray();
			LocalDateTime now = LocalDateTime.now();
			//混淆目录
	        File fileDir = new File(formData.getFilePath()+ File.separator + fileDirType.getType() + File.separator+ now.getYear()
            + File.separator + now.getMonth() + File.separator
            + now.getDayOfMonth()+File.separator+userID+File.separator+ChangeClassName.generateShortUuid());
		    if(!fileDir.exists()){//目录不存在则直接创建
		    	fileDir.mkdirs();
		    }
		    File file = new File(fileDir.getPath()+File.separator+formData.getFileName()+"."+formData.getFileType());
		    
		
		    OutputStream outputStream = new FileOutputStream(file);
			int flag ;
			for(int i=0;i<byteArrayOutputStream.size()-boundaryBytes.length-2;i++){
				outputStream.write(form[i]);
			}
			outputStream.flush();
			outputStream.close();
			formData.setValue("");
			if(file.getName().endsWith(".java")){
				File newFile = new File(ChangeClassName.newFileName(file));
				boolean result = file.renameTo(newFile);
				if(result != false){
					formData.setFilePath(newFile.getPath());
					//记得修改
					
					String sourcePath = Thread.currentThread().getContextClassLoader().getResource("/").getPath()+"baseAlgorithm/AnalyzeAlgorithm.java";
					System.out.println(sourcePath);
					CopyFile.copyFileByChannels(new File(sourcePath), new File(fileDir.getPath()+"/AnalyzeAlgorithm.java"));
				}
			}else {
				formData.setFilePath(file.getPath());
			}
		}else{
			byte[] form = new byte[byteArrayOutputStream.size()-boundaryBytes.length-2];
			System.arraycopy(byteArrayOutputStream.toByteArray(), 0, form, 0, byteArrayOutputStream.size()-boundaryBytes.length-2);
			
			formData.setValue(new String(form,Charset.forName("UTF-8")));			
		}
		formDatas.add(formData);
	}
	
	
	
    
    /**
     * 当有换行后判断是否是边界
     * WFP
     * @param boundaryBytes
     * @param temp
     * @return
     * @throws IOException
     * 2018年3月25日
     */
    private static boolean isBoundary( byte[] boundaryBytes, byte[] temp) throws IOException{  
    	
        for (int i = 0; i < boundaryBytes.length; i++) {  
            if (boundaryBytes[i] != temp[i]) {  
                return false;  
            }  
        }  
        return true;  
    }  
    
    /**
	 * 获取表单数据 （已经不使用）
	 * WFP
	 * @param formData
	 * @param input
	 * @param boundaryBytes
	 * @throws IOException
	 * 2018年3月25日
	 */
    private static void formValue(FormData formData, BufferedInputStream bufferedInputStream, byte[] boundaryBytes) throws IOException{  
    	 
        ByteArrayOutputStream tempOut = new ByteArrayOutputStream();
        byte[] tempByte = new byte[boundaryBytes.length]; 	//存储边界
        
        int flag = -1; 
        int flag10 = -1;
        while((flag = bufferedInputStream.read()) != -1){  
        	if(flag==13&&bufferedInputStream.read()==10){//  /r=13  /n=10		
        		if(tempOut.size()==0){
        			continue;
        		}
        		String line = tempOut.toString();
    	 		System.out.println(line);
  
    	 		if(line.contains("Content-Type:")){  
    	 			tempOut.reset();
    	 			continue;
	            }
    	 		if(bufferedInputStream.read(tempByte)!=-1&&isBoundary(boundaryBytes,tempByte)){
    	 			tempOut.reset();
    	 			continue;
    	 		}else{
    	 			tempOut.write(13);
    	 			tempOut.write(10);
    	 			tempOut.write(tempByte);
    	 		}
    	 		
	 		}else{
	 			tempOut.write(flag);
	 		} 
        }  
        if(formData.isFile()){
    		FileOutputStream out1 = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/buledot码云账号.txt"));
    		out1.write(tempOut.toByteArray());
    		out1.flush();  
    		out1.close(); 
        }else{
        	String line = tempOut.toString();
        	formData.setValue(line);
        	
        }
        
       /* if(item.getFileType() != null){ //文件  
            //此处测试环境，故直接写入本地文件，正式应写入系统java.io.temp目录  
            String url = "e:/temp/" + item.getFileName();  
            File file = new File(url);  
            if(!file.getParentFile().exists()){  
                file.getParentFile().mkdirs();  
            }  
            FileOutputStream out = new FileOutputStream(file);  
            out.write(tempOut.toByteArray());  
            out.flush();  
            out.close();  
     
            item.setFilePath(url);  
        }  
        else{  
            item.setValue((new String(tempOut.toByteArray(), "UTF-8")));  

        }  */
    }  
    

}
