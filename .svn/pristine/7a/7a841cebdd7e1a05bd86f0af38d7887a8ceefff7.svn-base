package bluedot.spectrum.web.controller;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Maintenance;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 系统维护与备份
 * @author 龚志鹏
 * 2018年1月20日
 */

@Controller
@RequestMapping("/maintenance")
public class SystemController extends BaseController{
	
	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;
	
	/**
	 * 系统维护的备份业务
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/backup")
	public String backup(@RequestParam("maintenanceName")String maintenanceName, @RequestParam("maintenanceContent")String maintenanceContent, @RequestParam("maintenanceDescribe")String maintenanceDescribe, HttpServletRequest request, HttpServletResponse response){
		//封装传入的参数，用来创建备份信息
		Map<String,Object> insert = new HashMap<>();
		insert.put("maintenance_name", maintenanceName);
		insert.put("maintenance_content", maintenanceContent);
		insert.put("maintenance_describe", maintenanceDescribe);
		
		//权限不足，禁止访问
		User user = (User)request.getSession().getAttribute("userSession");
		if(user.getRoleId() != 5){
			return "redirect:/index";
		}
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		insert.put("gmt_modified", sdf.format(d));
		
		
		String backupAddress = backupDatabase();
		insert.put("maintenance_file_address", backupAddress);
		
		insert.put("maintenance_type", 0);
		EditObject editParm = new EditObject(insert, "maintenance"); 
		int Result = editService.edit(editParm);
		
		return "redirect:/maintenance/getmaintenances?start0&end=9";
		
	}
	
	/**
	 * 系统维护的恢复业务
	 * 2018年1月21日
	 * zclong
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/recover")
	public String recover(@RequestParam("maintenanceFileAddress")String maintenanceFileAddress,@RequestParam("maintenanceName")String maintenanceName, @RequestParam("maintenanceContent")String maintenanceContent, @RequestParam("maintenanceDescribe")String maintenanceDescribe, HttpServletRequest request, HttpServletResponse response){
		//封装传入的参数，用来创建备份信息
		Map<String,Object> insert = new HashMap<>();
		insert.put("maintenance_name", maintenanceName);
		insert.put("maintenance_content", maintenanceContent);
		insert.put("maintenance_describe", maintenanceDescribe);
		
		//权限不足，禁止访问
		User user = (User)request.getSession().getAttribute("userSession");
		if(user.getRoleId() != 5){
			return "redirect:/index";
		}
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		insert.put("gmt_modified", sdf.format(d));
		
		
		recoverDatabase(maintenanceFileAddress);;
		
		
		insert.put("maintenance_type", 1);
		EditObject editParm = new EditObject(insert, "maintenance"); 
		int Result = editService.edit(editParm);
		
		return "redirect:/maintenance/getmaintenances?start0&end=9";
	}
	
	/**
	 * 获得所有的系统维护信息
	 * 2018年1月21日
	 * zclong
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getmaintenances")
	public ModelAndView getAllMaintenances(@RequestParam("start")Integer start,@RequestParam("end")Integer end, HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        Map<String,Object> condition = new HashMap<>();
      
        QueryObject queryParm = new QueryObject("maintenance", condition, start, end, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        modelAndView.addAllObjects(model);
        
        List<Maintenance> systemInfoList  = getBeanList(queryResult, Maintenance.class);
        modelAndView.addObject(systemInfoList);
        
        modelAndView.setViewName("/system/maintenance");
        return modelAndView;
	}
	
	
		//mysql的bin配置路径
		private static final String binPath = "E:\\mysql-5.7.17-winx64\\bin";

		//备份目标的数据库名
		private static final String dataBaseName = "spectrumanalysis";
		
		
	
		
		/**
		 * 备份数据库
		 * @param maintenanceTime 备份数据库的时间
		 * @return  ...../specture2/spectrum-commons/target/classes/bluedot/....sql
		 */
		private String backupDatabase(){
			
			//通过类拿到绝对路径
			String path = getClass().getResource("").getFile().toString();
			
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
