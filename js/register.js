
function check()
{
if(regist.name.value=="")
alert("用户名不得为空！！！");

else if(regist.pass1.value=="")
alert("密码不得为空！！！");

else if(regist.pass2.value=="")
alert("密码不得为空！！！");

else if(regist.pass2.value!=regist.pass1.value)
alert("两次输入密码不一致！！！");

else if(regist.email.value=="")
alert("email不得为空！！！");

else if(regist.email.value.indexOf("@")<0)
alert("邮箱格式不正确！！！");

else if(regist.address.value=="")
alert("请填写详细地址！！！");

else if(regist.phone.value=="")
alert("为方便与你联系，请填写电话！！！");
else
{
document.regist.action="userdo.do?method=add";
document.regist.submit();
}
}
// 检查用户名是否可用
function getName()
{
	var name=regist.name.value;
	if(name==""){
	alert("用户名不得为空");
	
	}else{
		document.regist.action="userdo.do?method=isUsed&privledge=3";
		document.regist.submit();
	}

}
