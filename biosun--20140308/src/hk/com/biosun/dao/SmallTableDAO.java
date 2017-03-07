/*
 * ˵������Ӧ���ݿ��small_table�Ľӿ�<br>
 * �޸����ݿ��ṹ,���޸ĸ����Լ���Ӧ��DAOImpl��
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.SmallTable;

public interface SmallTableDAO {

	public SmallTable selectByPK(int smallId);

	public SmallTable select(String exeCondition, Object[] values);

	public SmallTable select(String exeCondition);

	public SmallTable select();

	public int insert(SmallTable smallTable);

	public int update(SmallTable smallTable);

	public int updateSelective(SmallTable smallTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int smallId);

	public int delete(SmallTable smallTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<SmallTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<SmallTable> getList(String exeCondition, Object[] values);

	public List<SmallTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<SmallTable> getList(String exeCondition);

	public List<SmallTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}