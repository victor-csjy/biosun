/*
 * 说明：对应数据库表admin的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:44 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.Admin;

public interface AdminDAO {

	public Admin selectByPK(String adminName);

	public Admin select(String exeCondition, Object[] values);

	public Admin select(String exeCondition);

	public Admin select();

	public int insert(Admin admin);

	public int update(Admin admin);

	public int updateSelective(Admin admin);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String adminName);

	public int delete(Admin admin);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<Admin> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<Admin> getList(String exeCondition, Object[] values);

	public List<Admin> getList(String exeCondition, int pageSize, int pageNo);

	public List<Admin> getList(String exeCondition);

	public List<Admin> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}