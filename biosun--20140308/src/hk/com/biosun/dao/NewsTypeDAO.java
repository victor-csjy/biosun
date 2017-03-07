/*
 * 说明：对应数据库表news_type的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.NewsType;

public interface NewsTypeDAO {

	public NewsType selectByPK(int newsType);

	public NewsType select(String exeCondition, Object[] values);

	public NewsType select(String exeCondition);

	public NewsType select();

	public int insert(NewsType newsType);

	public int update(NewsType newsType);

	public int updateSelective(NewsType newsType);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int newsType);

	public int delete(NewsType newsType);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<NewsType> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<NewsType> getList(String exeCondition, Object[] values);

	public List<NewsType> getList(String exeCondition, int pageSize, int pageNo);

	public List<NewsType> getList(String exeCondition);

	public List<NewsType> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}