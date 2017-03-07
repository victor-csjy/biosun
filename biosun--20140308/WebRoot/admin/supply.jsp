<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.SupplyTable"%>
<%@ page import="hk.com.biosun.service.SupplyTableService"%>
<%@ page import="hk.com.biosun.service.ConTableService"%>
<%@ page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp" %>
<%
int supply_id=MathUtil.toInt(request.getParameter("supply_id"));
int pageNo=MathUtil.toInt(request.getParameter("page"),1);
String supply_del=request.getParameter("supply_del");

int con_id=MathUtil.toInt(request.getParameter("con_id"));
String con_del=request.getParameter("con_del");

String supply_name=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("supply_name")));
String con_mail=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("con_mail")));
String con_name=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("con_name")));
String order_by=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("order_by")));
String submit_all=request.getParameter("submit_all");

SupplyTableService  supplyTableService=new SupplyTableService();
ConTableService  conTableService=new ConTableService();
ProductsTableService productsTableService=new ProductsTableService();

if(supply_del!=null&&supply_del.equals("ok")&&supply_id>0){
  int result=supplyTableService.delete(supply_id);
  conTableService.deleteBySupplyId(supply_id);
  productsTableService.deleteBySupplyId(supply_id);
  if(result>0){ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
   }else{ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");   
   }	
}

if(con_del!=null&&con_del.equals("ok")&&con_id>0){
  int result=conTableService.delete(con_id);
  if(result>0){ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
  }else{ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");   
  }	
}

List<Object> valuesList=new ArrayList<Object>();
StringBuffer condSB=new StringBuffer();
if(submit_all!=null){
   supply_name="";con_mail="";con_name="";
}else { 
     if(!supply_name.equals("")){
        condSB.append("WHERE supply_name LIKE ?");
        valuesList.add("%"+supply_name+"%");
     }
}
int recordCount=supplyTableService.getCount(condSB.toString(),valuesList);

if(!order_by.equals("")){
    condSB.append(" ORDER BY ");
    condSB.append(order_by); 
}

List<SupplyTable> supplyTableList=supplyTableService.getList(condSB.toString(),valuesList);
int supplyTableListSize=supplyTableList!=null?supplyTableList.size():0;
SupplyTable supplyTable;
int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
int pageCount=(recordCount-1)/pageSize+1;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit()
 {
 
}
  </script> 
  
  <SCRIPT language=javascript> 
//删除一条信息
function del()
{
   if(confirm("确定要删除此供应商和此供应商所有联系人以及该供应商的所有产品!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}

function del_con()
{
   if(confirm("确定要删除该联系人资料!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}


</SCRIPT>




 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="css/Style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
-->
</style>

</head>
<body>
<div align="center"> <form name="form1" method="POST" action="supply.jsp"  onSubmit="return on_submit()" ><table border="0" align="center" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
    
    
    <tr >
      <td width="8" height="22"  >&nbsp;</td>
      <td width="8"  >&nbsp;</td>
      <td width="11"  >&nbsp;</td>
      <td width="436"  >&nbsp;</td>
      <td width="515"></td>
    </tr>
    <tr >
      <td height="32"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td colspan="3" align="left" valign="top"  ><span class="STYLE2">
                      供应商管理——供应商信息
					
      </span>                    </td>
      </tr>
    <tr >
      <td height="51"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td></td>
    </tr>
    <tr >
      <td height="31"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td colspan="2" valign="top"  ><span class="bgcolor4">供应商名称</span>
        <input name="supply_name" type="text" id="supply_name" value="<%=supply_name%>"  size="19" maxlength="25" >
        <input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
        <input name="submit_find" type="submit"  id="submit_find" value="查  找">
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="submit_all" type="submit" id="submit_all" value="显示全部">
&nbsp;</td>
      </tr>
    <tr >
      <td height="20"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td></td>
    </tr>
    
    <tr >
      <td height="185"  >&nbsp;</td>
      <td colspan="4" valign="top"  ><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bordercolordark="#FFFFFF" >
        
        
        <tr>
          <td width="34" height="26" align="center" valign="middle" class="bgcolor4">Item No.</td>
              <TD width="187" vAlign=center class="bgcolor4"><a href="supply.jsp?pageSize=<%=pageSize%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=supply_name">供应商名称</a></TD>
              <TD width="138" class="bgcolor4">网址</TD>
	          <TD width="138" class="bgcolor4">
              <a href="supply.jsp?pageSize=<%=pageSize%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=supply_addr">公司地址</a></TD>
	          <TD width="89">公司电话</TD>
	          <TD width="89" class="bgcolor4">
              公司传真</TD>
	          <TD width="89" >备注</TD>
	          <TD width="57" class="bgcolor4"><a href="supply.jsp?pageSize=<%=pageSize%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=supply_date">日期</a></TD>
	          <TD class="bgcolor4">操作</TD>
            </tr>
        
        <%  for(int i=0;i<supplyTableListSize;i++){
               supplyTable=supplyTableList.get(i);
						  %>
        
        <tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'" onMouseOut="this.bgColor='#f8f8f8'">
          <td height="40" align="center" valign="middle" nowrap="nowrap"><%=(pageNo-1)*pageSize+i+1%></td>
              <TD nowrap="nowrap" align="left" vAlign=middle><a href="supply_change.jsp?supply_id=<%=supplyTable.getSupplyId()%>" target="_self"><%=supplyTable.getSupplyName()%></a></TD>
              <TD nowrap="nowrap" vAlign=middle><a href="<%=supplyTable.getSupplyHttp()%>" target="_blank"><%=supplyTable.getSupplyHttp()%></a></TD>
	          <TD nowrap="nowrap" vAlign=middle ><%=supplyTable.getSupplyAddr()%></TD>
	           <TD nowrap="nowrap" vAlign=middle><%=supplyTable.getSupplyTel()%></TD>
	           <TD nowrap="nowrap" vAlign=middle ><%=supplyTable.getSupplyFax()%></TD>
	           <TD nowrap="nowrap" vAlign=middle ><%=supplyTable.getSupplyOther()%></TD>
	           <TD nowrap="nowrap"><%=supplyTable.getSupplyDate()%></TD>
			   <TD nowrap="nowrap">
			   <a href="supply_change.jsp?supply_id=<%=supplyTable.getSupplyId()%>" target="_self">修改</a> 
		       <a href="supply.jsp?pageSize=<%=pageSize%>&&supply_id=<%=supplyTable.getSupplyId()%>&&page=<%=pageNo%>&&supply_del=ok&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>" onClick="return del();">删除</a>  <a href="con_list.jsp?supply_id=<%=supplyTable.getSupplyId()%>" target="_self">联系人</a> </TD>
          </tr>
        <%  }
		if(supplyTableListSize>0){ %> 
        <tr>
          <td height="31" colspan="9" align="center" valign="middle" > <div align="center"> 
            
            <%
		if(pageNo>1){ %>
            <a href="supply.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo-1)%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>">上一页</a>&nbsp;&nbsp; 
            <%}
		 if (pageNo<pageCount)
		 { %>
            <a href="supply.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo+1)%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>">下一页</a>
            <% }
        %>
            &nbsp;&nbsp;&nbsp;&nbsp;共<strong><%=pageCount%></strong>页<strong><%=recordCount%></strong>条记录 
            &nbsp;&nbsp;&nbsp;&nbsp;
            <SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION  value=supply.jsp?pageSize=20&&page=<%=pageNo%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>>20</OPTION>
<OPTION  value=supply.jsp?pageSize=30&&page=<%=pageNo%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>>30</OPTION>
<OPTION  value=supply.jsp?pageSize=50&&page=<%=pageNo%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>>50</OPTION>
<OPTION  value=supply.jsp?pageSize=75&&page=<%=pageNo%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>>75</OPTION>
<OPTION  value=supply.jsp?pageSize=100&&page=<%=pageNo%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>>100</OPTION>
</select>条/页&nbsp;&nbsp; 
            <label>第
              <SELECT name=menu1 onChange="javascript:location.href=this.options(this.selectedIndex).value;" >
                <OPTION value=# selected><%=pageNo%></OPTION>
                 <%
                                                                int pageMin=pageNo-20;
																pageMin=pageMin<1?1:pageMin;
																int pageMax=pageNo+20;
																pageMax=pageMax>pageCount?pageCount:pageMax;
																if(pageMin>pageMax){
																   pageMin=pageMax;
																}
																for (int i = pageMin; i <= pageMax; i++) {
																		if (i == pageNo)
																			continue;
																			%>
                <OPTION  value=supply.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&supply_name=<%=supply_name%>&&con_mail=<%=con_mail%>><%=i%></OPTION>
                <%}%>
                </select>
            </label>页</div></td>
            </tr>
        <%} else {%>  
        
        
        <tr>
          <td height="22" colspan="9" align="center" valign="middle"><font color="#FF0000">没有记录！</td>
            </tr>
        <%}%>    
      </table></td>
    </tr>
   
  </table>  
  </form>
<br><br>
</div>
</body>
</html>