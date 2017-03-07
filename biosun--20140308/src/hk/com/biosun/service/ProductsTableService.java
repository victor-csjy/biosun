package hk.com.biosun.service;

import hk.com.biosun.dao.ProductsTableDAO;
import hk.com.biosun.dao.impl.ProductsTableDAOImpl;
import hk.com.biosun.model.ProductsTable;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.util.FileUtil;
import com.aokle.util.ImageZoom;
import com.aokle.util.PathUtil;

public class ProductsTableService {
	private static Logger LOG = Logger.getLogger(ProductsTableService.class);

	public ProductsTable getByPK(int pId) {
		if (pId < 1) {
			return null;
		} else {
			ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
			return productsTableDAO.selectByPK(pId);
		}
	}

	public ProductsTable getByPKFront(int pId) {
		ProductsTable productsTable = getByPK(pId);
		if (productsTable == null || "0".equals(productsTable.getIsShow())) {
			return null;
		} else {
			return productsTable;
		}
	}

	public int getCountFront(int bigId, int smallId, String keyWord) {
		StringBuffer exeConditionSB = new StringBuffer();
		List<Object> valuesList = new ArrayList<Object>();

		if (bigId > 0) {
			exeConditionSB.append(" AND big_id=?");
			valuesList.add(bigId);
		}
		if (smallId > 0) {
			exeConditionSB.append(" AND small_id=?");
			valuesList.add(smallId);
		}

		exeConditionSB.append(" AND is_show='1' ");

		if (keyWord != null && !"".equals(keyWord) && !"\\%".equals(keyWord)
				&& !"\\?".equals(keyWord)) {
			exeConditionSB.append(" AND key_word LIKE '%?%'");
			valuesList.add(keyWord);
		}
		exeConditionSB.delete(0, 4);
		exeConditionSB.insert(0, "WHERE");
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return (int) productsTableDAO.count("*", exeConditionSB.toString(),
				valuesList.toArray());
	}

	public List<ProductsTable> getListFront(int bigId, int smallId,
			String keyWord, int pageSize, int pageNo) {
		return getListFront(bigId, smallId, keyWord, "order_id,p_date DESC",
				pageSize, pageNo);
	}

	public List<ProductsTable> getListFront(int bigId, int smallId,
			String keyWord, String orderBy, int pageSize, int pageNo) {
		if (pageNo < 1) {
			pageNo = 1;
		}
		if (pageSize < 1) {
			pageSize = 1;
		}
		if (pageSize > 5000) {
			pageSize = 5000;
		}
		StringBuffer exeConditionSB = new StringBuffer();
		List<Object> valuesList = new ArrayList<Object>();
		if (bigId > 0) {
			exeConditionSB.append(" AND big_id=?");
			valuesList.add(bigId);
		}
		if (smallId > 0) {
			exeConditionSB.append(" AND small_id=?");
			valuesList.add(smallId);
		}

		exeConditionSB.append(" AND is_show='1'");

		if (keyWord != null && !"".equals(keyWord) && !"\\%".equals(keyWord)
				&& !"\\?".equals(keyWord)) {
			exeConditionSB.append(" AND key_word LIKE '%?%'");
			valuesList.add(keyWord);
		}
		if (orderBy == null || "".equals(orderBy)) {
			orderBy = "order_id,p_date DESC";
		}
		exeConditionSB.append(" ORDER BY ").append(orderBy);
		exeConditionSB.delete(0, 4);
		exeConditionSB.insert(0, "WHERE");
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO.getList(exeConditionSB.toString(), valuesList
				.toArray(), pageSize, pageNo);
	}

	public int updateBrowseTimes(int productsTableId, int span) {
		if (productsTableId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { span, productsTableId };
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		sql = "UPDATE products_table SET browse=browse+? WHERE p_id=?";
		return productsTableDAO.update(sql, values);
	}

	public int updateComTimes(int productsTableId, int span) {
		if (productsTableId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { span, productsTableId };
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		sql = "UPDATE products_table SET com_times=com_times+? WHERE p_id=?";
		return productsTableDAO.update(sql, values);
	}

	public int updateAskTimes(int productsTableId, int span) {
		if (productsTableId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { span, productsTableId };
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		sql = "UPDATE products_table SET ask_times=ask_times+? WHERE p_id=?";
		return productsTableDAO.update(sql, values);
	}

	public int deleteBySupplyId(int supplyId) {
		if (supplyId < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO.delete("WHERE supply_id=?",
				new Object[] { supplyId });
	}

	public int deleteByBigId(int bigId) {
		if (bigId < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO
				.delete("WHERE big_Id=?", new Object[] { bigId });
	}

	public int deleteBySmallId(int smallId) {
		if (smallId < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO.delete("WHERE small_id=?",
				new Object[] { smallId });
	}

	public int updateClass(int bigIdOrient, int smallIdOrient, int bigIdNew,
			int smallIdNew) {
		if (bigIdOrient < 1 || smallIdOrient < 1 || bigIdNew < 1
				|| smallIdNew < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO.update("big_id=?,small_id=?",
				"WHERE big_id=? AND small_id=?", new Object[] { bigIdNew,
						smallIdNew, bigIdOrient, smallIdOrient });
	}

	public int add(String p_model, String p_name, int big_id, int small_id,
			String small_strong, String detail1, String detail2, String app,
			String sc, String oc, String sp, String ec1_word, String ec_1,
			String ec2_word, String ec_2, float public_price, float bs_price,
			String supply_model, String model_name, float bs_cg_price,
			String p_pic, String key_word, String order_id, String other,
			int browse, int ask_times, int com_times, String is_show,
			int supply_id, String index_order, String p_date) {
		if ("".equals(p_name) || big_id < 1 || small_id < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		ProductsTable productsTable = new ProductsTable();

		productsTable.setPModel(p_model);
		productsTable.setPName(p_name);
		productsTable.setBigId(big_id);
		productsTable.setSmallId(small_id);
		productsTable.setSmallStrong(small_strong);

		productsTable.setDetail1(detail1);
		productsTable.setDetail2(detail2);
		productsTable.setApp(app);
		productsTable.setSc(sc);
		productsTable.setOc(oc);

		productsTable.setSp(sp);
		productsTable.setEc1Word(ec1_word);
		productsTable.setEc1(ec_1);
		productsTable.setEc2Word(ec2_word);
		productsTable.setEc2(ec_2);

		productsTable.setPublicPrice(public_price);
		productsTable.setBsPrice(bs_price);
		productsTable.setSupplyModel(supply_model);
		productsTable.setModelName(model_name);
		productsTable.setBsCgPrice(bs_cg_price);

		productsTable.setPPic(p_pic);
		productsTable.setKeyWord(key_word);
		productsTable.setOrderId(order_id);
		productsTable.setOther(other);
		productsTable.setBrowse(browse);

		productsTable.setAskTimes(ask_times);
		productsTable.setComTimes(com_times);
		productsTable.setIsShow(is_show);
		productsTable.setSupplyId(supply_id);
		productsTable.setIndexOrder(index_order);

		productsTable.setPDate(p_date);

		return productsTableDAO.insert(productsTable);
	}

	public int update(int p_id, String p_model, String p_name, int big_id,
			int small_id, String small_strong, String detail1, String detail2,
			String app, String sc, String oc, String sp, String ec1_word,
			String ec_1, String ec2_word, String ec_2, float public_price,
			float bs_price, String supply_model, String model_name,
			float bs_cg_price, String p_pic, String key_word, String order_id,
			String other, int browse, int ask_times, int com_times,
			String is_show, int supply_id, String index_order, String p_date) {

		if (p_id < 1 || "".equals(p_name) || big_id < 1 || small_id < 1) {
			return -1;
		}

		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		ProductsTable productsTable = new ProductsTable();

		productsTable.setPId(p_id);
		productsTable.setPModel(p_model);
		productsTable.setPName(p_name);
		productsTable.setBigId(big_id);
		productsTable.setSmallId(small_id);
		productsTable.setSmallStrong(small_strong);

		productsTable.setDetail1(detail1);
		productsTable.setDetail2(detail2);
		productsTable.setApp(app);
		productsTable.setSc(sc);
		productsTable.setOc(oc);

		productsTable.setSp(sp);
		productsTable.setEc1Word(ec1_word);
		productsTable.setEc1(ec_1);
		productsTable.setEc2Word(ec2_word);
		productsTable.setEc2(ec_2);

		productsTable.setPublicPrice(public_price);
		productsTable.setBsPrice(bs_price);
		productsTable.setSupplyModel(supply_model);
		productsTable.setModelName(model_name);
		productsTable.setBsCgPrice(bs_cg_price);

		productsTable.setPPic(p_pic);
		productsTable.setKeyWord(key_word);
		productsTable.setOrderId(order_id);
		productsTable.setOther(other);
		productsTable.setBrowse(browse);

		productsTable.setAskTimes(ask_times);
		productsTable.setComTimes(com_times);
		productsTable.setIsShow(is_show);
		productsTable.setSupplyId(supply_id);
		productsTable.setIndexOrder(index_order);

		productsTable.setPDate(p_date);

		return productsTableDAO.update(productsTable);
	}

	public int deleteByPk(int pId) {
		if (pId < 1) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		return productsTableDAO.deleteByPK(pId);
	}

	public int getCount(String exeCondition, List<Object> valuesList) {
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) productsTableDAO.count("*", exeCondition);
		}
		return (int) productsTableDAO.count("*", exeCondition, valuesList
				.toArray());

	}

	public List<ProductsTable> getList(String exeCondition,
			List<Object> valuesList, int pageSize, int pageNo) {
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		if (pageSize > 500) {
			pageSize = 500;
		}
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return productsTableDAO.getList(exeCondition, null, pageSize,
					pageNo);
		}
		return productsTableDAO.getList(exeCondition, valuesList.toArray(),
				pageSize, pageNo);
	}

	public int zoomPic(String picName) {
		int result = 0;
		if (picName == null || "".equals(picName)) {
			return -1;
		}
		ImageZoom imageZoom = new ImageZoom();
		String realPath = PathUtil.getRealPath();

		try {
			imageZoom.zoom(realPath + "product/pic/" + picName, realPath
					+ "product/pic/small" + picName, 318, 227, 1, 1);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return result;
	}

	public int deleteEc(int p_id, String ecColumn, String ecName) {
		if (p_id < 1 || ecName == null || "".equals(ecName) || ecColumn == null
				|| "".equals(ecColumn)) {
			return -1;
		}
		ProductsTableDAO productsTableDAO = new ProductsTableDAOImpl();
		int result = productsTableDAO.update(ecColumn + "=?", "WHERE p_id=?",
				new Object[] { "", p_id });
		if (result > 0) {
			FileUtil
					.deleteFile(PathUtil.getRealPath() + "product/ec/" + ecName);
		}
		return result;
	}

	public static void main(String[] args) {
		String keyWord = "";
		if (keyWord != null && !"".equals(keyWord) && !"\\%".equals(keyWord)
				&& !"\\?".equals(keyWord)) {
			System.out.println(keyWord);
		} else {
			System.out.println("keyWord==null");
		}
	}
}
