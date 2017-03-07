package com.aokle.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;

public class FileUtil {
	public static long FILE_MAX = 50 * 1024 * 1024;// 对拷贝文件不起作用 50*1024*1024

	// 最大处理50M的文件

	/**
	 * 功能：创建不 含有内容的空文件 或 文件夹
	 * 
	 * @param realPathStr
	 *            绝对路径与文件名称。文件扩展名
	 * @param isFile
	 *            true=创建文件 false=创建文件夹
	 * @return 0=创建失败 1=创建成功 2=文件已经存在
	 */
	public static int creatFileOrDir(String realPathStr, boolean isFile) {
		int createFileOrDirResult = 0;
		try {
			File newFile = new File(realPathStr);
			if (!newFile.exists()) { // 文件或文件夹不存在
				if (isFile) {// 创建文件
					try {
						newFile.createNewFile();
						createFileOrDirResult = 1;
					} catch (IOException ioex) {
						ioex.printStackTrace();
					}
				} else { // 创建文件夹
					try {
						newFile.mkdirs();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
			} else {// 文件或文件夹已经存在
				createFileOrDirResult = 2;
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return createFileOrDirResult;
	}

	/**
	 * 功能：删除多个文件 与文件夹
	 * 
	 * @param f
	 * @return
	 */
	public static int deleteFileList(File f) {
		// f 要删除的文件或文件夹
		int countFile = 0; // 被成功删除的文件个数
		try {
			File fList[] = f.listFiles();
			for (int i = 0; (fList != null) && (i < fList.length); i++) {
				if (fList[i].isDirectory()) {
					countFile = countFile + deleteFileList(fList[i]);
				} else {
					if (fList[i].delete())
						countFile++; // 文件删除成功
					else {
						// this.deleteFileFailCount++; // 文件删除失败
					}
				}
			}
			if (f.delete())
				countFile++; // 成功删除文件夹
			else {
				// this.deleteFileFailCount++; // 删除文件夹失败
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return countFile;
	}

	/**
	 * 功能：删除文件夹与文件
	 * 
	 * @param realPathStr
	 * @param fileOrDir -1=所有文件 1=文件 2=文件夹  
	 * @return
	 */
	public static int deleteFileOrDir(String realPathStr, int fileOrDir) {
		int countFile = 0; // 被成功删除的文件个数
		
		try {
			// this.deleteFileFailCount=0;// 初始化删除失败的 文件个数为0
			File delFile = new File(realPathStr);
			if (delFile != null) {
				if(fileOrDir==2&&!delFile.isDirectory()){
					return -1;
				}else if(fileOrDir==1&&delFile.isDirectory()){
					return -1;
				}
				countFile = deleteFileList(delFile); // 递归执行删除操作
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countFile;
	}

	public static int deleteFile(String realPathStr) {
		return deleteFileOrDir(realPathStr, 1);
	}

	public static int deleteDir(String realPathStr) {
		return deleteFileOrDir(realPathStr, 2);
	}

	/**
	 * 功能：创建一个含有内容的文件 会把已经存在的文件覆盖掉
	 * 
	 * @param realPathStr
	 * @param content
	 * @param charset
	 * @return
	 */
	public boolean creatFileContent(String realPathStr, String content,
			String charset) {
		boolean isCreatFileContent = false;
		FileOutputStream fos = null;
		OutputStreamWriter out = null;
		try {
			File file = new File(realPathStr);
			fos = new FileOutputStream(file);
			if (charset == null || "".equals(charset)) {
				out = new OutputStreamWriter(fos);
			} else {
				out = new OutputStreamWriter(fos, charset);
			}
			out.write(content); // 写入文件内容
			out.flush();
			out.close(); // 写入文件
			out = null;
			fos.close();
			fos = null;
			isCreatFileContent = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
					out = null;
				}
			} catch (IOException ioexout) {
				ioexout.printStackTrace();
			} finally {
				try {
					if (fos != null) {
						fos.close();
						fos = null;
					}
				} catch (IOException ioexfos) {
					ioexfos.printStackTrace();
				}
			}
		}
		return isCreatFileContent;
	}

	public boolean creatFileContent(String realPathStr, String content) {
		return creatFileContent(realPathStr, content, "");
	}

	/**
	 * 功能：在文件中追加最后一个内容(String),没有这个文件的话返回 false
	 * 
	 * @param realPathStr
	 * @param content
	 * @param charset
	 * @param type
	 *            1=在文件后追加 2=在文件前加（该方法还没有实现）
	 * @return
	 */
	public boolean fileAddContent(String realPathStr, String content,
			String charset, int type) {
		boolean isFileaddcontent = false;
		File file = new File(realPathStr);
		FileOutputStream fos = null;
		OutputStreamWriter out = null;
		if (file.length() > FILE_MAX) {
			System.err
					.println(new StringBuffer(
							"com.magicwebsoft.util.FileUtil.java fileAddContent() fileAddContent()=File too big,realPathStr=")
							.append(realPathStr).append(" ").append(
									file.length() / (1024 * 1024)).append("MB")
							.toString());
			return isFileaddcontent;
		}
		if (file.exists() && file.isFile()) { // 存在文件,正常追加
			if (type == 1) {// 在文件后追加
				try {
					fos = new FileOutputStream(file, true); // true 追加
					if (charset == null || "".equals(charset)) {
						out = new OutputStreamWriter(fos);
					} else {
						out = new OutputStreamWriter(fos, charset);
					}
					out.write(content); // 写入文件内容
					out.flush(); // 追加文件
					out.close();
					out = null;
					fos.close();
					fos = null;
					isFileaddcontent = true;
				} catch (Exception ex) {
					ex.printStackTrace();
				} finally {
					try {
						if (out != null) {
							out.close();
							out = null;
						}
					} catch (IOException ioexout) {
						ioexout.printStackTrace();
					} finally {
						try {
							if (fos != null) {
								fos.close();
								fos = null;
							}
						} catch (IOException ioexfos) {
							ioexfos.printStackTrace();
						}
					}
				}
			}
		}
		return isFileaddcontent;
	}

	/**
	 * 功能：读取一个文件,返回 String 的文件内容
	 * 
	 * @param realPathStr
	 * @param charset
	 * @return
	 */

	public String fileReader(String realPathStr, String charset) {
		String fileContent = "";
		File file = new File(realPathStr);
		FileInputStream fis = null;
		InputStreamReader isr = null;
		if (file.length() > FILE_MAX) {
			System.err
					.println(new StringBuffer(
							"com.magicwebsoft.util.FileUtil.java fileReader() File too big,realPathStr=")
							.append(realPathStr).append(" ").append(
									file.length() / (1024 * 1024)).append("MB")
							.toString());
			return "";
		}
		if (file.exists() && file.isFile()) {
			try {
				fis = new FileInputStream(file); // 读取原文件
				int lenght = (int) file.length(); // 文件字符总数
				if (charset == null || "".equals(charset)) {
					isr = new InputStreamReader(fis);
				} else {
					isr = new InputStreamReader(fis, charset);
				}
				char[] char_arr = new char[lenght];
				isr.read(char_arr, 0, lenght);
				isr.close();
				isr = null;
				fis.close();
				fis = null;
				fileContent = new String(char_arr); // 把文件内容转换为字符串
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				try {
					if (isr != null) {
						isr.close();
						isr = null;
					}
				} catch (IOException ioexout) {
					ioexout.printStackTrace();
				} finally {
					try {
						if (fis != null) {
							fis.close();
							fis = null;
						}
					} catch (IOException ioexfos) {
						ioexfos.printStackTrace();
					}
				}
			}
		}
		return fileContent;
	}

	/**
	 * 功能：读取文件内容
	 * 
	 * @param realPathStr
	 * @param charset
	 * @return
	 */
	public String readFile(String realPathStr, String charset) {
		String fileContent = "";
		if (realPathStr == null || realPathStr.trim().equals("")) {
			return "";
		}
		File file = new File(realPathStr);
		if (!file.exists() || file.isDirectory()) {
			return "";
		}
		FileInputStream fis = null;
		InputStreamReader isr = null;
		if (file.length() > FILE_MAX) {
			System.err
					.println(new StringBuffer(
							"com.magicwebsoft.util.FileUtil.java fileReader() File too big,realPathStr=")
							.append(realPathStr).append(" ").append(
									file.length() / (1024 * 1024)).append("MB")
							.toString());
			return "";
		}

		try {
			fis = new FileInputStream(file); // 读取原文件
			int lenght = (int) file.length(); // 文件字符字节
			if (charset == null || "".equals(charset)) {
				isr = new InputStreamReader(fis);
			} else {
				isr = new InputStreamReader(fis, charset);
			}
			char[] char_arr = new char[lenght];
			isr.read(char_arr, 0, lenght);
			isr.close();
			isr = null;
			fis.close();
			fis = null;
			fileContent = new String(char_arr); // 把文件内容转换为字符串
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (isr != null) {
					isr.close();
					isr = null;
				}
			} catch (IOException ioexout) {
				ioexout.printStackTrace();
			}
		}
		return fileContent;
	}

	public String readFile(String realPathStr, String fileName, String charset) {
		if (realPathStr == null || fileName == null) {
			return "";
		}
		if (realPathStr.endsWith("/")) {
			realPathStr = realPathStr + fileName;
		} else if (fileName.startsWith("/")) {
			realPathStr = realPathStr + fileName;
		} else {
			realPathStr = realPathStr + "/" + fileName;
		}
		return readFile(realPathStr, charset);
	}

	public String readFile(String realPathStr) {
		return readFile(realPathStr, "");
	}

	/**
	 * 功能：替换文件中的某个字符串 注意：字符串中不要含有特殊的字符，如：单双引号
	 * 
	 * @param realPathStr
	 * @param contentOld
	 * @param contentNew
	 * @param charset
	 * @param replaceFirstOrLastOrAll
	 * @return 0=仅仅替换第一个 1=替换最后一个 2=替换全部的
	 */
	public boolean fileContentReplace(String realPathStr, String contentOld,
			String contentNew, String charset, int replaceFirstOrLastOrAll) {
		boolean isFileContentReplace = false;
		File file = new File(realPathStr);
		FileInputStream fis = null;
		InputStreamReader isr = null;
		FileOutputStream fos = null;
		if (file.length() > FILE_MAX) {
			System.err
					.println(new StringBuffer(
							"com.magicwebsoft.util.FileUtil.java fileContentReplace() File too big,realPathStr=")
							.append(realPathStr).append(" ").append(
									file.length() / (1024 * 1024)).append("MB")
							.toString());

			return isFileContentReplace;
		}
		if (file.exists() && file.isFile()) {
			try {
				fis = new FileInputStream(file); // 读取原文件
				int lenght = (int) file.length(); // 文件字符字节
				if (charset == null || "".equals(charset)) {
					isr = new InputStreamReader(fis);
				} else {
					isr = new InputStreamReader(fis, charset);
				}
				char[] char_arr = new char[lenght];
				isr.read(char_arr, 0, lenght);
				isr.close();
				isr = null;
				fis.close();
				fis = null;

				String fileContent = new String(char_arr); // 把文件内容转换为字符串
				if (replaceFirstOrLastOrAll == 0)
					fileContent = fileContent.replaceFirst(contentOld,
							contentNew);
				else if (replaceFirstOrLastOrAll == 1) { // 替换最后一个 效率比较低,避免使用
					int indexlast = fileContent.lastIndexOf(contentOld);
					StringBuffer fileContentSB = new StringBuffer();
					if (indexlast != -1) {
						fileContentSB.append(fileContent
								.substring(0, indexlast));
						fileContentSB.append(contentNew);
						fileContentSB.append(fileContent.substring(indexlast
								+ contentOld.length()));
						fileContent = fileContentSB.toString();
					}
				} else if (replaceFirstOrLastOrAll == 2)
					fileContent = fileContent
							.replaceAll(contentOld, contentNew);
				fos = new FileOutputStream(realPathStr);

				byte bytesTemp[] = null;
				if (charset == null || "".equals(charset)) {
					bytesTemp = fileContent.getBytes();
				} else {
					bytesTemp = fileContent.getBytes(charset);
				}
				fos.write(bytesTemp);
				fos.flush();
				fos.close();
				fos = null;
				isFileContentReplace = true;
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				try {
					if (isr != null) {
						isr.close();
						isr = null;
					}
				} catch (IOException ioexout) {
					ioexout.printStackTrace();
				} finally {
					try {
						if (fos != null) {
							fos.close();
							fos = null;
						}
					} catch (IOException ioexout) {
						ioexout.printStackTrace();
					} finally {
						try {
							if (fis != null) {
								fis.close();
								fis = null;
							}
						} catch (IOException ioexfos) {
							ioexfos.printStackTrace();
						}
					}
				}
			}
		}
		return isFileContentReplace;
	}

	/**
	 * 功能：拷贝文件
	 * 
	 * @param f
	 * @param realPathStrNew
	 * @return
	 */
	public boolean copyFile(File f, String realPathStrNew) {
		boolean isCopyFile = false;
		FileInputStream fis = null; // 以字节流的形式读取文件内容
		FileOutputStream fos = null;
		try {
			if (f.isFile()) { // 仅仅对文件进行拷贝
				try {
					fis = new FileInputStream(f);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
				File fileNew = new File(realPathStrNew); // 新的文件夹路径与名称
				try {
					fos = new FileOutputStream(fileNew);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
				int byteTemp = 0;
				byte[] buffer = new byte[1024];
				try {
					while ((byteTemp = fis.read(buffer)) != -1) {
						fos.write(buffer, 0, byteTemp);
					}
					fos.flush();
					fos.close();
					fos = null;
					fis.close();
					fis = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
				isCopyFile = true;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (fos != null) {
					fos.close();
					fos = null;
				}
			} catch (IOException ioexfos) {
				ioexfos.printStackTrace();
			} finally {

				try {
					if (fis != null) {
						fis.close();
						fis = null;
					}
				} catch (IOException ioexfis) {
					ioexfis.printStackTrace();
				}
			}
		}
		return isCopyFile;
	}

	/**
	 * 功能：拷贝文件夹
	 * 
	 * @param realPathStrSource
	 * @param realPathStrNew
	 * @return
	 */
	public int copyDir(String realPathStrSource, String realPathStrNew) {
		int countFile = 0; // 被成功拷贝的文件个数
		try {
			creatFileOrDir(realPathStrNew, false);
			countFile++;
			File f = new File(realPathStrSource);
			File[] fileList = f.listFiles();
			for (int i = 0; i < fileList.length; i++) {
				if (fileList[i].isDirectory()) { // 拷贝
					copyDir(realPathStrSource + "/" + fileList[i].getName(),
							realPathStrNew + "/" + fileList[i].getName());
				} else { // 拷贝文件
					if (copyFile(fileList[i], realPathStrNew + "/"
							+ fileList[i].getName())) { // 拷贝文件成功
						countFile++;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countFile;
	}

	/**
	 * 功能：拷贝文件或文件夹方法
	 * 
	 * @param realPathStrSource
	 * @param realPathStrNew
	 * @return 返回成功拷贝的文件个数
	 */
	public int copyFileOrDir(String realPathStrSource, String realPathStrNew) {
		int countFile = 0; // 被成功拷贝的文件个数
		try {
			File sourceFile = new File(realPathStrSource);
			if (sourceFile.isFile()) {// 是文件的拷贝就拷贝单个文件
				if (copyFile(sourceFile, realPathStrNew)) {
					countFile++;// File 新文件的路径与名称
				}
			} else if (sourceFile.isDirectory()) {
				// 创建一个新的文件夹
				if (creatFileOrDir(realPathStrNew, false) != 0) {// 创建文件夹成功
					// 1=创建成功
					// 2=文件已经存在
					countFile = countFile
							+ copyDir(realPathStrSource, realPathStrNew);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countFile;
	}

	/**
	 * 功能：返回文件名 不包括扩展名
	 * 
	 * @param fileNameFull
	 * @return
	 */
	public static String getFileNameNoExt(String fileNameFull) {
		if (fileNameFull == null)
			return "";
		String fileName = getFileNameWithExt(fileNameFull);
		String fileExt = getFileExt(fileName);
		if (fileExt.equals("")) {
			return fileName;
		} else {
			return fileName.replace("." + fileExt, "");
		}
	}

	/**
	 * 功能：返回文件名包括扩展名
	 * 
	 * @param fileNameFull
	 * @return
	 */
	public static String getFileNameWithExt(String fileNameFull) {
		if (fileNameFull == null)
			return "";
		fileNameFull = fileNameFull.trim();
		int index = fileNameFull.lastIndexOf("/");
		if (index < 0) {
			index = fileNameFull.lastIndexOf("\\");
		}
		if (index < 0) {
			return fileNameFull;
		} else if ((index + 1) >= fileNameFull.length()) {
			return "";
		}
		String fileName = fileNameFull.substring(index + 1, fileNameFull
				.length());
		return fileName;
	}

	/**
	 * 功能：返回文件的扩展名 不包括"."
	 * 
	 * @param fileName
	 * @return abc.jpg=jpg
	 */
	public static String getFileExt(String fileName) {
		if (fileName == null)
			return "";
		fileName = fileName.trim();
		int index = fileName.lastIndexOf(".");
		if (index < 0) {
			return "";
		}
		if (fileName.endsWith(".")) {
			return "";
		}
		String extName = fileName.substring(index + 1, fileName.length());
		return extName;
	}

	/**
	 * 功能：获取URL中的内容转换为本地的文件
	 * 
	 * @param realPathStr
	 *            应用的绝对路径
	 * @param strUrl
	 *            URL地址
	 * @param fileName
	 *            文件名称
	 * @param chageExtByUrl
	 *            推荐使用1 0=不改变，以fileName为准 1=仅仅是图片的改变(默认) 2=统一强制使用URL的扩展名，没有就不变
	 * @return 成功返回实际的文件名称 fileName ，失败返回 ""
	 */
	public String getFileByUrl(String realPathStr, String urlStr,
			String fileName, int chageExtByUrl) {
		boolean isSuccess = false;
		if (fileName == null || "".equals(fileName)) {
			fileName = getFileNameWithExt(urlStr);
		}
		String urlExt = getFileExt(urlStr).toLowerCase();
		if (chageExtByUrl == 0) {// 0=不改变

		} else if (chageExtByUrl == 1) {// 1=仅仅是URL为图片的改变成URL的扩展名
			// 以下是文件扩展名强制转换
			if (urlExt.equals("jpg") || urlExt.equals("jpeg")
					|| urlExt.equals("gif") || urlExt.equals("png")
					|| urlExt.equals("bmp")) {// 要是图片文件的话，扩展名一定不能变 其他的不管
				fileName = getFileNameNoExt(fileName);
				fileName = fileName + "." + urlExt;
			}
		} else if (chageExtByUrl == 2) {// 2=统一强制使用URL的扩展名，没有就不变
			if (!urlExt.equals("")) {
				fileName = getFileNameNoExt(fileName);
				fileName = fileName + "." + urlExt;
			}
		}
		if (fileName.equals("") || fileName.equalsIgnoreCase("." + urlExt)) {
			return "";
		}
		URL url = null;
		InputStream inputStream = null;
		OutputStream outputStream = null;
		int httpState = 0;
		HttpURLConnection urlConnection = null;
		boolean isTimeout = false; // 连接是否超时
		try {
			url = new URL(urlStr);
			urlConnection = (HttpURLConnection) url.openConnection(); // 判断是否能打开该连接
			urlConnection.setConnectTimeout(2000); // 设置连接主机超时
			urlConnection.setReadTimeout(20000); // 设置从主机读取数据超时
		} catch (MalformedURLException e2) {
			isTimeout = true;
			e2.printStackTrace();
		} catch (SocketTimeoutException e) {
			isTimeout = true;
			e.printStackTrace();
		} catch (IOException e) {
			isTimeout = true;
			e.printStackTrace();
		}
		if (!isTimeout && urlConnection != null) {
			try {
				httpState = urlConnection.getResponseCode();
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (httpState == 200) {
				if (realPathStr.endsWith("/")) {

				}
				if (realPathStr.endsWith("\\")) {

				} else {
					realPathStr = realPathStr + "/";
				}
				try {
					inputStream = url.openStream();
				} catch (IOException e) {
					e.printStackTrace();
				}

				// 查找目标文件夹是否存在
				File fileDir = new File(realPathStr);
				if (!fileDir.exists() || !fileDir.isDirectory()) {
					fileDir.mkdirs();
				}
				try {
					outputStream = new FileOutputStream(realPathStr + fileName);
					int bytesInt = 0;
					byte[] byteTemp = new byte[10240];// 10KB
					while ((bytesInt = inputStream.read(byteTemp)) != -1) {
						outputStream.write(byteTemp, 0, bytesInt);
					}
					if (outputStream != null) {
						outputStream.flush();
						outputStream.close(); // 关闭输出流
						outputStream = null;
						File file = new File(realPathStr + fileName);
						if (file.exists() && file.isFile()) {// 存在，并且是文件
							isSuccess = true;
						}
					}
					if (inputStream != null) {
						inputStream.close(); // 关闭输入流
						inputStream = null;
					}
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						if (outputStream != null) {
							outputStream.close(); // 关闭输出流
							outputStream = null;
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if (inputStream != null) {
								inputStream.close(); // 关闭输入流
								inputStream = null;
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}// 写文件的finally
			}
		}
		try {
			if (urlConnection != null) {
				urlConnection.disconnect();
				urlConnection = null;
			}
			url = null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuccess ? fileName : "";
	}

	public String getFileByUrl(String realPathStr, String urlStr,
			String fileName) {
		return getFileByUrl(realPathStr, urlStr, fileName, 1);
	}

	public static boolean isRightFileType(String fileName, String types) {
		if (types == null || types.equals("")) {
			return false;
		}
		String fileExt = getFileExt(fileName);
		if (fileExt.equals("")) {
			return false;
		}
		types = "," + types.toLowerCase() + ",";
		fileExt = "," + fileExt.toLowerCase() + ",";
		if (types.indexOf(fileExt) > -1) {
			return true;
		} else {
			return false;
		}
	}

	public static long recursionFileList(String fileRealPath) {
		if (fileRealPath == null) {
			return 0;
		}
		File f = new File(fileRealPath);
		if (!f.exists()) {
			return 0;
		}
		return recursionFileList(f);
	}

	public static long recursionFileList(File f) {
		long size = 0;
		if (f == null) {
			return 0;
		}
		File flist[] = f.listFiles();
		int flistLength = flist != null ? flist.length : 0;
		if (flistLength < 1) {
			return 0;
		}
		for (int i = 0; i < flistLength; i++) {
			if (flist[i].isDirectory()) {
				size = size + recursionFileList(flist[i]);
			} else {
				size = size + flist[i].length();
			}
		}
		return size;
	}

	public static void main(String[] args) {
		FileUtil fileUtil = new FileUtil();

		if (fileUtil.creatFileContent("D:/TestType.java", "samsam", null)) {
			System.out.println("OK");
		} else {
			System.out.println("false");
		}
		isRightFileType(
				"D:\\java\\eclipseworkspace\\magicwebsoft_develop\\WebRoot\\js\\magicwebsoftjscode\\ajax\\AjaxSimple.js",
				"js");

		// System.out.println(fileUtil.getFileByUrl("D:/test/","http://192.168.10.247:4081/dodoresource/head_photo/1225767037072_small_no.jpg","no.gif",
		// 0));
	}
}
