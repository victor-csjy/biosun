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
				// �����ʼ��Ự
				props.put("mail.smtp.host", mailTable.getMailService());
				props.put("mail.smtp.auth", "true");
				Session s = Session.getInstance(props);
				s.setDebug(true);
				MimeMessage message = new MimeMessage(s);

				// ����Ϣ�������÷�����/�ռ���/����/����ʱ��
				InternetAddress from = new InternetAddress(mailTable
						.getMailAddress());
				message.setFrom(from);// ������
				InternetAddress to = new InternetAddress(toMail);
				message.setRecipient(Message.RecipientType.TO, to);
				message.setSubject(subject);
				message.setSentDate(new Date());

				// ����Ϣ������������
				BodyPart mdp = new MimeBodyPart();// �½�һ������ż����ݵ�BodyPart����
				mdp.setContent(content, "text/html;charset=utf-8");// ��BodyPart�����������ݺ͸�ʽ�ı��뷽ʽ
				Multipart mm = new MimeMultipart();// �½�һ��MimeMultipart�����������BodyPart����(��ʵ�Ͽ��Դ�Ŷ��)
				mm.addBodyPart(mdp);// ��BodyPart���뵽MimeMultipart������(���Լ�����BodyPart)
				message.setContent(mm);// ��mm��Ϊ��Ϣ���������

				message.saveChanges();
				Transport transport = s.getTransport("smtp");
				// ��smtp��ʽ��¼����,��һ�������Ƿ����ʼ��õ��ʼ�������SMTP��ַ,�ڶ�������Ϊ�û���,����������Ϊ����
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
