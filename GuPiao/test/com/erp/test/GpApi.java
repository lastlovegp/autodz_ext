package com.erp.test;

import com.sun.jna.Native;
import com.sun.jna.win32.StdCallLibrary;

public class GpApi {

	public static int keep_time = 300; // 延时时间
	public final static int MOUSEEVENTF_MOVE = 0x0001; // 移动鼠标
	public final static int MOUSEEVENTF_LEFTDOWN = 0x0002; // 模拟鼠标左键按下
	public final static int MOUSEEVENTF_LEFTUP = 0x0004; // 模拟鼠标左键抬起
	public final static int MOUSEEVENTF_RIGHTDOWN = 0x0008; // 模拟鼠标右键按下
	public final static int MOUSEEVENTF_RIGHTUP = 0x0010; // 模拟鼠标右键抬起
	public final static int MOUSEEVENTF_MIDDLEDOWN = 0x0020; // 模拟鼠标中键按下
	public final static int MOUSEEVENTF_MIDDLEUP = 0x0040; // 模拟鼠标中键抬起
	public final static int MOUSEEVENTF_ABSOLUTE = 0x8000;// 标示是否采用绝对坐标
	
	public interface User32 extends StdCallLibrary {
		User32 INSTANCE = (User32) Native.loadLibrary("User32", User32.class);// 加载系统User32
																				// DLL文件，也可以是C++写的DLL文件

		int mouse_event(int dwFlags, int dx, int dy, int cButtons,
				int dwExtraInfo);

		void keybd_event(byte bVk, // 虚拟键值
				byte bScan,// 一般为0
				int dwFlags, // 这里是整数类型 0 为按下，2为释放
				int dwExtraInfo // 这里是整数类型 一般情况下设成为 0
		);
	}

	/**
	 * 输入股票代码
	 * 
	 * @throws InterruptedException
	 * */
	public static void inputCode(String code) throws InterruptedException {
		// 输入股票代码
		int kn = 0;
		for (int i = 0; i < code.length(); i++) {
			kn = Integer.parseInt(String.valueOf(code.toCharArray()[i]));
			switch (kn) {
			default:
				break;
			case 0:
				User32.INSTANCE.keybd_event((byte) Keys.D0, (byte) 0, 0, 0);
				break;
			case '.':
				 User32.INSTANCE.keybd_event((byte)Keys.Decimal,(byte)  0, 0, 0); 
                 break;
			case 1:
				User32.INSTANCE.keybd_event((byte) Keys.D1, (byte) 0, 0, 0);
				break;
			case 2:
				User32.INSTANCE.keybd_event((byte) Keys.D2, (byte) 0, 0, 0);
				break;
			case 3:
				User32.INSTANCE.keybd_event((byte) Keys.D3, (byte) 0, 0, 0);
				break;
			case 4:
				User32.INSTANCE.keybd_event((byte) Keys.D4, (byte) 0, 0, 0);
				break;
			case 5:
				User32.INSTANCE.keybd_event((byte) Keys.D5, (byte) 0, 0, 0);
				break;
			case 6:
				User32.INSTANCE.keybd_event((byte) Keys.D6, (byte) 0, 0, 0);
				break;
			case 7:
				User32.INSTANCE.keybd_event((byte) Keys.D7, (byte) 0, 0, 0);
				break;
			case 8:
				User32.INSTANCE.keybd_event((byte) Keys.D8, (byte) 0, 0, 0);
				break;
			case 9:
				User32.INSTANCE.keybd_event((byte) Keys.D9, (byte) 0, 0, 0);
				break;
			}

			Thread.sleep(50);
		}
	}
	
	public static void inputNum(String num) throws InterruptedException {
		// 输入股票代码
		int kn = 0;
		for (int i = 0; i < num.length(); i++) {
			kn = Integer.parseInt(String.valueOf(num.toCharArray()[i]));
			switch (kn) {
			default:
				break;
			case 0:
				User32.INSTANCE.keybd_event((byte) Keys.D0, (byte) 0, 0, 0);
				break;
			case '.':
				 User32.INSTANCE.keybd_event((byte)Keys.Decimal,(byte)  0, 0, 0); 
                 break;
			case 1:
				User32.INSTANCE.keybd_event((byte) Keys.D1, (byte) 0, 0, 0);
				break;
			case 2:
				User32.INSTANCE.keybd_event((byte) Keys.D2, (byte) 0, 0, 0);
				break;
			case 3:
				User32.INSTANCE.keybd_event((byte) Keys.D3, (byte) 0, 0, 0);
				break;
			case 4:
				User32.INSTANCE.keybd_event((byte) Keys.D4, (byte) 0, 0, 0);
				break;
			case 5:
				User32.INSTANCE.keybd_event((byte) Keys.D5, (byte) 0, 0, 0);
				break;
			case 6:
				User32.INSTANCE.keybd_event((byte) Keys.D6, (byte) 0, 0, 0);
				break;
			case 7:
				User32.INSTANCE.keybd_event((byte) Keys.D7, (byte) 0, 0, 0);
				break;
			case 8:
				User32.INSTANCE.keybd_event((byte) Keys.D8, (byte) 0, 0, 0);
				break;
			case 9:
				User32.INSTANCE.keybd_event((byte) Keys.D9, (byte) 0, 0, 0);
				break;
			}
			
			Thread.sleep(50);
		}
	}

	/**
	 * 卖出
	 * @throws InterruptedException 
	 * */
	public static int sellOut(String code, double price, int cnt) throws InterruptedException {

		System.setProperty("jna.encoding", "GBK");// 设置编码，防止乱码
		
		//回车下
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte)0, 0, 0);
		Thread.sleep(keep_time);

		// 卖出
		User32.INSTANCE.mouse_event(MOUSEEVENTF_ABSOLUTE | MOUSEEVENTF_MOVE,
				1745, 7800, 0, 0);
		User32.INSTANCE.mouse_event(MOUSEEVENTF_LEFTDOWN | MOUSEEVENTF_LEFTUP,
				1, 1, 0, 0);
		Thread.sleep(keep_time);

		// 输入股票代码
		inputCode(code);
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte) 0, 0, 0);
		Thread.sleep(keep_time);

		//价格默认
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte) 0, 0, 0);
		Thread.sleep(keep_time);

		// 股票数量
		//inputCode(String.valueOf(cnt));
		//Thread.sleep(keep_time);
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte) 0, 0, 0);
		Thread.sleep(keep_time);

		//下单
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte) 0, 0, 0);
		Thread.sleep(keep_time);
		
		//交易确认
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte) 0, 0, 0);		
		Thread.sleep(keep_time);
		
		//移到别的地方       
        User32.INSTANCE.mouse_event(MOUSEEVENTF_ABSOLUTE
				| MOUSEEVENTF_MOVE, 1745, 20000, 0, 0);
		User32.INSTANCE.mouse_event(MOUSEEVENTF_LEFTDOWN
				| MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

		return 0;
	}

	/**
	 * 买入
	 * @throws InterruptedException 
	 * */
	public static int buyIn(String code, double price, int cnt) throws InterruptedException {
		
		//回车下
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte)0, 0, 0);
		Thread.sleep(keep_time);
		
		// 买入
		User32.INSTANCE.mouse_event(MOUSEEVENTF_ABSOLUTE
				| MOUSEEVENTF_MOVE, 1745, 5800, 0, 0);
		User32.INSTANCE.mouse_event(MOUSEEVENTF_LEFTDOWN
				| MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

		Thread.sleep(keep_time);

		// 输入股票代码
		inputCode(code);
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte)0, 0, 0);
		Thread.sleep(keep_time);

		// 价格默认
		User32.INSTANCE.keybd_event((byte) Keys.Enter,(byte) 0, 0, 0);
		Thread.sleep(keep_time);

		// 数量
		inputCode(String.valueOf(cnt));		
		User32.INSTANCE.keybd_event((byte) Keys.Enter,(byte) 0, 0, 0);
		Thread.sleep(keep_time);

		// 交易确认
		User32.INSTANCE.keybd_event((byte) Keys.Enter, (byte)0, 0, 0);
		Thread.sleep(keep_time);			
		
		//移到别的地方       
        User32.INSTANCE.mouse_event(MOUSEEVENTF_ABSOLUTE
				| MOUSEEVENTF_MOVE, 1745, 20000, 0, 0);
		User32.INSTANCE.mouse_event(MOUSEEVENTF_LEFTDOWN
				| MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

		return 0;
	}

	public static void main(String[] args) throws Exception {
	    buyIn("600507", 0, 200);
	    sellOut("600507", 0, 200);
		//Thread.sleep(keep_time);
		//sellOut("600507", 0, 200);
	}
}
