/*
 * 说明：对应数据库表news_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.NewsTable;

public interface NewsTableDAO {

	public NewsTable selectByPK(int newsId);

	public NewsTable select(String exeCondition, Object[] values);

	public NewsTable select(String exeCondition);

	public NewsTable select();

	public int insert(NewsTable newsTable);

	public int update(NewsTable newsTable);

	public int updateSelective(NewsTable newsTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int newsId);

	public int delete(NewsTable newsTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<NewsTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<NewsTable> getList(String exeCondition, Object[] values);

	public List<NewsTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<NewsTable> getList(String exeCondition);

	public List<NewsTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}