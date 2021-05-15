
       	//ajax 從controllers拿回的資料傳進來遍歷出搜尋結果(商品格)
	function cardContent(data, path) {
//      		console.log(data);
      		const obj  = JSON.parse(data);
//      	  console.log(obj)
      		let htmlContent = "";
      	  
      	 obj["results"].forEach(function (item, index) {
//      		 console.log(item)
      	    htmlContent += `
      	    <div class="col-lg-4 col-sm-6">
      	        <div class="card mb-2 productcard">
      	           <div class="product-item" >
      	    		 <div class="pi-pic">
      	    		  <div class="pi-img">
      	                 <a href="${path}/product/product.do?product_no=${item.product_no}">
      	                    <img class="card-img-top" src="${path}/ProductShowPhoto?product_no=${item.product_no}" alt=""></a>
      	                    </div>
      	    				<ul>
                        <li class="w-icon active" id="SC${item.product_no}">
                            <a href="javascript:void(0)"><i class="icon_bag_alt" data-id="${item.product_no}"></i></a>
                        </li>   
                        <li class="w-heart">
      	                            <i class="icon_heart_alt"  data-id="${item.product_no}"></i>
      	                        </li>
      	                    </ul>
      	                </div>
      	                <div class="pi-text">
      	                <a href="${path}/product/product.do?product_no=${item.product_no}">                
      	                        <h5>${item.product_name}</h5>    
      	                    <div class="product-price"><span>$</span>
      	                        ${item.product_price}
      	                    </div>
      	                </div></a>
      	            </div>
      	        </div>
      	    </div>
      	   </div>
      	      `;
      	  });
      	  return htmlContent;
      	}
	const products = document.getElementById('products')
	products.addEventListener('click', event => {
		if (event.target.matches('.icon_bag_alt')) {
	    	addCart(event.target.dataset.id);	
		}else if (event.target.matches('.icon_heart_alt')){
			addFavorite(event.target.dataset.id);
    	}
});
	
	function cartProduct(cartdata, path) {
		var cart  = JSON.parse(cartdata);
		let cartContent = "";
	  
		cart["results"].forEach(function (carts, index) {
	    cartContent += `
					<tr>
					  <td class="si-pic"><img
						src="${path}/ProductShowPhoto?product_no=${carts.product_no}"
						alt="${carts.product_name}" style="width:100px; height:100px; border-radius:10px;" /></td>
					<td class="si-text">
				<div class="product-selected">
					<p>$${carts.product_price } x ${carts.product_quantity}</p>
					<h6>${carts.product_name }</h6>
				</div>
					</td>
				</tr>
	      `;
	  });
	  return cartContent;
	}