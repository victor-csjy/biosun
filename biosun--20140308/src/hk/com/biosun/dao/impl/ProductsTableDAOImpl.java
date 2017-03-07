/*
 * 说明：对应数据库表products_table的DAOImpl类<br>
 * 修改数据库表结构,请重新生成该类以及相应的基础类,接口类
 * 
 * 类变量dataBasePool 对应数据库连接池编码,一般使用数据库名称,只有reset()方法才重新恢复初始值,单一数据库连接池应用不需要这个变量<br>
 * 类变量execStatus 执行状态 0=初始值 1=执行成功 2=在缓存中成功获得[启用缓存的时候才起作用]<br>
 * -1=执行异常 -2=没有进行数据库操作(传入的条件不符合要求) -3=没有获取数据库连接 -4=条件参数数组中有空值null<br>
 * execStatus每个方法使用前都重新赋值<br>
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao.impl;

import java.util.List;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
import java.sql.Timestamp;
import java.sql.Time;
import java.sql.Types;
import hk.com.biosun.model.ProductsTable;
import hk.com.biosun.dao.ProductsTableDAO;
import com.aokle.db.ICon;
import com.aokle.db.proxool.ConUtil;
import org.apache.log4j.Logger;


public class ProductsTableDAOImpl implements ProductsTableDAO {
	private static Logger log = Logger.getLogger(ProductsTableDAOImpl.class);

	private int execStatus;

	/**
	 * 功能：根据ResultSet设置值
	 *
	 * @param productsTable
	 *            表的基础类
	 * @param rs
	 *            数据库表products_table全列结果集
	 * @throws Exception
	 *            抛出异常
	 */
	private void setFieldFromRs(ProductsTable productsTable, ResultSet rs) throws Exception {
		if (rs == null || rs.isAfterLast()) {
			return;
		}
		if (productsTable == null) {
			throw new NullPointerException(
					"ProductsTableDAOImpl.java setFieldFromRs() the paramer productsTable is NULL");
		}
		productsTable.setPId(rs.getInt("p_id"));
		productsTable.setPModel(rs.getString("p_model"));
		productsTable.setPName(rs.getString("p_name"));
		productsTable.setBigId(rs.getInt("big_id"));
		productsTable.setSmallId(rs.getInt("small_id"));
		productsTable.setSmallStrong(rs.getString("small_strong"));
		productsTable.setDetail1(rs.getString("detail1"));
		productsTable.setDetail2(rs.getString("detail2"));
		productsTable.setApp(rs.getString("app"));
		productsTable.setSc(rs.getString("sc"));
		productsTable.setOc(rs.getString("oc"));
		productsTable.setSp(rs.getString("sp"));
		productsTable.setEc1Word(rs.getString("ec1_word"));
		productsTable.setEc1(rs.getString("ec_1"));
		productsTable.setEc2Word(rs.getString("ec2_word"));
		productsTable.setEc2(rs.getString("ec_2"));
		productsTable.setPublicPrice(rs.getFloat("public_price"));
		productsTable.setBsPrice(rs.getFloat("bs_price"));
		productsTable.setSupplyModel(rs.getString("supply_model"));
		productsTable.setModelName(rs.getString("model_name"));
		productsTable.setBsCgPrice(rs.getFloat("bs_cg_price"));
		productsTable.setPPic(rs.getString("p_pic"));
		productsTable.setKeyWord(rs.getString("key_word"));
		productsTable.setOrderId(rs.getString("order_id"));
		productsTable.setOther(rs.getString("other"));
		productsTable.setBrowse(rs.getInt("browse"));
		productsTable.setAskTimes(rs.getInt("ask_times"));
		productsTable.setComTimes(rs.getInt("com_times"));
		productsTable.setIsShow(rs.getString("is_show"));
		productsTable.setSupplyId(rs.getInt("supply_id"));
		productsTable.setIndexOrder(rs.getString("index_order"));
		productsTable.setPDate(rs.getString("p_date"));
	}

	/**
	 * 功能：根据主键查询
	 *
	 * @param pId
	 *
	 * @return ProductsTable对象,可能为null对象
	 */
	public ProductsTable selectByPK(int pId) {
		this.execStatus = 0;
		ProductsTable returnValue = null;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM products_table  WHERE p_id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setInt(1,pId);
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					returnValue = new ProductsTable();
					setFieldFromRs(returnValue, rs);
					this.execStatus = 1;
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = null;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = null;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据exeCondition条件查询,直接到数据库中获得
	 *
	 * @param  exeCondition 查询条件
	 * @param values
	 *            可以为null,但是里面的值不允许有null
	 *
	 * @return ProductsTable对象,可能为null对象
	 */
	public ProductsTable select(String exeCondition, Object[] values) {
		this.execStatus = 0;
		ProductsTable returnValue = null;
		ICon iCon = null;
		int valuesLength = 0;
		if (values != null) {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return null;
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM products_table ";
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
			} else {
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (values != null && valuesLength > 0) {
					for (int i = 0; i < valuesLength; i++) {
						if (values[i] instanceof BigDecimal) {
							ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
						} else if ((values[i] instanceof Blob)) {
							ps.setBlob(i + 1, (Blob) values[i]);
						} else if ((values[i] instanceof Boolean)) {
							ps.setBoolean(i + 1, (Boolean) values[i]);
						} else if ((values[i] instanceof Byte)) {
							ps.setByte(i + 1, (Byte) values[i]);
						} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
							ps.setBytes(i + 1, valuesByte);
						} else if (values[i] instanceof Clob) {
							ps.setClob(i + 1, (Clob) values[i]);
						} else if (values[i] instanceof Date) {
							ps.setDate(i + 1, (Date) values[i]);
						} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
							ps.setDate(i + 1, date);
						} else if ((values[i] instanceof Double)) {
							ps.setDouble(i + 1, (Double) values[i]);
						} else if ((values[i] instanceof Float)) {
							ps.setFloat(i + 1, (Float) values[i]);
						} else if ((values[i] instanceof Integer)) {
							ps.setInt(i + 1, (Integer) values[i]);
						} else if ((values[i] instanceof Long)) {
							ps.setLong(i + 1, (Long) values[i]);
						} else if ((values[i] instanceof Short)) {
							ps.setShort(i + 1, (Short) values[i]);
						} else if ((values[i] instanceof String)) {
							ps.setString(i + 1, (String) values[i]);
						} else if ((values[i] instanceof Time)) {
							ps.setTime(i + 1, (Time) values[i]);
						} else if ((values[i] instanceof Timestamp)) {
							ps.setTimestamp(i + 1, (Timestamp) values[i]);
						} else if ((values[i] instanceof URL)) {
							ps.setURL(i + 1, (URL) values[i]);
						} else {
							ps.setObject(i + 1, values[i]);
						}
					}
				}
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					returnValue = new ProductsTable();
					setFieldFromRs(returnValue, rs);
					this.execStatus = 1;
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = null;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = null;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据条件查询,直接到数据库中获得
	 *
	 * @param  exeCondition 查询条件
	 * 
	 * @return ProductsTable对象,可能为null对象
	 */
	public ProductsTable select(String exeCondition) {
		return select(exeCondition, null);
	}
	/**
	 * 功能：方法重载,查询表中所有的记录,返回第一条记录,直接到数据库中获得
	 *
	 * @return ProductsTable对象,可能为null对象
	 */
	public ProductsTable select() {
		return select(null, null);
	}
	/**
	 * 功能：插入一条完整的记录
	 *
	 * @param productsTable 插入的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=插入异常 n>-1=成功插入的记录
	 */
	public int insert(ProductsTable productsTable) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (productsTable == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "INSERT INTO products_table (p_model,p_name,big_id,small_id,small_strong,detail1,detail2,app,sc,oc,sp,ec1_word,ec_1,ec2_word,ec_2,public_price,bs_price,supply_model,model_name,bs_cg_price,p_pic,key_word,order_id,other,browse,ask_times,com_times,is_show,supply_id,index_order,p_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (productsTable.getPModel() == null) {
					ps.setNull(1, Types.VARCHAR);
				} else {
					ps.setString(1, productsTable.getPModel());
				}
				if (productsTable.getPName() == null) {
					ps.setNull(2, Types.VARCHAR);
				} else {
					ps.setString(2, productsTable.getPName());
				}
				ps.setInt(3, productsTable.getBigId());
				ps.setInt(4, productsTable.getSmallId());
				if (productsTable.getSmallStrong() == null) {
					ps.setNull(5, Types.VARCHAR);
				} else {
					ps.setString(5, productsTable.getSmallStrong());
				}
				if (productsTable.getDetail1() == null) {
					ps.setNull(6, Types.LONGVARCHAR);
				} else {
					ps.setString(6, productsTable.getDetail1());
				}
				if (productsTable.getDetail2() == null) {
					ps.setNull(7, Types.LONGVARCHAR);
				} else {
					ps.setString(7, productsTable.getDetail2());
				}
				if (productsTable.getApp() == null) {
					ps.setNull(8, Types.LONGVARCHAR);
				} else {
					ps.setString(8, productsTable.getApp());
				}
				if (productsTable.getSc() == null) {
					ps.setNull(9, Types.LONGVARCHAR);
				} else {
					ps.setString(9, productsTable.getSc());
				}
				if (productsTable.getOc() == null) {
					ps.setNull(10, Types.LONGVARCHAR);
				} else {
					ps.setString(10, productsTable.getOc());
				}
				if (productsTable.getSp() == null) {
					ps.setNull(11, Types.LONGVARCHAR);
				} else {
					ps.setString(11, productsTable.getSp());
				}
				if (productsTable.getEc1Word() == null) {
					ps.setNull(12, Types.VARCHAR);
				} else {
					ps.setString(12, productsTable.getEc1Word());
				}
				if (productsTable.getEc1() == null) {
					ps.setNull(13, Types.VARCHAR);
				} else {
					ps.setString(13, productsTable.getEc1());
				}
				if (productsTable.getEc2Word() == null) {
					ps.setNull(14, Types.VARCHAR);
				} else {
					ps.setString(14, productsTable.getEc2Word());
				}
				if (productsTable.getEc2() == null) {
					ps.setNull(15, Types.VARCHAR);
				} else {
					ps.setString(15, productsTable.getEc2());
				}
				ps.setFloat(16, productsTable.getPublicPrice());
				ps.setFloat(17, productsTable.getBsPrice());
				if (productsTable.getSupplyModel() == null) {
					ps.setNull(18, Types.VARCHAR);
				} else {
					ps.setString(18, productsTable.getSupplyModel());
				}
				if (productsTable.getModelName() == null) {
					ps.setNull(19, Types.VARCHAR);
				} else {
					ps.setString(19, productsTable.getModelName());
				}
				ps.setFloat(20, productsTable.getBsCgPrice());
				if (productsTable.getPPic() == null) {
					ps.setNull(21, Types.VARCHAR);
				} else {
					ps.setString(21, productsTable.getPPic());
				}
				if (productsTable.getKeyWord() == null) {
					ps.setNull(22, Types.VARCHAR);
				} else {
					ps.setString(22, productsTable.getKeyWord());
				}
				if (productsTable.getOrderId() == null) {
					ps.setNull(23, Types.VARCHAR);
				} else {
					ps.setString(23, productsTable.getOrderId());
				}
				if (productsTable.getOther() == null) {
					ps.setNull(24, Types.LONGVARCHAR);
				} else {
					ps.setString(24, productsTable.getOther());
				}
				ps.setInt(25, productsTable.getBrowse());
				ps.setInt(26, productsTable.getAskTimes());
				ps.setInt(27, productsTable.getComTimes());
				if (productsTable.getIsShow() == null) {
					ps.setNull(28, Types.VARCHAR);
				} else {
					ps.setString(28, productsTable.getIsShow());
				}
				ps.setInt(29, productsTable.getSupplyId());
				if (productsTable.getIndexOrder() == null) {
					ps.setNull(30, Types.VARCHAR);
				} else {
					ps.setString(30, productsTable.getIndexOrder());
				}
				if (productsTable.getPDate() == null) {
					ps.setNull(31, Types.VARCHAR);
				} else {
					ps.setString(31, productsTable.getPDate());
				}
				returnValue = iCon.executePreUpdate();
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据主键修改一条完整的记录
	 *
	 * @param productsTable 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(ProductsTable productsTable) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (productsTable == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "UPDATE products_table SET p_model=?,p_name=?,big_id=?,small_id=?,small_strong=?,detail1=?,detail2=?,app=?,sc=?,oc=?,sp=?,ec1_word=?,ec_1=?,ec2_word=?,ec_2=?,public_price=?,bs_price=?,supply_model=?,model_name=?,bs_cg_price=?,p_pic=?,key_word=?,order_id=?,other=?,browse=?,ask_times=?,com_times=?,is_show=?,supply_id=?,index_order=?,p_date=?  WHERE p_id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (productsTable.getPModel() == null) {
					ps.setNull(1, Types.VARCHAR);
				} else {
					ps.setString(1, productsTable.getPModel());
				}
				if (productsTable.getPName() == null) {
					ps.setNull(2, Types.VARCHAR);
				} else {
					ps.setString(2, productsTable.getPName());
				}
				ps.setInt(3, productsTable.getBigId());
				ps.setInt(4, productsTable.getSmallId());
				if (productsTable.getSmallStrong() == null) {
					ps.setNull(5, Types.VARCHAR);
				} else {
					ps.setString(5, productsTable.getSmallStrong());
				}
				if (productsTable.getDetail1() == null) {
					ps.setNull(6, Types.LONGVARCHAR);
				} else {
					ps.setString(6, productsTable.getDetail1());
				}
				if (productsTable.getDetail2() == null) {
					ps.setNull(7, Types.LONGVARCHAR);
				} else {
					ps.setString(7, productsTable.getDetail2());
				}
				if (productsTable.getApp() == null) {
					ps.setNull(8, Types.LONGVARCHAR);
				} else {
					ps.setString(8, productsTable.getApp());
				}
				if (productsTable.getSc() == null) {
					ps.setNull(9, Types.LONGVARCHAR);
				} else {
					ps.setString(9, productsTable.getSc());
				}
				if (productsTable.getOc() == null) {
					ps.setNull(10, Types.LONGVARCHAR);
				} else {
					ps.setString(10, productsTable.getOc());
				}
				if (productsTable.getSp() == null) {
					ps.setNull(11, Types.LONGVARCHAR);
				} else {
					ps.setString(11, productsTable.getSp());
				}
				if (productsTable.getEc1Word() == null) {
					ps.setNull(12, Types.VARCHAR);
				} else {
					ps.setString(12, productsTable.getEc1Word());
				}
				if (productsTable.getEc1() == null) {
					ps.setNull(13, Types.VARCHAR);
				} else {
					ps.setString(13, productsTable.getEc1());
				}
				if (productsTable.getEc2Word() == null) {
					ps.setNull(14, Types.VARCHAR);
				} else {
					ps.setString(14, productsTable.getEc2Word());
				}
				if (productsTable.getEc2() == null) {
					ps.setNull(15, Types.VARCHAR);
				} else {
					ps.setString(15, productsTable.getEc2());
				}
				ps.setFloat(16, productsTable.getPublicPrice());
				ps.setFloat(17, productsTable.getBsPrice());
				if (productsTable.getSupplyModel() == null) {
					ps.setNull(18, Types.VARCHAR);
				} else {
					ps.setString(18, productsTable.getSupplyModel());
				}
				if (productsTable.getModelName() == null) {
					ps.setNull(19, Types.VARCHAR);
				} else {
					ps.setString(19, productsTable.getModelName());
				}
				ps.setFloat(20, productsTable.getBsCgPrice());
				if (productsTable.getPPic() == null) {
					ps.setNull(21, Types.VARCHAR);
				} else {
					ps.setString(21, productsTable.getPPic());
				}
				if (productsTable.getKeyWord() == null) {
					ps.setNull(22, Types.VARCHAR);
				} else {
					ps.setString(22, productsTable.getKeyWord());
				}
				if (productsTable.getOrderId() == null) {
					ps.setNull(23, Types.VARCHAR);
				} else {
					ps.setString(23, productsTable.getOrderId());
				}
				if (productsTable.getOther() == null) {
					ps.setNull(24, Types.LONGVARCHAR);
				} else {
					ps.setString(24, productsTable.getOther());
				}
				ps.setInt(25, productsTable.getBrowse());
				ps.setInt(26, productsTable.getAskTimes());
				ps.setInt(27, productsTable.getComTimes());
				if (productsTable.getIsShow() == null) {
					ps.setNull(28, Types.VARCHAR);
				} else {
					ps.setString(28, productsTable.getIsShow());
				}
				ps.setInt(29, productsTable.getSupplyId());
				if (productsTable.getIndexOrder() == null) {
					ps.setNull(30, Types.VARCHAR);
				} else {
					ps.setString(30, productsTable.getIndexOrder());
				}
				if (productsTable.getPDate() == null) {
					ps.setNull(31, Types.VARCHAR);
				} else {
					ps.setString(31, productsTable.getPDate());
				}
				ps.setInt(32, productsTable.getPId());
				returnValue = iCon.executePreUpdate();
				
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：不修改值为null对象的字段,根据提供的列与值，以及修改条件来执行批量修改
	 *
	 * @param productsTable 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int updateSelective(ProductsTable productsTable) {
		this.execStatus = 0;
		int returnValue = 0;
		if (productsTable == null) {
			return -2;
		}
		List<Object> valuesList = new ArrayList<Object>();
		StringBuffer sqlSB = new StringBuffer("UPDATE products_table SET ");
		StringBuffer sqlUpdateSB = new StringBuffer();
		if (productsTable.getPModel() != null) {
			sqlUpdateSB.append(",p_model=?");
			valuesList.add(productsTable.getPModel());
		}
		if (productsTable.getPName() != null) {
			sqlUpdateSB.append(",p_name=?");
			valuesList.add(productsTable.getPName());
		}
		sqlUpdateSB.append(",big_id=?");
		valuesList.add(productsTable.getBigId());

		sqlUpdateSB.append(",small_id=?");
		valuesList.add(productsTable.getSmallId());

		if (productsTable.getSmallStrong() != null) {
			sqlUpdateSB.append(",small_strong=?");
			valuesList.add(productsTable.getSmallStrong());
		}
		if (productsTable.getDetail1() != null) {
			sqlUpdateSB.append(",detail1=?");
			valuesList.add(productsTable.getDetail1());
		}
		if (productsTable.getDetail2() != null) {
			sqlUpdateSB.append(",detail2=?");
			valuesList.add(productsTable.getDetail2());
		}
		if (productsTable.getApp() != null) {
			sqlUpdateSB.append(",app=?");
			valuesList.add(productsTable.getApp());
		}
		if (productsTable.getSc() != null) {
			sqlUpdateSB.append(",sc=?");
			valuesList.add(productsTable.getSc());
		}
		if (productsTable.getOc() != null) {
			sqlUpdateSB.append(",oc=?");
			valuesList.add(productsTable.getOc());
		}
		if (productsTable.getSp() != null) {
			sqlUpdateSB.append(",sp=?");
			valuesList.add(productsTable.getSp());
		}
		if (productsTable.getEc1Word() != null) {
			sqlUpdateSB.append(",ec1_word=?");
			valuesList.add(productsTable.getEc1Word());
		}
		if (productsTable.getEc1() != null) {
			sqlUpdateSB.append(",ec_1=?");
			valuesList.add(productsTable.getEc1());
		}
		if (productsTable.getEc2Word() != null) {
			sqlUpdateSB.append(",ec2_word=?");
			valuesList.add(productsTable.getEc2Word());
		}
		if (productsTable.getEc2() != null) {
			sqlUpdateSB.append(",ec_2=?");
			valuesList.add(productsTable.getEc2());
		}
		sqlUpdateSB.append(",public_price=?");
		valuesList.add(productsTable.getPublicPrice());

		sqlUpdateSB.append(",bs_price=?");
		valuesList.add(productsTable.getBsPrice());

		if (productsTable.getSupplyModel() != null) {
			sqlUpdateSB.append(",supply_model=?");
			valuesList.add(productsTable.getSupplyModel());
		}
		if (productsTable.getModelName() != null) {
			sqlUpdateSB.append(",model_name=?");
			valuesList.add(productsTable.getModelName());
		}
		sqlUpdateSB.append(",bs_cg_price=?");
		valuesList.add(productsTable.getBsCgPrice());

		if (productsTable.getPPic() != null) {
			sqlUpdateSB.append(",p_pic=?");
			valuesList.add(productsTable.getPPic());
		}
		if (productsTable.getKeyWord() != null) {
			sqlUpdateSB.append(",key_word=?");
			valuesList.add(productsTable.getKeyWord());
		}
		if (productsTable.getOrderId() != null) {
			sqlUpdateSB.append(",order_id=?");
			valuesList.add(productsTable.getOrderId());
		}
		if (productsTable.getOther() != null) {
			sqlUpdateSB.append(",other=?");
			valuesList.add(productsTable.getOther());
		}
		sqlUpdateSB.append(",browse=?");
		valuesList.add(productsTable.getBrowse());

		sqlUpdateSB.append(",ask_times=?");
		valuesList.add(productsTable.getAskTimes());

		sqlUpdateSB.append(",com_times=?");
		valuesList.add(productsTable.getComTimes());

		if (productsTable.getIsShow() != null) {
			sqlUpdateSB.append(",is_show=?");
			valuesList.add(productsTable.getIsShow());
		}
		sqlUpdateSB.append(",supply_id=?");
		valuesList.add(productsTable.getSupplyId());

		if (productsTable.getIndexOrder() != null) {
			sqlUpdateSB.append(",index_order=?");
			valuesList.add(productsTable.getIndexOrder());
		}
		if (productsTable.getPDate() != null) {
			sqlUpdateSB.append(",p_date=?");
			valuesList.add(productsTable.getPDate());
		}
		if (valuesList.size() < 1) {
			return -2;
		}
		sqlUpdateSB.delete(0, 1);
		sqlSB.append(sqlUpdateSB);
		sqlSB.append(" WHERE p_id=?");
		valuesList.add(productsTable.getPId());
		try {
			return update(sqlSB.toString(), valuesList.toArray(),null,false);
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据SQL语句与值修改记录,
	 *
	 * @param sql  关于products_table表的SQL语句
	 * @param values 可以为null,但是里面的值不允许有null
	 * 
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String sql, Object[] values) {
		this.execStatus = 0;
		if (sql == null || "".equals(sql)) {
			return -2;
		}
		return update(sql, values, null, false);
	}
	/**
	 * 功能：根据sql语句与对应的值,以及值的类型来修改记录
	 *
	 * @param sql
	 * @param values 要是这个为null,后面的两个参数(valuesSqlType,isContainNullValue)不做检测
	 * @param valuesSqlType  当值中没有null的时候，valuesSqlType这个参数不做检测
	 * @param isContainNullValue true=值中含有null值 false=值中没有有null值
	 *
	 * @return  -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String sql, Object[] values, int[] valuesSqlType, boolean isContainNullValue) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (sql == null || sql.equals("")) {
			return -2;
		}
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			if (isContainNullValue) {
				if (valuesSqlType == null || valuesLength != valuesSqlType.length) {
					return -2;
				}
			} else {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] == null) {
						this.execStatus = -4;
						return -4;
					}
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] == null) {
						ps.setNull(i + 1, valuesSqlType[i]);
					} else {
						if (values[i] instanceof BigDecimal) {
							ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
						} else if ((values[i] instanceof Blob)) {
							ps.setBlob(i + 1, (Blob) values[i]);
						} else if ((values[i] instanceof Boolean)) {
							ps.setBoolean(i + 1, (Boolean) values[i]);
						} else if ((values[i] instanceof Byte)) {
							ps.setByte(i + 1, (Byte) values[i]);
						} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
							ps.setBytes(i + 1, valuesByte);
						} else if (values[i] instanceof Clob) {
							ps.setClob(i + 1, (Clob) values[i]);
						} else if (values[i] instanceof Date) {
							ps.setDate(i + 1, (Date) values[i]);
						} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
							ps.setDate(i + 1, date);
						} else if ((values[i] instanceof Double)) {
							ps.setDouble(i + 1, (Double) values[i]);
						} else if ((values[i] instanceof Float)) {
							ps.setFloat(i + 1, (Float) values[i]);
						} else if ((values[i] instanceof Integer)) {
							ps.setInt(i + 1, (Integer) values[i]);
						} else if ((values[i] instanceof Long)) {
							ps.setLong(i + 1, (Long) values[i]);
						} else if ((values[i] instanceof Short)) {
							ps.setShort(i + 1, (Short) values[i]);
						} else if ((values[i] instanceof String)) {
							ps.setString(i + 1, (String) values[i]);
						} else if ((values[i] instanceof Time)) {
							ps.setTime(i + 1, (Time) values[i]);
						} else if ((values[i] instanceof Timestamp)) {
							ps.setTimestamp(i + 1, (Timestamp) values[i]);
						} else if ((values[i] instanceof URL)) {
							ps.setURL(i + 1, (URL) values[i]);
						} else {
							ps.setObject(i + 1, values[i]);
						}
					}
				}
				returnValue = iCon.executePreUpdate();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据提供的列与值，以及修改条件来执行批量修改
	 *
	 * @param columns 列
	 * @param exeCondition 修改条件 不能为空 WHERE关键字会自动添加上
	 * @param values 可以为null,但是里面的值不允许有null
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String columns, String exeCondition, Object[] values) {
		return update(columns, exeCondition, values, null, false);
	}
	/**
	 * 功能：根据sql语句与对应的值,以及值的类型来修改记录
	 *
	 * @param columns 列
	 * @param exeCondition 修改条件 不能为空 WHERE关键字会自动添加上
	 * @param values 可以为null,但是里面的值不允许有null
	 * @param valuesSqlType 当值中没有null的时候，valuesSqlType这个参数不做检测
	 * @param isContainNullValue true=值中含有null值 false=值中没有有null值
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String columns, String exeCondition, Object[] values, int[] valuesSqlType, boolean isContainNullValue) {
		this.execStatus = 0;
		String sql = "UPDATE products_table ";
		if (columns == null || "".equals(columns.trim())) {
			return -2;
		} else {
			if (exeCondition == null || exeCondition.trim().equals("")) {
				exeCondition = "";
			}
			if (!exeCondition.equals("")) {
				exeCondition = exeCondition.trim();
				String strTemp = exeCondition.toUpperCase();
				if (!strTemp.startsWith("WHERE ")) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.insert(0, "WHERE ");
					exeCondition = exeConditionSB.toString();
				}
			}
			StringBuffer sqlSB = new StringBuffer(sql);
			columns = columns.trim();
			String columnsTmp = columns.toUpperCase();
			if (!columnsTmp.startsWith("SET ")) {
				sqlSB.append("SET ");
			}
			sqlSB.append(columns);
			if (!exeCondition.equals("")) {
				sqlSB.append(' ');
				sqlSB.append(exeCondition);
			}
			sql = sqlSB.toString();
		}
		return update(sql, values, valuesSqlType, isContainNullValue);
	}
	/**
	 * 功能：根据主键删除记录
	 *
	 * @param pId
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int deleteByPK(int pId) {
		int returnValue = 0;
		this.execStatus = 0;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM products_table  WHERE p_id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setInt(1,pId);
				returnValue = iCon.executePreDelete();
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据对象主键删除一条记录
	 *
	 * @param productsTable 删除的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(ProductsTable productsTable) {
		this.execStatus = 0;
		if (productsTable == null) {
			return -2;
		}
		return deleteByPK(productsTable.getPId());
	}
	/**
	 * 功能：根据this.exeCondition条件删除记录,删除条件不能为空 并且必须要有 WHERE关键字,防止删除这个表全部的数据记录<br>

	 *
	 * @param exeCondition 执行条件
	 * @param values 执行条件中对应的值,可以为null,但是里面的值不允许有null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(String exeCondition, Object[] values) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		int valuesLength = 0;
		if (exeCondition == null) {
			return -2;
		}
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return -4;
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM products_table ";
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
				return -2;
			} else {
				String exeConditionTmp = exeCondition.trim().toUpperCase();
				if (!exeConditionTmp.startsWith("WHERE ")) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.insert(0, " WHERE ");
					exeCondition = exeConditionSB.toString();
				}
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				returnValue = iCon.executePreDelete();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据this.exeCondition条件删除记录,删除条件不能为空 并且必须要有 WHERE关键字,防止删除这个表全部的数据记录<br>

	 *
	 * @param exeCondition 执行条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(String exeCondition) {
		this.execStatus = 0;
		if (exeCondition == null) {
			return -2;
		}
		return delete(exeCondition, null);
	}
	/**
	 * 功能：删除表中所有记录<br>

	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete() {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM products_table ";
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				returnValue = iCon.executePreDelete();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据条件统计
	 *
	 * @param columns 统计的列,可以包含数据库的函数
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String columns, String exeCondition, Object[] values) {
		this.execStatus = 0;
		long returnValue = 0;
		ICon iCon = null;
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return -4;
				}
			}
		}
		if (columns == null || columns.trim().equals("")) {
			columns = "*";
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "SELECT COUNT(";
			StringBuffer sqlSB = new StringBuffer(sql);
			sqlSB.append(columns);
			sqlSB.append(") AS countColumn FROM products_table ");
			if (exeCondition == null || "".equals(exeCondition.trim())) {
				sql = sqlSB.toString();
			} else {
				sqlSB.append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				returnValue = iCon.executePreCount();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param columns 统计的列,可以包含数据库的函数
	 * @param exeCondition 条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String columns, String exeCondition) {
		return count(columns, exeCondition, null);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String exeCondition, Object[] values) {
		return count(null, exeCondition, values);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param exeCondition 条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String exeCondition) {
		return count(null, exeCondition, null);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count() {
		return count(null, null, null);
	}
	/**
	 * 功能：根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 * @param pageSize 每页显示的记录数
	 * @param pageNo 页码
	 *
	 * @return 可能返回null的List
	 */
	public List<ProductsTable> getList(String exeCondition, Object[] values, int pageSize, int pageNo) {
		this.execStatus = 0;
		ICon iCon = null;
		boolean isPage = false;
		List<ProductsTable> list = null;
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return null;
				}
			}
		}
		if(exeCondition == null){
			exeCondition = "";
		} else {
			exeCondition = exeCondition.trim();
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM products_table ";
			if (pageSize > 0 && pageNo > 0) {
				int indexLimit = -1;
				String exeConditionTmp = exeCondition;
				if (exeConditionTmp == null) {
					exeCondition = "";
					exeConditionTmp = "";
				} else {
					exeConditionTmp = exeConditionTmp.toUpperCase();
					indexLimit = exeConditionTmp.indexOf(" LIMIT ");
					if (indexLimit < 0) {
						if (exeConditionTmp.startsWith("LIMIT ")) {
							indexLimit = 0;
						}
					}
				}
				if (indexLimit < 0) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.append(" LIMIT ?,?");
					exeCondition = exeConditionSB.toString();
					isPage = true;
				}
			}
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
			} else {
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				int i = 0;
				for (; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				if (isPage) {
					ps.setInt(i + 1, (pageNo - 1) * pageSize);
					ps.setInt(i + 2, pageSize);
				}
				ResultSet rs = iCon.executePreSelect();
				ProductsTable productsTable;
				if (rs != null && rs.next()) {
					list = new ArrayList<ProductsTable>();
					do {
						productsTable = new ProductsTable();
						setFieldFromRs(productsTable, rs);
						list.add(productsTable);
					} while (rs.next());
				}
				this.execStatus = 1;
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return list;
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return 可能返回null的List
	 */
	public List<ProductsTable> getList(String exeCondition, Object[] values) {
		return getList(exeCondition, values, 0, 0);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param pageSize 每页显示的记录数
	 * @param pageNo 页码
	 *
	 * @return 可能返回null的List
	 */
	public List<ProductsTable> getList(String exeCondition, int pageSize, int pageNo) {
		return getList(exeCondition, null, pageSize, pageNo);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 *
	 * @return 可能返回null的List
	 */
	public List<ProductsTable> getList(String exeCondition) {
		return getList(exeCondition, null, 0, 0);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @return 可能返回null的List
	 */
	public List<ProductsTable> getList() {
		return getList(null, null, 0, 0);
	}
	/**
	 * 功能：重置类变量dataBasePool数据库名称以及execStatus执行状态
	 */
	public void reset() {
		setExecStatus(0);
	}
	/**
	 * 功能：获取类变量execStatus执行状态
	 */
	public int getExecStatus() {
		return execStatus;
	}
	/**
	 * 功能：设置类变量execStatus执行状态
	 */
	public void setExecStatus(int execStatus) {
		this.execStatus = execStatus;
	}
}