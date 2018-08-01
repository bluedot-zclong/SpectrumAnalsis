package bluedot.spectrum.web.filter.wrapper;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import jxau.spectrum.frame.dataAccess.annotation.returnMapper;
/**
 * 包装类，通过body缓存request的流数据
 * @ClassName: StreamHpptServletRequestWrapper
 * @author WFP
 * @date 2018年3月24日 上午10:59:40
 * @Description: TODO
 *
 */
public class StreamHpptServletRequestWrapper extends HttpServletRequestWrapper{

	private final byte[] body;	//缓存报文

	public StreamHpptServletRequestWrapper(HttpServletRequest request) throws IOException {
		super(request);
		InputStream inputStream = request.getInputStream();
		DataInputStream dataInputStream = new DataInputStream(inputStream);
		byte[] bodyTrue = new byte[request.getContentLength()];
		dataInputStream.readFully(bodyTrue);
		dataInputStream.close();
		
		body= new byte[request.getContentLength()-2];
		System.arraycopy(bodyTrue, 0, body, 0, request.getContentLength()-4);
		body[body.length-2]=13;
		body[body.length-1]=10;
		
		/*ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(body);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		int falg=-1;
		while((falg=byteArrayInputStream.read())!=-1){
			byteArrayOutputStream.write(falg);
		}
		OutputStream outputStream = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2017暑假任务3.docx"));
		byteArrayOutputStream.writeTo(outputStream);
		outputStream.flush();
		outputStream.close();*/
		
		/*ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(body);
		OutputStream outputStream = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2017暑假任务3.docx"));
		int flag ;
		while((flag=byteArrayInputStream.read())!=-1){
			outputStream.write(flag);
		}
		outputStream.flush();
		outputStream.close();*/
	}
	
	/**
	 * 获得输入流，并且转换成字符串
	 * WFP
	 * @param request
	 * @return
	 * 2018年3月24日
	 * @throws IOException 
	 */
	/*private static String getBody(HttpServletRequest request) throws IOException {
		StringBuilder stringBuilder = new StringBuilder();
		try {
			
			InputStream inputStream = request.getInputStream();
			OutputStream outputStream = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2017暑假任务.docx"));
			int flag ;
			while((flag=inputStream.read())!=-1){
				outputStream.write(flag);
			}
			outputStream.flush();
			outputStream.close();
			
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream,Charset.forName("ISO-8859-1")));
			String line = "";
			
			while ((line = bufferedReader.readLine())!=null) {			
				stringBuilder.append(line+"\r\n");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String str = stringBuilder.toString();
		ByteArrayInputStream tInputStringStream = new ByteArrayInputStream(str.getBytes("ISO-8859-1"));
		
		OutputStream outputStream = new FileOutputStream(new File("C:/Users/WFP/Desktop/蓝点/光谱第二版本/巫发萍/20180317/2017暑假任务2.docx"));
		int flag ;
		while((flag=tInputStringStream.read())!=-1){
			outputStream.write(flag);
		}
		outputStream.flush();
		outputStream.close();
		return str;
	}*/
	
	/**
	 * 重写getInputStream类
	 */
	@Override
	public ServletInputStream getInputStream() throws IOException {
		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(body);
	    ServletInputStream servletInputStream=new ServletInputStream(){
	    	@Override
	        public int read() throws IOException {
	          return byteArrayInputStream.read();
	        }

			@Override
			public boolean isFinished() {
				// TODO Auto-generated method stub
				return false;
			}

			@Override
			public boolean isReady() {
				// TODO Auto-generated method stub
				return false;
			}

			@Override
			public void setReadListener(ReadListener readListener) {
				// TODO Auto-generated method stub
				
			}
	      };
		return servletInputStream;
	}


	@Override
	public BufferedReader getReader() throws IOException {
		// TODO Auto-generated method stub
		return new BufferedReader(new InputStreamReader(getInputStream())) ;
	}

}
