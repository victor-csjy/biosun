<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="com.aokle.util.PathUtil"%>
<%@page import="com.aokle.util.FileUtil"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@include file="session_admin.jsp"%>
<%
int p_id=MathUtil.toInt(request.getParameter("p_id"));
String ec1_word=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("ec1_word")));
String ec2_word=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("ec2_word")));
String ec1=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("ec1")));
String ec2=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("ec2")));
String p_pic_new=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("p_pic")));
String p_pic="";
		
String p_model=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("p_model")));
String p_name=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("p_name")));
int big_id=MathUtil.toInt(request.getParameter("big_id"));
int small_id=MathUtil.toInt(request.getParameter("small_id"));

String detail1=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content1")));
String detail2=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content2")));
String app=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content0")));
String sc=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content3")));
String oc=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content4")));
String sp=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content5")));

float bs_price=MathUtil.toFloat(request.getParameter("bs_price"));
float bs_cg_price=MathUtil.toFloat(request.getParameter("bs_cg_price"));
int supply_id=MathUtil.toInt(request.getParameter("supply_id"));
String supply_model=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("supply_model")));
String model_name=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("model_name")));
String other=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("other")));
int browse=MathUtil.toInt(request.getParameter("browse"));
int ask_times=MathUtil.toInt(request.getParameter("ask_times"));
int com_times=MathUtil.toInt(request.getParameter("com_times"));
String order_id=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("order_id")));
String is_show=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("is_show")));
String p_date=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("p_date")));
String key_word=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("key_word")));
String small_strong=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("small_strong")));
String index_order=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("index_order")));
float public_price=MathUtil.toFloat(request.getParameter("public_price"));

if(p_id<1){
  out.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法！');location.href='product.jsp';</SCRIPT>");
  return;
}
ProductsTableService productsTableService=new ProductsTableService();
ProductsTable productsTable=productsTableService.getByPK(p_id);
if(productsTable==null){
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法！');javascript:history.back(-1);</SCRIPT>");
	 return;
}

if(p_id>0&&!"".equals(p_name)){
   if("".equals(p_pic_new)){
      p_pic=productsTable.getPPic();
   }else{
      p_pic=p_pic_new;
   }
   
   if("".equals(ec1)){
      ec1=productsTable.getEc1();
   }
   if("".equals(ec2)){
      ec2=productsTable.getEc2();
   }
   
   int result=productsTableService.update(p_id,p_model,p_name,big_id,small_id,small_strong,detail1,detail2,app,sc,oc,sp,ec1_word,ec1,ec2_word,ec2,public_price,bs_price,supply_model,model_name,bs_cg_price,p_pic,key_word,order_id,other,browse,ask_times,com_times,is_show,supply_id,index_order,p_date);
   String realPath=PathUtil.getRealPath();
   if(result>0){
        //不需要删除旧的文件
        if(!p_pic.equals(productsTable.getPPic())&&!"".equals(productsTable.getPPic())){
          //FileUtil.deleteFile(realPath+"product/pic/"+productsTable.getPPic());
        }
        if(!ec1.equals(productsTable.getEc1())&&!"".equals(productsTable.getEc1())){
         // FileUtil.deleteFile(realPath+"product/ec/"+productsTable.getEc1());
        }
        if(!ec2.equals(productsTable.getEc2())&&!"".equals(productsTable.getEc2())){
         // FileUtil.deleteFile(realPath+"product/ec/"+productsTable.getEc2());
        }
        if(!"".equals(p_pic_new)){//有新的文件上传
            productsTableService.zoomPic(p_pic_new);
        }
        out.println("<SCRIPT LANGUAGE='JavaScript'>alert('修改成功!');location.href='product_change.jsp?p_id="+p_id+"';</SCRIPT>");
        return; 
   }else{
        //删除新的文件
        if(!p_pic.equals(productsTable.getPPic())&&!"".equals(p_pic)){
          //FileUtil.deleteFile(realPath+"product/pic/"+p_pic);
        }
        if(!ec1.equals(productsTable.getEc1())&&!"".equals(ec1)){
         // FileUtil.deleteFile(realPath+"product/ec/"+ec1);
        }
        if(!ec2.equals(productsTable.getEc2())&&!"".equals(ec2)){
          //FileUtil.deleteFile(realPath+"product/ec/"+ec2);
        }
        out.println("<SCRIPT LANGUAGE='JavaScript'>alert('修改失败！');javascript:history.back(-1);</SCRIPT>");
        return; 
   }
}
%>