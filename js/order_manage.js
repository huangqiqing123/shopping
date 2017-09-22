// 查询
function query()
{ 		 
document.formQuery.action="orderdo.do?method=query";
document.formQuery.submit(); 
}
		
	function detail()
		{ 
		 var obj=document.getElementsByName("id");
		 
		 if(obj!=null){
		 var count=0;
		 for(i=0;i<obj.length;i++){
          if(obj[i].checked==true){
          count++;
         }
         }
   		 if(count!=1){
     	 alert("请选择一条记录!!");
     	 return;
   		 }
		document.showOrder.action="orderdo.do?method=detail";
		document.showOrder.submit(); 
		} 
		}
		
		
		// 执行删除操作
		function del()
		{
		 obj=document.getElementsByName("id");
		
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
		if(confirm('确认删除选中记录？')){
		document.showOrder.action="orderdo.do?method=delete";
		document.showOrder.submit(); 
		}
		}
		}