package bluedot.spectrum.utils.msg.sendEmail;

public class sendThread implements Runnable{
  private Message message;
	
	public sendThread(Message message) {
		this.message = message;
	}

	@Override
	public void run() {
		try {
			Thread.sleep(1000);
			System.out.println(message.toString());
		} catch (InterruptedException e) {
			
			e.printStackTrace();
		}
		
	}
}
