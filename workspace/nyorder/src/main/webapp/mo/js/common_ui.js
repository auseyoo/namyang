$(document).ready(function(){
	var allBtn = $(".allBtn");
	var allMenu = $("nav");

	allBtn.on('click', function() {
		$(this).toggleClass('active');

		if($(".allBtn").hasClass("active") === true){
			allMenu.show().animate({"right":"0"}, 250);
		}else{
			allMenu.animate({"right":"-100%"}, 250);
		}
	});

	//tabs
	//$(".tabContent").hide();
    $(".tabContent:first").show();

	$(".tabsWrap ul.tabs li").click(function (){
        $(".tabsWrap ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".tabsWrap .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100); 
    });

	/* dropdown */
	$(".condit").click(function(){
		$drop = $(this);
		$content = $(".condition");
		$content.slideToggle(300, function(){
			$drop.toggleClass('down');
		});
	});

	//checkAll
	$(".checkAll").click(function(){    
		$("input:checkbox").prop("checked", this.checked);
	});

	//tblWrap H
	$(window).on("load resize", function(){
		tblH();
		tblBodyH();
	});


	function tblH(){
        var tblH = $(".fixScroll");
        var topCon = $(".topCon").outerHeight();

		if ($(".boNumFix").hasClass("none") === true){
			tblH.height($(document).height() - topCon - 155);
		}else{
			tblH.height($(document).height() - topCon - 210);
		}	
    }

	function tblBodyH(){
		var tblHeadH = $(".fixScroll .tbl thead").outerHeight();
        var bodyCon = $(".fixScroll .tbl tbody");

		bodyCon.height($(".fixScroll").height() - (tblHeadH + 40));
    }
	
	//top down 버튼
	$(window).scroll(function(){
		if ($(this).scrollTop() > 0) {
			$(".topDownBtn").fadeIn();
		} else {
			$(".topDownBtn").fadeOut();
		}
	});

	$(".topBtn").click(function(){
		$("html, body").animate({scrollTop:0}, 400);
		return false;
	});

	$(".boBtn").click(function(){
		$("html, body").animate({scrollTop: $(document).height()}, 400);
		return false;
	});

	//tr selected
	$(".selTbl tr").click(function(){
		$(".selTbl tr").removeClass("selected");
		$(this).addClass("selected");
	});
	
});