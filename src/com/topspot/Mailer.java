/*package com.topspot;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

*//**
 * Mailer is using to send email
 * @author pdudekula
 *
 *//*
public class Mailer {

	public static void sendMail(final String userName, final String password,String fromEmail, String toEmail, String subject, String text){

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(userName, password);
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromEmail));
			message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(toEmail));
			message.setSubject(subject);
	//		message.setText(text);
		
			message.setContent(text, "text/html");

			try {
				Transport transport = session.getTransport("smtp");
				transport.connect("smtp.gmail.com", 587, "username", "password");
				transport.sendMessage(message, message.getAllRecipients());
				transport.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	}
}
*/

package com.topspot;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class Mailer {
	
	public static void sendMail(final String userName, final String password,String fromEmail, String toEmail, String subject, String text){
		
		
	      // Assuming you are sending email through relay.jangosmtp.net
	      String host = "smtp.gmail.com";
		
		
		 // Get system properties
	     // Properties properties = System.getProperties();

	      Properties props = new Properties();
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.host", host);
	      props.put("mail.smtp.port", "587");
	      
      //	Session session = Session.getDefaultInstance(props, null);
	      
	      // Get the Session object.
	      Session session = Session.getInstance(props,
	      new javax.mail.Authenticator() {
	         protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(userName, password);
	         }
	      });

      try {
          Message msg = new MimeMessage(session);
          
          try {
				msg.setFrom(new InternetAddress(fromEmail, "Top spot Admin"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
          try {
				msg.addRecipient(Message.RecipientType.TO,new InternetAddress(toEmail, toEmail));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
          msg.setSubject(subject);
        //  msg.setText(text);
          msg.setContent(text, "text/html");
          Transport.send(msg);

      } catch (AddressException e) {
      	e.printStackTrace();
      } catch (MessagingException e) {
      	e.printStackTrace();
      }
		
	}
	
}


