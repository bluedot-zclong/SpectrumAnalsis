
  function txtchange() {
   var nnmae = $("#searchtext").val();
   $.ajax({
    type: "post",
    url: "/spectrum-web/search/indexsearch.do",
    data: { searchString: nnmae },
   
    success: function (datas) {
   
     $("#tbcontent").html(""); //删除原有数据
     if (datas != "null") {
    	 
      for (var i = 0; i < $(datas.obj).length; i++) {
       $("#tbcontent").append('<div style="width: 180px;" class="form-control" onclick="mousedown(this)">' + datas.obj[i].resultString + '</div>');
      
      }
      $("#tbcontent").slideDown();
     }
    },
	error : function()
	{
	alert("error");
	}

   });
  }
  //选择其中的提示内容
  function mousedown(object) {
   $("#searchtext").val($(object).text());
   $("#tbcontent").fadeOut();
  }
  //文档框失去焦点，隐藏提示内容
  function lost() {
   $("#tbcontent").fadeOut();
  }
