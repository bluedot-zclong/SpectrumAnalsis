package bluedot.spectrum.web.core.utils;

import java.io.IOException;
import java.net.JarURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class GetClassFromPackage {

	/**
	 * 从jar文件中读取指定目录下面的所有的class文件
	 * 
	 * @param jarPaht
	 *            jar文件存放的位置
	 * @param filePaht
	 *            指定的文件目录
	 * @return 所有的的class的对象
	 */
	public static void getClasssFromJarFile(URL filePaht, List<String> classNames, String controllerPackage) {

		JarFile jarFile = null;
		try {
			jarFile = ((JarURLConnection)filePaht.openConnection()).getJarFile();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		List<JarEntry> jarEntryList = new ArrayList<JarEntry>();

		Enumeration<JarEntry> ee = jarFile.entries();
		while (ee.hasMoreElements()) {
			JarEntry entry = (JarEntry) ee.nextElement();
			// 过滤我们出满足我们需求的东西
			if (entry.getName().endsWith(".class")) {
				jarEntryList.add(entry);
			}
		}
		for (JarEntry entry : jarEntryList) {
			String className = entry.getName().replace('/', '.');
			classNames.add(className.replace(".class", ""));
		}
	}
}
