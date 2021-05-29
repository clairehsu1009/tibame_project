	const favorite = document.getElementById('favorite');
	
	function favoriteContent(data,favfavPath) {		
      		let htmlContent = "";     	  
		data["results"].forEach(function (item, index) {

      	    htmlContent += `
      	    <div class="col-lg-3 col-sm-6 productBox">
      	        <div class="card mb-2 productcard">
      	           <div class="product-item" >
      	    		 <div class="pi-pic">
      	    		  <div class="pi-img">
      	                 <a href="${favPath}/product/product.do?product_no=${item.product_no}">
      	                    <img class="card-img-top" src="${favPath}/ProductShowPhoto?product_no=${item.product_no}" alt=""></a>
      	                    </div>
      	    				<ul>
                        <li class="w-icon" id="SC${item.product_no}">
                            <i class="icon_bag_alt" data-id="${item.product_no}"></i>
                        </li>   
                        <li class="w-heart" >
      	                            <i class="fa fa-close"  data-id="${item.product_no}"></i>
      	                        </li>
      	                    </ul>
      	                </div>
      	                <div class="pi-text">
      	                <a href="${favPath}/product/product.do?product_no=${item.product_no}">                
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
      	favorite.innerHTML = htmlContent;
      	}
	
		favorite.addEventListener('click', event => {
		if (event.target.matches('.fa-close')) {
    	removeFavoriteItem(event.target.dataset.id)
		}else if (event.target.matches('.icon_bag_alt')){
    	addCart(event.target.dataset.id);	
    	}
});


  function removeFavoriteItem (id) {
    const index = data["results"].findIndex(item => item.product_no === Number(id))
    if (index === -1) return 

    data["results"].splice(index, 1)
    localStorage.setItem('favorite', JSON.stringify(data))

    favoriteContent(data,favPath);
    removeSession(index);
    
  }
	

