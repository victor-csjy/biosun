package hk.com.biosun.service;

import hk.com.biosun.dao.MailTableDAO;
import hk.com.biosun.dao.impl.MailTableDAOImpl;
import hk.com.biosun.model.MailTable;

import java.util.Date;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

public class MailTableService {
	private static Logger LOG = Logger.getLogger(MailTableService.class);

	public MailTable getByPK(String mailId) {
		if (mailId == null || "".equals(mailId)) {
			return null;
		} else {
			MailTableDAO mailTableDAO = new MailTableDAOImpl();
			return mailTableDAO.selectByPK(mailId);
		}
	}

	public int update(String mailId, String mailService, String mailAddress,
			String mailUser, String mailPw, String website, String mailPrefix,
			String mailSuffix) {
		MailTableDAO mailTableDAO = new MailTableDAOImpl();
		Object[] values = { mailService, mailAddress, mailUser, mailPw,
				website, mailPrefix, mailSuffix };
		return mailTableDAO
				.update(
						"mail_service=?,mail_address=?,mail_user=?,mail_pw=?,website=?,mailPrefix=?,mailSuffix=?",
						"WHERE mail_id=1", values);

	}

	public int sendEmail(MailTable mailTable, String toMail, String subject,
			String content) {
		int result = -2;
		if (mailTable == null || subject == null || content == null
				|| mailTable.getMailAddress() == null
				|| "".equals(mailTable.getMailAddress())) {
			LOG
					.error("mailTable == null || subject == null || content == null");
			return -1;
		} else {
			try {
				Properties props = new Properties();
				// 建立邮件会话
				props.put("mail.smtp.host", mailTable.getMailService());
				props.put("mail.smtp.auth", "true");
				Session s = Session.getInstance(props);
				s.setDebug(true);
				MimeMessage message = new MimeMessage(s);

				// 给消息对象设置发件人/收件人/主题/发信时间
				InternetAddress from = new InternetAddress(mailTable
						.getMailAddress());
				message.setFrom(from);// 发件人
				InternetAddress to = new InternetAddress(toMail);
				message.setRecipient(Message.RecipientType.TO, to);
				message.setSubject(subject);
				message.setSentDate(new Date());

				// 给消息对象设置内容
				BodyPart mdp = new MimeBodyPart();// 新建一个存放信件内容的BodyPart对象
				mdp.setContent(content, "text/html;charset=utf-8");// 给BodyPart对象设置内容和格式的编码方式
				Multipart mm = new MimeMultipart();// 新建一个MimeMultipart对象用来存放BodyPart对象(事实上可以存放多个)
				mm.addBodyPart(mdp);// 将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
				message.setContent(mm);// 把mm作为消息对象的内容

				message.saveChanges();
				Transport transport = s.getTransport("smtp");
				// 以smtp方式登录邮箱,第一个参数是发送邮件用的邮件服务器SMTP地址,第二个参数为用户名,第三个参数为密码
				transport.connect(mailTable.getMailService(), mailTable
						.getMailUser(), mailTable.getMailPw());
				transport.sendMessage(message, message.getAllRecipients());
				transport.close();
				result = 1;
			} catch (MessagingException e) {
				LOG.error("toMail:" + toMail + " Subject:" + subject, e);
				e.printStackTrace();
			} catch (Exception e) {
				LOG.error("toMail:" + toMail + " Subject:" + subject, e);
				e.printStackTrace();
			} finally {

				if (LOG.isInfoEnabled()) {
					LOG.info("result=" + result + " fromMail="
							+ mailTable.getMailAddress() + " toMail=" + toMail
							+ " subject=" + subject);
				}

			}
			return result;
		}
	}
}
