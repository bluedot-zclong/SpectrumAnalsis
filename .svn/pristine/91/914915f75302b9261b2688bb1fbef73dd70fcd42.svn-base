package bluedot.spectrum.utils.msg.upload;

import bluedot.spectrum.utils.msg.Producer;
import bluedot.spectrum.utils.msg.QueueStorage;

public class WriterProducer extends Producer {

	public WriterProducer(QueueStorage queue) {
		super(queue);		
	}

	@Override
	public void notice() {
		WriterConsumer consumer=new WriterConsumer(queue);
    	consumer.writer();		
	}

}
