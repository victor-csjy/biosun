/*
 * 说明：对应数据库表big_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.BigTable;

public interface BigTableDAO {

	public BigTable selectByPK(int bigId);

	public BigTable select(String exeCondition, Object[] values);

	public BigTable select(String exeCondition);

	public BigTable select();

	public int insert(BigTable bigTable);

	public int update(BigTable bigTable);

	public int updateSelective(BigTable bigTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int bigId);

	public int delete(BigTable bigTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<BigTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<BigTable> getList(String exeCondition, Object[] values);

	public List<BigTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<BigTable> getList(String exeCondition);

	public List<BigTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}