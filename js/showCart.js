
      // 确定购买
		function buy()
		{ 
		if(showCart.time.value==""){
		alert("请输入用餐时间！！！");
		return;
		}	
		document.showCart.action="orderdo.do?method=add";
		document.showCart.submit(); 
		} 
	// 删除指定购物车中的信息	
		function del()
		{ 
		 obj=document.getElementsByName("detailId");
		
		 if(obj!=null){
		 var count=0;
		 for(i=0;i<obj.length;i++){
          if(obj[i].checked==true){
          count++;
         }
         }
   		 if(count < 1){
     	 alert("请选择要删除的记录!!");
     	 return;
   		 }
		if(confirm("确定删除选定的餐品？"))
		{
		document.showCart.action="orderdo.do?method=deleteDetailInShopCart";
		document.showCart.submit(); 
		} 
		}
	}
