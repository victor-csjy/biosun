/*
 * 说明：对应数据库表flash_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.FlashTable;

public interface FlashTableDAO {

	public FlashTable selectByPK(String id);

	public FlashTable select(String exeCondition, Object[] values);

	public FlashTable select(String exeCondition);

	public FlashTable select();

	public int insert(FlashTable flashTable);

	public int update(FlashTable flashTable);

	public int updateSelective(FlashTable flashTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String id);

	public int delete(FlashTable flashTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<FlashTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<FlashTable> getList(String exeCondition, Object[] values);

	public List<FlashTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<FlashTable> getList(String exeCondition);

	public List<FlashTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}