<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
.line{
width:500px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
}
</style>
</head>


<div class="row">
    <div class="box col-md-4">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 최근 공지</h2>

                
            </div>
            <div class="box-content">
               <div class="box-content">
               <c:forEach items="${gonggiList }" var="gonggiList">
		         <li class="line">
		         <c:if test="${gonggiList.parent != 0}">└</c:if>
		         <a href="/InLecture/lecture/board/${subjectSeq}/${gonggiList.type }/boardPage.do?idx=${gonggiList.idx }">${gonggiList.title }</a>
		         </li>
    			</c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="box col-md-4">
        <div class="box-inner">
            <div class="box-header well" data-original-title="">
                <h2><i class="glyphicon glyphicon-user"></i> 최근 질문</h2>
            </div>
            <div class="box-content">
               <div class="box-content">
          		 <c:forEach items="${qnaList }" var="qnaList">
		         <li class="line">
		         <c:if test="${qnaList.parent != 0}">└</c:if>
		         <a href="/InLecture/lecture/board/${subjectSeq}/${qnaList.type }/boardPage.do?idx=${qnaList.idx }">${qnaList.title }</a>
		         </li>
    			</c:forEach>
            </div>
        </div>
    </div>
</div>
</div>
<div class="row">
    
</div>