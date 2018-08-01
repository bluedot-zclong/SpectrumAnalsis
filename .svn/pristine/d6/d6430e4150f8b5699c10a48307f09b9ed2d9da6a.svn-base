package bluedot.spectrum.utils.msg;

import java.util.ArrayDeque;
import java.util.Queue;

public class QueueStorage<T> {
	private Queue<T> queue = null;
	private int limit;

	public QueueStorage(int limit) {
		this.limit = limit;
		queue = new ArrayDeque<T>(limit);
	}

	public synchronized void put(T e) {
		while (queue.size() == limit) {
			try {
				System.out.println("等待中.....");
				wait();
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}
		queue.add(e);
		
		notifyAll();

	}

	public synchronized T get() {
		while (queue.isEmpty()) {
			try {
				wait();
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}
		T e = queue.poll();

		return e;
	}

}
