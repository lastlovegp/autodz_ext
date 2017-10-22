package com.erp.test;

import com.sun.jna.Native;
import com.sun.jna.win32.StdCallLibrary;

public class CopyOfGpApi {
	public interface User32 extends StdCallLibrary {
		User32 INSTANCE = (User32) Native.loadLibrary("User32", User32.class);// 加载系统User32
																				// DLL文件，也可以是C++写的DLL文件
		int SendMessageA(int hwnd, int msg, int wparam, int lparam);

		int FindWindowA(String arg0, String arg1);

		void BlockInput(boolean isBlock);

		int MessageBoxA(int hWnd, String lpText, int lpCaption, int uType);
				
		int mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);
		
		void keybd_event(
		            byte bVk, //虚拟键值
		            byte bScan,// 一般为0
		            int dwFlags, //这里是整数类型 0 为按下，2为释放
		            int dwExtraInfo //这里是整数类型 一般情况下设成为 0
		        );
	}

	public static void main(String[] args) throws Exception {
		int hwnd = User32.INSTANCE.FindWindowA(null, null);
		System.setProperty("jna.encoding", "GBK");// 设置编码，防止乱码
		User32.INSTANCE.MessageBoxA(hwnd, "看我闪瞎你的狗眼", 0, 0);// 调用消息对话框
		int i = 0;
		while (true) {
			User32.INSTANCE.BlockInput(true);// 阻塞鼠标键盘的输入
			User32.INSTANCE.SendMessageA(hwnd, 0x0112, 0xF170, 2);// 关闭显示器
			Thread.sleep(2000);// 间隔2秒
			User32.INSTANCE.SendMessageA(hwnd, 0x0112, 0xF170, -1);// 打开显示器
			Thread.sleep(2000);// 间隔2秒
			i++;
			if (i > 10) {
				break;
			}
		}
		User32.INSTANCE.BlockInput(false);// 释放鼠标键盘
	}
}
