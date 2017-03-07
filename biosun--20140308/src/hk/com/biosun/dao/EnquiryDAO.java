/*
 * 说明：对应数据库表enquiry的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.Enquiry;

public interface EnquiryDAO {

	public Enquiry selectByPK(String enId);

	public Enquiry select(String exeCondition, Object[] values);

	public Enquiry select(String exeCondition);

	public Enquiry select();

	public int insert(Enquiry enquiry);

	public int update(Enquiry enquiry);

	public int updateSelective(Enquiry enquiry);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String enId);

	public int delete(Enquiry enquiry);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<Enquiry> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<Enquiry> getList(String exeCondition, Object[] values);

	public List<Enquiry> getList(String exeCondition, int pageSize, int pageNo);

	public List<Enquiry> getList(String exeCondition);

	public List<Enquiry> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}