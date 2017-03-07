package hk.com.biosun.cache;

import hk.com.biosun.dao.BigTableDAO;
import hk.com.biosun.dao.impl.BigTableDAOImpl;
import hk.com.biosun.model.BigTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.util.MathUtil;

public class BigTableCache implements ICacheSimple<BigTable> {
	private static Logger lOG = Logger.getLogger(BigTableCache.class);

	private static BigTableCache instance = new BigTableCache();
	private HashMap<String, BigTable> hashMap = new HashMap<String, BigTable>();
	private long intervalTime = 24 * 60 * 60 * 1000;
	private long lastInitDataTime = 0; // 上次成功读库的时间

	private BigTableCache() {
	}

	public static BigTableCache getInstance() {
		return instance;
	}
	public BigTable get(int bigId) {
		return get(String.valueOf(bigId));
	}

	public BigTable get(String key) {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			this.reload();
		}
		if (key == null || "".equals(key.trim())) {
			return null;
		}
		if (hashMap.size() > 0) {
			BigTable bigTable = hashMap.get(key.trim());
			return bigTable;
		} else {
			return null;
		}
	}
	/**
	 * 返回的是表中所有的数据
	 */
	public List<BigTable> getList() {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			reload();
		}
		List<BigTable> list = new ArrayList<BigTable>();
		int i = 0;
		int j = 0;
		int hashMapSize = hashMap.size();
		Iterator<String> iteratorKey = hashMap.keySet().iterator();
		String[] keyArr = new String[hashMapSize];
		int[] orderIdArr = new int[hashMapSize];
		BigTable bigTable = null;
		for (i=0;iteratorKey.hasNext();i++) {
			keyArr[i] = (String) iteratorKey.next();
			bigTable = hashMap.get(keyArr[i]);
			orderIdArr[i] = MathUtil.toInt(bigTable.getBigOrder());
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
			BigTableDAO bigTableDAO = new BigTableDAOImpl();
			List<BigTable> list=bigTableDAO.getList();
			
			BigTable bigTable = null;
			int listSize = list != null ? list.size() : 0;
			for (int i = 0; i < listSize; i++) {
				bigTable = (BigTable) list.get(i);
				hashMap.put(String.valueOf(bigTable.getBigId()), bigTable);
			}
			if (list == null) {
				lOG.error(" init() error!缓存无法从数据库BigTable表中获取数据.");
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
