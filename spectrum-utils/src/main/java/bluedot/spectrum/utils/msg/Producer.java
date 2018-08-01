package bluedot.spectrum.utils.msg;

public abstract class Producer<T> {
    protected QueueStorage<T> queue;
	
    public Producer(QueueStorage<T> queue) {
        this.queue = queue;
    }    
    public void product(T e){
    	queue.put(e);
    	notice();
    }
    public abstract void notice();
}
