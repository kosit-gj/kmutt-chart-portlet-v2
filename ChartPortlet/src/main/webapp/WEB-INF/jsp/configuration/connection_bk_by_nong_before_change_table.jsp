<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Connection</title>
<c:set var="ns"><portlet:namespace/></c:set>
<portlet:resourceURL var="getConnection" id="getConnection"></portlet:resourceURL>  
<portlet:actionURL var="formActionSave">
        <portlet:param name="action" value="doSave"/>
</portlet:actionURL>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.11.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/fusioncharts/js/fusioncharts.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/fusioncharts/js/themes/fusioncharts.theme.fint.js"/>"></script>
<script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
<style type="text/css">
	.errorMessage{ color:red;}
	
	.aui .form-horizontal .control-group{
		margin-bottom: 0;
	}
	.portlet-content {
    background: rgba(0, 0, 0, 0) linear-gradient(to bottom, #fff 0px, #f6f6f6 47%, #ededed 100%) repeat scroll 0 0;
    border-radius: 0;
    margin-bottom: 0;
	}
	.aui .form-horizontal .control-label{
	 width: 140px;
	 text-align: left;
	 font-weight:bold;
	}
	
	
	.aui .form-horizontal .controls {
	    margin-left: 143px;
	}
	.aui .portlet-content, .aui .portlet-minimized .portlet-content-container{
		padding: 15px 15px 15px 15px;
	}
	
	.labelConnection{
		width:160px;
		float:left;
		padding-top:5px;
		font-weight:bold;
	}
	
	.inputFormConnection{
		/*width:300px;*/
		float:left;
		padding-top:5px;
	}
	
	.aui label {
    font-weight:bold;
	}
	
	.aui .btn {
		font-size: 14px;
	 	padding: 4px 12px; 
		width: auto;
		margin-top: 0px;
		display: inline;
	}
	
	/* Large desktop Start#####################################*/
 @media (min-width: 1200px) { 
 
	
	.areaBtn{
		padding-left:160px;
	}
	 
  }
  /* Large desktop End######################################*/
  
  /*  desktop Start#########################################*/
 @media (min-width: 980px) and (max-width: 1199px) {
 
 	.labelConnection{
		width:100%;
	}
	.areaBtn{
		padding-left:0px;
	}
 	
  }
 /*  desktop End############################################*/
 
 /* Portrait tablet to landscape and desktop Start##########*/
 @media (min-width: 768px) and (max-width: 979px) {
 
	.labelConnection{
		width:100%;
	}

  }
 /* Portrait tablet to landscape and desktop End############*/ 
 
 /* Landscape phone to portrait tablet Start################*/
 @media (max-width: 767px) { 
 	
 	.labelConnection{
		width:100%;
	}
 
  }
 /* Landscape phone to portrait tablet End##################*/ 
 
 /* Landscape phones and down Start#########################*/
 @media (max-width: 480px) { 
 	
 	.labelConnection{
		width:100%;
	}
 

  }
  /* Landscape phones and down End##########################*/
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var controlMessage = "${connectionForm.message}";
		if(controlMessage.length>1){
			alert(controlMessage);
		}
	});
	function connNew(){
		$("#web_${ns} #mode").val("add");
		var result = confirm("Do you want to save as this connection ?");
		if (!result) {
		    return false;
		}
		connFormSubmit();
	}
	function connUpdate(){
		$("#web_${ns} #mode").val("edit");
		var result = confirm("Do you want to update this connection ?");
		if (!result) {
		    return false;
		}
		connFormSubmit();
	}
	function connDelete(){
		$("#web_${ns} #mode").val("delete");
		var result = confirm("Do you want to delete this connection ");
		if (!result) {
		    return false;
		}
		connFormSubmit();
	}
	function connFormSubmit(){
		$("#web_${ns} #submitMessage").html(""); //reset
		var invalid = [];
		$("#web_${ns} .detail").each(function(){
			if(this.value == ""){
				invalid.push( $(this).previous("label").html());
			}	
		});
		if(invalid.length<=0){
			$("#connectionForm").submit();
		}else{
			var message = "Require following fields: ["+invalid.join(",")+"]";
			$("#web_${ns} #submitMessage").html(message);
		}
	}
	function recallConnection(select){
			$("#web_${ns} .detail").val("");
			$.ajax({
	   	 		dataType: "json",
	   	 		url:"<%=getConnection%>",
	   	 		data: { connId: select.value },
	   	 		success:function(data){
	   	 			console.log(data);
	   	 			if(data["header"]["success"]>0){
	   	 				renderConnDetail(data["content"]);
	   	 			}
	   	 			else{
	   	 				$("#web_${ns} #sqlMessage").html("retrive connection detail not complete");
	   	 			}
	   	 		},fail:function(data){
	   	 			$("#web_${ns} #sqlMessage").html("retrive connection detail error");
	   	 		} 
	   	 	});
	}
	function renderConnDetail(data){
		$("#web_${ns} #connName").val(data["connName"]);
		$("#web_${ns} #connString").val(data["connString"]);
		$("#web_${ns} #driverClass").val(data["driverClass"]);
		$("#web_${ns} #dialect").val(data["dialect"]);
		$("#web_${ns} #username").val(data["username"]);
		$("#web_${ns} #password").val(data["password"]);
	}
</script>
</head>
<body >
<div class='row-fluid'>
	
	<div class='span6 offset3'>
		<div id="web_${ns}" style='display:block;'>
		<form:form id="connectionForm" modelAttribute="connectionForm" method="post" name="connectionForm" action="${formActionSave}" enctype="multipart/form-data">
			<form:hidden id="mode" path="mode" />
			<label class='labelConnection'>Connection List</label>
			<form:select  id="connId" path="model.connId" class='span12 inputFormConnection'  onchange="recallConnection(this)" style="width:337px;" >
				<form:option value="" label=""/>
	   			<form:options items="${connectionForm.conns}" itemValue="connId" itemLabel="connName"/>
			</form:select>
			<br style='clear:both'/>
			<label class='labelConnection'>Connection Name</label><form:input id="connName" class="detail inputFormConnection" type="text" path="model.connName" style="width:320px;" /><br/>
			<label class='labelConnection'>Connection string</label><form:input id="connString" type="text" class="detail inputFormConnection" path="model.connString" style="width:320px;" /><br/>
			<label class='labelConnection'>Driver class</label><form:input id="driverClass" type="text" class="detail inputFormConnection" path="model.driverClass" style="width:320px;" /><br/>
			<label class='labelConnection'>Hibernate Dialect</label><form:input id="dialect" type="text" class="detail inputFormConnection" path="model.dialect" style="width:320px;" /><br/>
			<label class='labelConnection'>User</label><form:input id="username" type="text" class="detail inputFormConnection" path="model.username" style="width:320px;" /><br/>
			<label class='labelConnection'>Password</label><form:input id="password" type="password" class="detail inputFormConnection" path="model.password" style="width:320px;"/><br/>
			<p id="submitMessage"></p>
			<br style='clear:both'/>
			<div class='areaBtn'>
			<input type="button" class="btn btn-primary" onclick="connNew()" value="Save as"/>
			<input type="button" class="btn btn-primary" onclick="connUpdate()" value="Update"/>
			<input type="button" class="btn btn-primary" onclick="connDelete()" value="Delete"/> 
			</div>		
		</form:form>
		</div>
	</div>
	
	
</div>
<!-- new design end --> 
</body>
</html>