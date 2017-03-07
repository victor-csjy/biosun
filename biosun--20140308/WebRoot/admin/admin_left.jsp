<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.model.Admin"%>
<%@include file="session_admin.jsp" %>
<%
NewsType newsType;
NewsTypeService newsTypeService=new NewsTypeService();
List<NewsType> newsTypeList=newsTypeService.getList();
int newsTypeListSize=newsTypeList!=null?newsTypeList.size():0;
Admin admin = SessionUtil.getAdmin(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Menu</title>
<script language=JavaScript type=text/JavaScript>
<!--
function showlayer(layerid) 
{ 
 var layerObj=document.getElementById(layerid);
 layerObj.style.visibility="visible";   
}
function hiddlelayer(layerid) 
{ 
 var layerObj=document.getElementById(layerid);
 layerObj.style.visibility="hidden";  
}
//-->
</script>
<style type="text/css">
BODY {
	BACKGROUND:#9aadcd; MARGIN: 0px; FONT: 9pt 宋体;
	SCROLLBAR-HIGHLIGHT-COLOR: ;
	SCROLLBAR-ARROW-COLOR:#C1C0B7;
	SCROLLBAR-TRACK-COLOR:#FFFFFF;
	SCROLLBAR-BASE-COLOR:#C1C0B7;
}
TD { FONT: 12px 宋体}
A { FONT: 12px 宋体; COLOR: #000000; TEXT-DECORATION: none }
A:hover { COLOR: #428eff; TEXT-DECORATION: underline}

.sec_menu 
{
	BORDER-RIGHT: white 1px solid; BACKGROUND: #EFEFEF; 
	OVERFLOW: hidden; BORDER-LEFT: white 1px solid; BORDER-BOTTOM: white 1px solid 
}

.menu_title SPAN { FONT-WEIGHT: bold; LEFT: 8px; COLOR: #215dc6; POSITION: relative; TOP: 2px }

.menu_title2 SPAN { FONT-WEIGHT: bold; LEFT: 8px; COLOR: #428eff; POSITION: relative; TOP: 2px }
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
</style>
<script>
function showsubmenu(sid)
{
	whichEl = document.getElementById("submenu" + sid);
	menuTitle =document.getElementById("menuTitle" + sid);
	if (whichEl.style.display == "none")
	{
	whichEl.style.display="block";
	menuTitle.background="images/title_bg_hide.gif";
	}
	else
	{
	whichEl.style.display="none";
	menuTitle.background="images/title_bg_show.gif";
	}
}
</script>
</head>
<body>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="154" height="40" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="">
        <!--DWLayoutTable-->
        <tr>
          <td width="156" height="14">&nbsp;</td>
        </tr>
        <tr>
          <td height="26" align="center" valign="middle"><span class="STYLE1">博生科技有限公司</span></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="25" background="images/title_bg_quit.gif" class="menu_title" onMouseOver="this.className='menu_title2';" 

onMouseOut="this.className='menu_title';"><span><a target="rightFrame" title="返回管理首页" href="index_face.jsp"><b><font 

color="215DC6">管理首页</font></b></a>|<a target="_parent" title="安全退出管理系统" href="exit.jsp"><b><font color="215DC6"> 安全退出</font></b></a></span>
  <tr>
    <td height="28" background="images/title_bg_quit.gif" class="menu_title2" onMouseOver="this.className='menu_title2';" 

onMouseOut="this.className='menu_title';"><span class="menu_title"><b><font color="215DC6">登录用户：</font><font 

color="#0000FF"><%=admin.getAdminName()%></font></b></span> <br/>
  </tr>
  <tr>
    <td height="25" align="left" valign="middle" background="images/title_bg_quit.gif" class="menu_title2" 

onMouseOver="this.className='menu_title2';" onMouseOut="this.className='menu_title';"><a href="../index.jsp" title="进入前台" 

target="_blank"> <span class="menu_title"><font color="215DC6">进入前台!</font></span></a> 
  </tr>
  <tr>
    <td height="25">&nbsp;<br/>
      <br/></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle1" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(1)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>系统管理</span></td>
  </tr>
  <tr>
    <td id="submenu1" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <!--DWLayoutTable-->
          <tr>
            <td width="131" height="22"><a href="../help.jsp" title="系统帮助" target="rightFrame">系统帮助</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="change_pw.jsp" title="管理员修改密码" target="rightFrame">修改密码</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="p_number.jsp" title="首页产品个数设定" target="rightFrame">首页产品</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="mail_set.jsp" title="邮箱设置" target="rightFrame">邮箱设置</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="flash_set.jsp" title="Flash管理" target="rightFrame">Flash管理</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="admin_log.jsp" title="登录日志" target="rightFrame">登录日志</a></td>
          </tr>
          <tr>
            <td width="131" height="22"><a href="splace_status.jsp" title="空间使用情况" target="rightFrame">空间情况 </a></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle2" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(2)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>综合文章</span></td>
  </tr>
  <tr>
    <td id="submenu2" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><p><a href="index_content.jsp"  title="index_content" target="rightFrame">index</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="article.jsp?article_type=about_us"  title="About Us" target="rightFrame">About 
                
                Us</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="article.jsp?article_type=sale_and_market"  title="Sale and Market" 

target="rightFrame">Sale and Market</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="article.jsp?article_type=service"  title="Service" 

target="rightFrame">Service</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="article.jsp?article_type=careers"  title="Careers" 

target="rightFrame">Careers</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="article.jsp?article_type=contact"  title="Contact" 

target="rightFrame">Contact</a></p></td>
          </tr>
          <tr>
            <td height="22"><p><a href="terms_of_use.jsp"  title="Terms of Use" target="rightFrame">Terms of Use</a></p></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle3" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(3)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" 

height="25"><span>Events</span></td>
  </tr>
  <tr>
    <td id="submenu3" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><a href="news_type.jsp" title="类别管理" target="rightFrame">类别管理</a></td>
          </tr>
          <%for(int i=0;i<newsTypeListSize;i++){
		     newsType=newsTypeList.get(i);
		  %>
          <tr>
            <td height="22"><a href="news_m.jsp?news_type=<%=newsType.getNewsType()%>" title="<%=newsType.getNewsName()%>" 

target="rightFrame"><%=StrUtil.toHtmlTag(newsType.getNewsName())%></a></td>
          </tr>
          <%}%>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle12" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(12)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>供应商管理</span></td>
  </tr>
  <tr>
    <td id="submenu12" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><a href="supply.jsp" title="供应商信息" target="rightFrame">供应商信息</a></td>
          </tr>
          <tr>
            <td height="22"><a href="supply_add.jsp" title="添加供应商" target="rightFrame">添加供应商</a></td>
          </tr>
          <tr>
            <td height="22"><a href="con_add.jsp" title="添加联系人" target="rightFrame">添加联系人</a></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle4" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(4)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" 

height="25"><span>Products</span></td>
  </tr>
  <tr>
    <td id="submenu4" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><a href="product_class.jsp" title="类别管理" target="rightFrame">类别管理</a></td>
          </tr>
          <tr>
            <td height="22"><a href="product.jsp" title="产品管理" target="rightFrame">产品管理</a></td>
          </tr>
          <tr>
            <td height="22"><a href="product_add.jsp" title="添加产品" target="rightFrame">添加产品</a></td>
          </tr>
          <tr>
            <td height="22"><a href="com.jsp" title="产品评论" target="rightFrame">产品评论</a></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle5" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(5)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>会员管理</span></td>
  </tr>
  <tr>
    <td id="submenu5" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><a href="reg_user_contract.jsp" title="Regstered User Contract"  target="rightFrame">Reg. User 
              
              Contract</a></td>
          </tr>
          <tr>
            <td height="22"><a href="user_inf.jsp" title="会员管理"  target="rightFrame">会员管理</a></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle6" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(6)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>Enquiry 
      
      Manage</span></td>
  </tr>
  <tr>
    <td id="submenu6" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"><a href="enquiry_m.jsp"  title="Enquiry List"  target="rightFrame">Enquiry List</a></td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle10" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(10)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>流量统计</span></td>
  </tr>
  <tr>
    <td id="submenu10" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22" valign="bottom"><a href="http://www.51.la/?730387" 

target="rightFrame">www.51.la&nbsp;&nbsp;&nbsp;<img src="http://img.users.51.la/730387.asp" 

alt="&#x6211;&#x8981;&#x5566;&#x514D;&#x8D39;&#x7EDF;&#x8BA1;" width="27" height="22" style="border:none" /></a> </td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<table cellspacing="0" cellpadding="0" width="155" align="center">
  <tr>
    <td class="menu_title" id="menuTitle102" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(102)" 

onMouseOut="this.className='menu_title';" style="cursor:hand" background="images/title_bg_show.gif" height="25"><span>Google 
      
      Analytics</span></td>
  </tr>
  <tr>
    <td id="submenu102" style="DISPLAY: none"><div class="sec_menu" style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22" valign="bottom"><a href="https://www.google.com/analytics/reporting/dashboard?id=3275180" 

target="rightFrame">Google Analytics</a> </td>
          </tr>
        </table>
      </div>
      <div style="WIDTH: 155px">
        <table cellspacing="0" cellpadding="0" width="135" align="center">
          <tr>
            <td height="22"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
</body>
</html>
