package com.base.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	static String jdbcURL = "jdbc:mysql://127.0.0.1:3306/book";
	static String jdbcDriver = "com.mysql.jdbc.Driver";
	static String userName = "root";
	static String password = "root";
	/**
	 * ��ȡ��ݿ�l�Ӷ���
	 * @return ��ݿ�l�Ӷ���
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName(jdbcDriver);
		return DriverManager.getConnection(jdbcURL, userName, password);
	}
}
