package bluedot.spectrum.utils.msg.upload;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Part;



public class WriterThread implements Runnable {
	private WriterFile file;
	
	public WriterThread(WriterFile file) {
		this.file = file;
	}

	@Override
	public void run(){
		try {
			file.getPart().write(file.getFileURL());
			System.out.println(file.getFileURL());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("抛出异常了"+file.getFileURL());
			e.printStackTrace();
		}
	
	}

}
