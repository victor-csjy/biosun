package hk.com.biosun.cache;

import java.util.List;

/**
 * ���ܣ�����ӿ�
 * 
 * @author qinyongcai
 */
public interface ICacheSimple<V> {
	void init();// ��ʼ��
	void reload();// ˢ��
	V get(String key);// ͨ��key��ȡ��Ӧ�Ķ���
	List<V> getList();// ��ȡ���еĶ���
	int size();

	/**
	 * ���ܣ����һ������ ���µķ���ֻ������ ���� �����ݿ��м���ʱ��������ȥʵ�֣����򶼵��� reload()����
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=���ʧ�� 1=��ӳɹ� 2=�����Ѿ����ڣ����ҳɹ���ӣ� int add(String key, ICache
	 *         iCache); // ���ĳ������ ��ɾ�������
	 * 
	 * ���ܣ��޸�һ������ ���µķ���ֻ������ ���� �����ݿ��м���ʱ��������ȥʵ�֣����򶼵��� reload()����
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=�޸�ʧ�� 1=�޸ĳɹ� 2=�����Ѿ����ڣ����ҳɹ��޸ģ� boolean update(String key, ICache
	 *         iCache);// �޸�ĳ������,û�о���� ��ɾ�������
	 * 
	 * ���ܣ�ɾ��һ������ ���µķ���ֻ������ ���� �����ݿ��м���ʱ��������ȥʵ�֣����򶼵��� reload()����
	 * 
	 * @param key
	 * @param iCache
	 * @return 0=ɾ��ʧ�� 1=ɾ���ɹ� 2=���󲻴���
	 * 
	 * int delete(String key, ICache iCache); // ɾ��ĳ������
	 */
}
