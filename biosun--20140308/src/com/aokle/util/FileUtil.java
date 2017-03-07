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
	public static long FILE_MAX = 50 * 1024 * 1024;// �Կ����ļ��������� 50*1024*1024

	// �����50M���ļ�

	/**
	 * ���ܣ������� �������ݵĿ��ļ� �� �ļ���
	 * 
	 * @param realPathStr
	 *            ����·�����ļ����ơ��ļ���չ��
	 * @param isFile
	 *            true=�����ļ� false=�����ļ���
	 * @return 0=����ʧ�� 1=�����ɹ� 2=�ļ��Ѿ�����
	 */
	public static int creatFileOrDir(String realPathStr, boolean isFile) {
		int createFileOrDirResult = 0;
		try {
			File newFile = new File(realPathStr);
			if (!newFile.exists()) { // �ļ����ļ��в�����
				if (isFile) {// �����ļ�
					try {
						newFile.createNewFile();
						createFileOrDirResult = 1;
					} catch (IOException ioex) {
						ioex.printStackTrace();
					}
				} else { // �����ļ���
					try {
						newFile.mkdirs();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
			} else {// �ļ����ļ����Ѿ�����
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
	 * ���ܣ�ɾ������ļ� ���ļ���
	 * 
	 * @param f
	 * @return
	 */
	public static int deleteFileList(File f) {
		// f Ҫɾ�����ļ����ļ���
		int countFile = 0; // ���ɹ�ɾ�����ļ�����
		try {
			File fList[] = f.listFiles();
			for (int i = 0; (fList != null) && (i < fList.length); i++) {
				if (fList[i].isDirectory()) {
					countFile = countFile + deleteFileList(fList[i]);
				} else {
					if (fList[i].delete())
						countFile++; // �ļ�ɾ���ɹ�
					else {
						// this.deleteFileFailCount++; // �ļ�ɾ��ʧ��
					}
				}
			}
			if (f.delete())
				countFile++; // �ɹ�ɾ���ļ���
			else {
				// this.deleteFileFailCount++; // ɾ���ļ���ʧ��
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return countFile;
	}

	/**
	 * ���ܣ�ɾ���ļ������ļ�
	 * 
	 * @param realPathStr
	 * @param fileOrDir -1=�����ļ� 1=�ļ� 2=�ļ���  
	 * @return
	 */
	public static int deleteFileOrDir(String realPathStr, int fileOrDir) {
		int countFile = 0; // ���ɹ�ɾ�����ļ�����
		
		try {
			// this.deleteFileFailCount=0;// ��ʼ��ɾ��ʧ�ܵ� �ļ�����Ϊ0
			File delFile = new File(realPathStr);
			if (delFile != null) {
				if(fileOrDir==2&&!delFile.isDirectory()){
					return -1;
				}else if(fileOrDir==1&&delFile.isDirectory()){
					return -1;
				}
				countFile = deleteFileList(delFile); // �ݹ�ִ��ɾ������
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
	 * ���ܣ�����һ���������ݵ��ļ� ����Ѿ����ڵ��ļ����ǵ�
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
			out.write(content); // д���ļ�����
			out.flush();
			out.close(); // д���ļ�
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
	 * ���ܣ����ļ���׷�����һ������(String),û������ļ��Ļ����� false
	 * 
	 * @param realPathStr
	 * @param content
	 * @param charset
	 * @param type
	 *            1=���ļ���׷�� 2=���ļ�ǰ�ӣ��÷�����û��ʵ�֣�
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
		if (file.exists() && file.isFile()) { // �����ļ�,����׷��
			if (type == 1) {// ���ļ���׷��
				try {
					fos = new FileOutputStream(file, true); // true ׷��
					if (charset == null || "".equals(charset)) {
						out = new OutputStreamWriter(fos);
					} else {
						out = new OutputStreamWriter(fos, charset);
					}
					out.write(content); // д���ļ�����
					out.flush(); // ׷���ļ�
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
	 * ���ܣ���ȡһ���ļ�,���� String ���ļ�����
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
				fis = new FileInputStream(file); // ��ȡԭ�ļ�
				int lenght = (int) file.length(); // �ļ��ַ�����
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
				fileContent = new String(char_arr); // ���ļ�����ת��Ϊ�ַ���
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
	 * ���ܣ���ȡ�ļ�����
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
			fis = new FileInputStream(file); // ��ȡԭ�ļ�
			int lenght = (int) file.length(); // �ļ��ַ��ֽ�
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
			fileContent = new String(char_arr); // ���ļ�����ת��Ϊ�ַ���
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
	 * ���ܣ��滻�ļ��е�ĳ���ַ��� ע�⣺�ַ����в�Ҫ����������ַ����磺��˫����
	 * 
	 * @param realPathStr
	 * @param contentOld
	 * @param contentNew
	 * @param charset
	 * @param replaceFirstOrLastOrAll
	 * @return 0=�����滻��һ�� 1=�滻���һ�� 2=�滻ȫ����
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
				fis = new FileInputStream(file); // ��ȡԭ�ļ�
				int lenght = (int) file.length(); // �ļ��ַ��ֽ�
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

				String fileContent = new String(char_arr); // ���ļ�����ת��Ϊ�ַ���
				if (replaceFirstOrLastOrAll == 0)
					fileContent = fileContent.replaceFirst(contentOld,
							contentNew);
				else if (replaceFirstOrLastOrAll == 1) { // �滻���һ�� Ч�ʱȽϵ�,����ʹ��
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
	 * ���ܣ������ļ�
	 * 
	 * @param f
	 * @param realPathStrNew
	 * @return
	 */
	public boolean copyFile(File f, String realPathStrNew) {
		boolean isCopyFile = false;
		FileInputStream fis = null; // ���ֽ�������ʽ��ȡ�ļ�����
		FileOutputStream fos = null;
		try {
			if (f.isFile()) { // �������ļ����п���
				try {
					fis = new FileInputStream(f);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
				File fileNew = new File(realPathStrNew); // �µ��ļ���·��������
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
	 * ���ܣ������ļ���
	 * 
	 * @param realPathStrSource
	 * @param realPathStrNew
	 * @return
	 */
	public int copyDir(String realPathStrSource, String realPathStrNew) {
		int countFile = 0; // ���ɹ��������ļ�����
		try {
			creatFileOrDir(realPathStrNew, false);
			countFile++;
			File f = new File(realPathStrSource);
			File[] fileList = f.listFiles();
			for (int i = 0; i < fileList.length; i++) {
				if (fileList[i].isDirectory()) { // ����
					copyDir(realPathStrSource + "/" + fileList[i].getName(),
							realPathStrNew + "/" + fileList[i].getName());
				} else { // �����ļ�
					if (copyFile(fileList[i], realPathStrNew + "/"
							+ fileList[i].getName())) { // �����ļ��ɹ�
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
	 * ���ܣ������ļ����ļ��з���
	 * 
	 * @param realPathStrSource
	 * @param realPathStrNew
	 * @return ���سɹ��������ļ�����
	 */
	public int copyFileOrDir(String realPathStrSource, String realPathStrNew) {
		int countFile = 0; // ���ɹ��������ļ�����
		try {
			File sourceFile = new File(realPathStrSource);
			if (sourceFile.isFile()) {// ���ļ��Ŀ����Ϳ��������ļ�
				if (copyFile(sourceFile, realPathStrNew)) {
					countFile++;// File ���ļ���·��������
				}
			} else if (sourceFile.isDirectory()) {
				// ����һ���µ��ļ���
				if (creatFileOrDir(realPathStrNew, false) != 0) {// �����ļ��гɹ�
					// 1=�����ɹ�
					// 2=�ļ��Ѿ�����
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
	 * ���ܣ������ļ��� ��������չ��
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
	 * ���ܣ������ļ���������չ��
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
	 * ���ܣ������ļ�����չ�� ������"."
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
	 * ���ܣ���ȡURL�е�����ת��Ϊ���ص��ļ�
	 * 
	 * @param realPathStr
	 *            Ӧ�õľ���·��
	 * @param strUrl
	 *            URL��ַ
	 * @param fileName
	 *            �ļ�����
	 * @param chageExtByUrl
	 *            �Ƽ�ʹ��1 0=���ı䣬��fileNameΪ׼ 1=������ͼƬ�ĸı�(Ĭ��) 2=ͳһǿ��ʹ��URL����չ����û�оͲ���
	 * @return �ɹ�����ʵ�ʵ��ļ����� fileName ��ʧ�ܷ��� ""
	 */
	public String getFileByUrl(String realPathStr, String urlStr,
			String fileName, int chageExtByUrl) {
		boolean isSuccess = false;
		if (fileName == null || "".equals(fileName)) {
			fileName = getFileNameWithExt(urlStr);
		}
		String urlExt = getFileExt(urlStr).toLowerCase();
		if (chageExtByUrl == 0) {// 0=���ı�

		} else if (chageExtByUrl == 1) {// 1=������URLΪͼƬ�ĸı��URL����չ��
			// �������ļ���չ��ǿ��ת��
			if (urlExt.equals("jpg") || urlExt.equals("jpeg")
					|| urlExt.equals("gif") || urlExt.equals("png")
					|| urlExt.equals("bmp")) {// Ҫ��ͼƬ�ļ��Ļ�����չ��һ�����ܱ� �����Ĳ���
				fileName = getFileNameNoExt(fileName);
				fileName = fileName + "." + urlExt;
			}
		} else if (chageExtByUrl == 2) {// 2=ͳһǿ��ʹ��URL����չ����û�оͲ���
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
		boolean isTimeout = false; // �����Ƿ�ʱ
		try {
			url = new URL(urlStr);
			urlConnection = (HttpURLConnection) url.openConnection(); // �ж��Ƿ��ܴ򿪸�����
			urlConnection.setConnectTimeout(2000); // ��������������ʱ
			urlConnection.setReadTimeout(20000); // ���ô�������ȡ���ݳ�ʱ
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

				// ����Ŀ���ļ����Ƿ����
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
						outputStream.close(); // �ر������
						outputStream = null;
						File file = new File(realPathStr + fileName);
						if (file.exists() && file.isFile()) {// ���ڣ��������ļ�
							isSuccess = true;
						}
					}
					if (inputStream != null) {
						inputStream.close(); // �ر�������
						inputStream = null;
					}
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						if (outputStream != null) {
							outputStream.close(); // �ر������
							outputStream = null;
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if (inputStream != null) {
								inputStream.close(); // �ر�������
								inputStream = null;
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}// д�ļ���finally
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
