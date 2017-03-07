/*
 * 说明：对应数据库表con_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.ConTable;

public interface ConTableDAO {

	public ConTable selectByPK(int conId);

	public ConTable select(String exeCondition, Object[] values);

	public ConTable select(String exeCondition);

	public ConTable select();

	public int insert(ConTable conTable);

	public int update(ConTable conTable);

	public int updateSelective(ConTable conTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int conId);

	public int delete(ConTable conTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<ConTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<ConTable> getList(String exeCondition, Object[] values);

	public List<ConTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<ConTable> getList(String exeCondition);

	public List<ConTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}