package bluedot.spectrum.utils.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
/**
 * NIO 复制文件
 * @author WFP
 *
 */
public class CopyFile {
	public static void copyFileByChannels(File source,File target){
		FileChannel inputChannel = null;
		FileChannel outputChannel = null;
		
		try{
			inputChannel = new FileInputStream(source).getChannel();
			outputChannel = new FileOutputStream(target).getChannel();
			outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
		}catch(IOException e){
			e.printStackTrace();
		}finally {
			try {
				inputChannel.close();
				outputChannel.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
