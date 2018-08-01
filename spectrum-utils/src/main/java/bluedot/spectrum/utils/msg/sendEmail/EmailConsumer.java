package bluedot.spectrum.utils.msg.sendEmail;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import bluedot.spectrum.utils.msg.Consumer;
import bluedot.spectrum.utils.msg.QueueStorage;

public class EmailConsumer<T> extends Consumer<T> {
	// 邮件队列（线程共享）
	private static BlockingQueue<Runnable> emailQueue = new LinkedBlockingDeque<Runnable>();

	// 实例化线程池（线程共享）
	private ThreadPoolExecutor threadPool = new ThreadPoolExecutor(corePoolSize, maximumPoolSize, keepAliveTime,
			TimeUnit.SECONDS, emailQueue, new ThreadPoolExecutor.AbortPolicy());

	public EmailConsumer(QueueStorage<T> queue) {
		super(queue);
	}

	public void send() {
		Message message = (Message) consumer();
		System.out.println("aaaaaa:" + message.toString());
		threadPool.execute(new sendThread(message));
	}
}
