<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.model.SupplyTable"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@page import="hk.com.biosun.service.SupplyTableService"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="com.aokle.util.PathUtil"%>
<%@page import="com.aokle.util.FileUtil"%>
<%@include file="session_admin.jsp"%>
<%
	int big_id = MathUtil.toInt(request.getParameter("big_id"));
	int small_id = MathUtil.toInt(request.getParameter("small_id"));

	String p_model = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("p_model")));
	int supply_id = MathUtil.toInt(request.getParameter("supply_id"));
	String p_date = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("p_date")));

	String order_by = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_by")));

	int pageNo = MathUtil.toInt(request.getParameter("page"), 1);
	String Action = request.getParameter("Action");
	String submit_find = request.getParameter("submit_find");
	String submit_all = request.getParameter("submit_all");

	int p_id = MathUtil.toInt(request.getParameter("p_id"));
	String p_del = request.getParameter("p_del");
	int ecNo = MathUtil.toInt(request.getParameter("ecNo"));
	String p_del_ec = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("p_del_ec")));

	ProductsTableService productsTableService = new ProductsTableService();
	ProductsTable productsTable;
	if (p_del != null && p_del.equals("ok")) {
		productsTable = productsTableService.getByPK(p_id);
		if (productsTable == null) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
		} else {
			int result = productsTableService.deleteByPk(p_id);
			if (result > 0) {
				String realPath = PathUtil.getRealPath();
				if (productsTable.getPPic() != null
						&& !"".equals(productsTable.getPPic())) {
					FileUtil.deleteFile(realPath + "product/pic/"
							+ productsTable.getPPic());
					FileUtil.deleteFile(realPath + "product/pic/small"
							+ productsTable.getPPic());
				}
				if (productsTable.getEc1() != null
						&& !"".equals(productsTable.getEc1())) {
					FileUtil.deleteFile(realPath + "product/ec/"
							+ productsTable.getEc1());
				}
				if (productsTable.getEc2() != null
						&& !"".equals(productsTable.getEc2())) {
					FileUtil.deleteFile(realPath + "product/ec/"
							+ productsTable.getEc2());
				}

				out
						.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
			} else {
				out
						.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
			}
		}
	}
	if ("ok".equalsIgnoreCase(p_del_ec)) {
		productsTable = productsTableService.getByPK(p_id);
		if (productsTable == null) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
		} else {
			int result = 0;
			if (ecNo == 1) {
				result=productsTableService.deleteEc(productsTable.getPId(),"ec_1",productsTable.getEc1());
			} else {
				result=productsTableService.deleteEc(productsTable.getPId(),"ec_2",productsTable.getEc2());
			}
			if (result > 0) {
				out
						.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
			} else {
				out
						.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
			}
		}
	}

	List<Object> valuesList = new ArrayList<Object>();
	StringBuffer condSB = new StringBuffer();
	if (submit_all != null) {
		big_id = 0;
		small_id = 0;
		p_model = "";
		supply_id = 0;
		order_by = "";
		p_date = "";
	} else {
	    if (p_id > 0) {
			//sql=sql+" and products_table.big_id="+Integer.parseInt(big_id); 
			condSB.append(" AND p_id=?");
			valuesList.add(p_id);
		}
		if (big_id > 0) {
			//sql=sql+" and products_table.big_id="+Integer.parseInt(big_id); 
			condSB.append(" AND big_id=?");
			valuesList.add(big_id);
		}
		if (small_id > 0) {
			//sql=sql+" and products_table.small_id="+Integer.parseInt(small_id);
			condSB.append(" AND small_id=?");
			valuesList.add(small_id);
		}
		if (!p_model.equals("")) {
			//sql=sql+" and p_model like '%"+p_model+"%'";
			condSB.append(" AND p_model LIKE ?");
			valuesList.add("%" + p_model + "%");
		}
		if (supply_id > 0) {
			//sql=sql+" and supply_name like '%"+supply_name+"%'";
			condSB.append(" AND supply_id=?");
			valuesList.add(supply_id);
		}
		if (!p_date.equals("")) {
			//sql=sql+" and p_date like '"+p_date+"%'";
			condSB.append(" AND p_date LIKE ?");
			valuesList.add("%" + p_date + "%");
		}
	}
	if(condSB.length()>4){
	  condSB.delete(0,4);
	  condSB.insert(0,"WHERE");
	}
	
	int recordCount = productsTableService.getCount(condSB.toString(),
			valuesList);
	condSB.append(" ORDER BY ");

	if (order_by.equals("")) {
		condSB.append("order_id,p_date DESC");

	} else if ("order_id".equals(order_by)
			|| "index_order".equals(order_by)) {
		condSB.append(order_by);
	} else if ("gross_profit".equals(order_by)) {
		condSB.append("(bs_price-bs_cg_price) DESC");
	} else if ("profit_rate".equals(order_by)) {
		condSB.append("(bs_price-bs_cg_price)/bs_cg_price DESC");
	} else {
		condSB.append(order_by + " DESC");
	}
	int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<ProductsTable> productsTableList = productsTableService
			.getList(condSB.toString(), valuesList, pageSize, pageNo);
	int productsTableListSize = productsTableList != null ? productsTableList
			.size()
			: 0;
	int pageCount = (recordCount - 1) / pageSize + 1;

	BigTableService bigTableService = new BigTableService();
	BigTable bigTable;
	List<BigTable> bigTableList = bigTableService.getList();
	int bigTableListSize = bigTableList != null ? bigTableList.size()
			: 0;
	SmallTableService smallTableService = new SmallTableService();
	SmallTable smallTable;
	List<SmallTable> smallTableList = smallTableService.getList();
	int smallTableListSize = smallTableList != null ? smallTableList
			.size() : 0;
	SupplyTableService supplyTableService = new SupplyTableService();
	SupplyTable supplyTable;
	List<SupplyTable> supplyTableList = supplyTableService.getList();
	int supplyTableListSize = supplyTableList != null ? supplyTableList
			.size() : 0;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<SCRIPT language=javascript> 
//删除一条信息
function del()
{
   if(confirm("确定要删除此产品以及该产品的所有评论，并且不能恢复！"))
     return true;
   else
     return false;
	 
}
function delEc(ecNo){
    if(confirm("确定要删除此产品附件"+ecNo+"?"))
     return true;
    else
     return false;
}

</SCRIPT>

	<script language="JavaScript">
var onecount;
onecount=0;
subcat = new Array();
 <%
int count = 0;
String sName="";
for(int i=0;i<smallTableListSize;i++){
    smallTable=smallTableList.get(i);
    sName=smallTable.getSmallCode()+"——"+smallTable.getSmallName();
%>
subcat[<%=count%>] = new Array("<%=sName%>","<%=smallTable.getBigId()%>","<%=smallTable.getSmallId()%>");//产生数组
<%
        count = count + 1;
}
%>
onecount=<%=count%>;

function changelocation(id)
    {
    document.form1.small_id.length = 0; 

    var id=id;
    var i;
    document.form1.small_id.options[0] = new Option('全部','');
    for (i=0;i < onecount; i++)
        {
            if (subcat[i][1] == id)
            { 
         document.form1.small_id.options[document.form1.small_id.length] = new Option(subcat[i][0], subcat[i][2]);
            }        
        }
        
    }      
    
</script>
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
		<div align="center">
			<br>
			<form name="form1" method="POST" action="product.jsp">
				<table width="4000" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="10" height="32">&nbsp;
							

						</td>
						<td colspan="3" align="left" valign="top">
							<span class="STYLE2"> Products——产品管理 </span>
						</td>
						<td width="57">&nbsp;
							

						</td>
						<td width="2039"></td>
						<td width="1029"></td>
					</tr>

					<tr>
						<td height="27">&nbsp;
							

						</td>
						<td width="110">&nbsp;
							

						</td>
						<td colspan="3">
							大类
							<label>
								<select name="big_id"
									onChange="changelocation(document.form1.big_id.options[document.form1.big_id.selectedIndex].value)"
									size="1">
									<option value="0">
										全部
									</option>
									<%
										String bName = "";
										for (int i = 0; i < bigTableListSize; i++) {
											bigTable = bigTableList.get(i);
											bName = bigTable.getBigCode() + "——" + bigTable.getBigName();
									%>
									<option value="<%=bigTable.getBigId()%>"><%=bName%></option>
									<%
										}
									%>
								</select>
								<script language="JavaScript">
<!--
  form1.big_id.value="<%=big_id%>"
//-->
</script>
							</label>
							&nbsp;&nbsp;小类
							<select name="small_id">
								<option value="0">
									全部
								</option>
								<%
									for (int i = 0; i < smallTableListSize; i++) {
										smallTable = smallTableList.get(i);
								%>
								<option value="<%=smallTable.getSmallId()%>"><%=smallTable.getSmallName()%></option>
								<%
									}
								%>
							</select>

							<script language="JavaScript">
<!--
  form1.small_id.value="<%=small_id%>"
//-->
</script>
						</td>
						<td></td>
						<td></td>
					</tr>

					<tr>
						<td height="26">&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td colspan="3">
							产品型号
							<input name="p_model" type="text" id="p_model"
								value="<%=p_model%>" size="19" maxlength="25">
							&nbsp;&nbsp;供应商
							<select name="supply_id" id="supply_id">
								<option value="">
									请选择
								</option>
								<%
									for (int i = 0; i < supplyTableListSize; i++) {
										supplyTable = supplyTableList.get(i);
								%>
								<option value="<%=supplyTable.getSupplyId()%>"><%=supplyTable.getSupplyName()%></option>
								<%
									}
								%>
								<script language="JavaScript">
<!--
  form1.supply_id.value="<%=supply_id%>"
//-->
</script>
							</select>

							&nbsp;&nbsp;发布日期
							<input name="p_date" type="text" id="p_date" value="<%=p_date%>"
								size="19" maxlength="25">
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td height="26">&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td width="69">&nbsp;
							

						</td>
						<td width="686" align="left" valign="middle">
                            <input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
							<input name="submit_find" type="submit" id="submit_find"
								value="查  找">
							&nbsp;&nbsp;&nbsp;&nbsp;
                            
							<input name="submit_all" type="submit" id="submit_all"
								value="显示全部">
							&nbsp;
						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
					</tr>
					<tr>
						<td height="18">&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
					</tr>
					<tr>
						<td height="193">&nbsp;
							

						</td>
						<td colspan="5" valign="top">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">
								<tr>
									<TD width="1%" height="38" vAlign=center class="bgcolor4">
										Item No.
									</TD>


									<TD width="3%" align="center" vAlign=center class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=p_model">产品型号</a>
									</TD>



									<TD width="3%" align="center" vAlign=center class="bgcolor4">
										Part Number
									</TD>





									<TD width="4%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=p_name">产品名称</a>
									</TD>



									<TD width="2%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=public_price">Public
											Price</a>
									</TD>


									<TD width="2%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=bs_price">Deal
											Price</a>
									</TD>
									<TD width="2%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=bs_cg_price">Bioson
											Cost</a>
									</TD>



									<TD width="2%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=gross_profit">Gross
											Profit</a>
									</TD>
									<TD width="2%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=profit_rate">Profit
											Rate</a>
									</TD>



									<TD width="3%" align="center">
										产品图片
									</TD>
									<TD width="4%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=big_id">所属大类</a>
									</TD>


									<TD width="2%" align="center">
										大类编码
									</TD>



									<TD width="4%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=small_id">所属小类</a>
									</TD>

									<TD width="2%" align="center">
										小类编码
									</TD>

									<TD width="2%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=small_strong">小类内权重</a>
									</TD>

									<TD width="5%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=supply_name">供应商</a>
									</TD>


									<TD width="2%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=supply_model">供应商型号</a>
									</TD>
									<TD width="5%" align="center" class="bgcolor4">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=model_name">对应名称</a>
									</TD>
									<TD width="4%" align="center">
										附件1
									</TD>
									<TD width="4%" align="center">
										附件2
									</TD>
									<TD width="1%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=browse">浏览次数</a>
									</TD>
									<TD width="1%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=ask_times">询单次数</a>
									</TD>
									<TD width="1%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=com_times">评论次数</a>
									</TD>

									<TD width="1%">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=order_id">显示序号</a>
									</TD>
									<TD width="1%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=is_show">是否显示</a>
									</TD>
									<TD width="1%" align="center" valign="middle">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=index_order">首页显示序号</a>
									</TD>

									<TD width="4%" align="center">
										<a
											href="product.jsp?pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=p_date">发布日期</a>
									</TD>

									<TD width="5%" align="center">
										其它
									</TD>
									<TD width="3%" align="center" vAlign=middle class="bgcolor4">
										<img src="../img/doing.jpg" width="102" height="23">
									</TD>
								</tr>

								<%
									for (int i = 0; i < productsTableListSize; i++) {
										productsTable = productsTableList.get(i);
										bigTable = bigTableService.getByPK(productsTable.getBigId());
										smallTable = smallTableService.getByPK(productsTable
												.getSmallId());
										supplyTable = supplyTableService.getByPK(productsTable
												.getSupplyId());
								%>

								<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
									onMouseOut="this.bgColor='#f8f8f8'">
									<TD height="98" align="center" vAlign=middle><%=(pageNo - 1) * pageSize + i + 1%>
									</TD>
									<TD align="left" vAlign=middle>
                                    <% if(productsTable.getIsShow()==null||"0".equals(productsTable.getIsShow())){%>
                                    <%=productsTable.getPModel()%>
                                    <%}else{%><a href="../products_detail.jsp?p_id=<%=productsTable.getPId()%>" target="_blank" title="到前台去预览"><%=productsTable.getPModel()%></a><%}%></TD>

									<TD align="left" vAlign=middle>
										<%="BS-"
						+ (bigTable != null ? bigTable.getBigCode() : "")
						+ (smallTable != null ? smallTable.getSmallCode() : "")
						+ productsTable.getSmallStrong()%>
									</TD>



									<TD align="left" vAlign=middle>
                                     <% if(productsTable.getIsShow()==null||"0".equals(productsTable.getIsShow())){%>
                                    <%=productsTable.getPName()%>
                                    <%}else{%><a href="../products_detail.jsp?p_id=<%=productsTable.getPId()%>" target="_blank" title="到前台去预览"><%=productsTable.getPName()%></a><%}%>
									</TD>


									<TD align="right" vAlign=middle><%=MathUtil.formatFloat(productsTable.getPublicPrice())%></TD>
									<TD align="right" vAlign=middle><%=MathUtil.formatFloat(productsTable
										.getBsPrice())%>
									</TD>
									<TD align="right" vAlign=middle><%=MathUtil.formatFloat(productsTable.getBsCgPrice())%></TD>
									<TD align="right" vAlign=middle><%=MathUtil.formatFloat(productsTable.getBsPrice()
								- productsTable.getBsCgPrice())%></TD>
									<TD align="right" vAlign=middle>
										<%=MathUtil.formatFloat((productsTable
										.getBsPrice() - productsTable
										.getBsCgPrice())
										/ productsTable.getBsCgPrice() * 100)%>%
									</TD>


									<TD align="left" vAlign=middle>
										<a href="show_pic.jsp?p_pic=<%=productsTable.getPPic()%>"
											target="_blank"><%=productsTable.getPPic()%> </a>
										<a
											href="product_change.jsp?p_id=<%=productsTable.getPId()%>&&pageSize=<%=pageSize%>&&big_id=<%=productsTable.getBigId()%>&&small_id=<%=productsTable.getSmallId()%>&&supply_id=<%=productsTable.getSupplyId()%>"
											target="_self" title="修改"> <img
												src="../product/pic/small<%=productsTable.getPPic()%>" width="96"
												height="78" border="0"> </a>
									</TD>
									<TD vAlign=middle><%=(bigTable != null ? bigTable.getBigName() : "")%></TD>
									<TD align="center" vAlign=middle><%=(bigTable != null ? bigTable.getBigCode() : "")%></TD>


									<TD vAlign=middle><%=(smallTable != null ? smallTable
										.getSmallName() : "")%></TD>
									<TD align="center" vAlign=middle><%=(smallTable != null ? smallTable
										.getSmallCode() : "")%></TD>
									<TD align="center" vAlign=middle><%=productsTable.getSmallStrong()%></TD>


									<TD vAlign=middle><%=(supplyTable != null ? supplyTable.getSupplyName()
								: "")%></TD>
									<TD vAlign=middle><%=productsTable.getSupplyModel()%></TD>
									<TD vAlign=middle><%=productsTable.getModelName()%></TD>
									<TD vAlign=middle><%=productsTable.getEc1()%></TD>
									<TD><%=productsTable.getEc2()%></TD>
									<TD align="center">
										浏览:
										<br>
										<%=productsTable.getBrowse()%></TD>
									<TD align="center">
										询单:
										<br>
										<a href="enquiry_m.jsp?p_model=<%=productsTable.getPModel()%>"><%=productsTable.getAskTimes()%></a>
									</TD>
									<TD align="center">
										评论:
										<br>
										<a href="com.jsp?p_id=<%=productsTable.getPId()%>"><%=productsTable.getComTimes()%></a>
									</TD>

									<TD align="center">
										序号:
										<br>
										<%=productsTable.getOrderId()%></TD>
									<TD align="center">
										<%=(productsTable.getIsShow()==null||"0".equals(productsTable.getIsShow())?"隐藏":"显示")%></TD>
									<TD align="center" valign="middle"><%=productsTable.getIndexOrder()%></TD>
									<TD valign="middle"><%=productsTable.getPDate()%></TD>
									<TD><%=productsTable.getOther()%></TD>

									<TD align="center" vAlign=middle>
										<a
											href="product_change.jsp?p_id=<%=productsTable.getPId()%>&&pageSize=<%=pageSize%>&&big_id=<%=productsTable.getBigId()%>&&small_id=<%=productsTable.getSmallId()%>&&supply_id=<%=productsTable.getSupplyId()%>"
											target="_self">修改</a>
										<a
											href="product.jsp?p_id=<%=productsTable.getPId()%>&&page=<%=pageNo%>&&pageSize=<%=pageSize%>&&p_del=ok"
											onClick="return del();">删除</a>
										<% if(productsTable.getEc1()!=null&&!"".equals(productsTable.getEc1())){ %>
                                        <br />
										<a
											href="product.jsp?p_id=<%=productsTable.getPId()%>&&page=<%=pageNo%>&&pageSize=<%=pageSize%>&&p_del_ec=ok&ecNo=1"
											onClick="return delEc(1);">删除附件1</a>
										<%} %>
										<% if(productsTable.getEc2()!=null&&!"".equals(productsTable.getEc2())){ %>
                                        <br>
										<a
											href="product.jsp?p_id=<%=productsTable.getPId()%>&&page=<%=pageNo%>&&pageSize=<%=pageSize%>&&p_del_ec=ok&ecNo=2"
											onClick="return delEc(2);">删除附件2</a>
										<%} %>
									</TD>
								</tr>


								<%
									}
									if (productsTableListSize > 0) {
								%>
								<tr>
									<td height="31" colspan="20" align="left" valign="middle">

										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<%
											if (pageNo > 1) {
										%>
										<a
											href="product.jsp?page=<%=(pageNo - 1)%>&&pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>">上一页</a>&nbsp;&nbsp;
										<%
											}
												if (pageNo < pageCount) {
										%>
										<a
											href="product.jsp?page=<%=(pageNo + 1)%>&&pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>">下一页</a>
										<%
											}
										%>
										&nbsp;&nbsp;&nbsp;&nbsp;共
										<strong><%=pageCount%></strong>页
										<strong><%=recordCount%></strong>条记录 &nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION value=product.jsp?page=<%=pageNo%>&&pageSize=20&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>>20</OPTION>
<OPTION value=product.jsp?page=<%=pageNo%>&&pageSize=30&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>>30</OPTION>
<OPTION value=product.jsp?page=<%=pageNo%>&&pageSize=50&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>>50</OPTION>	
<OPTION value=product.jsp?page=<%=pageNo%>&&pageSize=75&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>>75</OPTION>	
<OPTION value=product.jsp?page=<%=pageNo%>&&pageSize=100&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>>100</OPTION>												
											</select>
                                             条/页&nbsp;&nbsp;
										<label>
											第
											<SELECT name=menu1
												onChange="location.href=this.options[this.selectedIndex].value;">
												<OPTION value=# selected><%=pageNo%></OPTION>
												<%
													int pageMin = pageNo - 20;
														pageMin = pageMin < 1 ? 1 : pageMin;
														int pageMax = pageNo + 20;
														pageMax = pageMax > pageCount ? pageCount : pageMax;
														if (pageMin > pageMax) {
															pageMin = pageMax;
														}
														for (int i = pageMin; i <= pageMax; i++) {
															if (i == pageNo)
																continue;
												%>
<OPTION value=product.jsp?page=<%=i%>&&pageSize=<%=pageSize%>&&big_id=<%=big_id%>&&small_id=<%=small_id%>&&p_model=<%=p_model%>&&supply_id=<%=supply_id%>&&p_date=<%=p_date%>&&order_by=<%=order_by%>><%=i%></OPTION>
												<%
													}
												%>
											</select>
										</label>
										页
									</td>
									<td></td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td></td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
								</tr>


								<%
									} else {
								%>


								<tr>
									<td height="24" colspan="20" align="center" valign="middle">
										<font color="#FF0000">没有记录！ 
									</td>
									<td></td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td></td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
									<td>&nbsp;
										

									</td>
								</tr>
								<%
									}
								%>
							</table>
						</td>
						<td>&nbsp;
							

						</td>
					</tr>
					<tr>
						<td height="278">&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
						<td>&nbsp;
							

						</td>
					</tr>
				</table>
			</form>
			<br>
			<br>
		</div>
	</body>
</html>