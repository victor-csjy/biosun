package hk.com.biosun.cache;

import hk.com.biosun.dao.SmallTableDAO;
import hk.com.biosun.dao.impl.SmallTableDAOImpl;
import hk.com.biosun.model.SmallTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.util.MathUtil;

public class SmallTableCache implements ICacheSimple<SmallTable> {
	private static Logger lOG = Logger.getLogger(SmallTableCache.class);

	private static SmallTableCache instance = new SmallTableCache();
	private HashMap<String, SmallTable> hashMap = new HashMap<String, SmallTable>();
	private long intervalTime = 24 * 60 * 60 * 1000;
	private long lastInitDataTime = 0; // 上次成功读库的时间

	private SmallTableCache() {
	}

	public static SmallTableCache getInstance() {
		return instance;
	}
	public SmallTable get(int smallId) {
		return get(String.valueOf(smallId));
	}

	public SmallTable get(String key) {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			this.reload();
		}
		if (key == null || "".equals(key.trim())) {
			return null;
		}
		if (hashMap.size() > 0) {
			SmallTable smallTable = hashMap.get(key.trim());
			return smallTable;
		} else {
			return null;
		}
	}
	/**
	 * 返回的是表中所有的数据
	 */
	public List<SmallTable> getList() {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			reload();
		}
		List<SmallTable> list = new ArrayList<SmallTable>();
		int i = 0;
		int j = 0;
		int hashMapSize = hashMap.size();
		Iterator<String> iteratorKey = hashMap.keySet().iterator();
		String[] keyArr = new String[hashMapSize];
		int[] orderIdArr = new int[hashMapSize];
		SmallTable smallTable = null;
		for (i = 0; iteratorKey.hasNext(); i++) {
			keyArr[i] = (String) iteratorKey.next();
			smallTable = hashMap.get(keyArr[i]);
			orderIdArr[i] = MathUtil.toInt(smallTable.getSmallOrder());
		}
		// 排序 keyArr[]处理后成升序
		String strTemp = "";
		int orderIdTemp = 0;
		for (i = 0; i < hashMapSize - 1; i++) {// 快速排序
			for (j = i + 1; j < hashMapSize; j++) {
				if (orderIdArr[i] > orderIdArr[j]) {// 交换
					orderIdTemp = orderIdArr[i];
					orderIdArr[i] = orderIdArr[j];
					orderIdArr[j] = orderIdTemp;
					strTemp = keyArr[i];
					keyArr[i] = keyArr[j];
					keyArr[j] = strTemp;
				}
			}
		}
		// 返回升序的
		for (i = 0; i < hashMapSize; i++) {
			list.add(hashMap.get(keyArr[i]));
		}
		return list;
	}

	public synchronized void init() {
		hashMap.clear();// 重新初始化
		try {
			SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
			List<SmallTable> list = smallTableDAO.getList();
			SmallTable smallTable = null;
			int listSize = list != null ? list.size() : 0;
			for (int i = 0; i < listSize; i++) {
				smallTable = (SmallTable) list.get(i);
				hashMap
						.put(String.valueOf(smallTable.getSmallId()),
								smallTable);
			}
			if (list == null) {
				lOG.error(" init() error!缓存无法从数据库SmallTable表中获取数据.");
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
