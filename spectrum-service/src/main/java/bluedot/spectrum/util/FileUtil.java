package bluedot.spectrum.util;
/**
 * 
 * @author Aaron
 *
 */

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

	public static FileInputStream getFileStream(String url) throws Exception {
		File file = new File(url);
		if (file.isDirectory()) {
			throw new Exception();
		}
		FileInputStream fileInputStream = new FileInputStream(file);
		return fileInputStream;
	}

	public static BufferedReader getBufferedReader(String url) throws Exception{
		File file = new File(url);
		System.out.println(url);
		if (file.isDirectory()) {
			throw new Exception();
		}
		BufferedReader reader = null;
		reader = new BufferedReader(new FileReader(file));
		return reader;
	}
	/**
	 * 得到文件编码
	 * @param filePath
	 * @return
	 */
    public static String getFileCharset(String filePath) {  
    	  
        File file = new File(filePath);  
  
        if (!file.exists()) {  
            System.out.println("File not found.");  
        }  
        // 默认编码格式为GBK  
        String charset = "GBK";  
  
        FileInputStream is = null;  
        BufferedInputStream bis = null;  
  
        try {  
            byte[] first3Bytes = new byte[3];  
  
            boolean checked = false;  
  
            is = new FileInputStream(file);  
  
            bis = new BufferedInputStream(is);  
  
            bis.mark(0);  
  
            int read = bis.read(first3Bytes, 0, 3);  
  
            if (-1 == read) {  
                charset = "GBK";  
            } else if (first3Bytes[0] == (byte) 0xFF  
                    && first3Bytes[1] == (byte) 0xFE) {  
                charset = "UTF-16LE";  
                checked = true;  
            } else if (first3Bytes[0] == (byte) 0xFE  
                    && first3Bytes[1] == (byte) 0xFF) {  
                charset = "UTF-16BE";  
                checked = true;  
            } else if (first3Bytes[0] == (byte) 0xEF  
                    && first3Bytes[1] == (byte) 0xBB  
                    && first3Bytes[2] == (byte) 0xBF) {  
                charset = "UTF-8";  
                checked = true;  
            }  
            bis.reset();  
  
            if (!checked) {  
  
                int loc = 0;  
  
                while ((read = bis.read()) != -1) {  
  
                    loc++;  
  
                    if (read >= 0xF0) {  
                        break;  
                    }  
  
                    if (0x80 <= read && read <= 0xBF) {  
                        // 单独出现BF以下的,也算GBK  
                        break;  
                    }  
  
                    if (0x80 <= read && read <= 0xDF) {  
                        read = bis.read();  
                        if (0x80 <= read && read <= 0xBF) {  
                            // GBK  
                            continue;  
                        } else {  
                            break;  
                        }  
                    } else if (0xE0 <= read && read <= 0xEF) {  
                        read = bis.read();  
                        if (0x80 <= read && read <= 0xBF) {  
                            read = bis.read();  
                            if (0x80 <= read && read <= 0xBF) {  
                                charset = "UTF-8";  
                                break;  
                            } else {  
                                break;  
                            }  
                        } else {  
                            break;  
                        }  
                    }  
                }  
            }  
  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {
				bis.close();
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
            
        }  
  
        return charset;  
    }

	public static List<String> readFileByLine(FileChannel channel, ByteBuffer buffer) {
		List<String> list = new ArrayList();
		StringBuilder builder = new StringBuilder();
		int bytesRead;
		try {
			bytesRead = channel.read(buffer);
			while(bytesRead!=-1){
				buffer.flip();
				while (true) {
                    char ch = (char)buffer.get();
                    builder.append(ch);
                    if(!buffer.hasRemaining()){
                    	break;
                    }
                    if(ch=='\n'){
                    	break;
                    }
                }
				list.add(builder.toString());
				builder.setLength(0);
				 // 清空Buffer区
				buffer.compact();
                // 继续将数据写入缓存区
                bytesRead = channel.read(buffer);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
    
    
}

