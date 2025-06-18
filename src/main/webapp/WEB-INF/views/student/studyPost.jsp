<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>스터디 게시판</title>
</head>
<body>
<h2>강의 ID: ${lectureId} - 스터디 게시판</h2>

<!-- 조별 태그 버튼 -->
<div>
    <c:forEach var="entry" items="${groupPostMap}">
        <button class="tag-btn" onclick="showGroup(${entry.key})">조 ${entry.key}</button>
    </c:forEach>
</div>


<!-- 조별 게시글 테이블 -->
<c:forEach var="entry" items="${groupPostMap}">
    <div id="group-${entry.key}" class="post-table" style="display:none;">
        <h3>조 ${entry.key}의 게시글</h3>
        
        <!-- 새글 등록 -->
        <c:if test="${isLeaderMap[entry.key]}">
		    <a href="/student/addStudyPost/${entry.key}">새글등록</a>
		</c:if>

        
        <table border="1">
            <thead>
                <tr>
                    <th>조</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${entry.value}">
                    <tr>
                        <td>${post.groupId}</td>
                        <td>
                        	<a href="/student/studyPostOne/${post.postId}">
                        		${post.title}
                        	</a>
                        </td>
                        <td>${post.createDate}</td>
                        <td>
                        	<c:if test="${isLeaderMap[entry.key]}">
                                <a href="/student/updateStudyPost/${post.postId}">수정</a>
                                <a href="javascript:void(0);" onclick="deleteStudyPost(${post.postId}, ${lectureId})">삭제</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:forEach>

<br>
<a href="/student/lectureOne?lectureId=${lectureId}">← 강의페이지로 돌아가기</a>
<script>
    function showGroup(groupId) {
        // 모든 테이블 숨김
        document.querySelectorAll('.post-table').forEach(div => {
            div.style.display = 'none';
        });

        // 모든 버튼 초기화
        document.querySelectorAll('.tag-btn').forEach(btn => {
            btn.style.backgroundColor = '';
            btn.style.color = '';
        });

        // 선택된 테이블 보이기
        const groupDiv = document.getElementById('group-' + groupId);
        if (groupDiv) groupDiv.style.display = 'block';

        // 선택된 버튼 스타일 강조 (간단한 인라인 예시)
        const selectedBtn = Array.from(document.querySelectorAll('.tag-btn'))
            .find(btn => btn.textContent.includes(groupId));
        if (selectedBtn) {
            selectedBtn.style.backgroundColor = '#4CAF50';
            selectedBtn.style.color = '#fff';
        }
    }
    
    function deleteStudyPost(postId, lectureId) {
        if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
                url: '/student/studyPosts/' + postId,
                type: 'DELETE',
                success: function(response) {
                    alert('게시글이 삭제되었습니다.');
                    location.href = '/student/studyPost/' + lectureId;
                },
                error: function(xhr) {
                    alert('삭제 중 오류가 발생했습니다.');
                    console.error(xhr.responseText);
                }
            });
        }
    }

    // 첫 조 자동 선택
    window.onload = function () {
        const firstBtn = document.querySelector('.tag-btn');
        if (firstBtn) firstBtn.click();
    }
</script>
</body>
</html>
