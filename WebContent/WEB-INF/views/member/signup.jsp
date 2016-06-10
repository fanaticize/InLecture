<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>InLecture</title>
	<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
	});
	function verifyID(){
		var param = { 
		    	"id" : $('#id').val()
		    	};
		var _data = JSON.stringify(param);
		$.ajax({
		    url : "verifyID.do",
		    type : "post",
		    contentType : "application/json",
		    data : _data,
		    success: function(data) {
				if(data=='N'){
					$('#verify').css('display', 'block');
					$('#verifyVal').val('N');
				}else{
					$('#verify').css('display', 'none');
					$('#verifyVal').val('Y');
				}
		    },
		    error:function(request,status,error){
		    }
		 
		});
	}
	function doSubmit(){
		if($('#verifyVal').val() == 'N'){
			alert('중복검증에 성공하지 못했습니다.');
		}else{
			document.member1.submit();
		}
	}
	</script>
</head>

<body>
<div class="ch-container">
    <div class="row">
        
    <div class="row">
        <div class="col-md-12 center login-header">
            <h2>In Lecture System</h2>
        </div>
        <!--/span-->
    </div><!--/row-->

    <div class="row">
        <div class="well col-md-5 center login-box"><!--
            <div class="alert alert-info">
                Please login with your Username and Password.
            </div>-->
        	<form:form commandName="member" name="member1" class="form-horizontal">
              <div class="form-group">
                <label for="inputID" class="col-sm-2 control-label">ID</label>
                <div class="col-sm-10">
                <form:input path="id" class="form-control" placeholder="ID" onchange="verifyID();"/>
        		<form:errors path="id" />
        		<span id="verify" style="display:none;">
        			중복된 아이디입니다.
        			<input id="verifyVal" type="hidden" value="N"/>
        		</span>
<!--                   <input type="text" class="form-control" id="inputID" placeholder="ID"> -->
                </div>
              </div>
              <div class="form-group">
                <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                <div class="col-sm-10">
                  <form:password path="pw" class="form-control" id="inputPassword3" placeholder="Password"/>
       			  <form:errors path="pw" />
                </div>
              </div>
               <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">이름</label>
                <div class="col-sm-10">
                <form:input path="name"  class="form-control" id="inputEmail3" placeholder="이름" />
                <form:errors path="name" />
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">소속 학교</label>
                <div class="col-sm-10">
                <form:input path="school" class="form-control" id="inputEmail3" placeholder="소속 학교" />
                <form:errors path="school" />
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">고유번호(학번)</label>
                <div class="col-sm-10">
                <form:input path="code" class="form-control" id="inputEmail3" placeholder="고유번호(학번)"/>
                <form:errors path="code" />
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
                <div class="col-sm-10">
                  <form:input path="email" class="form-control" id="inputEmail3" placeholder="Email"/><form:errors path="email" />
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">닉네임</label>
                <div class="col-sm-10">
                <form:input path="nick" class="form-control" id="inputEmail3" placeholder="닉네임"/>
                <form:errors path="nick" />
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">신분</label>
                <div class="col-sm-10">
<!--               		<div style="margin-left: 134px;"> -->
	                    <label class="radio-inline">
	                    	<form:radiobutton path="role" value="T" label="교수" />
	                    </label>
	                    <label class="radio-inline">
	                    <form:radiobutton path="role" value="S" label="학생" /> 
	                    </label><p>
						<form:errors path="role" />
<!-- 					</div> -->
				</div>
              </div>
              <div class="form-group">
                  <button type="button" class="btn btn-default" style="width: 150px;" onclick="doSubmit();">Sign up</button>
                     

	               </div>
	            </form:form>
	        </div>
	        <!--/span-->
	    </div><!--/row-->
	</div><!--/fluid-row-->

</div><!--/.fluid-container-->

<%-- <form:form commandName="member"> --%>
<!--   <table> -->
<!--      <tr> -->
<!--         <td>아이디 :</td> -->
<!--         <td> -->
<%--         <form:input path="id" /> --%>
<%--         <form:errors path="id" /> --%>
<!--         </td> -->
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>패스워드 :</td>  -->
<!--         <td> -->
<%--         <form:password path="pw" /> --%>
<%--         <form:errors path="pw" /> --%>
<!--         </td> -->
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>유형 :</td> -->
<%--         <td><form:radiobutton path="role" value="S" label="학생" />  --%>
<%--             <form:radiobutton path="role" value="T" label="교수" /> --%>
<%--             <form:errors path="role" /></td> --%>
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>이름 :</td> -->
<%--         <td><form:input path="name" /><form:errors path="name" /></td> --%>
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>고유번호(학번) :</td> -->
<%--         <td><form:input path="code" /><form:errors path="code" /></td> --%>
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>닉네임 :</td> -->
<%--         <td><form:input path="nick" /><form:errors path="nick" /></td> --%>
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>학교 :</td> -->
<%--         <td><form:input path="school" /><form:errors path="school" /></td> --%>
<!--      </tr> -->
<!--      <tr> -->
<!--         <td>이메일 :</td> -->
<%--         <td><form:input path="email" /><form:errors path="email" /></td> --%>
<!--      </tr> -->
<!--    </table> -->
<!--    <input type="submit" value="submit"/> -->
<%-- </form:form> --%>
</body>
</html>