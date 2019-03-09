package cn.jsbintask.bbs.utils;

import javax.mail.*;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {
	/*private PropConfig prop;
	
	public EmailUtil(String location) {
		prop = new PropConfig();
		try {
			prop.init(location);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}*/
	
	public static void sendMessage(String to, String code) throws Exception {
		Properties props = new Properties();
		String from = "Jsbintask@163.com";
		String smtpUrl = "smtp." + from.split("@")[1];
		
		props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.host", smtpUrl);
		
		Session session = Session.getInstance(props, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("Jsbintask@163.com", "xxxxxx");
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress("Jsbintask@163.com"));
		message.setRecipient(RecipientType.TO, new InternetAddress(to));
		System.out.println("BBSCheckCode");
		message.setSubject("激活码");
		message.setContent(
				"<h1>您的验证码：<span style='color=red'>" + code + "</span></h1>",
				"text/html;charset=UTF-8");
		Transport.send(message);
	}
	
	public static String getCheckCode() {
		StringBuilder checkCode = new StringBuilder();
		Random random = new Random();
		for(int i = 0;i<6;i++) {
			checkCode.append(random.nextInt(10));
		}
		return checkCode.toString();
	}


}
