	//ajax header搜尋框	
	
    $("#sendQuery").on('click', () => { 
		var datas = {
		  "product_name":$("#product_name").val(),      				
		  "action":"search_ajax" 
		}; 
	  sendQuery(datas); 
  }); 
	$("#search").on('submit',(event) => { 
	  event.preventDefault()
	  	var datas = {
		  "product_name":$("#product_name").val(),      				
		  "action":"search_ajax" 
		};
	  sendQuery(datas); 
  }); 
	//nav 全部商品(舊到新)
	$("#allProductsQuery").on('click',() => { 
		  	var datas = {      				
			  "action":"search_ajax" 
			};
		  sendQuery(datas); 
	  });
	//最新商品
	$("#newProductsQuery").on('click',() => { 
	  	var datas = {
	  	  "product_no":"product_no",			
		  "action":"search_ajax" 
		};
	  	sendQuery(datas);
  });
	
	//價格低到高+高到低
	$("#p-show").change(function() { 
		var pricevalue = $("#p-show option:selected").val();
		if (pricevalue == 1){
	  	var datas = {
	  	  "product_price":"product_price",			
		  "action":"search_ajax" 
		 };
		} else if (pricevalue == 2) {
		  var datas = {
		  	"product_price2":"product_price2",			
		    "action":"search_ajax" 
		  };
		};
	  	sendQuery(datas);
  });
	
	//功能列 分類
		$(".catagoriesQuery").click(function() {
			var datas = { 
	 		  	"pdtype_no":$(this).attr("value"),
	 			  "action":"search_ajax" 
	 			}; 
	 		  sendQuery(datas); 
	 	  });
	
	//價格篩選
	$("#moneyRange").click(function(){
	  var min = $("#minamount").val();
	  var max = $("#maxamount").val();
	  min = min.substring(min.indexOf("$")+1);
	  max = max.substring(max.indexOf("$")+1);
	  var datas = {
			  minPrice: min,
			  maxPrice: max,
			  action: 'moneyRange'
			}
			sendQuery(datas);
	})
	
	
	//進階查詢ajax
	$("#fw-all-btn").click(function(){
		var arr = [];
		$('input[name="pdtypeNo"]:checked').each(function(i) {
	     	arr.push($(this).attr("value"));
		});
		var type = $('input[name="productPrice"]:checked').val();
		var datas = {
			pdtypeNo: arr,
			productPrice: type,
			action: 'fw-all-choose'
		}
		sendQuery(datas);
	});
		
	//前端取值+串接字串,不使用
// 		$('input[name="pdtypeNo"]:checked').each(function(i) {
//            pdtypeNo += $(this).attr("value") + " OR ";		
// 		});
// 		$('input[name="productPrice"]:checked').each(function(i) {
// 			productPrice += $(this).attr("value");
				
// 			});

// 		pdtypeNo = pdtypeNo.substring(0,pdtypeNo.lastIndexOf("OR"))
// 		if (productPrice.length === 0 && pdtypeNo.length > 0){
// 			var datas = { 
// 		 		  	 "fw-all-choose":"("+pdtypeNo+")",
// 		 			  "action":"fw-all-choose" 
// 		 			}; 
// 		 		  sendQuery(datas); 
// 		}else if (productPrice.length > 0 && pdtypeNo.length > 0) {
// 			alert("("+pdtypeNo+")" + " AND " + productPrice);
// // 			var datas = { 
// // 		 		  	 "fw-all-choose":"("+pdtypeNo+")" + " AND " + productPrice,
// // 		 			  "action":"fw-all-choose" 
// // 		 			}; 
// // 		 		  sendQuery(datas); 
		 		  
// 		}else if (productPrice.length > 0 && pdtypeNo.length === 0){
// 			alert(productPrice);
// // 			var datas = { 
// // 		 		  	 "fw-all-choose":productPrice,
// // 		 			  "action":"fw-all-choose" 
// // 		 			}; 
// // 		 		  sendQuery(datas); 
// 		}
		
		