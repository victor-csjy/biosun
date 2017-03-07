/*
 * 说明：对应数据库表article的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.Article;

public interface ArticleDAO {

	public Article selectByPK(int articleId);

	public Article select(String exeCondition, Object[] values);

	public Article select(String exeCondition);

	public Article select();

	public int insert(Article article);

	public int update(Article article);

	public int updateSelective(Article article);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int articleId);

	public int delete(Article article);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<Article> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<Article> getList(String exeCondition, Object[] values);

	public List<Article> getList(String exeCondition, int pageSize, int pageNo);

	public List<Article> getList(String exeCondition);

	public List<Article> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}