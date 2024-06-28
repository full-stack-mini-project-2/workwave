<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>점심 메이트 게시판</title>
 <style>
         table {
             width: 100%;
             border-collapse: collapse;
         }
         th, td {
             border: 1px solid black;
             padding: 10px;
             text-align: left;
         }
         th {
             background-color: #f2f2f2;
         }

         .join-button {
                     text-align: center; /* 버튼 가운데 정렬 */
                 }
     </style>
</head>
<body>
    <h1>LUNCH MATE BOARD</h1>
   <table>
       <c:forEach var="board" items="${boards}" varStatus="loop">
           <thead>
               <tr>
                   <th>작성자</th>
                   <th>제목</th>
                   <th>작성일자</th>
                   <th>식사일정</th>
                   <th>식당</th>
                   <th>메뉴</th>
                   <th>인원</th>
                   <th>상태</th>
                     <th>참가하기</th>
               </tr>
           </thead>
           <tbody>
               <tr>
                   <td>${board.userId}</td>
                   <td>${board.lunchPostTitle}</td>
                   <td>${board.lunchDate}</td>
                   <td>${board.eatTime}</td>
                   <td>${board.lunchLocation}</td>
                   <td>${board.lunchMenuName}</td>
                   <td>${board.lunchAttendees}</td>
                   <td>${board.progressStatus}</td>
                    <td class="join-button">
                        <a href="#">참가하기</a>
                    </td>
               </tr>
           </tbody>
       </c:forEach>
   </table>
    <div class="button-container">
          <a href="http://localhost:8383/lunchMateBoard/new" class="button">새 글쓰기</a>
      </div>

</body>
</html>
