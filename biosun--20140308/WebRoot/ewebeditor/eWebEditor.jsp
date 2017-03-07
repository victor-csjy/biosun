<%@page contentType="text/html;charset=utf-8"%>
<%@include file="../admin/session_admin.jsp" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/CoolBlue/Editor.css" type="text/css" rel="stylesheet">
<Script Language=Javascript>
var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}

var sLinkFieldName = URLParams["id"] ;
var sExtCSS = URLParams["extcss"] ;
var sFullScreen = URLParams["fullscreen"];
if(sLinkFieldName==""){
   sLinkFieldName="content0";
   alert("eWebEditor.jsp must in iframe page,The paramter id and it's parent page must have a element name of id!");
}

var config = new Object() ;
config.StyleName = (URLParams["style"]) ? URLParams["style"].toLowerCase() : "coolblue";
config.CusDir = URLParams["cusdir"];
config.ServerExt = "jsp";
config.StyleUploadDir ="UploadFile/";//www.aokle.com

config.StyleDir = "standard";
config.InitMode = "EDIT";
config.AutoDetectPasteFromWord = true;
config.BaseUrl = 1;
config.AutoRemote = 0;

var sPath = document.location.pathname;
sPath = sPath.substr(0, sPath.length-14);
// 全局设置对象
config.StyleEditorHeader = "<head><link href=\""+sPath+"css/CoolBlue/EditorArea.css\" type=\"text/css\" rel=\"stylesheet\"></head><body MONOSPACE>" ;
config.StyleMenuHeader = "<head><link href=\""+sPath+"css/CoolBlue/MenuArea.css\" type=\"text/css\" rel=\"stylesheet\"></head><body scroll=\"no\" onConTextMenu=\"event.returnValue=false;\">";
config.StateFlag="1";//是否显示增加


</Script>
<Script Language=Javascript src="include/editor.js"></Script>
<Script Language=Javascript src="include/table.js"></Script>
<Script Language=Javascript src="include/menu.js"></Script>
<script language="javascript" event="onerror(msg, url, line)" for="window"></script>
</head>
<body SCROLLING=no onConTextMenu="event.returnValue=false;" onFocus="VerifyFocus()">
<table border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'>
  <tr>
    <td>
    
    <table border=0 cellpadding=0 cellspacing=0 width='100%' class='Toolbar' id='eWebEditor_Toolbar'>
        <tr>
          <td><div class='yToolbar'>
              <DIV CLASS="TBHandle"></DIV>
              <SELECT CLASS="TBGen" onChange="format('FormatBlock',this[this.selectedIndex].value);this.selectedIndex=0">
                <option selected>段落样式</option>
                <option value="&lt;P&gt;">普通</option>
                <option value="&lt;H1&gt;">标题一</option>
                <option value="&lt;H2&gt;">标题二</option>
                <option value="&lt;H3&gt;">标题三</option>
                <option value="&lt;H4&gt;">标题四</option>
                <option value="&lt;H5&gt;">标题五</option>
                <option value="&lt;H6&gt;">标题六</option>
                <option value="&lt;p&gt;">段落</option>
                <option value="&lt;dd&gt;">定义</option>
                <option value="&lt;dt&gt;">术语定义</option>
                <option value="&lt;dir&gt;">目录列表</option>
                <option value="&lt;menu&gt;">菜单列表</option>
                <option value="&lt;PRE&gt;">已编排格式</option>
              </SELECT>
              <SELECT CLASS="TBGen" onChange="format('fontname',this[this.selectedIndex].value);this.selectedIndex=0">
                <option selected>字体</option>
                <option value="宋体">宋体</option>
                <option value="黑体">黑体</option>
                <option value="楷体_GB2312">楷体</option>
                <option value="仿宋_GB2312">仿宋</option>
                <option value="隶书">隶书</option>
                <option value="幼圆">幼圆</option>
                <option value="Arial">Arial</option>
                <option value="Arial Black">Arial Black</option>
                <option value="Arial Narrow">Arial Narrow</option>
                <option value="Brush Script MT">Brush Script MT</option>
                <option value="Century Gothic">Century Gothic</option>
                <option value="Comic Sans MS">Comic Sans MS</option>
                <option value="Courier">Courier</option>
                <option value="Courier New">Courier New</option>
                <option value="MS Sans Serif">MS Sans Serif</option>
                <option value="Script">Script</option>
                <option value="System">System</option>
                <option value="Times New Roman">Times New Roman</option>
                <option value="Verdana">Verdana</option>
                <option value="Wide Latin">Wide Latin</option>
                <option value="Wingdings">Wingdings</option>
              </SELECT>
              <SELECT CLASS="TBGen" onChange="format('fontsize',this[this.selectedIndex].value);this.selectedIndex=0">
                <option selected>字号</option>
                <option value="7">一号</option>
                <option value="6">二号</option>
                <option value="5">三号</option>
                <option value="4">四号</option>
                <option value="3">五号</option>
                <option value="2">六号</option>
                <option value="1">七号</option>
              </SELECT>
              <SELECT CLASS="TBGen" onChange="doZoom(this[this.selectedIndex].value)">
                <option value="10">10%</option>
                <option value="25">25%</option>
                <option value="50">50%</option>
                <option value="75">75%</option>
                <option value="100" selected>100%</option>
                <option value="150">150%</option>
                <option value="200">200%</option>
                <option value="500">500%</option>
              </SELECT>
              <DIV CLASS="Btn" TITLE="粗体" onClick="format('bold')"><IMG CLASS="Ico" SRC="buttonimage/standard/bold.gif"></DIV>
              <DIV CLASS="Btn" TITLE="斜体" onClick="format('italic')"><IMG CLASS="Ico" SRC="buttonimage/standard/italic.gif"></DIV>
              <DIV CLASS="Btn" TITLE="下划线" onClick="format('underline')"><IMG CLASS="Ico" SRC="buttonimage/standard/underline.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="左对齐" onClick="format('justifyleft')"><IMG CLASS="Ico" SRC="buttonimage/standard/justifyleft.gif"></DIV>
              <DIV CLASS="Btn" TITLE="居中对齐" onClick="format('justifycenter')"><IMG CLASS="Ico" SRC="buttonimage/standard/justifycenter.gif"></DIV>
              <DIV CLASS="Btn" TITLE="右对齐" onClick="format('justifyright')"><IMG CLASS="Ico" SRC="buttonimage/standard/justifyright.gif"></DIV>
              <DIV CLASS="Btn" TITLE="两端对齐" onClick="format('JustifyFull')"><IMG CLASS="Ico" SRC="buttonimage/standard/justifyfull.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="删除文字格式" onClick="format('RemoveFormat')"><IMG CLASS="Ico" SRC="buttonimage/standard/removeformat.gif"></DIV>
              <DIV CLASS="Btn" TITLE="中划线" onClick="format('StrikeThrough')"><IMG CLASS="Ico" SRC="buttonimage/standard/strikethrough.gif"></DIV>
              <DIV CLASS="Btn" TITLE="上标" onClick="format('superscript')"><IMG CLASS="Ico" SRC="buttonimage/standard/superscript.gif"></DIV>
              <DIV CLASS="Btn" TITLE="下标" onClick="format('subscript')"><IMG CLASS="Ico" SRC="buttonimage/standard/subscript.gif"></DIV>
              <DIV CLASS="Btn" TITLE="全部选中" onClick="format('SelectAll')"><IMG CLASS="Ico" SRC="buttonimage/standard/selectall.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="取消选择" onClick="format('Unselect')"><IMG CLASS="Ico" SRC="buttonimage/standard/unselect.gif"></DIV>
            </div></td>
        </tr>
        <tr>
          <td><div class='yToolbar'>
              <DIV CLASS="TBHandle"></DIV>
              <DIV CLASS="Btn" TITLE="插入或修改图片" onClick="ShowDialog('dialog/img.htm', 350, 315, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/img.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入Flash动画" onClick="ShowDialog('dialog/flash.htm', 350, 220, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/flash.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入自动播放的媒体文件" onClick="ShowDialog('dialog/media.htm', 350, 220, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/media.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入其他文件" onClick="ShowDialog('dialog/file.htm', 350, 150, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/file.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="表格菜单" onClick="showToolMenu('table')"><IMG CLASS="Ico" SRC="buttonimage/standard/tablemenu.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="插入或修改栏目框" onClick="ShowDialog('dialog/fieldset.htm', 350, 170, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/fieldset.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入或修改网页帧" onClick="ShowDialog('dialog/iframe.htm', 350, 200, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/iframe.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入水平尺" onClick="format('InsertHorizontalRule')"><IMG CLASS="Ico" SRC="buttonimage/standard/inserthorizontalrule.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入或修改字幕" onClick="ShowDialog('dialog/marquee.htm', 395, 150, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/marquee.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="撤消" onClick="format('undo')"><IMG CLASS="Ico" SRC="buttonimage/standard/undo.gif"></DIV>
              <DIV CLASS="Btn" TITLE="恢复" onClick="format('redo')"><IMG CLASS="Ico" SRC="buttonimage/standard/redo.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="插入或修改超级链接" onClick="format('CreateLink')"><IMG CLASS="Ico" SRC="buttonimage/standard/createlink.gif"></DIV>
              <DIV CLASS="Btn" TITLE="取消超级链接或标签" onClick="format('UnLink')"><IMG CLASS="Ico" SRC="buttonimage/standard/unlink.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="插入特殊字符" onClick="ShowDialog('dialog/symbol.htm', 350, 220, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/symbol.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入表情图标" onClick="ShowDialog('dialog/emot.htm', 300, 180, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/emot.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入当前日期" onClick="insert('nowdate')"><IMG CLASS="Ico" SRC="buttonimage/standard/date.gif"></DIV>
              <DIV CLASS="Btn" TITLE="插入当前时间" onClick="insert('nowtime')"><IMG CLASS="Ico" SRC="buttonimage/standard/time.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="引用样式" onClick="insert('quote')"><IMG CLASS="Ico" SRC="buttonimage/standard/quote.gif"></DIV>
              <DIV CLASS="Btn" TITLE="代码样式" onClick="insert('code')"><IMG CLASS="Ico" SRC="buttonimage/standard/code.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <script>
              if(sFullScreen!=1){//非全屏
                document.write("<DIV CLASS=\"Btn\" TITLE=\"全屏编辑\" onClick=\"Maximize()\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/maximize.gif\"></DIV>");
              }else{//全屏
                document.write("<DIV CLASS=\"Btn\" TITLE=\"全屏返回\" onClick=\"parent.Minimize()\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/minimize.gif\"></DIV>");
              }
              </script>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="编号" onClick="format('insertorderedlist')"><IMG CLASS="Ico" SRC="buttonimage/standard/insertorderedlist.gif"></DIV>
              <DIV CLASS="Btn" TITLE="项目符号" onClick="format('insertunorderedlist')"><IMG CLASS="Ico" SRC="buttonimage/standard/insertunorderedlist.gif"></DIV>
              <DIV CLASS="TBSep"></DIV>
              <DIV CLASS="Btn" TITLE="字体颜色" onClick="ShowDialog('dialog/selcolor.htm?action=forecolor', 280, 250, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/forecolor.gif"></DIV>
              <DIV CLASS="Btn" TITLE="对象背景颜色" onClick="ShowDialog('dialog/selcolor.htm?action=bgcolor', 280, 250, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/bgcolor.gif"></DIV>
              <DIV CLASS="Btn" TITLE="字体背景颜色" onClick="ShowDialog('dialog/selcolor.htm?action=backcolor', 280, 250, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/backcolor.gif"></DIV>
              <DIV CLASS="Btn" TITLE="背景图片" onClick="ShowDialog('dialog/backimage.htm', 350, 220, true)"><IMG CLASS="Ico" SRC="buttonimage/standard/bgpic.gif"></DIV>
            </div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height='100%'><table border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'>
        <tr>
          <td height='100%'><input type="hidden" ID="ContentEdit" value="">
            <input type="hidden" ID="ContentLoad" value="">
            <input type="hidden" ID="ContentFlag" value="0">
            <iframe class="Composition" ID="eWebEditor" MARGINHEIGHT="1" MARGINWIDTH="1" width="100%" height="100%" scrolling="yes"> </iframe></td>
        </tr>
      </table></td>
  </tr>
  
  <script>
  if(config.StateFlag==1){
     document.write("<tr>");
     document.write("<td height=25><TABLE border=0 cellPadding=0 cellSpacing=0 width=\"100%\" class=StatusBar height=25>");
     document.write("  <TR valign=middle>");
     document.write("      <td><table border=0 cellpadding=0 cellspacing=0 height=20>");
     document.write("              <tr>");
     document.write("                <td width=10></td>");
     document.write("                <td class=StatusBarBtnOff id=eWebEditor_CODE onClick=\"setMode('CODE')\"><img border=0 src=\"buttonimage/standard/modecode.gif\" width=50 height=15 align=absmiddle></td>");
     document.write("                <td width=5></td>");
     document.write("                <td class=StatusBarBtnOff id=eWebEditor_EDIT onClick=\"setMode('EDIT')\"><img border=0 src=\"buttonimage/standard/modeedit.gif\" width=50 height=15 align=absmiddle></td>");
     document.write("                <td width=5></td>");
     document.write("                <td class=StatusBarBtnOff id=eWebEditor_VIEW onClick=\"setMode('VIEW')\"><img border=0 src=\"buttonimage/standard/modepreview.gif\" width=50 height=15 align=absmiddle></td>");
     document.write("              </tr>");
     document.write("            </table></td>");
     
     if(sFullScreen!=1){
       document.write("          <td align=right>");
       document.write("            <table border=0 cellpadding=0 cellspacing=0 height=20>");
       document.write("               <tr>");
       document.write("                  <td style=\"cursor:pointer;\" onClick=\"sizeChange(300)\"><img border=0 SRC=\"buttonimage/standard/sizeplus.gif\" width=20 height=20 alt=\"增高编辑区\"></td>");
       document.write("                  <td width=5></td>");
       document.write("                  <td style=\"cursor:pointer;\" onClick=\"sizeChange(-300)\"><img border=0 SRC=\"buttonimage/standard/sizeminus.gif\" width=20 height=20 alt=\"减小编辑区\"></td>");
       document.write("                  <td width=40></td>");
       document.write("               </tr>");
       document.write("            </table>");
       document.write("           </td>");
     }
     
     document.write("        </tr>");
     document.write("      </Table></td>");
     document.write("  </tr>");
  }
  </script>
</table>
<div id="eWebEditor_Temp_HTML" style="VISIBILITY: hidden; OVERFLOW: hidden; POSITION: absolute; WIDTH: 1px; HEIGHT: 1px"></div>
<form id="eWebEditor_UploadForm" action="../admin/UploadFileJsp.jsp?op=remote&fileType=remote" method="post" target="eWebEditor_UploadTarget">
  <input type="hidden" name="eWebEditor_UploadText">
</form>
<iframe name="eWebEditor_UploadTarget" width=0 height=0></iframe>
<div id=divProcessing style="width:200px;height:30px;position:absolute;display:none">
  <table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
    <tr>
      <td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5" style="font-size:9pt">
        <font color=#FFFFFF>...远程文件收集中...请等待...</font>
        </marquee></td>
    </tr>
  </table>
</div>
<script>
documentOnreadystatechange();
</script>
</body>
</html>
