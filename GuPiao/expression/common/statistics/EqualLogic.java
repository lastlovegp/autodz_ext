package common.statistics;

/**
 * User: caiyuan Date: 2011/11/01 17:59
 */
public class EqualLogic implements Function {

	// 布尔相等
	public boolean orArray(Boolean[] bs) {
		boolean fb = bs[0];
		for (Boolean b : bs) {
			fb = fb || b;
		}
		return fb;
	}

	// 布尔相等
	public boolean andArray(Boolean[] bs) {
		boolean fb = bs[0];
		for (Boolean b : bs) {
			fb = fb && b;
		}
		return fb;
	}

	// 布尔相等
	public boolean or(boolean a, boolean b) {
		return a || b;
	}

	// 布尔相等
	public boolean and(boolean a, boolean b) {
		return a && b;
	}

	// 取反
	public boolean reverse(boolean a) {
		return !a;
	}

}
