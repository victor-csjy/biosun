/*
 * 说明：对应数据库表user_inf的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.UserInf;

public interface UserInfDAO {

	public UserInf selectByPK(String id);

	public UserInf select(String exeCondition, Object[] values);

	public UserInf select(String exeCondition);

	public UserInf select();

	public int insert(UserInf userInf);

	public int update(UserInf userInf);

	public int updateSelective(UserInf userInf);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String id);

	public int delete(UserInf userInf);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<UserInf> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<UserInf> getList(String exeCondition, Object[] values);

	public List<UserInf> getList(String exeCondition, int pageSize, int pageNo);

	public List<UserInf> getList(String exeCondition);

	public List<UserInf> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}