/*
 * 说明：对应数据库表com_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.ComTable;

public interface ComTableDAO {

	public ComTable selectByPK(int comId);

	public ComTable select(String exeCondition, Object[] values);

	public ComTable select(String exeCondition);

	public ComTable select();

	public int insert(ComTable comTable);

	public int update(ComTable comTable);

	public int updateSelective(ComTable comTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int comId);

	public int delete(ComTable comTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<ComTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<ComTable> getList(String exeCondition, Object[] values);

	public List<ComTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<ComTable> getList(String exeCondition);

	public List<ComTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}