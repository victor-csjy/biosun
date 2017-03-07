/*
 * 说明：对应数据库表admin_log的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.AdminLog;

public interface AdminLogDAO {

	public AdminLog selectByPK(long id);

	public AdminLog select(String exeCondition, Object[] values);

	public AdminLog select(String exeCondition);

	public AdminLog select();

	public int insert(AdminLog adminLog);

	public int update(AdminLog adminLog);

	public int updateSelective(AdminLog adminLog);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(long id);

	public int delete(AdminLog adminLog);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<AdminLog> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<AdminLog> getList(String exeCondition, Object[] values);

	public List<AdminLog> getList(String exeCondition, int pageSize, int pageNo);

	public List<AdminLog> getList(String exeCondition);

	public List<AdminLog> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}