
$(function(){
	 // navbar notification popups
	  $(".notification-dropdown").each(function (index, el) {
	    var $el = $(el);
	    var $dialog = $el.find(".pop-dialog");
	    var $trigger = $el.find(".trigger");
	    
	    $dialog.click(function (e) {
	        e.stopPropagation()
	    });
	    $dialog.find(".close-icon").click(function (e) {
	      e.preventDefault();
	      $dialog.removeClass("is-visible");
	      $trigger.removeClass("active");
	    });
	    $("body").click(function () {
	      $dialog.removeClass("is-visible");
	      $trigger.removeClass("active");
	    });

	    $trigger.click(function (e) {
	      e.preventDefault();
	      e.stopPropagation();
	      
	      // hide all other pop-dialogs
	      $(".notification-dropdown .pop-dialog").removeClass("is-visible");
	      $(".notification-dropdown .trigger").removeClass("active")

	      $dialog.toggleClass("is-visible");
	      if ($dialog.hasClass("is-visible")) {
	        $(this).addClass("active");
	      } else {
	        $(this).removeClass("active");
	      }
	    });
	  });
	$("#example-navbar-collapse .dropdown").mouseenter(function(e) {
		e.preventDefault();
		var $item = $(this);
		$item.toggleClass("active");
		if ($item.hasClass("active")) {
			$item.find(".dropdown-menu").slideDown("fast");
		} else {
			$item.find(".dropdown-menu").slideUp("fast");
		}
	});
	$("#example-navbar-collapse .dropdown").mouseleave(function(e) {
		e.preventDefault();
		var $item = $(this);
		$item.toggleClass("active");
		if ($item.hasClass("active")) {
			$item.find(".dropdown-menu").slideDown("fast");
		} else {
			$item.find(".dropdown-menu").slideUp("fast");
		}
	});

	// sidebar menu dropdown toggle
	$("#dashboard_menu .dropdown-toggle").click(function(e) {
		e.preventDefault();
		var $item = $(this).parent();
		$item.toggleClass("active");
		if ($item.hasClass("active")) {
			$item.find(".submenu").slideDown(600);
		} else {
			$item.find(".submenu").slideUp(600);
		}
	});
	//li 列表的删除按钮
	$("ul.media-list li").mouseover(function(){
		$(this).find("i.icon-trash").show();
	});
	$("ul.media-list li").mouseout(function(){
		$(this).find("i.icon-trash").hide();
	});

	//左侧导航
	var $menu = $("#sidebar-nav");
	  $("body").click(function () {
	    if ($(this).hasClass("menu")) {
	      $(this).removeClass("menu");
	    }
	  });
	  $menu.click(function(e) {
		    e.stopPropagation();
		  });
	  $("#menu-toggler").click(function (e) {
		    e.stopPropagation();
		    $("body").toggleClass("menu");
		  });
	  $(window).resize(function() { 
		    $(this).width() > 769 && $("body.menu").removeClass("menu")
		  })
		  
	//响应式导航下拉
	$("[data-toggle='navcollapse']").on("click",function(){
		var buttonObj=$(""+$("[data-toggle='navcollapse']").attr("data-target"));
		buttonObj.slideToggle("slow")
	})
		// toggle all checkboxes from a table when header checkbox is clicked
  	
	  // quirk to fix dark skin sidebar menu because of B3 border-box
    if ($("#sidebar-nav").height() > $(".content").height()) {
      $("html").addClass("small");
    }
	 $("a[data-friend='addfriend']").click(function(){
		
		 	var submitURL="friend!addfriends?date="+new Date()+"";
			var form_data=[{name:"user_account",value:$(this).data("target")}];
			jQuery.post(submitURL,form_data,function(jsonData){
				 
				var info =jsonData.info;
				if(info){
					alert(jsonData.text);
				}else{
					alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
				}
			},"json");
	 });
});
function URLencode(sStr) 
{
    return escape(sStr).replace(/\+/g,'%2B').replace(/\"/g,'%22').replace(/\'/g, '%27').replace(/\//g,'%2F').replace(/\%/g,"%25").replace(/\#/g,"%23").replace(/\&/g,"%26");
}