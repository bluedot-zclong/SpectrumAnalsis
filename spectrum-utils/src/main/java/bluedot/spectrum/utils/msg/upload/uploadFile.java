package bluedot.spectrum.utils.msg.upload;

import javax.servlet.http.Part;

import bluedot.spectrum.utils.msg.Producer;
import bluedot.spectrum.utils.msg.QueueStorage;
/**
 * 文件上传调用
 * @author 刘勋承
 *
 */
public class uploadFile {
	private static QueueStorage<WriterFile> queue = new QueueStorage<WriterFile>(100);
	private static Producer producer = new WriterProducer(queue);
	/**
	 * 文件上传
	 * @param part:part对象
	 * @param url:文件上传路径
	 */
	public static  void upload(Part part,String url){
		
		WriterFile file=new WriterFile();
		file.setFileURL(url);
		file.setPart(part);
		producer.product(file);
	}
}
