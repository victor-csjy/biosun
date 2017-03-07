<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.aokle.util.FileUtil"%>
<%@page import="com.aokle.util.PathUtil;"%>
<%
NumberFormat nFormat=NumberFormat.getNumberInstance();
nFormat.setMaximumFractionDigits(3);//设置小数点后面尾数为5

String root_path=PathUtil.getRealPath();
double splace_all=FileUtil.recursionFileList(root_path)/(1024);
double splace_upload=(FileUtil.recursionFileList(root_path+"/product")+FileUtil.recursionFileList(root_path+"/UploadFile"))/(1024);
double splace_admin=FileUtil.recursionFileList(root_path+"/admin")/1024;
double with_split=550/splace_all;
double with_upload=splace_upload*with_split;
double with_admin=splace_admin*with_split;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Language content=zh-cn>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.3790.2795" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId><link href="css/Style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
-->
</style>
</HEAD>
<BODY style="BACKGROUND-COLOR: #eeeeee">
<DIV align=center>
<CENTER>
<P>&nbsp;</P>
<TABLE cellSpacing=1 cellPadding=0 width="98%"border=0>
  <TBODY>
  <TR>
    <TD height=50 valign="top" class="STYLE2">系统管理——空间情况</TD>
  </TR>
  <TR>
    <TD vAlign=top >
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border="1" bordercolor="#000000" bordercolordark="#FFFFFF" >
        <TBODY>
        <TR>
          <TD align=right width="18%" height=25><SPAN 
            class=style1>后台文件占用空间:</SPAN></TD>
          <TD width="82%" height=25><SPAN class=style1><IMG height=10 
            src="images/bar.gif" width=<%=with_admin%> border=0><FONT 
            face=verdana><%=nFormat.format(splace_admin)%>&nbsp;KB</FONT> </SPAN></TD>
        </TR>
        <tr>
          <TD align=right width="18%" height=25><SPAN 
            class=style1>上传文件占用空间:</SPAN></TD>
          <TD width="82%" height=25><SPAN class=style1><IMG height=10 
            src="images/bar.gif" width=<%=with_upload%> border=0><FONT 
            face=verdana><%=nFormat.format(splace_upload)%>&nbsp;KB</FONT> </SPAN></TD></TR>
        <TR>
          <TD align=right width="18%" height=25><SPAN 
            class=style1>全站占用空间:</SPAN></TD>
          <TD width="82%" height=25><SPAN class=style1><IMG height=10 
            src="images/bar.gif" width=550 border=0> <FONT 
            face=verdana><%=nFormat.format(splace_all)%>&nbsp;KB</FONT> 
  </SPAN></TD>
    </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></CENTER></DIV></BODY></HTML>
