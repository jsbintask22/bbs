package cn.jsbintask.bbs.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropConfig extends Properties {

	private static final long serialVersionUID = 1L;

	public void init(String location) throws IOException {
		InputStream inStream = Properties.class.getResourceAsStream("/" + location);
		this.load(inStream);
	}

	public String getProperties(String name) {
		return this.getProperty(name);
	}
}
