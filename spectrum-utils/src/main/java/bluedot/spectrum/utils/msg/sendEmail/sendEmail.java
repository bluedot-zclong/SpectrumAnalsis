package bluedot.spectrum.utils.msg.sendEmail;

import bluedot.spectrum.utils.msg.Producer;
import bluedot.spectrum.utils.msg.QueueStorage;
/**
 * 发送邮件调用
 * @author 刘勋承
 *
 */
public class sendEmail {
	private static QueueStorage<Message> queue=new QueueStorage<Message>(100);
	private static Producer producer=new EmailProducer(queue);
	/**
	 * 文件上传调用
	 * @param email:邮箱号
	 * @param message:内容
	 */
	public static void send(String email,String message){
		Message m=new Message(email, email);
	
		producer.product(m);
	}
}
