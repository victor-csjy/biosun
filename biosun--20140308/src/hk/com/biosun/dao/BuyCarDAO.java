/*
 * 说明：对应数据库表buy_car的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.BuyCar;

public interface BuyCarDAO {

	public BuyCar selectByPK(String enId,int pId);

	public BuyCar select(String exeCondition, Object[] values);

	public BuyCar select(String exeCondition);

	public BuyCar select();

	public int insert(BuyCar buyCar);

	public int update(BuyCar buyCar);

	public int updateSelective(BuyCar buyCar);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(String enId,int pId);

	public int delete(BuyCar buyCar);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<BuyCar> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<BuyCar> getList(String exeCondition, Object[] values);

	public List<BuyCar> getList(String exeCondition, int pageSize, int pageNo);

	public List<BuyCar> getList(String exeCondition);

	public List<BuyCar> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}