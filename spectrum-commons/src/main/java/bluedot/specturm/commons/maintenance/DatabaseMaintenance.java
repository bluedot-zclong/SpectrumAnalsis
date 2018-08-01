package bluedot.specturm.commons.maintenance;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;

/**
 * 专门用于数据库方面的维护类
 * @author Harold
 * @date 2018年3月29日 
 */
public class DatabaseMaintenance extends Maintenance{
	//mysql的bin配置路径
	private static final String binPath = "E:\\mysql-5.7.17-winx64\\bin";

	//备份目标的数据库名
	private static final String dataBaseName = "spectrumanalysis";
	
	
	
	@Override
	public boolean databaseRecover(String filePath) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String databaseBackup(String path) {
		// TODO Auto-generated method stub
		return backupDatabase(path);
	}
	
	/**
	 * 备份数据库
	 * @param maintenanceTime 备份数据库的时间
	 * @return  ...../specture2/spectrum-commons/target/classes/bluedot/....sql
	 */
	private String backupDatabase(String path){
		
		
		path = path.substring(1, path.lastIndexOf("/") - 1);
		path = path.substring(0, path.lastIndexOf("/"));
		path = path.substring(0, path.lastIndexOf("/"));
		
		try {
            Runtime rt = Runtime.getRuntime();
            // 调用 调用mysql的安装目录的命令
            Process child = rt
                    .exec(binPath + "\\mysqldump -hlocalhost -uroot -proot " + dataBaseName);
            // 设置导出编码为utf-8。这里必须是utf-8
            // 把进程执行中的控制台输出信息写入.sql文件，即生成了备份文件。注：如果不对控制台信息进行读出，则会导致进程堵塞无法运行
            InputStream in = child.getInputStream();// 控制台的输出信息作为输入流
 
            // 设置输出流编码为utf-8。这里必须是utf-8，否则从流中读入的是乱码
            InputStreamReader backupTofile = new InputStreamReader(in, "utf-8");
            	
            String inStr;
            StringBuffer sb = new StringBuffer("");
            String outStr;
            // 组合控制台输出信息字符串
            BufferedReader br = new BufferedReader(backupTofile);
            while ((inStr = br.readLine()) != null) {
                sb.append(inStr + "\r\n");
            }
            outStr = sb.toString();
            
            //备份文件地址
            String backupfileAddress = path +"spectrum" + new Date().getTime() + ".sql";
        
            
            // 要用来做导入用的sql目标文件：
            FileOutputStream fout = new FileOutputStream(backupfileAddress);                     
            OutputStreamWriter writer = new OutputStreamWriter(fout, "utf-8");
            
            System.out.println(backupfileAddress);
            
            writer.write(outStr);
            writer.flush();
            in.close();
            backupTofile.close();
            br.close();
            writer.close();
            fout.close();
            return backupfileAddress;
        } 
		catch (Exception e) {
           return "error";
        }
	}

	/**
	 * 恢复数据库
	 * @param maintanceId 恢复数据库的文件对象
	 * @param maintenanceTime 恢复数据库的时间
	 */
	private void recoverDatabase(String filePath){
		 try {
			 	System.out.println(filePath);
	            Runtime runtime = Runtime.getRuntime();
	            /*Process process = runtime
	                    .exec(binPath + "\\mysql.exe -hlocalhost -uroot -proot --default-character-set=utf8 "
	                            + dataName);*/
	            Process process = runtime
	                    .exec("mysql.exe -hlocalhost -uroot -proot --default-character-set=utf8 "
	                            + dataBaseName);
	            OutputStream outputStream = process.getOutputStream();
	            BufferedReader br = new BufferedReader(new InputStreamReader(
	                    new FileInputStream(filePath), "utf-8"));
	            String str = null;
	            StringBuffer sb = new StringBuffer();
	            while ((str = br.readLine()) != null) {
	                sb.append(str + "\r\n");
	            }
	            str = sb.toString();
	            
	            OutputStreamWriter writer = new OutputStreamWriter(outputStream,
	                    "utf-8");
	            writer.write(str);
	            writer.flush();
	            outputStream.close();
	            br.close();
	            writer.close();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	}
	
	
}
