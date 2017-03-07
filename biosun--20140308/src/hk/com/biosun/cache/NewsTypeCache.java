package hk.com.biosun.cache;

import hk.com.biosun.dao.NewsTypeDAO;
import hk.com.biosun.dao.impl.NewsTypeDAOImpl;
import hk.com.biosun.model.NewsType;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.util.MathUtil;

public class NewsTypeCache implements ICacheSimple<NewsType> {
	private static Logger lOG = Logger.getLogger(NewsTypeCache.class);

	private static NewsTypeCache instance = new NewsTypeCache();
	private HashMap<String, NewsType> hashMap = new HashMap<String, NewsType>();
	private long intervalTime = 24 * 60 * 60 * 1000;
	private long lastInitDataTime = 0; // 上次成功读库的时间

	private NewsTypeCache() {
	}

	public static NewsTypeCache getInstance() {
		return instance;
	}

	public NewsType get(int newsType) {
		return get(String.valueOf(newsType));
	}
	public NewsType get(String key) {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			this.reload();
		}
		if (key == null || "".equals(key.trim())) {
			return null;
		}
		if (hashMap.size() > 0) {
			NewsType newsType = hashMap.get(key.trim());
			return newsType;
		} else {
			return null;
		}
	}

	public List<NewsType> getList() {
		if (QuartzTime.isReload(lastInitDataTime, intervalTime)) {
			reload();
		}
		List<NewsType> list = new ArrayList<NewsType>();
		int i = 0;
		int j = 0;
		int hashMapSize = hashMap.size();
		Iterator<String> iteratorKey = hashMap.keySet().iterator();
		String[] keyArr = new String[hashMapSize];
		int[] orderIdArr = new int[hashMapSize];
		NewsType newsType = null;
		for (i=0;iteratorKey.hasNext();i++) {
			keyArr[i] = (String) iteratorKey.next();
			newsType = hashMap.get(keyArr[i]);
			orderIdArr[i] = MathUtil.toInt(newsType.getOrderId());
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
			NewsTypeDAO newsTypeDAO = new NewsTypeDAOImpl();
			List<NewsType> list = newsTypeDAO.getList();
			NewsType newsType = null;
			int listSize = list != null ? list.size() : 0;
			for (int i = 0; i < listSize; i++) {
				newsType = (NewsType) list.get(i);
				hashMap.put(String.valueOf(newsType.getNewsType()), newsType);
			}
			if (list == null) {
				lOG.error(" init() error!缓存无法从数据库NewsType表中获取数据.");
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
