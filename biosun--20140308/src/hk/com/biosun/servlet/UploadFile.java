package hk.com.biosun.servlet;

import hk.com.biosun.model.Admin;
import hk.com.biosun.util.SessionUtil;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.aokle.util.FileUtil;
import com.aokle.util.PathUtil;
import com.aokle.util.StrUtil;

public class UploadFile extends HttpServlet {

	private static Logger LOG = Logger.getLogger(UploadFile.class);

	public UploadFile() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		// �����ַ�����ΪUTF-8, ����֧�ֺ�����ʾ
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		Admin admin=SessionUtil.getAdmin(request);
		if(admin==null){
			out.print("����û�е�½���½��ʱ�������µ�½������");
			return ;
		}
		long maxSize = 3 * 1024 * 1024;// �����ϴ��ļ����Ϊ 10M
		// �����ϴ����ļ���ʽ���б�
		String[] allowedExt = null;
		String allowedExtJs = "jpg|jpeg|gif|png|bmp|txt|doc|docx|pdf|rar|zip|mp3|wma|m4a|swf";

		
		String op = StrUtil.toHtmlTag(request.getParameter("op"));// ���� upload
		String business = StrUtil.toHtmlTag(request.getParameter("business"));// ҵ�����
		// webeditor
		// ���ǲ�ƷͼƬ�ϴ�
		String fileType = StrUtil.toHtmlTag(request.getParameter("fileType"));// �ϴ��ļ�����
		// image
		// file
		// media
		// flash
		if ("".equals(fileType) || "image".equals(fileType)) {
			allowedExtJs="jpg|jpeg|gif|png|bmp";
			allowedExt=allowedExtJs.split("[|]");
		} else if ("file".equals(fileType)) {
			maxSize = 50 * 1024 * 1024;
			allowedExtJs="jpg|jpeg|gif|png|bmp|txt|doc|docx|pdf|rar|zip|mp3|wma|m4a|swf";
			allowedExt=allowedExtJs.split("[|]");
		} else if ("media".equals(fileType)) {
			maxSize = 100 * 1024 * 1024;
			allowedExtJs="mp3|wma|m4a|swf";
			allowedExt=allowedExtJs.split("[|]");
		} else if ("flash".equals(fileType)) {
			maxSize = 10 * 1024 * 1024;
			allowedExtJs="swf";
			allowedExt=allowedExtJs.split("[|]");
		}

		String fileNameOld = StrUtil.toHtmlTag(request
				.getParameter("fileNameOld"));// ���ļ���������չ�����������ɾ��
		String fileName = StrUtil.toHtmlTag(request.getParameter("fileName"));// �ϴ�����ļ�����
		// ��������չ��
		String webPath = StrUtil.toHtmlTag(request.getParameter("webPath"));// ��biosun
		String inputId = StrUtil.toHtmlTag(request.getParameter("inputId"));// �ɹ�����ϴ��ĵ�ַ���浽���input

		// �� UploadFile/
		if (business == null || "".equals(business)) {
			business = "webeditor";
		}
		if (fileType == null || "".equals(fileType)) {
			fileType = "image";
		}
		if (webPath != null && webPath.startsWith("/")) {// ȥ��ǰ���/
			while (webPath.startsWith("/")) {
				webPath = webPath.substring(1);
			}
		}
		if (webPath == null || "".equals(webPath)) {
			webPath = "UploadFile/";
		} else if (!webPath.endsWith("/")) {
			webPath = webPath + "/";
		}
		LOG.info("op=" + op + " business=" + business + " fileType=" + fileType
				+ " fileNameOld=" + fileNameOld + " fileName=" + fileName
				+ " webPath=" + webPath);

		if ("".equals(op)) {// ����ϴ��ļ�����
			if ("webeditor".equals(business)) {// �༭��
				out.println("<HTML>");
				out.println("<HEAD>");
				out.println("<TITLE>�ļ��ϴ�</TITLE>");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				out.println("<style type=\"text/css\">");
				out.println("body, a, table, div, span, td, th, input, select{font:9pt;font-family: \"����\", Verdana, Arial, Helvetica, sans-serif;}");
				out.println("body {padding:0px;margin:0px}");
				out.println("</style>");
				out.println("<script language=\"JavaScript\" src=\"../ewebeditor/dialog/dialog.js\">");
				out.println("</script>");
				out.println("</head>");
				out.println("<body bgcolor=menu>");
				out.print("<form action=\"?op=upload&fileType=image\"");
				out.println(" method=post name=myform enctype=\"multipart/form-data\">");
				out.println("<input type=file name=uploadfile size=1 style=\"width:100%\" onchange=\"originalfile.value=this.value\">");
				out.println("<input type=hidden name=originalfile value=\"\">");
				out.println("</form>");
				
				out.println("<script language=javascript>");
				out.print("var sAllowExt = \"");
				out.print(allowedExtJs);
				out.println("\";");
				out.println("// ����ϴ���");
				out.println("function CheckUploadForm() {");
				out.println("	if (!IsExt(document.myform.uploadfile.value,sAllowExt)){");
				out.println("		parent.UploadError(\"��ʾ��\\n\\n��ѡ��һ����Ч���ļ���\\n֧�ֵĸ�ʽ�У�\"+sAllowExt+\"����\");");
				out.println("		return false;");
				out.println("	}");
				out.println("	return true;");
				out.println("}");
				out.println("var oForm = document.myform ;");
				out.println("oForm.attachEvent(\"onsubmit\", CheckUploadForm) ;");
				out.println("if (! oForm.submitUpload) oForm.submitUpload = new Array() ;");
				out.println("oForm.submitUpload[oForm.submitUpload.length] = CheckUploadForm ;");
				out.println("if (! oForm.originalSubmit) {");
				out.println("	oForm.originalSubmit = oForm.submit ;");
				out.println("	oForm.submit = function() {");
				out.println("		if (this.submitUpload) {");
				out.println("			for (var i = 0 ; i < this.submitUpload.length ; i++) {");
				out.println("				this.submitUpload[i]() ;");
				out.println("			}");
				out.println("		}");
				out.println("		this.originalSubmit() ;");
				out.println("	}");
				out.println("}");
				out.println("// �ϴ�����װ�����");
				out.println("try {");
				out.println("	parent.UploadLoaded();");
				out.println("}");
				out.println("catch(e){");
				out.println("}");
				out.println("</script>");
				out.println("</body>");
				out.println("</html>");
			}else if("adminUpload".equalsIgnoreCase(business)){
				
				out.println("<html><head><title>�ļ��ϴ�</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
			    out.println("<script language=\"javascript\">");
				out.println(" function mysub(){");
				out.print("   var file_ext_allowmysub =\"");
				out.print(allowedExtJs);
				out.println("\";");
				out.println("  var filenowmysub = form1.fileObj.value;");
				out.println("  var lastindexmysub = filenowmysub.lastIndexOf(\".\");");
				out.println("  if (lastindexmysub != -1)filenowmysub = filenowmysub.substring(lastindexmysub+1);");
                out.println("  if (file_ext_allowmysub.indexOf(filenowmysub) != -1){");
				out.println("     esave.style.visibility = \"visible\";");
				out.println(" }");
				out.println("}");
				out.println(" function on_submit(){");
				out.print(" var file_ext_allow =\"");
				out.print(allowedExtJs);
				out.println("\";");
				out.println("var filenow = form1.fileObj.value;");
				out.println("var lastindex = filenow.lastIndexOf(\".\");");
				out.println("if (lastindex != -1)filenow = filenow.substring(lastindex+1);");
				out.println("if (filenow == null || filenow == \"\" || file_ext_allow.indexOf(filenow) == -1){");
				out.println("    alert(\"��ѡ��\" + file_ext_allow + \"�ļ�!\");");
				out.println("    form1.fileObj.value = \"\";");
				out.println("    document.form1.fileObj.focus();");
				out.println("    return false;");
				out.println("       }");
				out.println("    }");
				out.println(" </script>");
				out.println("</head>");
				out.println("<body bgcolor=\"#FFFFFF\">");
				out.println("<div id=\"esave\" style=\"width:200px; height:30px; position:absolute; left:110px; top:120px; z-index:10; visibility: hidden;\">");
				out.println("<table border=0 cellpadding=0 cellspacing=1 bgcolor=\"#000000\" width=\"100%\" height=\"100%\">");
				out.println("<tr><td bgcolor=#3A6EA5><marquee align=\"middle\" behavior=\"alternate\" scrollamount=\"5\"><font color=#FFFFFF>...�ļ��ϴ���...��ȴ�...</font></marquee></td></tr></table>");
				out.println("</div>");
				out.println("<table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"3\" cellspacing=\"1\" bordercolor=\"#CC0000\" bordercolorlight=\"#CC0000\" bordercolordark=\"#FFCC00\" bgcolor=\"#CC0000\">");
				out.println("<form name=\"form1\" method=\"post\" action=\"UploadFileJsp.jsp?op=upload&business=");
				out.print(business);
				out.print("&fileType=");
				out.print(fileType);
				out.print("&webPath=");
				out.print(webPath);
				out.print("&fileName=");
				out.print(fileName);
				out.print("&inputId=");
				out.print(inputId);
				out.println("\" enctype=\"multipart/form-data\" onSubmit=\"return on_submit()\">");
				out.println("<tr bgcolor=\"#CCCCCC\"><td width=\"100%\" height=\"25\" align=\"left\" valign=\"middle\" bgcolor=\"#CCCCCC\" class=\"head\"><font style=\"color:#FFFFFF; font-weight:bold;font-size:12px\">�ļ��ϴ�</font></td></tr>");
				out.println("<tr align=\"center\" valign=\"middle\"><td width=\"100%\" height=\"80\" align=\"left\" bgcolor=\"#FFFFFF\" style=\"font-size:12px\"> ѡ���ļ�:<input type=\"file\" name=\"fileObj\" style=\"width:300\"  value=\"\"></td></tr>");
				out.println("<tr align=\"center\" valign=\"middle\"><td width=\"100%\" height=\"24\" bgcolor=\"#CCCCCC\"><input name=\"Submit\" type=\"submit\" onClick=\"javascript:mysub()\" value=\"�� ��ʼ�ϴ� ��\" />");
				out.println("</td></tr></form>");
				out.println("</table>");
				out.println("</body></html>");
			}
		} else if ("upload".equals(op)) {// ���ﻹ��Ҫ�����

			String saveFileName = "";
			String originalFileName = "";
			String pathFileName = "";

			// ʵ����һ��Ӳ���ļ�����,���������ϴ����ServletFileUpload
			String realPath = PathUtil.getRealPath();
			if (realPath == null || "".equals(realPath.trim())) {
				LOG.error("realPath=" + realPath);
				out.print("Error:" + "realPath=" + realPath);
				return;
			}
			DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
			diskFileItemFactory.setSizeThreshold(1024 * 1024);// ��λ�ֽ�1MB
			// �����ϴ��ļ�ʱ������ʱ����ļ����ڴ��С,������4K.���ڵĲ��ֽ���ʱ����Ӳ��
			diskFileItemFactory.setRepository(new File(realPath
					+ "UploadFile/tmp"));// ���ô����ʱ�ļ���Ŀ¼,web��Ŀ¼�µ�ImagesUploadTempĿ¼

			// �����Ϲ���ʵ�����ϴ����
			ServletFileUpload servletFileUpload = new ServletFileUpload(
					diskFileItemFactory);
			// ��������ϴ��ߴ�
			servletFileUpload.setSizeMax(maxSize);
			// ��request�õ� ���� �ϴ�����б�
			List<FileItem> fileList = null;
			try {
				fileList = servletFileUpload.parseRequest(request);
			} catch (FileUploadException e) {// �����ļ��ߴ�����쳣
				if (e instanceof SizeLimitExceededException) {
					LOG.error("file is too big! MaxSize=" + maxSize
							/ (1024 * 1024) + "MB");
					out.print("Error:" + "file is too big! MaxSize=" + maxSize
							/ (1024 * 1024) + "MB");
					return;
				}
				LOG.error(e);
				e.printStackTrace();
			} catch (Exception e) {
				LOG.error(e);
				e.printStackTrace();
			}

			// û���ļ��ϴ�
			if (fileList == null || fileList.size() == 0) {
				LOG.error("file input is null! fileList.size() == 0");
				out
						.print("Error:"
								+ "file input is null! fileList.size() == 0");
				return;
			}
			// �õ������ϴ����ļ�
			Iterator<FileItem> fileItr = fileList.iterator();
			// ѭ�����������ļ�
			while (fileItr.hasNext()) {
				FileItem fileItem = null;
				String path = null;
				long size = 0;
				// �õ���ǰ�ļ�
				fileItem = (FileItem) fileItr.next();
				// ���Լ�form�ֶζ������ϴ�����ļ���(<input type="text" />��)
				if (fileItem == null || fileItem.isFormField()) {
					continue;
				}
				// �õ��ļ�������·��
				path = fileItem.getName();
				// �õ��ļ��Ĵ�С
				size = fileItem.getSize();
				if ("".equals(path) || size == 0) {
					LOG
							.error("file input is null! file size == 0 path="
									+ path);
					continue;
				}
				String fileExt = FileUtil.getFileExt(path).trim();
				if (fileExt == null || "".equals(fileExt)) {
					LOG.error("The file type is not allowed, path=" + path);
					continue;
				}

				int allowFlag = 0;
				int allowedExtCount = allowedExt.length;
				for (; allowFlag < allowedExtCount; allowFlag++) {
					if (allowedExt[allowFlag].equalsIgnoreCase(fileExt))
						break;
				}
				if (allowFlag == allowedExtCount) {
					LOG.error("The following file types is allowed:");
					for (allowFlag = 0; allowFlag < allowedExtCount; allowFlag++)
						LOG.error("*." + allowedExt[allowFlag]);
					continue;
				}
				if (fileName == null || "".equals(fileName)) {// �µ��ļ�����
					fileName = String.valueOf(System.currentTimeMillis());
				}
				originalFileName = FileUtil.getFileNameWithExt(path);
				saveFileName = fileName + "." + fileExt;
				pathFileName = webPath + saveFileName;

				// ����ϵͳʱ�������ϴ��󱣴���ļ���
				// ����������ļ�����·��,������web��Ŀ¼�µ�ImagesUploadedĿ¼��
				String filePath = realPath + pathFileName;
				try {
					// �����ļ�
					fileItem.write(new File(filePath));
					// �ɹ�
					if (fileNameOld != null
							&& !fileNameOld.equals(saveFileName)) {// ɾ���ɵ��ļ�

						try {
							File fileDel = new File(realPath + webPath
									+ fileNameOld);
							fileDel.delete();
						} catch (Exception e) {
							LOG.error("Delete file Error! fileNameOld="
									+ realPath + webPath + fileNameOld);
							e.printStackTrace();
						}
					}
				} catch (Exception e) {
					LOG.error(e);
					e.printStackTrace();
				}
			}

			LOG.info("originalFileName=" + originalFileName);
			LOG.info("saveFileName=" + saveFileName);
			LOG.info("pathFileName=" + pathFileName);

			if ("webeditor".equals(business)) {// �༭��
				out.println("<HTML>");
				out.println("<HEAD>");
				out.println("<TITLE>�ļ��ϴ�</TITLE>");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				out.println("<style type=\"text/css\">");
				out.println("body, a, table, div, span, td, th, input, select{font:9pt;font-family: \"����\", Verdana, Arial, Helvetica, sans-serif;}");
				out.println("body {padding:0px;margin:0px}");
				out.println("</style>");
				out.println("<script language=\"JavaScript\" src=\"../ewebeditor/dialog/dialog.js\">");
				out.println("</script>");
				out.println("</head>");
				out.println("<body bgcolor=menu>");
				out.print("<form action=\"?op=upload&fileType=image\"");
				out.println(" method=post name=myform enctype=\"multipart/form-data\">");
				out.println("<input type=file name=uploadfile size=1 style=\"width:100%\" onchange=\"originalfile.value=this.value\">");
				out.println("<input type=hidden name=originalfile value=\"\">");
				out.println("</form>");
				
				out.println("<script language=javascript>");
				out.print("var sAllowExt = \"");
				out.print(allowedExtJs);
				out.println("\";");
				out.println("// ����ϴ���");
				out.println("function CheckUploadForm() {");
				out.println("	if (!IsExt(document.myform.uploadfile.value,sAllowExt)){");
				out.println("		parent.UploadError(\"��ʾ��\\n\\n��ѡ��һ����Ч���ļ���\\n֧�ֵĸ�ʽ�У�\"+sAllowExt+\"����\");");
				out.println("		return false;");
				out.println("	}");
				out.println("	return true;");
				out.println("}");
				out.println("var oForm = document.myform ;");
				out.println("oForm.attachEvent(\"onsubmit\", CheckUploadForm) ;");
				out.println("if (! oForm.submitUpload) oForm.submitUpload = new Array() ;");
				out.println("oForm.submitUpload[oForm.submitUpload.length] = CheckUploadForm ;");
				out.println("if (! oForm.originalSubmit) {");
				out.println("	oForm.originalSubmit = oForm.submit ;");
				out.println("	oForm.submit = function() {");
				out.println("		if (this.submitUpload) {");
				out.println("			for (var i = 0 ; i < this.submitUpload.length ; i++) {");
				out.println("				this.submitUpload[i]() ;");
				out.println("			}");
				out.println("		}");
				out.println("		this.originalSubmit() ;");
				out.println("	}");
				out.println("}");
				out.println("// �ϴ�����װ�����");
				out.println("try {");
				out.println("	parent.UploadLoaded();");
				out.println("}");
				out.println("catch(e){");
				out.println("}");
				out.println("</script>");
				out.println("</body>");
				out.println("</html>");
				// �Ѿ��ɹ���
				out.println("<script language=javascript>");
				out.print("parent.UploadSaved('");
				out.print(saveFileName);// �����ı�������
				out
						.print("');var obj=parent.dialogArguments.dialogArguments;if (!obj) obj=parent.dialogArguments;try{obj.addUploadFile('");
				out.print(originalFileName);
				out.print("', '");
				out.print(saveFileName);
				out.print("', '");
				out.print(pathFileName);
				out.print("');} catch(e){}");
				out.println(";history.back();</script>");
			}else if ("flashSet".equals(business)) {
				out.println("<script language=javascript>");
				out.println("alert('�ϴ��ɹ���');");
				out.println("location.href='flash_set.jsp'");
				out.println("</script>");
			} else if("adminUpload".equals(business)){
				out.print("<script>window.opener.document.getElementById('" + inputId + "').value='" + saveFileName+ "';window.alert(\"�ļ��ϴ��ɹ�,�벻Ҫ�޸ķ��ص��ļ�����!\");window.close();</script>");
			}else {
				out.println("<script language=javascript>");
				out.println("  try{ parent.uploadFileBack('" + inputId + "','"
						+ originalFileName + "','" + saveFileName + "','"
						+ pathFileName + "')");
				out.println("  } catch(e){}history.back();");
				out.println("</script>");
			}
		}
	}
	public void init() throws ServletException {
		super.init();
	}
}
