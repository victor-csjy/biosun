package hk.com.biosun.init;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.xml.DOMConfigurator;
import org.logicalcobwebs.proxool.configuration.JAXPConfigurator;

import com.aokle.util.PathUtil;

public class ApplicationInitServlet extends HttpServlet {
	private static final long serialVersionUID = 20100316L;

	public void init() throws ServletException {
		// ServletContext application = getServletContext();
		// application.getRealPath("");
		String realPath = PathUtil.getRealPath();
		String realPathLog4jXml = (new StringBuffer(realPath)
				.append("WEB-INF/log4j.xml")).toString();
		try {
			DOMConfigurator.configure(realPathLog4jXml);// ¼ÓÔØ.xmlÎÄ¼þ
			System.out
					.println(new Date()
							+ "hk.com.biosun.init.ApplicationInitServlet.java Log4j init() success!  "
							+ realPathLog4jXml);
		} catch (Exception e) {
			System.err
					.println(new Date()
							+ "hk.com.biosun.init.ApplicationInitServlet.java Log4j init() failure! log4j.xml not exist!  "
							+ realPathLog4jXml);
			e.printStackTrace();
		} finally {
			String realPathProxoolXml = (new StringBuffer(realPath)
					.append("WEB-INF/proxool.xml")).toString();
			try {
				JAXPConfigurator.configure(realPathProxoolXml, false);
				System.out
						.println(new Date()
								+ "hk.com.biosun.init.ApplicationInitServlet.java proxool init() success!  "
								+ realPathProxoolXml);
			} catch (RuntimeException e) {
				System.err
						.println(new Date()
								+ "hk.com.biosun.init.ApplicationInitServlet.java proxool init() failure! proxool.xml not exist!  "
								+ realPathProxoolXml);
				e.printStackTrace();
			} catch (Exception e) {
				System.err
						.println(new Date()
								+ "hk.com.biosun.init.ApplicationInitServlet.java proxool init() failure! proxool.xml not exist!  "
								+ realPathProxoolXml);
				e.printStackTrace();
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}
