<%@page contentType="text/html;charset=utf-8"%><%@ page import="hk.com.biosun.model.Admin"%><%@ page import="hk.com.biosun.util.SessionUtil"%><%@ page import="java.io.File"%><%@ page import="java.util.Iterator"%><%@ page import="java.util.List"%><%@ page import="org.apache.commons.fileupload.FileItem"%><%@ page import="org.apache.commons.fileupload.FileUploadException"%><%@ page import="org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException"%><%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%><%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%><%@ page import="com.aokle.util.FileUtil"%><%@ page import="com.aokle.util.PathUtil"%><%@ page import="com.aokle.util.StrUtil"%><%
        Admin admin=SessionUtil.getAdmin(request);
		if(admin==null){
			out.print("您还没有登陆或登陆超时，请重新登陆！！！");
			return ;
		}
		long maxSize = 3 * 1024 * 1024;// 设置上传文件最大为 10M
		// 允许上传的文件格式的列表
		String[] allowedExt = null;
		String allowedExtJs = "jpg|jpeg|gif|png|bmp|txt|doc|docx|pdf|rar|zip|mp3|wma|m4a|swf";

		
		String op = StrUtil.toHtmlTag(request.getParameter("op"));// 操作 upload
		String business = StrUtil.toHtmlTag(request.getParameter("business"));// 业务参数
		// webeditor
		// 还是产品图片上传
		String fileType = StrUtil.toHtmlTag(request.getParameter("fileType"));// 上穿文件类型
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
				.getParameter("fileNameOld"));// 旧文件名称与扩展名，方便程序删除
		String fileName = StrUtil.toHtmlTag(request.getParameter("fileName"));// 上传后的文件名称
		// 不包括扩展名
		String webPath = StrUtil.toHtmlTag(request.getParameter("webPath"));// 如biosun
		String inputId = StrUtil.toHtmlTag(request.getParameter("inputId"));// 成功后把上传的地址保存到这个input

		// 下 UploadFile/
		if (business == null || "".equals(business)) {
			business = "webeditor";
		}
		if (fileType == null || "".equals(fileType)) {
			fileType = "image";
		}
		if (webPath != null && webPath.startsWith("/")) {// 去掉前面的/
			while (webPath.startsWith("/")) {
				webPath = webPath.substring(1);
			}
		}
		if (webPath == null || "".equals(webPath)) {
			webPath = "UploadFile/";
		} else if (!webPath.endsWith("/")) {
			webPath = webPath + "/";
		}
		if ("".equals(op)) {// 输出上传文件的域
			if ("webeditor".equals(business)) {// 编辑器
				out.println("<HTML>");
				out.println("<HEAD>");
				out.println("<TITLE>文件上传</TITLE>");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				out.println("<style type=\"text/css\">");
				out.println("body, a, table, div, span, td, th, input, select{font:9pt;font-family: \"宋体\", Verdana, Arial, Helvetica, sans-serif;}");
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
				out.println("// 检测上传表单");
				out.println("function CheckUploadForm() {");
				out.println("	if (!IsExt(document.myform.uploadfile.value,sAllowExt)){");
				out.println("		parent.UploadError(\"提示：\\n\\n请选择一个有效的文件，\\n支持的格式有（\"+sAllowExt+\"）！\");");
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
				out.println("// 上传表单已装入完成");
				out.println("try {");
				out.println("	parent.UploadLoaded();");
				out.println("}");
				out.println("catch(e){");
				out.println("}");
				out.println("</script>");
				out.println("</body>");
				out.println("</html>");
			}else if("adminUpload".equalsIgnoreCase(business)){
				
				out.println("<html><head><title>文件上传</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
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
				out.println("    alert(\"请选择\" + file_ext_allow + \"文件!\");");
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
				out.println("<tr><td bgcolor=#3A6EA5><marquee align=\"middle\" behavior=\"alternate\" scrollamount=\"5\"><font color=#FFFFFF>...文件上传中...请等待...</font></marquee></td></tr></table>");
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
				out.println("<tr bgcolor=\"#CCCCCC\"><td width=\"100%\" height=\"25\" align=\"left\" valign=\"middle\" bgcolor=\"#CCCCCC\" class=\"head\"><font style=\"color:#FFFFFF; font-weight:bold;font-size:12px\">文件上传</font></td></tr>");
				out.println("<tr align=\"center\" valign=\"middle\"><td width=\"100%\" height=\"80\" align=\"left\" bgcolor=\"#FFFFFF\" style=\"font-size:12px\"> 选择文件:<input type=\"file\" name=\"fileObj\" style=\"width:300\"  value=\"\"></td></tr>");
				out.println("<tr align=\"center\" valign=\"middle\"><td width=\"100%\" height=\"24\" bgcolor=\"#CCCCCC\"><input name=\"Submit\" type=\"submit\" onClick=\"javascript:mysub()\" value=\"· 开始上传 ·\" />");
				out.println("</td></tr></form>");
				out.println("</table>");
				out.println("</body></html>");
			}
		} else if ("upload".equals(op)) {// 这里还需要这个吗

			String saveFileName = "";
			String originalFileName = "";
			String pathFileName = "";

			// 实例化一个硬盘文件工厂,用来配置上传组件ServletFileUpload
			String realPath = PathUtil.getRealPath();
			if (realPath == null || "".equals(realPath.trim())) {
				out.print("Error:" + "realPath=" + realPath);
				return;
			}
			DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
			diskFileItemFactory.setSizeThreshold(1024 * 1024);// 单位字节1MB
			// 设置上传文件时用于临时存放文件的内存大小,这里是4K.多于的部分将临时存在硬盘
			diskFileItemFactory.setRepository(new File(realPath
					+ "UploadFile/tmp"));// 设置存放临时文件的目录,web根目录下的ImagesUploadTemp目录

			// 用以上工厂实例化上传组件
			ServletFileUpload servletFileUpload = new ServletFileUpload(
					diskFileItemFactory);
			// 设置最大上传尺寸
			servletFileUpload.setSizeMax(maxSize);
			// 从request得到 所有 上传域的列表
			List<FileItem> fileList = null;
			try {
				fileList = servletFileUpload.parseRequest(request);
			} catch (FileUploadException e) {// 处理文件尺寸过大异常
				if (e instanceof SizeLimitExceededException) {
					out.print("Error:" + "file is too big! MaxSize=" + maxSize
							/ (1024 * 1024) + "MB");
					return;
				}
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 没有文件上传
			if (fileList == null || fileList.size() == 0) {
				out
						.print("Error:"
								+ "file input is null! fileList.size() == 0");
				return;
			}
			// 得到所有上传的文件
			Iterator<FileItem> fileItr = fileList.iterator();
			// 循环处理所有文件
			while (fileItr.hasNext()) {
				FileItem fileItem = null;
				String path = null;
				long size = 0;
				// 得到当前文件
				fileItem = (FileItem) fileItr.next();
				// 忽略简单form字段而不是上传域的文件域(<input type="text" />等)
				if (fileItem == null || fileItem.isFormField()) {
					continue;
				}
				// 得到文件的完整路径
				path = fileItem.getName();
				// 得到文件的大小
				size = fileItem.getSize();
				if ("".equals(path) || size == 0) {
					continue;
				}
				String fileExt = FileUtil.getFileExt(path).trim();
				if (fileExt == null || "".equals(fileExt)) {
					continue;
				}

				int allowFlag = 0;
				int allowedExtCount = allowedExt.length;
				for (; allowFlag < allowedExtCount; allowFlag++) {
					if (allowedExt[allowFlag].equalsIgnoreCase(fileExt))
						break;
				}
				if (allowFlag == allowedExtCount) {
					continue;
				}
				if (fileName == null || "".equals(fileName)) {// 新的文件名称
					fileName = String.valueOf(System.currentTimeMillis());
				}
				originalFileName = FileUtil.getFileNameWithExt(path);
				saveFileName = fileName + "." + fileExt;
				pathFileName = webPath + saveFileName;

				// 根据系统时间生成上传后保存的文件名
				// 保存的最终文件完整路径,保存在web根目录下的ImagesUploaded目录下
				String filePath = realPath + pathFileName;
				try {
					// 保存文件
					fileItem.write(new File(filePath));
					// 成功
					if (fileNameOld != null
							&& !fileNameOld.equals(saveFileName)) {// 删除旧的文件

						try {
							File fileDel = new File(realPath + webPath
									+ fileNameOld);
							fileDel.delete();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			if ("webeditor".equals(business)) {// 编辑器
				out.println("<HTML>");
				out.println("<HEAD>");
				out.println("<TITLE>文件上传</TITLE>");
				out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				out.println("<style type=\"text/css\">");
				out.println("body, a, table, div, span, td, th, input, select{font:9pt;font-family: \"宋体\", Verdana, Arial, Helvetica, sans-serif;}");
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
				out.println("// 检测上传表单");
				out.println("function CheckUploadForm() {");
				out.println("	if (!IsExt(document.myform.uploadfile.value,sAllowExt)){");
				out.println("		parent.UploadError(\"提示：\\n\\n请选择一个有效的文件，\\n支持的格式有（\"+sAllowExt+\"）！\");");
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
				out.println("// 上传表单已装入完成");
				out.println("try {");
				out.println("	parent.UploadLoaded();");
				out.println("}");
				out.println("catch(e){");
				out.println("}");
				out.println("</script>");
				out.println("</body>");
				out.println("</html>");
				// 已经成功的
				out.println("<script language=javascript>");
				out.print("parent.UploadSaved('");
				out.print(saveFileName);// 单独的保存名称
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
				out.println("alert('上传成功！');");
				out.println("location.href='flash_set.jsp'");
				out.println("</script>");
			} else if("adminUpload".equals(business)){
				out.print("<script>window.opener.document.getElementById('" + inputId + "').value='" + saveFileName+ "';window.close();</script>");
			}else {
				out.println("<script language=javascript>");
				out.println("  try{ parent.uploadFileBack('" + inputId + "','"
						+ originalFileName + "','" + saveFileName + "','"
						+ pathFileName + "')");
				out.println("  } catch(e){}history.back();");
				out.println("</script>");
			}
		}
%>