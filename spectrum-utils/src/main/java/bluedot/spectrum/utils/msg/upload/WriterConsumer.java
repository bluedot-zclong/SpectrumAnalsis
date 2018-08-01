package bluedot.spectrum.utils.msg.upload;



import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.sound.midi.Synthesizer;

import bluedot.spectrum.utils.msg.Consumer;
import bluedot.spectrum.utils.msg.QueueStorage;


public class WriterConsumer extends Consumer {
	//队列（线程共享）  
    private static BlockingQueue<Runnable> writererQueue =  new LinkedBlockingDeque<Runnable>();  
	
    //实例化线程池（线程共享）  
    private  ThreadPoolExecutor threadPool= new ThreadPoolExecutor(corePoolSize, maximumPoolSize, keepAliveTime, TimeUnit.SECONDS,writererQueue,new ThreadPoolExecutor.AbortPolicy());  
	public WriterConsumer(QueueStorage queue) {
		super(queue);
	}
	public  void writer(){
		WriterFile file=(WriterFile)consumer();
		System.out.println(file.toString());
		threadPool.execute(new WriterThread(file)); 
	}

}
