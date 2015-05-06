jQuery(document).ready(function(){
		/*if(jQuery("#page_pack").data("pagejson")!=null&&jQuery("#page_pack").data("pagejson")!=""){
			var pagepack=$("#page_pack");
       // alert(jQuery("#page_pack").data("pagejson").pageUrl);
			CreateDom_default(pagepack);
			var datajson=$("#page_pack").data("pagejson");
			var formobj=pagepack.closest("form");
			formobj.attr("action",datajson.pageUrl);
			formobj.attr("method","post");
			var bObj=pagepack.find("b");
			bObj.eq(0).html(datajson.currentPage);
			bObj.eq(1).html(datajson.allPage);
			bObj.eq(2).html(datajson.maxrecord);
			bObj.eq(3).html(datajson.allResult);
			//判断结果是条数
			if(datajson.allResult*1==0){
				alert(datajson.allResult);
				no_Search_Results();
			}
			//默认等于当前页
			$("#page_pack input[name='maxrecord']").val(datajson.maxrecord);
			$("#page_pack input[name='currentPage']").val(datajson.currentPage);
			$("#page_pack input[name='sortField']").val(datajson.sortField);
			$("#page_pack input[name='orderType']").val(datajson.orderType);
			//alert(intputobj.eq(0).val());
			var per=datajson.per;
			var next=datajson.next;
			var currentPage=datajson.currentPage;
			var buttonper=$("[data-direction='per']");
			var buttonnext=$("[data-direction='next']");
			
			//$("input[name='maxrecord']").val(datajson.maxrecord);
			if(per*1==currentPage*1){
				buttonper.addClass("disabled");
			}else{
				buttonper.removeClass("disabled");
			}
			
			if(next*1==currentPage*1){
				buttonnext.addClass("disabled");
			}else if(next*1==0){
				buttonnext.addClass("disabled");
			}else{
				buttonnext.removeClass("disabled");
			}
			
			if(!buttonper.hasClass("disabled")){
				buttonper.bind("click",function(){
					$("#page_pack input[name='currentPage']").val(datajson.per);
					formobj.submit();
					//alert(formobj.serialize());
				});
			}
			if(!buttonnext.hasClass("disabled")){
				buttonnext.bind("click",function(){
					$("#page_pack input[name='currentPage']").val(datajson.next);
					formobj.submit();
				});
			}
		}
*/
    });
//排序
$(".table th[data-property]").click(function(){

	$("#page_pack input[name='sortField']").val($(this).data("property"));
	var ordertype=getCookie("ordertype");
	if(ordertype==null||ordertype=="") ordertype="asc"
	$("#page_pack input[name='orderType']").val(ordertype);
	setCookie("ordertype", ordertype=="asc"?"desc":"asc", 60*60);
	//alert($("#page_pack>form").serialize());
	//加上高级查找内容
	$("#list_page_form").submit();
})
//默认样式
	function CreateDom_default(target){
		//var fromobj=$("<form class=\"appento\"></form>").appendTo(target);
		$("<input type=\"hidden\" name=\"currentPage\" >").appendTo(target);
		$("<input type=\"hidden\" name=\"orderType\" >").appendTo(target);
		$("<input type=\"hidden\" name=\"sortField\" >").appendTo(target);
		//$("<input type=\"hidden\" name=\"target\" >").appendTo(target);
		$("<button type=\"button\" class=\"btn btn-primary btn-xs\" data-direction='per'>上一页</button>").appendTo(target);
		$("<button type=\"button\" class=\"btn btn-primary btn-xs\" data-direction='next'>下一页</button>").appendTo(target);
		$("<span>[第<b></b>页]/</span> ").appendTo(target);
		$("<span class=\"mar\">[共<b></b>页]</span>").appendTo(target);
		$("<span>[每页<b></b>条]/</span>").appendTo(target);
		$("<span class=\"mar\">[共<b></b>条]</span>").appendTo(target);
		$("<span>每页显示</span>").appendTo(target);
		$("<input type=\"text\" class=\"maxpage\" name=\"maxrecord\" placeholder=\"10\" maxlength=\"2\"/>").appendTo(target);
		$("<span class=\"mar\">条</span>").appendTo(target);
		
		$("<button type=\"submit\" class=\"btn btn-primary btn-xs\" id=\"config_edit_page\">确认</button>").appendTo(target);
		$("<button type=\"submit\" class=\"btn btn-primary btn-xs\" id=\"refresh_page\">刷新</button>").appendTo(target);
		$("<button type=\"reset\" class=\"btn btn-primary btn-xs\" id=\"refresh_page\">清空所有搜索条件</button>").appendTo(target);
		//return fromobj;
	}
//样式2 没有修改分页

function CreateDom_ys2(target){
	//var fromobj=$("<form class=\"appento\"></form>").appendTo(target);
	$("<input type=\"hidden\" name=\"currentPage\" >").appendTo(target);
	$("<input type=\"hidden\" name=\"orderType\" >").appendTo(target);
	$("<input type=\"hidden\" name=\"sortField\" >").appendTo(target);
	//$("<input type=\"hidden\" name=\"target\" >").appendTo(target);
	$("<button type=\"button\" class=\"btn btn-primary btn-xs\" data-direction='per'>上一页</button>").appendTo(target);
	$("<button type=\"button\" class=\"btn btn-primary btn-xs\" data-direction='next'>下一页</button>").appendTo(target);
	$("<span>[第<b></b>页]/</span> ").appendTo(target);
	$("<span class=\"mar\">[共<b></b>页]</span>").appendTo(target);
	$("<span>[每页<b></b>条]/</span>").appendTo(target);
	$("<span class=\"mar\">[共<b></b>条]</span>").appendTo(target);
	//return fromobj;
}
	function no_Search_Results(){
		//<tr>
		//<td colspan="4">
		//	未找到满足的搜索结果
		//</td>
	//</tr>
		var target_obj= $("#list_page_form table tfoot");
		var target_TR=$("<tr></tr>").appendTo(target_obj);
		var td_num=$("#list_page_form table thead th").length;
		var target_TD=$("<td colspan='"+td_num+"'>未找到满足的搜索结果</td>").appendTo(target_TR);
	}
	function no_comment(){
		
	}
//文字加亮插件
function setHeightKeyWord(id, keyword, color, bold){   // id=元素的ID,
	if (keyword == "")
		return;
	
	var tempHTML = $("#" + id).html();
	var htmlReg = new RegExp("\<.*?\>", "i");
	
	var arrA = new Array();
	for (var i = 0; true; i++) {
		var m = htmlReg.exec(tempHTML);
		if (m) {
			arrA[i] = m;
		} else {
			break;
		}
		tempHTML = tempHTML.replace(m, "[[[[" + i + "]]]]");
	}
	var replaceText
	if (bold)
		replaceText = "<span style=' color:" + color + ";'>$1</span>";
	else
		replaceText = "<font style=' color:" + color + ";'>$1</font>";
	var arrayWord = keyword.split(',');
	for (var w = 0; w < arrayWord.length; w++) {
		var r = new RegExp("("
				+ arrayWord[w].replace(/[(){}.+*?^$|\\\[\]]/g, "\\$&")
				+ ")", "ig");
		tempHTML = tempHTML.replace(r, replaceText);
	}
	for (var i = 0; i < arrA.length; i++) {
		tempHTML = tempHTML.replace("[[[[" + i + "]]]]", arrA[i]);
	}
	$("#" + id).html(tempHTML);
}
