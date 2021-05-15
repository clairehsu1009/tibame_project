(function () { 
	const INDEX_URL = "http://localhost:8081/CEA103G4/ProductSearch?action=getJson";
	const data = [];
    const products = document.getElementById('products');

//    const searchForm = document.getElementById('search');
//    const searchInput = document.getElementById('search-input');

    const pagination = document.getElementById('pagination');
    const ITEM_PER_PAGE = 12;
    let paginationData = [];

    let nowPage = "1";
    // now data
    let nowData = [];
       
    axios.get(INDEX_URL)
    .then((response) => {
        //迭代器 for-of 會把資料一個個取出放進item,再push進data陣列
        for (let item of response.data.results) {
            data.push(item);
            getTotalPages(data); //計算頁數,分頁
            getPageData(1, data);
            nowData = data;
        }
       
    }).catch((err) => console.log(err));


// listen to data panel
    products.addEventListener('click', (event) => {
     if (event.target.matches('.icon_heart_alt')) {
        // console.log(event.target.dataset.id) //每次設定事件時,可以先用console.log確認是否有抓到東西
        addFavoriteItem(event.target.dataset.id)
    }
})

		//如果點擊到 a 標籤，則透過將頁碼傳入 getPageData 來切換分頁。
		// listen to pagination click event
		pagination.addEventListener('click', event => {
			if (event.target.tagName === 'A') {
        nowPage = event.target.dataset.page;
        getPageData(event.target.dataset.page)
    }
})
	function getTotalPages(data) {
        let totalPages = Math.ceil(data.length / ITEM_PER_PAGE) || 1
        let pageItemContent = "";
        //註明這個 a 標籤會觸發 JavaScript 程式。
        for (let i = 0; i < totalPages; i++) {
            pageItemContent += `
        <li class="page-item">
          <a class="page-link" href="javascript:;" data-page="${i + 1}">${i + 1}</a>
        </li>
        `
        }
        pagination.innerHTML = pageItemContent;
    }

    function getPageData(pageNum, data) {
        paginationData = data || paginationData;
        let offset = (pageNum - 1) * ITEM_PER_PAGE;
        let pageData = paginationData.slice(offset, offset + ITEM_PER_PAGE);
    }



    //撰寫新的 addFavoriteItem()，將使用者想收藏的電影送進 local storage 儲存起來
    function addFavoriteItem(id) {
        //若使用者是第一次使用收藏功能，則 localStorage.getItem('favoriteProducts') 會找不到東西，所以需要建立一個空 Array。
        const list = JSON.parse(localStorage.getItem('favoriteProducts')) || []
        const product = data.find(item => item.id === Number(id))
        //some 測試陣列中是否至少有一個元素,回傳布林值,相等的結果給item,if(some = true)
        if (list.some(item => item.id === Number(id))) {
            alert(`${product.title} 已經加到清單囉~`)
        } else {
            list.push(product)
            alert(`已新增 ${product.title} 到收藏清單 `)
        }
        localStorage.setItem('favoriteProducts', JSON.stringify(list))
    }	
    
})()