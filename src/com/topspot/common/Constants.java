package com.topspot.common;

import java.util.ResourceBundle;

public class Constants {
	private static ResourceBundle resource = null;
	public Constants() {
		this.getBundle("config");
	}
	public void getBundle(String resourcePath) {
		if (resource == null) {
			resource = ResourceBundle.getBundle(resourcePath);
		}
	}
	public String getValue(String propertyName) {
		return resource.getString(propertyName);
	}
}
