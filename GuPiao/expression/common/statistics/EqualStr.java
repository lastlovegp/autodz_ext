package common.statistics;

import java.util.Arrays;

/**
 * User: caiyuan Date: 2011/11/01 17:59
 */
public class EqualStr implements Function {

	// 字符串相等
	public boolean eqsArray(String[] strs) {
		String fstr = strs[0];
		boolean isEqual = false;
		for (String str : strs) {
			if (str.equals(fstr)) {
				fstr = str;
				isEqual = true;
			} else {
				fstr = str;
				isEqual = false;
			}
		}
		return isEqual;
	}

	// 字符串相等
	public boolean eqs(String a, String b) {
		boolean isEqual = false;
		if (a.equals(b)) {
			isEqual = true;
		}
		return isEqual;
	}

	// 字符串不相等
	public boolean notEqs(String a, String b) {
		boolean isEqual = false;
		if (!a.equals(b)) {
			isEqual = true;
		}
		return isEqual;
	}

	// 包含
	public boolean in(String a, String b) {
		return Arrays.asList(b.split(",")).contains(a);
	}

	// 包含
	public boolean notIn(String a, String b) {
		return !Arrays.asList(b.split(",")).contains(a);
	}

	// 包含
	public boolean nin(String a, String[] strs) {
		return Arrays.asList(strs).contains(a);
	}

	// 不包含
	public boolean nnotIn(String a, String[] strs) {
		return !Arrays.asList(strs).contains(a);
	}

}
