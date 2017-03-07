/*
 * 说明：对应数据库表products_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao;

import java.util.List;
import hk.com.biosun.model.ProductsTable;

public interface ProductsTableDAO {

	public ProductsTable selectByPK(int pId);

	public ProductsTable select(String exeCondition, Object[] values);

	public ProductsTable select(String exeCondition);

	public ProductsTable select();

	public int insert(ProductsTable productsTable);

	public int update(ProductsTable productsTable);

	public int updateSelective(ProductsTable productsTable);

	public int update(String sql,Object[] values);

	public int update(String sql, Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int update(String columns, String exeCondition,Object[] values);

	public int update(String columns, String exeCondition,Object[] values, int[] valuesSqlType,boolean isContainNullValue);

	public int deleteByPK(int pId);

	public int delete(ProductsTable productsTable);

	public int delete(String exeCondition, Object[] values);

	public int delete(String exeCondition);

	public int delete();

	public long count(String columns, String exeCondition, Object[] values);

	public long count(String columns, String exeCondition);

	public long count(String columns, Object[] values);

	public long count(String exeCondition);

	public long count();

	public List<ProductsTable> getList(String exeCondition, Object[] values,int pageSize, int pageNo);

	public List<ProductsTable> getList(String exeCondition, Object[] values);

	public List<ProductsTable> getList(String exeCondition, int pageSize, int pageNo);

	public List<ProductsTable> getList(String exeCondition);

	public List<ProductsTable> getList();

	public void reset();

	public int getExecStatus();

	public void setExecStatus(int execStatus);

}