package com.topspot.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Constants {
	Properties prop = new Properties();

	public Constants() {
		InputStream input = null;
		try {
			input = Constants.class.getClassLoader().getResourceAsStream("./././config.properties");
			prop.load(input);
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	public String getValue(String propertyName) {
		return prop.getProperty(propertyName);
	}
}
