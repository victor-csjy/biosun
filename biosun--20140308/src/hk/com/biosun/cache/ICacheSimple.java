package hk.com.biosun.cache;

import java.util.List;

/**
 * 功能：缓存接口
 * 
 * @author qinyongcai
 */
public interface ICacheSimple<V> {
	void init();// 初始化
	void reload();// 刷新
	V get(String key);// 通过key获取对应的对象
	List<V> getList();// 获取所有的对象
	int size();

	/**
	 * 功能：添加一个对象 以下的方法只有数据 不是 从数据库中加载时才真正的去实现，否则都调用 reload()方法
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=添加失败 1=添加成功 2=对象已经存在（并且成功添加） int add(String key, ICache
	 *         iCache); // 添加某个对象 先删除再添加
	 * 
	 * 功能：修改一个对象 以下的方法只有数据 不是 从数据库中加载时才真正的去实现，否则都调用 reload()方法
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=修改失败 1=修改成功 2=对象已经存在（并且成功修改） boolean update(String key, ICache
	 *         iCache);// 修改某个对象,没有就添加 先删除再添加
	 * 
	 * 功能：删除一个对象 以下的方法只有数据 不是 从数据库中加载时才真正的去实现，否则都调用 reload()方法
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=删除失败 1=删除成功 2=对象不存在
	 * 
	 * int delete(String key, ICache iCache); // 删除某个对象
	 */
}
