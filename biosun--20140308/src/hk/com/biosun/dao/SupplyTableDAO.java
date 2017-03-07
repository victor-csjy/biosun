/*
 * 说明：对应数据库表supply_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.SupplyTable;

public interface SupplyTableDAO {

	public SupplyTable selectByPK(int supplyId);

	public SupplyTable select(String exeCondition, Object[] values);

	public SupplyTable select(String exeCondition);

	public SupplyTable select();

	public int insert(SupplyTable supplyTable);

	public int update(SupplyTable supplyTable);

	public int updateSelective(SupplyTable supplyTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int supplyId);

	public int delete(SupplyTable supplyTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<SupplyTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<SupplyTable> getList(String exeCondition, Object[] values);

	public List<SupplyTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<SupplyTable> getList(String exeCondition);

	public List<SupplyTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}