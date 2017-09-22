/*******************************************************************
/*时间控件
/*作者：戴林涛
/*修改：刘彦峰
/*功能描述：选择年月日,可带时间，返回8位日期和时间，可挡住下拉框
/*******************************************************************/
//************************************
//
//************************************
Date.prototype.format=function(fomatstr)
{
if(fomatstr==null || fomatstr=="")
	return ;
var nowYear=this.getFullYear();
var nowMonth=this.getMonth()+1;
var nowDay=this.getDate();
var nowHour=this.getHours();
var nowMinute=this.getMinutes();
var nowSecond=this.getSeconds();
if(nowYear!=null && nowYear!=="")
	{
	fomatstr=fomatstr.replace("yyyy",nowYear);
	}
if(nowMonth!=null && nowMonth!=="")
	{
nowMonth=this.numUtil(nowMonth);
	fomatstr=fomatstr.replace("MM",nowMonth);
	}
if(nowDay!=null && nowDay!=="")
	{
	nowDay=this.numUtil(nowDay);
	fomatstr=fomatstr.replace("dd",nowDay);
	}
if(nowHour!=null && nowHour!=="")
	{
	nowHour=this.numUtil(nowHour);
	var restr=/HH/i;
	fomatstr=fomatstr.replace(restr,nowHour);
	}
else
	{
	var restr=/hh[\S ]*mm/i;
	fomatstr=fomatstr.replace(restr,"");	
	}
if(nowMinute!=null && nowMinute!=="")
	{
	nowMinute=this.numUtil(nowMinute);
	fomatstr=fomatstr.replace("mm",nowMinute);
	}
if(nowSecond!=null && nowSecond!=="")
	{
	nowSecond=this.numUtil(nowSecond);
	var restr=/SS/i;
	fomatstr=fomatstr.replace(restr,nowSecond);
	}
return fomatstr.replace(/\s*$/g,"");
}
Date.prototype.numUtil=function(num)
{
	if(parseInt(num,10)<10)
		return "0"+num;
	else
		return num;

}
function Calendar(name)
{
//共有变量
this.name=name;
//*******************************
//通用变量
//*******************************
var dDate = new Date();
var month= dDate.getMonth()+1;
var year= dDate.getFullYear();
var day=dDate.getDate();
var hour=dDate.getHours();
var minute=dDate.getMinutes();
var second=dDate.getSeconds();
var inputtextid=null;
var inputtext=null;
var savetext=null;
var innerhtml="";
var middle="-";
var align="left";
var hastime=false;
var divAll=null; //外面总的DIV
var divDate=null;//显示日期的DIV
var divTime=null;//显示时间的DIV
var curTd=null;// 上次点击的TD
var newtdstr="";//取开始默认的TD
var targetFormat="yyyy-MM-dd HH:mm:SS";//转换的日期格式
var sourceFormat="yyyy-MM-dd HH:mm:SS";//原始的日期格式
//微调
var _interv = null;
var _interv_ob = null;
var _currob = null;
this._inchingswitch=_inchingswitch;
function _inchingswitch(obj,flag)
{
	var o,ob,ar;
	if(_currob != null&&obj.parentElement.parentElement.contains(_currob))
	{
		o = _currob;
		ob = _currob.value;
		ar = _currob.conf.split(",");
	}
	else
	{
		o = obj.parentElement.nextSibling;//输入筐
		ob = obj.parentElement.nextSibling.value;//输入筐值
		ar = obj.parentElement.nextSibling.conf.split(",");//参数用逗号分割
	}

	var step = parseInt(ar[0]);
	var min = parseInt(ar[1]);
	var max = parseInt(ar[2]);
	var alph = ar[3];

	if(ob=="")
	ob=ar[1];//如果输入域为空则默认是最小值
	if(typeof(alph)!="undefined"&&alph!="")
	{
		if(alph==ob.substr(ob.length-2,ob.length-1))
			ob = ob.substr(0,ob.length-1);
	}
	var obvalue = parseInt(ob,10);
	if(isNaN(obvalue))
	{
	//alert("微调初始值是非数字！");
		obvalue = min;
	}
	if(isNaN(step))
		step = 1;
	if(flag=="+")
	{
		obvalue = obvalue + step;
		if(obvalue>max)
			return;
	}
	if(flag=="-")
	{
		obvalue = obvalue - step;
		if(obvalue<min)
			return;
	}
	o.value = obvalue+alph;
	o.select();
}
this._uper=_uper;
function _uper(ob)
{
	//alert(event.fromElement);
	if(_interv_ob!=null)
		_inchingswitch(_interv_ob,"+");
	else
		_inchingswitch(ob,"+");
	
}
this._conti_uper=_conti_uper;
function _conti_uper(obb)
{
	if(_interv==null)
	{
		_interv_ob = obb;
		_interv=window.setInterval(this._uper, 200);
	}
}
this._stop_inch=_stop_inch;
function _stop_inch()
{
	if(_interv!=null)
	{
		clearInterval(_interv);
		_interv=null;
		_interv_ob = null;
	}
}
this._downer=_downer;
function _downer(ob)
{
	if(_interv_ob!=null)
		_inchingswitch(_interv_ob,"-");
	else
		_inchingswitch(ob,"-");

}
this._conti_downer=_conti_downer;
function _conti_downer(obb)
{
	if(_interv==null)
	{
		_interv_ob = obb;
		_interv=window.setInterval(this._downer, 200);
	}
}
this._selthis=_selthis;
function _selthis(ob)
{
	ob.select();//alert(ob.tagName);
	_currob = ob;
}
//微调结束
//日历按钮变化
this.doUpDown=doUpDown;
function doUpDown(){
	var odiv=divAll;
	var btn=divAll.previousSibling;
	if(odiv.style.display=="none"){
		btn.innerText="6";
		var scr=odiv.offsetTop-inputtext.offsetHeight-document.body.scrollTop;
		if(scr<0)
			window.scrollBy(0,scr-3);
	}else
		btn.innerText="5";
}
//获取日期值
this.getDateValue=getDateValue;
function getDateValue(){
	return savetext.value;
}
//清空日期值
this.cleanInput=cleanInput;
function cleanInput(){
	inputtext.value="";	
	savetext.value="";
}
this.fGetDaysInMonth=fGetDaysInMonth;
function fGetDaysInMonth(iMonth, iYear) {
var dPrevDate = new Date(iYear, iMonth, 0);
return dPrevDate.getDate();
}
this.fBuildCal=fBuildCal;
function fBuildCal(iYear, iMonth, iDayStyle) {
var aMonth = new Array();
aMonth[0] = new Array(7);
aMonth[1] = new Array(7);
aMonth[2] = new Array(7);
aMonth[3] = new Array(7);
aMonth[4] = new Array(7);
aMonth[5] = new Array(7);
aMonth[6] = new Array(7);
var dCalDate = new Date(iYear, iMonth-1, 1);
var iDayOfFirst = dCalDate.getDay();
var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
var iVarDate = 1;
var i, d, w;
if (iDayStyle == 2) {
aMonth[0][0] = "Sunday";
aMonth[0][1] = "Monday";
aMonth[0][2] = "Tuesday";
aMonth[0][3] = "Wednesday";
aMonth[0][4] = "Thursday";
aMonth[0][5] = "Friday";
aMonth[0][6] = "Saturday";
} else if (iDayStyle == 1) {
//aMonth[0][0] = calendar_Sunday;
//aMonth[0][1] = calendar_Monday;
//aMonth[0][2] = calendar_Tuesday;
//aMonth[0][3] = calendar_Wednesday;
//aMonth[0][4] = calendar_Thursday;
//aMonth[0][5] = calendar_Friday;
//aMonth[0][6] = calendar_Saturday;
aMonth[0][0] = "日";
aMonth[0][1] = "一";
aMonth[0][2] = "二";
aMonth[0][3] = "三";
aMonth[0][4] = "四";
aMonth[0][5] = "五";
aMonth[0][6] = "六";
} else {
aMonth[0][0] = "Su";
aMonth[0][1] = "Mo";
aMonth[0][2] = "Tu";
aMonth[0][3] = "We";
aMonth[0][4] = "Th";
aMonth[0][5] = "Fr";
aMonth[0][6] = "Sa";
}
for (d = iDayOfFirst; d < 7; d++) {
aMonth[1][d] = iVarDate;
iVarDate++;
}
for (w = 2; w < 7; w++) {
for (d = 0; d < 7; d++) {
if (iVarDate <= iDaysInMonth) {
aMonth[w][d] = iVarDate;
iVarDate++;
      }
   }
}
return aMonth;
}
this.fDrawCal=fDrawCal;
function fDrawCal(iYear, iMonth,iDayStyle) {
var myMonth;
myMonth = fBuildCal(iYear, iMonth, iDayStyle);

innerhtml+="<table border='0' width='100%'  class='date_body' cellspacing='0' cellpadding='0' ><tr class='date_title'>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][0] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][1] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][2] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][3] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][4] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][5] + "</td>";
innerhtml+="<td width='10%' unselectable='on'>" + myMonth[0][6] + "</td>";
innerhtml+="</tr>";
for (w = 1; w < 6; w++) {
      innerhtml+="<tr class='date_row_odd'>"
      for (d = 0; d < 7; d++) {
            //innerhtml+="<td align='center' valign='top' width='" + iCellWidth + "' height='" + iCellHeight + "' id=calCell style='CURSOR:Hand' onclick=fSetSelectedDay(this)>");
            
            if(myMonth[w][d]==day && year==dDate.getFullYear() && month==dDate.getMonth()+1){
                innerhtml+="<td   width='10%'  class='date_today' unselectable='on'>"+ myMonth[w][d];
              }
            else if(day!=null && day!=dDate.getDate()&& day==myMonth[w][d])
			 {
				innerhtml+="<td   width='10%'  class='date_select' unselectable='on'>"+ myMonth[w][d];
				newtdstr="divDate.children[0].rows["+w+"].cells["+d+"];";
			}
            else
		  {
				
				if (!isNaN(myMonth[w][d])) {
					   innerhtml+="<td   width='10%' class='date_td' unselectable='on'>" + myMonth[w][d];
				} else {
					  innerhtml+="<td   width='10%' class='date_blank_td' unselectable='on'>";
				}
		  }
           innerhtml+="</td>"
       }
      innerhtml+="</tr>";
 }
innerhtml+="<tr  class='date_row_odd'>"
for (d = 0; d < 7; d++) {
  // innerhtml+="<td  width='10%' unselectable='on'>";
if (!isNaN(myMonth[6][d])) {        
     innerhtml+="<td   width='10%' class='date_td' unselectable='on'>" + myMonth[6][d];
   
} else {
	 innerhtml+="<td   width='10%' class='date_blank_td' unselectable='on'>";
}
innerhtml+="</td>"
}
innerhtml+="</tr>";
innerhtml+="</table>";
}

//*******************************
//
//*******************************
this.showSelectTable=showSelectTable;
function showSelectTable(flag){
   var obj=document.all("objcalendar");
   if(obj.style.display=="block")
        obj.style.display="none";
	else
	obj.style.position="absolute";
   
           	
}

this.parseInputTextValue=parseInputTextValue;
function parseInputTextValue(val){
  var value=checkinputtextvalue(val);
  var b=new Array();
  for(var i=0;i<2;i++){
   var a=value.indexOf(middle);
   if(value.substring(0,a)=="08"){
      b[i]=8;	
   }else{
   if(value.substring(0,a)=="09"){
      b[i]=9;	
   }else{
      b[i]=parseInt(value.substring(0,a));
   }
   }
   
   value=value.substring(a+1);
   }
   if(value.charAt(0)=='0'){
       value=value.substring(1);
    }
  b[2]=parseInt(value);
  year=b[0];
  month=b[1];
  day=b[2];
 changeYearAndMonth(3);    	
}

this.checkinputtextvalue=checkinputtextvalue;
function checkinputtextvalue(val){
   var flag=false;
   var i,j;
   var value,val1,val2;
   if(val.length!=10){
      flag=true;
   }
   if(flag){
      value=year+middle;
      if(month<10)
          value+="0"+month+middle;
       else
          value+=month+middle;
      if(day<10)
          value+="0"+day;
       else
          value+=day;
       if(hasform){
	  var obj1=eval(tableformname);
	  input=eval(obj1.name+"."+inputtextid);
       }
       else
	  input=document.all(inputtextid);
   }
   else
       value=val;

   return value;
}


this.OnMouseOver=OnMouseOver;
function OnMouseOver(){
  var obj=event.srcElement;
  if(obj!=curTd)
  obj.className="date_mouseover";
}

this.OnMouseOut=OnMouseOut;
function OnMouseOut(){
  var obj=event.srcElement;
  if(obj!=curTd)
	obj.className="date_td";
}

this.OnMouseDown=OnMouseDown;
function OnMouseDown(){
  var obj=event.srcElement;
  if(curTd!=null)
	  curTd.className="date_td";
	curTd=obj;
  day=obj.innerText;
  obj.className="date_select";
  divDate.children[0].focus();
}
this.OnDbClick=OnDbClick;
function OnDbClick(){ 
  var obj=event.srcElement; 
  if(curTd!=null)
	  curTd.className="date_td";
	curTd=obj;
  day=obj.innerText;
  obj.className="date_select";
saveValue();
}

this.changeYearAndMonth=changeYearAndMonth;
function changeYearAndMonth(oyear,omonth){
	if(oyear!=null)
		year=oyear;
if(omonth!=null)
	month=omonth;
  innerhtml="";
  setJavaScript();
}
this.changeHourAndMinute=changeHourAndMinute;
function changeHourAndMinute(ohour,ominute,osecond){
	if(ohour!=null)
		hour=ohour;
if(ominute!=null)
	minute=ominute;
if(osecond!=null)
	second=osecond;
}

this.setJavaScript=setJavaScript;
function setJavaScript(){
  fDrawCal(year,month,1);
  var obj=divDate;
  obj.innerHTML=innerhtml;
  var tabDate=divDate.children[0];
  if(newtdstr!="")
	  curTd=eval(newtdstr);
	else{
		var mcels=tabDate.cells;
		for(var i=0;i<mcels.length;i++)
			if(mcels.item(i).className=="date_today"){
					curTd=mcels.item(i);
					break;
				}
		}
  
  if(tabDate!=null)
	{
		if(hastime)
	for(var i=1;i<tabDate.rows.length;i++)
		{
		for(var j=0;j<tabDate.rows[i].cells.length;j++)
			{
			var otd=tabDate.rows[i].cells[j];
			if(otd.innerText=="") continue;
				otd.onmouseover=OnMouseOver;
				otd.onmouseout=OnMouseOut;
				otd.onmousedown=OnMouseDown;
				otd.ondblclick=OnDbClick;		
			}
		}
		else
				for(var i=1;i<tabDate.rows.length;i++)
		{
		for(var j=0;j<tabDate.rows[i].cells.length;j++)
			{
			var otd=tabDate.rows[i].cells[j];
			if(otd.innerText=="") continue;
				otd.onmouseover=OnMouseOver;
				otd.onmouseout=OnMouseOut;
				otd.onmousedown=OnMouseDown;
				otd.onclick=OnDbClick;			
			}
		}
	}
}

this.set=set;
function set(objid,splitStr){
if(objid!=null && objid!="")
   inputtextid=objid;
   if(splitStr!=null && splitStr!="")
   middle=splitStr;
   innerhtml="";
   setJavaScript(); 
}
//年输入框失去焦点
this.doYearBlur=doYearBlur;
function doYearBlur(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(objvalue) || objvalue=="")
objvalue=year;
if(parseInt(objvalue)<parseInt(minyear))
objvalue=minyear;
if(parseInt(objvalue)>parseInt(maxyear))
objvalue=maxyear;
obj.value=objvalue;
changeYearAndMonth(objvalue);
}

//小时输入框失去焦点
this.doHourBlur=doHourBlur;
function doHourBlur(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(objvalue) || objvalue=="")
objvalue=0;
if(parseInt(objvalue,10)<0)
objvalue="0";
if(parseInt(objvalue)>23)
objvalue=23;
obj.value=objvalue;
hour=obj.value;
}
//分钟输入框失去焦点
this.doMiniteBlur=doMiniteBlur;
function doMiniteBlur(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(objvalue) || objvalue=="")
objvalue=0;
if(parseInt(objvalue,10)<0)
objvalue="0";
if(parseInt(objvalue)>59)
objvalue=59;
obj.value=objvalue;
minute=obj.value;
}
//秒输入框失去焦点
this.doSecondBlur=doSecondBlur;
function doSecondBlur(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minsecond=arr[1];
var maxsecond=arr[2];
if(isNaN(objvalue) || objvalue=="")
objvalue=0;
if(parseInt(objvalue,10)<0)
objvalue="0";
if(parseInt(objvalue)>59)
objvalue=59;
obj.value=objvalue;
second=obj.value;
}
///////////只用在年月组件中
//年输入框失去焦点
this.doYearBlurInYM=doYearBlurInYM;
function doYearBlurInYM(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(parseInt(objvalue,10)) || objvalue=="")
objvalue=minyear;
if(parseInt(objvalue,10)<minyear)
objvalue=minyear;
if(parseInt(objvalue,10)>maxyear)
objvalue=maxyear;
obj.value=objvalue;
var hidInput=obj.previousSibling.previousSibling;
var monthInput=obj.nextSibling.nextSibling;
saveYearMonth(hidInput,objvalue,monthInput.value);
}
//年输入框失去焦点，只用在年组件中
this.doYearBlurInY=doYearBlurInY;
function doYearBlurInY(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(parseInt(objvalue,10)) || objvalue=="")
objvalue=minyear;
if(parseInt(objvalue,10)<minyear)
objvalue=minyear;
if(parseInt(objvalue,10)>maxyear)
objvalue=maxyear;
obj.value=objvalue;
var hidInput=obj.previousSibling.previousSibling;
saveYear(hidInput,objvalue);
}
//月输入框失去焦点
this.doMonthBlurInYM=doMonthBlurInYM;
function doMonthBlurInYM(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minyear=arr[1];
var maxyear=arr[2];
if(isNaN(parseInt(objvalue,10)) || objvalue=="")
objvalue=minyear;
if(parseInt(objvalue,10)<minyear)
objvalue=minyear;
if(parseInt(objvalue,10)>maxyear)
objvalue=maxyear;
obj.value=objvalue;
var yearInput=obj.previousSibling.previousSibling;
var hidInput=yearInput.previousSibling.previousSibling;

saveYearMonth(hidInput,yearInput.value,objvalue);

}
//把年,月值相加放到隐藏域
this.saveYearMonth=saveYearMonth;
function saveYearMonth(hid,oyear,omonth)
	{
	//alert(hid);
if(hid!=null && hid.tagName=="INPUT")
		{
	var odate=new Date();
	if(isNaN(oyear)|| oyear.length!=4)
		oyear=odate.getFullYear();
	if(isNaN(omonth)||omonth.length<1||omonth.length>2)
		omonth=odate.getMonth()+1+"";
	if(omonth.length==1)
		omonth="0"+omonth;
	hid.value=oyear+omonth;
	//alert(hid.value);
	}

}
//把年值相加放到隐藏域，只用在年组件
this.saveYear=saveYear;
function saveYear(hid,oyear){
if(hid!=null && hid.tagName=="INPUT")
		{
	var odate=new Date();
	if(isNaN(oyear)|| oyear.length!=4)
		oyear=odate.getFullYear();
	hid.value=oyear
	//alert(hid.value);
	}
}
//只用在年月组件END
//初始化
this.init=init;
function init(divid,iniyear,inimonth,iniday,inihour,iniminute,initsecond,targetformatstr,sourceformatstr)
	{
	if(divid!=null && divid!="") 
		{	
			divAll=document.all(divid);
			if(divAll!=null && divAll.tagName=="DIV")
			{
			divDate=divAll.children[1];
			savetext=divAll.previousSibling.previousSibling;
				if(savetext.type=="hidden"){
					inputtext=savetext.previousSibling;
					var clearhidden=function(){
						savetext.value="";
					}
					inputtext.attachEvent("ondblclick",clearhidden);
				}
				else if(savetext.type=="text")
					inputtext=savetext;
			}
			if(divAll.children.length==4){
			divTime=divAll.children[2];
			hastime=true;
			}
		}
		var nfun=new Function("var oodiv=document.all('"+divid+"');var obj=window.event.srcElement;if(!oodiv.contains(obj)&&obj!=oodiv.previousSibling) oodiv.style.display='none';");
		document.body.attachEvent("onmousedown",nfun);
	if(iniyear!="") year=iniyear;
	if(inimonth!="") month=inimonth;
	if(iniday!="") day=iniday;
	if(inihour!="") hour=inihour;
	if(iniminute!="") minute=iniminute;
	if(initsecond!="") second=initsecond;
	if(targetformatstr!=null && targetformatstr!="") targetFormat=targetformatstr;
	if(sourceformatstr!=null && sourceformatstr!="") sourceFormat=sourceformatstr;
	set("",'-');
	var odate=new Date(iniyear,inimonth-1,iniday,inihour,iniminute,initsecond);
	if(inputtext.value!="" && !isNaN(odate))
	savetext.value=odate.format(targetFormat);//Date.proptotype.format=function(formatstr);
	}

//返回最后的值
this.saveValue=saveValue;
function saveValue()
	{
	var datestr=year+middle+month+middle+day;
	var timestr="";
	var inputs=divAll.getElementsByTagName("INPUT");
	for(var i=0;i<inputs.length;i++)
		inputs[i].fireEvent("onchange");
	if(divTime!==null && divTime.style.display=="none")
		{//timestr=hour+":"+minute;
		hour="";
		minute="";
		second="";
		}

	var ndate=new Date(year,month-1,day,hour,minute,second);
	inputtext.value=ndate.format(sourceFormat);
	savetext.value=ndate.format(targetFormat);
	if(inputtext.onchange!=null)
		inputtext.onchange();
	divAll.style.display="none";
	if(curTd!=null)
		{
		curTd.className="";
		cutTd=null;
		}
	}
//显示/隐藏
this.showDate=showDate;
function showDate()
	{
	if(divAll==null) return;
	var odiv=divAll;
	if(odiv==null) return;
	if(odiv.style.display=="none")
		{
		var obj=inputtext;
		var otop=20;
		var oleft=0;
		var alph=0;
		while(obj!=null){
			otop+=obj.offsetTop;
			oleft+=obj.offsetLeft;
			obj=obj.offsetParent;
			if(obj!=null&&obj.tagName=="TD")
				alph=1;
			}
		odiv.style.top=otop+alph;
		odiv.style.left=oleft+alph;
		odiv.style.display="block";
		var scr=(odiv.offsetTop+odiv.offsetHeight)-(document.body.scrollTop+document.body.clientHeight);
		if(scr>0)			
			window.scrollBy(0,scr);
		var str=inputtext.value;
		if(str!="")
		initInputDate(str);
		set("",'-');
		}
	else
			odiv.style.display="none";
	}
//SET方法
this.setDay=setDay;
function setDay(oday)
	{
	if(oday!=null && oday!="")
	day=oday;
	}
//初始化输入的日期
this.initInputDate=initInputDate;
function initInputDate(str)
	{
	if(str==null)
		{
		alert(calendar_msg_1);
		return false;
		}
	str=parseIntputDate(str);
	var dd=new Date(str);
	if(isNaN(dd))
		{
		//alert("输入日期格式不正确");
		return false;
		}
month= dd.getMonth()+1;
year= dd.getFullYear();
day=dd.getDate();
hour=dd.getHours();
minute=dd.getMinutes();
second=dd.getSeconds();
var objtab=divAll.children[0].children[0];
var objyear=objtab.getElementsByTagName("INPUT")[0];
var objmonth=objtab.getElementsByTagName("SELECT")[0];
objyear.value=year;
for(var i=0;i<objmonth.options.length;i++)
		{
		var opt=objmonth.options[i];
		if(month==opt.value)
			opt.selected=true;
		}
	if(divTime!=null){
		var objtime=divTime.getElementsByTagName("INPUT");
		objtime[0].value=hour<10?"0"+hour:hour;
		objtime[2].value=minute<10?"0"+minute:minute;
		if(objtime.length==5)
			objtime[4].value=second<10?"0"+second:second;
		}
}
//把输入的日期转换成yyyy/MM/dd hh:mm:ss
this.parseIntputDate=parseIntputDate;
function parseIntputDate(str)
	{
var sparr=str.split(" ");
var pararr=sourceFormat.split(" ");
var len=sparr.length;
var datestr,timestr;
var pardate,partime;
if(len>1)
{
datestr=sparr[0];
timestr=sparr[1];
pardate=pararr[0];
partime=pararr[1];
}
else
{
datestr=str;
timestr="";
pardate=sourceFormat;
partime="";
}
var regstr=/[^yyyyMMdd]/g;
var arr=pardate.match(regstr);
if(arr==null)
{
datestr=datestr.slice(0,4)+"/"+datestr.slice(4,6)+"/"+datestr.slice(6);
}
else
{
	for(var i=0;i<arr.length;i++)
	{
	datestr=datestr.replace(arr[i],"/");
	}
	var ldate=datestr.substr(datestr.length-1,1);
	if(isNaN(ldate))
	{
	datestr=datestr.substr(0,datestr.length-1);
	}
}
if(timestr!="")
{
	var regtime=/[^hhmmss]/g;
	var arrt=partime.match(regtime);
	//alert("arrt="+arrt);
	if(arrt==null)
	{ 
	timestr=timestr.slice(0,2)+":"+timestr.slice(2,4)+":"+timestr.slice(4);
	}
	else
	{
		for(var i=0;i<arrt.length;i++)
		{
		timestr=timestr.replace(arrt[i],":");
		}
		var ltime=timestr.substr(timestr.length-1,1);
		if(isNaN(ltime))
		{
		timestr=timestr.substr(0,timestr.length-1);
		}
	}

}
return (datestr+" "+timestr);

}
this.setDateDisabled=setDateDisabled;
function setDateDisabled(param)
	{
		var obj=divAll.children[0].children;
		for (var i=0;i<obj.length;i++)
		   obj[i].disabled=param;
	}
//为隐藏的input赋值,onchange时
this.setHidDateValInCalendar=setHidDateValInCalendar;
function setHidDateValInCalendar(targetFormatstr)
{
if(targetFormatstr==null || targetFormatstr=="") return;
if(event.srcElement.nextSibling!=null && event.srcElement.nextSibling.tagName=="INPUT")
	{
	var datestr=event.srcElement.value;
	if(datestr==null ||datestr=="") {
		event.srcElement.nextSibling.value="";
		return;
	}
	datestr=parseIntputDate(datestr);
	var ndate=new Date(datestr);
	if(isNaN(ndate)){
		event.srcElement.nextSibling.value="";
		return;
	}
	event.srcElement.nextSibling.value=	ndate.format(targetFormatstr);
	}
}
//只显示时间的控件
//小时输入框失去焦点
this.doHourBlurInHM=doHourBlurInHM;
function doHourBlurInHM(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minhour=arr[1];
var maxhour=arr[2];
if(isNaN(parseInt(objvalue,10)) || objvalue=="")
objvalue=minhour;
if(parseInt(objvalue,10)<minhour)
objvalue=minhour;
if(parseInt(objvalue,10)>maxhour)
objvalue=maxhour;
obj.value=objvalue;
var hidInput=obj.previousSibling.previousSibling;
var minitueInput=obj.nextSibling.nextSibling;
saveTime(hidInput,objvalue,minitueInput.value);
}
//分钟输入框失去焦点
this.doMinuteBlurInHM=doMinuteBlurInHM;
function doMinuteBlurInHM(obj)
{
if(obj==null) return;
var arr=obj.conf.split(",");
var objvalue=obj.value;
var minminiute=arr[1];
var maxminiute=arr[2];
if(isNaN(parseInt(objvalue,10)) || objvalue=="")
objvalue=minminiute;
if(parseInt(objvalue,10)<minminiute)
objvalue=minminiute;
if(parseInt(objvalue,10)>maxminiute)
objvalue=maxminiute;
obj.value=objvalue;
var hourInput=obj.previousSibling.previousSibling;
var hidInput=hourInput.previousSibling.previousSibling;
saveTime(hidInput,hourInput.value,objvalue);

}
//把小时、分钟值相加放到隐藏域
this.saveTime=saveTime;
function saveTime(hid,ohour,ominiute)
	{
	//alert(hid);
	if(hid!=null && ((hid.tagName=="INPUT")||(hid.tagName=="input")))
	{
	var odate=new Date();
	if(isNaN(ohour)|| ohour.length!=2)
		oyear="0"+odate.getHours();
	if(isNaN(ominiute)||ominiute.length!=2)
		ominiute="0"+ominiute;
	hid.value=ohour+ominiute;
	//alert("隐藏域的值="+hid.value);
	}

}
//外部set方法，根据sourceFormat
this.setDate=setDate;
function setDate(str)
	{
	var dstr=parseIntputDate(str);
	var odate=new Date(dstr);
	if(!isNaN(odate))
		{
		inputtext.value=str;
	savetext.value=odate.format(targetFormat);
		}
	}
}

function checkDateFormat(formatStr,dateStr){
	if(dateStr==null || dateStr=="" ||formatStr==null || formatStr=="")
		return false;
	var regstr=formatStr.replace("yyyy","[0-9]{4}");
	regstr=regstr.replace("MM","[0-9]{2}");
	regstr=regstr.replace("dd","[0-9]{2}");
	regstr=eval("/^"+regstr+"$/");
	if(!regstr.test(dateStr))
		return false;
	var yearstr="";
	if(formatStr.indexOf("yyyy")>=0)
		yearstr=dateStr.substr(formatStr.indexOf("yyyy"),4);
	var monthstr="";
	if(formatStr.indexOf("MM")>=0)
		monthstr=dateStr.substr(formatStr.indexOf("MM"),2);
	var datestr="";
	if(formatStr.indexOf("dd")>=0)
		datestr=dateStr.substr(formatStr.indexOf("dd"),2);
	var obj=new Date(yearstr,monthstr-1,datestr);
	if(isNaN(obj))
		return false;
	if(obj.getFullYear()!=yearstr || obj.getMonth()+1!=monthstr || obj.getDate()!=datestr)
		return false;
	return true;
}


function checkTimeFormat(formatStr,timeStr){
	if(timeStr==null || timeStr=="" ||formatStr==null || formatStr=="")
		return false;
	var regstr=formatStr.replace("yyyy","[0-9]{4}");
	regstr=regstr.replace("MM","[0-9]{2}");
	regstr=regstr.replace("dd","[0-9]{2}");
	regstr=regstr.replace("hh","[0-9]{2}");
	regstr=regstr.replace("mm","[0-9]{2}");
	regstr=regstr.replace("ss","[0-9]{2}");
	regstr=eval("/^"+regstr+"$/");
	if(!regstr.test(timeStr))
		return false;
	var yearstr="";
	if(formatStr.indexOf("yyyy")>=0)
		yearstr=timeStr.substr(formatStr.indexOf("yyyy"),4);
	var monthstr="";
	if(formatStr.indexOf("MM")>=0)
		monthstr=timeStr.substr(formatStr.indexOf("MM"),2);
	var datestr="";
	if(formatStr.indexOf("dd")>=0)
		datestr=timeStr.substr(formatStr.indexOf("dd"),2);
	var hourstr="";
	if(formatStr.indexOf("hh")>=0)
		hourstr=timeStr.substr(formatStr.indexOf("hh"),2);
	var minstr="";
	if(formatStr.indexOf("mm")>=0)
		minstr=timeStr.substr(formatStr.indexOf("mm"),2);
	var secstr="";
	if(formatStr.indexOf("ss")>=0)
		secstr=timeStr.substr(formatStr.indexOf("ss"),2);
	var obj=new Date(yearstr,monthstr-1,datestr,hourstr,minstr,secstr);
	if(isNaN(obj))
		return false;
	if(obj.getFullYear()!=yearstr || obj.getMonth()+1!=monthstr || obj.getDate()!=datestr || obj.getHours()!=hourstr || obj.getMinutes()!=minstr || obj.getSeconds()!=secstr)
		return false;
	return true;
}
