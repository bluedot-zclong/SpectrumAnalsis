package bluedot.spectrum.commons.index.database;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 将数据写入到文件中的文件写入流
 * @author Harold
 * @date 2018年3月17日 
 * @description:
 */
public final class DataToFile {
	/** 文件名 */
	private static String filename;
	
	
	private static FileWriter fw;
	
	/**
	 * 无参构造方法私有化
	 */
	private DataToFile() {
		
	}
	
	/**
	 * 公有构造方法，但必须传入文件名
	 * @param filename 传入的文件名
	 * @throws FileNotFoundException 如果文件名为空，则抛出文件不存在异常
	 */
	public DataToFile(String filename) throws FileNotFoundException {
		if(filename == null || "".equals(filename))
			throw new FileNotFoundException();
		this.filename = filename;
	}
	
	/**
	 * 文件写入方法
	 * @return 写入流
	 */
	static PrintWriter getFileReader(){				
		try {
			//如果文件存在，则追加内容；如果文件不存在，则创建文件
			File f=new File(filename);			
			fw = new FileWriter(f, true);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		PrintWriter pw = new PrintWriter(fw);
		
		return pw;		
	}
	
	public static void close(PrintWriter pw){
		try {
			fw.flush();
			pw.close();
			fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
