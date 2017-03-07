package hk.com.biosun.cache;

public class QuartzTime {
	public static boolean isReload(long lastInitDataTime, long intervalTime) {
		if (System.currentTimeMillis() - lastInitDataTime > intervalTime) {
			return true;
		} else {
			return false;
		}
	}
}
