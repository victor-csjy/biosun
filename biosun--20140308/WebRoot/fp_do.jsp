<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.service.NewsTableService"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.model.NewsTable"%>
<%
NewsTableService newsTableService=new NewsTableService();
List<NewsTable>  newsTableList=newsTableService.getListFront(-1,1,100,1);
int newsTableListSize=newsTableList!=null?newsTableList.size():0;
NewsTable newsTable;

//查找该会员的问题！
String id=StrUtil.toHtmlTxt(request.getParameter("find_id"));
UserInfService userInfService=new UserInfService();
UserInf userInf=userInfService.getByPK(id);
if(userInf==null){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Your ID E-mail is wrong!');javascript:history.back(-1);</SCRIPT>");
    return;
}
String answer=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("answer"), true));
String fExe=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("f_exe"), true));

String passWordNew="";
if(fExe.equals("f_exe_go")){
  if(answer.equals(userInf.getAnswer())){//答案正确
    passWordNew=MathUtil.getRandomStr(6,6);
    int result=userInfService.findPassWord(id,passWordNew);
    if(result>0){  
       out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please remember your news Password!');</SCRIPT>");
    }else{ 
       passWordNew="";
       out.println("<SCRIPT LANGUAGE='JavaScript'>alert('The Password question Answer is wrong!');</SCRIPT>");
    }
  }else{
       out.println("<SCRIPT LANGUAGE='JavaScript'>alert('The Password question Answer is wrong!');</SCRIPT>");
  }
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:asp xmlns:uc1><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>

<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function f_p_on()
 {
 if (f_p.answer.value=="")
		{
			alert("Please input the Password question Answer!");
	        f_p.answer.value="";
	        f_p.answer.focus();	   
	        return false;
		}

   f_p.submit(); 
}

function f_on_reset()
{
f_p.reset();  
}
//-->
</SCRIPT>
<style type="text/css">
<!--
.STYLE6 {
	color: #878a8e;
	font-size: 12;
}
.STYLE9 {font-size: 12px}
.STYLE11 {color: #838383}
body {
	background-color: #FFFFFF;
}
.STYLE12 {color: #FFFFFF}
.STYLE13 {font-size: 12px; color: #333333; }
.STYLE14 {color: #000000}
.STYLE15 {color: #003366}
.STYLE16 {
	font-size: 16pt;
	font-weight: bold;
	color: #878a8e;
	font-family: "Times New Roman", Times, serif;
}
.STYLE20 {font-family: "Times New Roman", Times, serif; font-size: 14px; }
.STYLE23 {font-family: "Times New Roman", Times, serif; font-size: 9pt; }
.STYLE24 {
	color: #666666;
	font-weight: bold;
}
.STYLE26 {font-family: "Times New Roman", Times, serif; font-size: 9pt; color: #000000; }

.STYLE27 {
	color: #73B549;
	font-weight: bold;
}

.STYLE30 {font-size: 12px}
.STYLE31 {	color: #FFFFFF;
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</HEAD>
<BODY >
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
  <TR>
    <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center 
border=0>
            <TBODY>
              <TR>
                <TD width=778  valign="bottom">
				
				<%@ include file="header.jsp"%>				</TD>
              </TR>
            </TBODY>
          </TABLE></TD>
          </TR>
        </TBODY></TABLE></TD></TR>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD height=6><IMG height=1 
      width=1></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=774 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 height="221" vAlign=top bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0">
            
            
            <tr>
              <td height="195" valign="top"><div align="center">
                <table border="0" cellpadding="0" cellspacing="0">
                  
                  
                  <tr>
                    <td height="193" valign="top"><table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td><table width="191" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="191" height="33" background="img/about-1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="29%"><div align="right" class="STYLE31">News</div></td>
                                <td width="68%"><div align="right"><span class="STYLE12"><img src="img/07.jpg" width="18" height="16"><a href="news.jsp">more...&nbsp;</a>&nbsp;&nbsp;&nbsp;</span></div></td>
                              </tr>
                            </table></td>
                                      </tr>
                          <tr>
                            <td height="130" background="img/a3.jpg"><table width="94%" border="0" align="center" cellpadding="0" cellspacing="0">
                              <tr>
                                <td height="130" valign="top" bgcolor="#FFFFFF"><MARQUEE id=news onmouseover=news.stop() 
                              onmouseout=news.start() scrollAmount=2 
                              direction=up width="100%" height=168>
                                  <table width="100%" border="0" cellpadding="0" cellspacing="5">
                                    <%
                                      for(int i=0;i<newsTableListSize;i++){
                                         newsTable=newsTableList.get(i);
                                      %>									
                                    <tr>
                                      <td colspan="2"><span class="STYLE30"><a href="news_show.jsp?news_type=<%=newsTable.getNewsType()%>&&news_id=<%=newsTable.getNewsId()%>" class="STYLE26">·
<%=StrUtil.fomatStr(StrUtil.toHtmlTag(newsTable.getNewsTitle()),25)%></a></span></td>
                            </tr>
                                    <%}%>    
                                    </table>
                                                </MARQUEE></td>
                                            </tr>
                              </table></td>
                                      </tr>
                          <tr>
                            <td><img src="img/about.gif" width="191" height="8"></td>
                                      </tr>
                          </table></td>
                                </tr>
                      
                      
                                          </table>                        </td>
                          </tr>
                    </table>
                              
              </div></td>
                  </tr>
            <tr>
              <td height="26"><%@ include file="left.jsp"%></td>
            </tr>
            
            
          </table></TD>
          <TD width=592 rowspan="3" vAlign=top>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              
              <TBODY>
              <TR>
                <TD colspan="3"><div align="center"><script language="javascript">
	if (AC_FL_RunContent == 0) {
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
			'width', '580',
			'height', '133',
			'src', 'flash/home',
			'quality', 'high',
			'pluginspage', 'https://www.macromedia.com/go/getflashplayer',
			'align', 'middle',
			'play', 'true',
			'loop', 'true',
			'scale', 'showall',
			'wmode', 'transparent',
			'devicefont', 'false',
			'id', 'home_main',
			'name', 'home_main',
			'menu', 'true',
			'allowScriptAccess','sameDomain',
			'movie', 'flash/home',
			'salign', ''
			); //end AC code
	}
</script>
                </div></TD>
              </TR>
              <TR>
                <TD width="46" height=17>&nbsp;</TD>
                <TD width="496">&nbsp;</TD>
                <TD width="32">&nbsp;</TD>
              </TR>
              <TR>
                <TD height=30 colspan="3" valign="top">
				 <table width="97%" border="0" align="right" cellpadding="0" cellspacing="0">
                  
                  
                    <tr>
                      <td width="3%" height="30"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                      <td width="191"><span class="STYLE27">Forget Password</span></td>
                      <td width="368" align="right">
                          <span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">Forget Password</a> </td>
                      </tr>
                </table>                </TD>
              </TR>
              <TR>
                <TD height=3 colspan="3" valign="top"><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
                </TR>
              <TR>
                <TD height=81>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD height=98>&nbsp;</TD>
                <TD valign="top">
			<%if("".equals(passWordNew)){%>	
				<form  name="f_p" action="fp_do.jsp"   method="POST"  >  
				 
				  <table width="100%" border="0" cellpadding="0" cellspacing="0">
				    
				    <tr>
				      <td height="21" colspan="2" align="right" valign="top"><STRONG><SPAN lang="EN-US">Password   questionr&nbsp;&nbsp;</SPAN><strong>:</strong></STRONG>&nbsp;</td>
				        <td colspan="2" valign="top"><%=StrUtil.toHtmlTag(userInf.getQuestion())%></td>
				        </tr>
				    <tr>
				      <td width="61" height="8"></td>
				        <td width="79"></td>
				        <td width="160"></td>
				        <td width="196"></td>
				    </tr>
				    
				    <tr>
				      <TD height="21" colspan="2" align="right" valign="top"><STRONG><SPAN lang="EN-US">Answer&nbsp;&nbsp;</SPAN><strong>:</strong></STRONG>&nbsp;</TD>
                    <TD colspan="2" align="left" valign="top"><strong>
                      <input name="answer" type="text" class="STYLE23" id="answer" size="50" maxlength="150">
                       <input name="find_id" type="hidden" id="find_id" value="<%=id%>">
						  <input name="f_exe" type="hidden" id="f_exe" value="f_exe_go">
						  </strong></TD>
                    </tr>
				    
				    <tr>
				      <td height="21"></td>
                        <td>&nbsp;</td>
                        <td></td>
                        <td></td>
				    </tr>
				    <tr>
				      <td height="27"></td>
				      <TD colspan="2" align="center" valign="top">
                         
						  
                          <img src="img/s1.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:f_on_reset()"> &nbsp;&nbsp;&nbsp;
                          
                          <img src="img/s.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:f_p_on()"> </TD>
                        <td>&nbsp;</td>
				      </tr>
				      </table>
					</form>
				<%}else {%>Your news Password is :<%=passWordNew%>
				<%}%>					  </TD>
                <TD>&nbsp;</TD>
              </TR>
              </TBODY></TABLE></TD>
        </TR>
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>