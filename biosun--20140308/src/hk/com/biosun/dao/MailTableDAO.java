/*
 * 说明：对应数据库表mail_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.MailTable;

public interface MailTableDAO {

	public MailTable selectByPK(String mailId);

	public MailTable select(String exeCondition, Object[] values);

	public MailTable select(String exeCondition);

	public MailTable select();

	public int insert(MailTable mailTable);

	public int update(MailTable mailTable);

	public int updateSelective(MailTable mailTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String mailId);

	public int delete(MailTable mailTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<MailTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<MailTable> getList(String exeCondition, Object[] values);

	public List<MailTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<MailTable> getList(String exeCondition);

	public List<MailTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}