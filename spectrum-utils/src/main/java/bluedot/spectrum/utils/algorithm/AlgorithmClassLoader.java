package bluedot.spectrum.utils.algorithm;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.nio.channels.WritableByteChannel;

public class AlgorithmClassLoader extends ClassLoader{

	private String name;	//类加载器的名字
	private String basPath="";// 指定加载类的基本路径
	
    public void setBasPath(String basPath) {
        this.basPath = basPath;
    }
	
	//取得类加载器名字
	public String getName() {
		return name;
	}

	public AlgorithmClassLoader(String name){
		super();	
		this.name = name;
	}
	/**
	 * 1、如果不想打破双亲委派模型，那么只需要重写findClass方法即可
	 *
	 * 2、如果想打破双亲委派模型，那么就重写整个loadClass方法
	 */
	protected Class<?> findClass(String name) throws ClassNotFoundException
    {					
		
        File file = new File(basPath+name+".class");
        byte[] bytes;
		try {
			bytes = getClassBytes(file);
			name = name.replaceAll(".class", "");
			Class<?> c = this.defineClass(name, bytes, 0, bytes.length);	
            //defineClass方法可以把二进制流字节组成的文件转换为一个java.lang.Class
            return c;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return super.findClass(name);
    }
    
    
    private byte[] getClassBytes(File file) throws Exception
    {
        // 这里要读入.class的字节，因此要使用字节流
        FileInputStream fis = new FileInputStream(file);
        FileChannel fc = fis.getChannel();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        WritableByteChannel wbc = Channels.newChannel(baos);
        ByteBuffer by = ByteBuffer.allocate(1024);
        
        while (true)
        {
            int i = fc.read(by);
            if (i == 0 || i == -1)
                break;
            by.flip();
            wbc.write(by);
            by.clear();
        }
        
        fis.close();
        
        return baos.toByteArray();
    }
}
