<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">  

function MM_goToURL() { //v3.0
	  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
	  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
	}
	function JM_cc(ob)
	{
	    var obj=MM_findObj(ob); 
	    if (obj) 
	    { 
	        obj.select();js=obj.createTextRange();js.execCommand("Copy");
	    }
	}

	function MM_findObj(n, d) 
	{ //v4.0
	      var p,i,x;  
	      if(!d) d=document; 
	      
	      if((p=n.indexOf("?"))>0&&parent.frames.length)
	       {
	         d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	        }
	      if(!(x=d[n])&&d.all) x=d.all[n];
	       
	      for (i=0;!x&&i<d.forms.length;i++)
	        x=d.forms[i][n];
	      for(i=0;!x&&d.layers&&i<d.layers.length;i++)
	        x=MM_findObj(n,d.layers[i].document);
	        
	      if(!x && document.getElementById) x=document.getElementById(n);
	       return x;
	}
	//-->


 /*  var xmlhttp;  
  var outMsg;  
  function createXMLHtppRequest()  
  {  
    if(window.ActiveXOject)  
    {  
     xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");  
    }  
    else if(window.XMLHttpRequest)  
    {  
      xmlhttp = new XMLHttpRequest();  
    }  
  }  
    
    
  function createQueryString()  
  {  
    //createRequest();  
    var userName = document.getElementById("userName").value;  
    var queryString=  "userName="+userName;  
    return queryString;    
  }  
    
  function doRequest()    
{  
  createXMLHtppRequest();  
  var queryString = "HelloAjaxJava1?";  
  queryString = queryString+createQueryString();  
  xmlhttp.onreadystatechange = handleStateChange;  
  xmlhttp.open("POST", "../afterSaleComeRecordServlet.do?sign=SearchExportList", true);  
  xmlhttp.send(null);  
    
}  
function handleStateChange()  
{  
 if(xmlhttp.readyState==4)  
 {  
   if(xmlhttp.status==200) parseResults();  
 }  
}  
function parseResults()  
{  
	alert("zoudao");
  var responseDiv = document.getElementById("serverResponse");  
  if(responseDiv.hasChildNodes())  
  {   
    responseDiv.removeChild(responseDiv.childNodes[0]);  
  }  
  var responseText = document.createTextNode(xmlhttp.responseText);  
  responseDiv.appendChild(responseText);  
}   */
</script>  

</head>
<body>


<!--第二步：把如下代码加入到<body>区域中-->
<div>
<INPUT name=Button onclick="JM_cc('js_1')" type=button value=复制到剪贴板>
  <BR>
</div>

  <div align="center">
    <TEXTAREA cols=70 name=js_1 rows=10 wrap=VIRTUAL></textarea>
  </div>

<br />
<a href="#" onclick="JM_cc('js_1')">复制</a>

	<!--  <h1>Simple Application Form</h1>  
  <form action="#">  
  choose your user:  
  <input type="text" id="userName"/>  
  <br>  
  <br>  
  <input type="button" id="submission" value="submit" onclick="doRequest();"/>  
  </form>  
  <br>  
  <h2>Server Response:</h2>  
  <div id="serverResponse"></div>   -->
</body>
</html>