package bluedot.spectrum.utils.msg;

public class Consumer<T> {
	protected static final int corePoolSize = 1; // 线程池中所保存的核心线程数。      
	protected static final int maximumPoolSize = 4; //线程池允许创建的最大线程数。  
	protected static final long keepAliveTime = 0; //当前线程池线程总数大于核心线程数时，终止多余的空闲线程的时间。  
	private  QueueStorage<T> queue;
    public Consumer(QueueStorage<T> queue) {
		this.queue = queue;
	}
	public T consumer(){
		return queue.get();
	}
}
