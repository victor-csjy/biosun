<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%
	UserInf userInfSesLeft = SessionUtil.getUserInf(request);
	BigTableService bigTableServiceLeft = new BigTableService();
	BigTable bigTableLeft;
	List<BigTable> bigTableListLeft = bigTableServiceLeft
			.getListFront();
	int bigTableListSizeLeft = bigTableListLeft == null
			? 0
			: bigTableListLeft.size();

	SmallTableService smallTableServiceLeft = new SmallTableService();
	SmallTable smallTableLeft;
	List<SmallTable> smallTableListLeft;
	int smallTableListSizeLeft = 0;
%>
<script language="javascript">
function showsubmenu_left(sid_left)
{
	whichEl_left = document.getElementById("submenu_left" + sid_left);
	menuTitle_left = document.getElementById("menuTitle_left" + sid_left);
	change_bg = document.getElementById("change" + sid_left);
	
	if (whichEl_left.style.display == "none")
	{
	whichEl_left.style.display="block";
	change_bg.background="img/zk.gif";
	}
	else
	{
	whichEl_left.style.display="none";
	change_bg.background="img/dian.gif";
	}
}


   function form_login_on()
 {
 if (form_login.id.value.length>8)
		{
			for (i=0; i<form_login.id.value.length; i++)
			  if (form_login.id.value.charAt(i)=="@")
					break;
			if (i==form_login.id.value.length||i==0||i==(form_login.id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  form_login.id.focus();
			  return false;
			 }	
		}
  else
       {
        alert("Please input the ID!");
		form_login.id.focus();
		return false;

        }
if (form_login.id.value.length>8)
		{
			for (i=0; i<form_login.id.value.length; i++)
			  if (form_login.id.value.charAt(i)==".")
					break;
			if (i==form_login.id.value.length||i==0||i==(form_login.id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  form_login.id.focus();
			  return false;
			 }	
		}
		
		
if(form_login.password.value.length<6)
  {
    alert("Password:6+ letter or number!");
	form_login.password.value="";
	form_login.password.focus();	   
	return false;
  }				

  }
</script>

<style type="text/css">
<!--
.menu_close {
	background: background : url(img/dian.gif);
}

.menu_open {
	background: background : url(img/zk.gif);
}
-->
</style>

<form name=form_left9 action="product_list.jsp" method="POST">
	<table width="191" border="0" cellpadding="0" cellspacing="0">
		<%
			if (userInfSesLeft != null) {
		%>
		<tr>
			<td height="13" colspan="2" align="left" valign="middle">
				<div align="left" class="STYLE24">
					&nbsp;&nbsp;Welcome on board
				</div>
			</td>
		</tr>
		<tr>
			<td height="18" colspan="2">
				<div align="center" class="STYLE24">
					<%
						if ("1".equals(userInfSesLeft.getSex()))
								out.print("Mr.");
							else
								out.print("Ms.");
					%>
					&nbsp;&nbsp;<%=StrUtil.toHtmlTag(userInfSesLeft.getPerson())%>&nbsp;!
				</div>
			</td>
		</tr>
		<tr>
			<td height="13" colspan="2">
				<div align="center">
					<a href="change_inf.jsp" class="STYLE26"> Update Info</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<a href="exit.jsp" class="STYLE26">Sign Out</a>
				</div>
			</td>
		</tr>
		<%
			}
			if (userInfSesLeft == null) {
		%>

		<tr>
			<td height="13" colspan="2">
				<div align="left" class="STYLE24">
					&nbsp;&nbsp;Search
				</div>
			</td>
		</tr>
		<tr>
			<td height="19" colspan="2" align="center">
				<div align="center">
					<select name="big_small" style="width: 179px">
						<option value="">
							All Products
						</option>
						<%
							for (int i = 0; i < bigTableListSizeLeft; i++) {
									bigTableLeft = bigTableListLeft.get(i);
						%>
						<option value="<%=bigTableLeft.getBigId()%>_"><%=StrUtil.toHtmlTxt(bigTableLeft
											.getBigName())%></option>
						<%
							smallTableListLeft = smallTableServiceLeft
											.getListFront(bigTableLeft.getBigId());
									smallTableListSizeLeft = smallTableListLeft == null
											? 0
											: smallTableListLeft.size();
									for (int j = 0; j < smallTableListSizeLeft; j++) {
										smallTableLeft = smallTableListLeft.get(j);
						%>
						<option
							value="<%=smallTableLeft.getBigId()%>_<%=smallTableLeft.getSmallId()%>">
							&nbsp;&nbsp;|-
							<%=StrUtil.toHtmlTxt(smallTableLeft
										.getSmallName())%></option>
						<%
							}
								}
						%>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td height="13" colspan="2">
				<div align="left" class="STYLE24">
					&nbsp;&nbsp;Keyword
				</div>
			</td>
		</tr>
		<tr>
			<td width="159" height="20" valign="top">
				&nbsp;&nbsp;
				<input name="key_word" type="text" class="STYLE23" id="key_word"
					size="10">
			</td>
			<td width="27" align="center" valign="bottom">
				<input name="" type="image" src="img/05.jpg" />
			</td>
		</tr>

		<%
			}
		%>
	</table>
</form>
<table width="191" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="20">
			<div align="center"></div>
		</td>
	</tr>
</table>
<table width="191" border="0" cellpadding="0" cellspacing="0">
	<%
		for (int i = 0; i < bigTableListSizeLeft; i++) {
			bigTableLeft = bigTableListLeft.get(i);
	%>
	<tr id="menuTitle_left<%=i%>" onClick="showsubmenu_left(<%=i%>)"
		style="cursor: pointer;">
		<td width="30" height="15"></td>
		<td width="73" id="change<%=i%>" valign="top"
			background="img/dian.gif">
			&nbsp;&nbsp;
		</td>
		<td width="26"></td>
		<td width="786" rowspan="2" align="left" valign="top">
			<a href="product_big.jsp?big_id=<%=bigTableLeft.getBigId()%>"
				class="STYLE26"><%=StrUtil.toHtmlTxt(bigTableLeft.getBigName())%></a>
		</td>
	</tr>
	<tr id="menuTitle_left<%=i%>" onClick="showsubmenu_left(<%=i%>)"
		style="cursor: hand">
		<td height="1"></td>
		<td></td>
		<td></td>
	</tr>


	<tr>
		<td height="11" colspan="4">
			<div align="left">
				<img src="img/0.gif" width="191" height="11">
			</div>
		</td>
	</tr>
	<tr>
		<td id="submenu_left<%=i%>" style="DISPLAY: none" colspan="4"
			valign="top">
			<div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<%
						smallTableListLeft = smallTableServiceLeft
									.getListFront(bigTableLeft.getBigId());
							smallTableListSizeLeft = smallTableListLeft == null
									? 0
									: smallTableListLeft.size();
							for (int j = 0; j < smallTableListSizeLeft; j++) {
								smallTableLeft = smallTableListLeft.get(j);
					%>
					<tr>
						<td width="26" height="17" align="right" valign="middle">
							&nbsp;&nbsp;
						</td>
						<td width="161" align="left" valign="top">
							<img src="img/pc-17a.gif" width="8" height="9" />
							<a
								href="product_list.jsp?big_id=<%=smallTableLeft.getBigId()%>&&small_id=<%=smallTableLeft.getSmallId()%>"
								class="STYLE26"> <%=StrUtil.toHtmlTxt(smallTableLeft.getSmallName())%></a>
						</td>
					</tr>
					<tr>
						<td height="2"></td>
						<td></td>
					</tr>
					<tr>
						<td height="11" colspan="2" valign="top">
							<div align="left">
								<img src="img/0.gif" width="191" height="11">
							</div>
						</td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<%
				}
			%>
		</td>
	</tr>
</table>
<table width="191" border="0" cellpadding="0" cellspacing="0">
</table>
<%
	if (userInfSesLeft != null) {//登陆后
%>
<form name=form_left10 action="product_list.jsp" method="POST">

	<table width="191" border="0" cellpadding="0" cellspacing="0">

		<tr>
			<td height="15" colspan="2">
				&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td height="13" colspan="2">
				<div align="left" class="STYLE24">
					&nbsp;&nbsp;Search
				</div>
			</td>
		</tr>
		<tr>
			<td height="19" colspan="2">
				<div align="center">
					<select name="big_small" style="width: 179px">
						<option value="">
							All Products
						</option>
						<%
							for (int i = 0; i < bigTableListSizeLeft; i++) {
									bigTableLeft = bigTableListLeft.get(i);
						%>
						<option value="<%=bigTableLeft.getBigId()%>_"><%=StrUtil.toHtmlTxt(bigTableLeft
											.getBigName())%></option>
						<%
							smallTableListLeft = smallTableServiceLeft
											.getListFront(bigTableLeft.getBigId());
									smallTableListSizeLeft = smallTableListLeft == null
											? 0
											: smallTableListLeft.size();
									for (int j = 0; j < smallTableListSizeLeft; j++) {
										smallTableLeft = smallTableListLeft.get(j);
						%>
						<option
							value="<%=smallTableLeft.getBigId()%>_<%=smallTableLeft.getSmallId()%>">
							&nbsp;&nbsp;|-
							<%=StrUtil.toHtmlTxt(smallTableLeft
										.getSmallName())%></option>
						<%
							}
								}
						%>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td height="13" colspan="2">
				<div align="left" class="STYLE24">
					&nbsp;&nbsp;Keyword
				</div>
			</td>
		</tr>
		<tr>
			<td width="818" height="22" valign="top">
				&nbsp;&nbsp;
				<input name="key_word" type="text" class="STYLE23" id="key_word"
					size="10">
			</td>
			<td width="141" valign="top" align="center">
				<input name="" type="image" src="img/05.jpg" />
			</td>
		</tr>

	</table>
</form>
<%
	}

	if (userInfSesLeft == null) {
%>
<form name="form_login" action="login_do.jsp" method="POST"
	onSubmit="return form_login_on()">
	<table width="191" border="0" cellpadding="0" cellspacing="0">

		<tr>
			<td width="330" height="15">&nbsp;
				
			</td>
			<td colspan="2">&nbsp;
				
			</td>
		</tr>
		<tr>
			<td width="330" height="26">
				<div align="left">
					<strong>&nbsp; User ID:</strong>
				</div>
			</td>
			<td colspan="2">
				<strong> <input name="id" type="text" class="STYLE23"
						id="id" size="15" maxlength="150"> </strong>
			</td>
		</tr>
		<tr>
			<td height="19">
				<div align="left">
					<strong> &nbsp;&nbsp;Password<strong>:</strong>
					</strong>
				</div>
			</td>
			<td colspan="2">
				<strong> <input name="password" type="password"
						class="STYLE23" id="password" size="15" maxlength="50"> <input
						name="login" type="hidden" id="login" value="go_test"> </strong>
			</td>
		</tr>
		<tr>
			<td height="6"></td>
			<td width="614"></td>
			<td width="14"></td>
		</tr>
		<tr>
			<td height="13" colspan="2" valign="top">
				<div align="right" class="STYLE23">
					<a href="find_password.jsp" class="STYLE26">Forget Password!</a>
				</div>
			</td>
			<td>&nbsp;
				
			</td>
		</tr>
		<tr>
			<td height="6"></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td height="20" colspan="3" valign="top" nowrap="nowrap">&nbsp;<a href="reg.jsp"><img src="img/up1.jpg" width="120" height="20" border="0"></a>&nbsp;<input name="" type="image" src="img/in.gif" />&nbsp;</td>
	  </tr>
		<tr>
			<td height="20" colspan="3" valign="top">&nbsp;
				
			</td>
		</tr>

	</table>
</form>
<%
	}
%>
