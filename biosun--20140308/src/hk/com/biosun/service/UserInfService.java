package hk.com.biosun.service;

import hk.com.biosun.dao.UserInfDAO;
import hk.com.biosun.dao.impl.UserInfDAOImpl;
import hk.com.biosun.model.UserInf;
import hk.com.biosun.util.ReqParamUtil;
import hk.com.biosun.util.SessionUtil;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.aokle.util.DateUtil;
import com.aokle.util.StrUtil;

public class UserInfService {

	public UserInf getByPK(String id) {
		if (id == null || "".equals(id)) {
			return null;
		} else {
			UserInfDAO userInfDAO = new UserInfDAOImpl();
			return userInfDAO.selectByPK(id);
		}
	}

	public int findPassWord(String id, String passWord) {
		if (id == null || "".equals(id)) {
			return -1;
		} else {
			UserInfDAO userInfDAO = new UserInfDAOImpl();
			Object[] values = { passWord, id };
			return userInfDAO.update("password=?", "WHERE id=?", values);
		}
	}

	public int updatePassWord(String id, String passWord, String passWordOld) {
		if (id == null || "".equals(id) || "".equals(passWordOld)) {
			return -1;
		} else {
			UserInfDAO userInfDAO = new UserInfDAOImpl();
			Object[] values = { passWord, id, passWordOld };
			return userInfDAO.update("password=?", "WHERE id=? AND password=?",
					values);
		}
	}

	public int updateLoginInfo(UserInf userInf) {
		if (userInf == null || "".equals(userInf.getId())) {
			return -1;
		} else {
			String loginLog = userInf.getLoginLog();
			if (loginLog == null) {
				loginLog = "";
			}
			String dateNow = DateUtil.formatDate(System.currentTimeMillis(), 2);
			if (loginLog.length() > 5000) {
				loginLog = dateNow + "," + loginLog.substring(0, 250);
			} else {
				loginLog = dateNow + "," + loginLog;
			}
			UserInfDAO userInfDAO = new UserInfDAOImpl();
			Object[] values = { loginLog, 1, userInf.getId() };
			return userInfDAO.update("login_log=?,login_times=login_times+?",
					"WHERE id=?", values);
		}
	}

	public int add(HttpServletRequest request) {

		String id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("id"), true));

		if (id.indexOf("@") == -1 || id.indexOf(".") == -1) {
			return -2;
		}
		String dateNowStr = DateUtil.formatDate(System.currentTimeMillis(), 2);
		String password = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("password"), true));
		String question = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("question"), true));
		String answer = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("answer"), true));

		String send = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("send"), true));
		String sex = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("sex"), true));
		String person = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("person"), true));
		String job_title = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("job_title"), true));
		String company = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("company"), true));
		String country_code = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(
				request.getParameter("country_code"), true));
		String area_code = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("area_code"), true));
		String tel = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("tel"), true));
		String f_ccode = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("f_ccode"), true));
		String f_acode = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("f_acode"), true));
		String fax = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("fax"), true));
		String email = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("email"), true));
		String ms = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ms"), true));
		String website = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("website"), true));
		String mailing_address = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(
				request.getParameter("mailing_address"), true));
		String a_city = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_city"), true));
		String a_state = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_state"), true));
		String a_zip = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_zip"), true));
		String a_country = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_country"), true));
		String di = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("di"), true));
		String ma = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ma"), true));
		String en = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("en"), true));
		String im1 = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("im1"), true));
		String im2 = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("im2"), true));
		String re = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("re"), true));
		String bu = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("bu"), true));
		String br = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("br"), true));
		String pr = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("pr"), true));
		String ot = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ot"), true));
		String other = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("other"), true));
		String invoice = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("invoice"), true));
		String other_ms = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("other_ms"), true));
		String reg_go = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("reg_go"), true));
		if (!ot.equals(""))
			ot = ot + ":" + other;

		if (reg_go.equals("ok")) {
			UserInfDAO userInfDAO = new UserInfDAOImpl();
			UserInf userInf = new UserInf();
			userInf.setId(id);
			userInf.setPassword(password);
			userInf.setQuestion(question);
			userInf.setAnswer(answer);
			userInf.setSend(send);

			userInf.setSex(sex);
			userInf.setPerson(person);
			userInf.setJobTitle(job_title);
			userInf.setCompany(company);
			userInf.setCountryCode(country_code);

			userInf.setAreaCode(area_code);
			userInf.setTel(tel);
			userInf.setFCcode(f_ccode);
			userInf.setFAcode(f_acode);
			userInf.setFax(fax);

			userInf.setEmail(email);
			userInf.setMs(ms);
			userInf.setWebsite(website);
			userInf.setMailingAddress(mailing_address);
			userInf.setACity(a_city);

			userInf.setAState(a_state);
			userInf.setAZip(a_zip);
			userInf.setACountry(a_country);
			userInf.setDi(di);
			userInf.setMa(ma);

			userInf.setEn(en);
			userInf.setIm1(im1);
			userInf.setIm2(im2);
			userInf.setRe(re);
			userInf.setBu(bu);

			userInf.setBr(br);
			userInf.setPr(pr);
			userInf.setOt(ot);
			userInf.setInvoice(invoice);
			userInf.setOtherMs(other_ms);

			userInf.setIdGrage("1");
			userInf.setEnTimes(0);
			userInf.setTradeTimes(0);
			userInf.setLoginTimes(1);
			userInf.setUsercomTimes(0);

			userInf.setRegDate(dateNowStr);
			userInf.setLoginLog(dateNowStr);

			int result = userInfDAO.insert(userInf);
			if (result > 0) {
				SessionUtil.setUserInf(request, userInf);
			}
			return result;
		}
		return -1;
	}

	public int update(HttpServletRequest request) {
		UserInf userInfSes = SessionUtil.getUserInf(request);
		if (userInfSes == null) {
			return -1;
		}
		String send = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("send"), true));
		String sex = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("sex"), true));
		String person = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("person"), true));
		String job_title = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("job_title"), true));
		String company = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("company"), true));
		String country_code = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(
				request.getParameter("country_code"), true));
		String area_code = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("area_code"), true));
		String tel = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("tel"), true));
		String f_ccode = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("f_ccode"), true));
		String f_acode = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("f_acode"), true));
		String fax = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("fax"), true));
		String email = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("email"), true));
		String ms = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ms"), true));
		String website = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("website"), true));
		String mailing_address = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(
				request.getParameter("mailing_address"), true));
		String a_city = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_city"), true));
		String a_state = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_state"), true));
		String a_zip = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_zip"), true));
		String a_country = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("a_country"), true));
		String di = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("di"), true));
		String ma = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ma"), true));
		String en = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("en"), true));
		String im1 = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("im1"), true));
		String im2 = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("im2"), true));
		String re = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("re"), true));
		String bu = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("bu"), true));
		String br = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("br"), true));
		String pr = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("pr"), true));
		String ot = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("ot"), true));
		String other = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("other"), true));
		String change_yes = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
				.getParameter("change_yes"), true));
		if (!ot.equals(""))
			ot = ot + ":" + other;
		if (change_yes.equals("change_yes")) {
			List<Object> list = new ArrayList<Object>();
			StringBuffer columnsSB = new StringBuffer(
					"send=?,sex=?,person=?,job_title=?,company=?,");
			list.add(send);
			list.add(sex);
			list.add(person);
			list.add(job_title);
			list.add(company);
			columnsSB
					.append("country_code=?,area_code=?,tel=?,f_ccode=?,f_acode=?,");
			list.add(country_code);
			list.add(area_code);
			list.add(tel);
			list.add(f_ccode);
			list.add(f_acode);
			columnsSB.append("fax=?,email=?,ms=?,website=?,mailing_address=?,");
			list.add(fax);
			list.add(email);
			list.add(ms);
			list.add(website);
			list.add(mailing_address);
			columnsSB.append("a_city=?,a_state=?,a_zip=?,a_country=?,di=?,");
			list.add(a_city);
			list.add(a_state);
			list.add(a_zip);
			list.add(a_country);
			list.add(di);
			columnsSB.append("ma=?,en=?,im1=?,im2=?,re=?,");
			list.add(ma);
			list.add(en);
			list.add(im1);
			list.add(im2);
			list.add(re);
			columnsSB.append("bu=?,br=?,pr=?,ot=?");
			list.add(bu);
			list.add(br);
			list.add(pr);
			list.add(ot);
			list.add(userInfSes.getId());

			UserInfDAO userInfDAO = new UserInfDAOImpl();
			int result = userInfDAO.update(columnsSB.toString(), "WHERE id=?",
					list.toArray());
			return result;
		}
		return -1;
	}

	public int updateUsercomTimes(String id, int span) {
		if (id == null || "".equals(id)) {
			return -1;
		}
		String sql;
		Object[] values = { span, id };
		UserInfDAO userInfDAO = new UserInfDAOImpl();
		sql = "UPDATE user_inf SET usercom_times=usercom_times+? WHERE id=?";
		return userInfDAO.update(sql, values);
	}

	/**
	 * 修改会员级别！询单一次是2级，询单二次或以上是3级，交易一次是4级，交易大于1是5级！ //若是3级就不用修改！ //大于三时只修改询单次数，
	 * 修改级别和询单次数！
	 * 
	 * @param userId
	 * @param idGrage
	 * @return
	 */
	public int addEnTimes(String userId, int idGrage, int span) {
		if (userId == null) {
			return -1;
		}
		Object[] values = { span, userId };
		StringBuffer sqlSB = new StringBuffer();
		if (idGrage >= 3) {
			sqlSB.append("UPDATE user_inf SET en_times=en_times+?  WHERE id=?");
		} else if (idGrage == 2) {
			sqlSB
					.append("UPDATE user_inf SET en_times=en_times+?,id_grage='3' WHERE id=?");
		} else {
			// 第一次询单！
			sqlSB
					.append("UPDATE user_inf SET en_times=en_times+?,id_grage='2' WHERE id=?");
		}
		UserInfDAO userInfDAO = new UserInfDAOImpl();
		return userInfDAO.update(sqlSB.toString(), values);
	}

	public int updateTradeTimes(String userId, int idGrage, int tradeTimes) {
		if (userId == null) {
			return -1;
		}
		Object[] values = { tradeTimes, userId };
		StringBuffer sqlSB = new StringBuffer();
		if (idGrage < 4) {
			sqlSB
					.append("UPDATE user_inf SET trade_times=?,id_grage='4'  WHERE id=?");
		} else if (idGrage == 4) {
			sqlSB
					.append("UPDATE user_inf SET trade_times=?,id_grage='5' WHERE id=?");
		} else {
			// 第一次询单！
			sqlSB.append("UPDATE user_inf SET trade_times=? WHERE id=?");
		}
		UserInfDAO userInfDAO = new UserInfDAOImpl();
		return userInfDAO.update(sqlSB.toString(), values);
	}

	public int delete(String id) {
		if (id == null || id.equals("")) {
			return -1;
		}
		UserInfDAO userInfDAO = new UserInfDAOImpl();
		return userInfDAO.deleteByPK(id);
	}

	public int getCount(String exeCondition, List<Object> valuesList) {
		UserInfDAO userInfDAO = new UserInfDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) userInfDAO.count("*", exeCondition);
		}
		return (int) userInfDAO.count("*", exeCondition, valuesList.toArray());

	}

	public List<UserInf> getList(String exeCondition, List<Object> valuesList,
			int pageSize, int pageNo) {
		if (pageSize > 500) {
			pageSize = 500;
		}

		UserInfDAO userInfDAO = new UserInfDAOImpl();
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return userInfDAO.getList(exeCondition, null, pageSize, pageNo);
		}
		return userInfDAO.getList(exeCondition, valuesList.toArray(), pageSize,
				pageNo);
	}

}
