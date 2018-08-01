package bluedot.spectrum.utils.msg.sendEmail;

import bluedot.spectrum.utils.msg.Producer;
import bluedot.spectrum.utils.msg.QueueStorage;

public class EmailProducer<T> extends Producer<T> {

	public EmailProducer(QueueStorage<T> queue) {
		super(queue);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void notice() {
		EmailConsumer consumer=new EmailConsumer(queue);
    	consumer.send();		
		
	}

}
