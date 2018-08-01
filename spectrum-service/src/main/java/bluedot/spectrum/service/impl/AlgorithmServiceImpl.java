package bluedot.spectrum.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

import javax.tools.Diagnostic;
import javax.tools.DiagnosticCollector;
import javax.tools.JavaCompiler;
import javax.tools.JavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

import bluedot.spectrum.commons.algorithm.method.PretreatmentAlgorithm;
import bluedot.spectrum.commons.vo.SpectrumFile;
import bluedot.spectrum.service.AlgorithmService;
import bluedot.spectrum.service.exception.ServiceException;
import bluedot.spectrum.utils.algorithm.AlgorithmClassLoader;
import bluedot.spectrum.utils.algorithm.AlgorithmClassLoaderSingleton;
import bluedot.spectrum.utils.algorithm.cache.AlgorithmCache;
import bluedot.spectrum.utils.algorithm.cache.AlgorithmEntry;
import bluedot.spectrum.utils.algorithm.cache.EnumSingleton;
import bluedot.spectrum.utils.spectrum.SpectrumUtils;
import bluedot.spectrum.utils.upload.ChangeClassName;
import bluedot.spectrum.utils.upload.ParseFile;
import jxau.spectrum.frame.web.annotation.Service;
@Service
public class AlgorithmServiceImpl implements AlgorithmService{
	
	private AlgorithmCache<String,PretreatmentAlgorithm> concurrentHashMap = new AlgorithmCache(100);
	
	/**
	 * 前期构思方案，现在已经不再使用。20180514
	 */
	public SpectrumFile pretreatmentAlgorithm(String algorithmFilePath, SpectrumFile spectrumFile) {
		// TODO Auto-generated method stub
		
		double[][] points = SpectrumUtils.getSpectrumFilePoints(spectrumFile);
		File libPath = new File(algorithmFilePath);
		//获取该目录下所有.jar或者.zip文件
		File[] jarFiles = libPath.listFiles(
				(FilenameFilter) (File dir, String name) ->  {return name.endsWith(".class") || name.endsWith(".jar") || name.endsWith(".zip");
				});
		try {
			for (File file : jarFiles) {
				String classURL  = file.getName();
				classURL =  classURL.replaceAll(".class", "");
				if(concurrentHashMap.get(classURL)==null){
					loaderAlgorithmClass(algorithmFilePath);
				}
				points = concurrentHashMap.get(classURL).getValue().pretreatmentAlgorithm(points);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		spectrumFile = SpectrumUtils.setSpectrumFilePoints(points, spectrumFile);
		return spectrumFile;
	}
	
	/**
	 * 当前使用
	 */
	@Override
	public SpectrumFile analysisAlgorithm(String algorithmFilePath,SpectrumFile spectrumFile) {
		// TODO Auto-generated method stub
		
		double[][] points = SpectrumUtils.getSpectrumFilePoints(spectrumFile);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		File algorithmFile = new File(algorithmFilePath);
		if(algorithmFile.exists()){
			runProcess(algorithmFile,points,resultMap);
		}
		/*
		 * resultMap取得exit的键值对，true表示处理成功，否则处理失败;
		 * 
		 * */
		points = (double[][]) resultMap.get("points");
		if(points!=null){
			spectrumFile = SpectrumUtils.setSpectrumFilePoints(points, spectrumFile);
			return spectrumFile;
		}else{
			return null;
		}
	}

	/**
	 * 加载算法类
	 * WFP
	 * @param algorithmFilePath	算法类路径
	 * 2018年3月17日
	 */
	private void loaderAlgorithmClass(String algorithmFilePath) {
		// TODO Auto-generated method stub
		File libPath = new File(algorithmFilePath);
		
		//获取该目录下所有.jar或者.zip文件
		File[] jarFiles = libPath.listFiles(
				(FilenameFilter) (File dir, String name) ->  {return name.endsWith(".class") || name.endsWith(".jar") || name.endsWith(".zip");
				});
		
		if(jarFiles != null){
			AlgorithmClassLoader classLoader = AlgorithmClassLoaderSingleton.getAlgorithmClassLoader();
			classLoader.setBasPath(algorithmFilePath+"/");
			
			for (File file : jarFiles) {  
				String classURL  = file.getName();
				classURL =  classURL.replaceAll(".class", "");
				if(concurrentHashMap.get(classURL)==null){
		            try {
						Class<?> clazz = Class.forName(classURL, true, classLoader) ;
						PretreatmentAlgorithm obj = (PretreatmentAlgorithm) clazz.newInstance();
						AlgorithmEntry<String, PretreatmentAlgorithm> algorithmEntry = new AlgorithmEntry<String, PretreatmentAlgorithm>(classURL, obj);
						concurrentHashMap.put(classURL, algorithmEntry);
					} catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}else{
					return;
				}
	        }  
			
			
		}
	}

	/**
	 * 校验算法
	 */
	@Override
	public boolean checkAlgorithm(String filePath,String msg) {
		// TODO Auto-generated method stub
		String sourcePath = Thread.currentThread().getContextClassLoader().getResource("/").getPath()+"baseAlgorithm/";

		long star = System.currentTimeMillis(); //开始编译时间

        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();   //获取系统编译器

        DiagnosticCollector<JavaFileObject> diagnosticCollector = new DiagnosticCollector<>();  //  建立ClassFileManager对象
        StandardJavaFileManager fileManager =
                compiler.getStandardFileManager(diagnosticCollector,null,null);
        //StandardJavaFileManager类(文件管理器)可以很好地控制输入、输出，并且能通过DiagnosticListener得到诊断信息

        //
        File sourceFile = new File(filePath);
        File sss = new File(sourceFile.getAbsoluteFile().toString().split(sourceFile.getName())[0]);
        List<File> javaFileList = new ArrayList<>();
        getJavaFiles(sss, javaFileList);
        if(javaFileList.size() == 0){
        	System.out.println(filePath+"中找不到.java文件！");
        	return false;
        }else{
        	ChangeClassName.ChangeMainClass(new File(sourceFile.getAbsoluteFile().toString().split(sourceFile.getName())[0]+"AnalyzeAlgorithm.java"), sourceFile.getName().split("\\.")[0]);
        }
        
        // 建立用于保存被编译文件名的对象（编译单元）;每个文件被保存在一个从JavaFileObject继承的类中
        Iterable<? extends JavaFileObject> compilationUnits = fileManager
                    .getJavaFileObjectsFromFiles(javaFileList);
        //使用编译选项可以改变默认编译行为。编译选项是一个元素为String类型的Iterable集合
        List<String> options = new ArrayList<String>();

        options.add("-target");
        options.add("1.8");
        options.add("-encoding");
        options.add("UTF-8");
        options.add("-sourcepath");
        options.add(sourcePath);
        options.add("-d");
        options.add(sourceFile.getAbsoluteFile().toString().split(sourceFile.getName())[0]);

        JavaCompiler.CompilationTask compilationTask =
                compiler.getTask(null,fileManager,diagnosticCollector,options,null,compilationUnits);
        boolean flag = compilationTask.call();
        if (flag){
            return flag;
        }else {
            //如果想得到具体的编译错误，可以对Diagnostics进行扫描
            String error = "";
            for (Diagnostic diagnostic : diagnosticCollector.getDiagnostics()) {
                error = error + diagnostic;
            }
            System.out.println(error);
            return !flag;
        }
	}
	
	/**
	 * 寻找该目录下的所有.java文件
	 * WFP
	 * @param sourceFile
	 * @param javaFileList
	 * 2018年3月8日
	 */
	private void getJavaFiles(File sourceFile, List<File> javaFileList){
		//判断文件或目录是否存在
		if(sourceFile.exists() && sourceFile != null){
			if(sourceFile.isDirectory()){
			
				File[] childFiles = sourceFile.listFiles((File pathname) ->{
					if (pathname.isDirectory()) {  
                        return true;  
                    } else {  
                        String name = pathname.getName();  
                        return name.endsWith(".java") ? true : false;  
                    }  
				}); 
				
				for(File childFile : childFiles){
					getJavaFiles(childFile, javaFileList);
				}
			}else{
/*				File file = new File(newFileName(sourceFile));
				
				boolean result = sourceFile.renameTo(file);
				if(result == false){
					throw new ServiceException("文件无法重命名，动态编译失败！");
				}*/
				javaFileList.add(sourceFile);
			}
				
		}
	}
	
	

	/**
	 * 在沙箱中运行一个jvm实例
	 * WFP
	 * @param algorithmFilePath 算法路径
	 * @param spectrumFile 光谱文件
	 * 2018年5月15日
	 */
	public static void runProcess(File algorithmFile,double[][] points,HashMap<String, Object> resultMap){
		
        //构造具有指定操作系统程序和参数的进程构建器。
        ProcessBuilder processBuilder = new ProcessBuilder("java","-Xmn16m","-Xms64m","-Xmx128m","-Xss1m",algorithmFile.getName().split("\\.")[0]);
        //设置此进程构造器的工作目录
        processBuilder.directory(new File(algorithmFile.getAbsoluteFile().toString().split(algorithmFile.getName())[0]));
        try {
            Process process = processBuilder.start();	//使用此流程构建器的属性启动新进程。
            //子进程输入流
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(process.getOutputStream());
            objectOutputStream.writeObject(points);
            objectOutputStream.flush();
            objectOutputStream.close();

            //子进程正常输出输出流
            InputStream inputStream = process.getInputStream(); 
            //子进程错误输出的输出流
            InputStream errInputStream = process.getErrorStream();
            //正常输出流处理
            new Thread(()->{
                double[][] newPoints = null;
                try {
                    ObjectInputStream objectInputStream = new ObjectInputStream(inputStream);

                    newPoints = (double[][]) objectInputStream.readObject();
/*                    for (int i=0;i<newPoints.length;i++){
                        for (int j=0;j<newPoints[i].length;j++){
                            System.out.println(newPoints[i][j]);
                        }
                    }*/
                    objectInputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                try {
                    inputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                resultMap.put("points", newPoints);
            }).start();
            //错误流处理
            new Thread(()->{
                BufferedReader err = new BufferedReader(new InputStreamReader(errInputStream));
                StringBuilder errStringBuilder = new StringBuilder("");
                String line = null;
                try {
                    while((line = err.readLine())!=null){
                        errStringBuilder.append(line);
                    }
                    err.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                try {
                    errInputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                try {
                    errInputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                resultMap.put("error",errStringBuilder);
            }).start();

            try {
                boolean exit = process.waitFor(10, TimeUnit.SECONDS);
                resultMap.put("exit",exit);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
