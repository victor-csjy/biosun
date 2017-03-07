package hk.com.biosun.cache;

import hk.com.biosun.dao.SupplyTableDAO;
import hk.com.biosun.dao.impl.SupplyTableDAOImpl;
import hk.com.biosun.model.SupplyTable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

public class SupplyTableCache implements ICacheSimple<SupplyTable> {
	private static Logger lOG = Logger.getLogger(SupplyTableCache.class);

	private static SupplyTableCache instance = new SupplyTableCache();
	private HashMap<String, SupplyTable> hashMap = new HashMap<String, SupplyTable>();
	private long intervalTime = 24 * 60 * 60 * 1000;
	private long lastInitDataTime = 0; // 上次成功读库的时间

	private SupplyTableCache() {
	}

	public static SupplyTableCache getInstance() {
		return instance;
	}

	public SupplyTable get(int supplyId) {
		return get(String.valueOf(supplyId));
	}

	public SupplyTable get(String key) {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			this.reload();
		}
		if (key == null || "".equals(key.trim())) {
			return null;
		}
		if (hashMap.size() > 0) {
			SupplyTable supplyTable = hashMap.get(key.trim());
			return supplyTable;
		} else {
			return null;
		}
	}

	/**
	 * 返回的是表中所有的数据
	 */
	public List<SupplyTable> getList() {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			reload();
		}
		List<SupplyTable> list = new ArrayList<SupplyTable>();
		for (SupplyTable supplyTable : hashMap.values()) {
			list.add(supplyTable);
		}
		return list;
	}

	public synchronized void init() {
		hashMap.clear();// 重新初始化
		try {
			SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
			List<SupplyTable> list = supplyTableDAO.getList();

			SupplyTable supplyTable = null;
			int listSize = list != null ? list.size() : 0;
			for (int i = 0; i < listSize; i++) {
				supplyTable = (SupplyTable) list.get(i);
				hashMap.put(String.valueOf(supplyTable.getSupplyId()),
						supplyTable);
			}
			if (list == null) {
				lOG.error(" init() error!缓存无法从数据库SupplyTable表中获取数据.");
			} else {
				lastInitDataTime = System.currentTimeMillis();
				lOG.debug("init() successful!");
			}
		} catch (Exception e) {
			lOG.error(e);
		}
	}

	public void reload() {
		init();
	}

	public int size() {
		return hashMap.size();
	}
}
