// ====== 전역 변수 ========
//export const BASE_URL = 'http://localhost:8383/replies';

// ====== 실행 코드 ========
const bno = document.getElementById("reply-container").dataset.bno;

// 댓글을 조회하는 함수
async function fetchReplies(bno) {
  // GET 요청을 보낼 URL
  const url = `http://localhost:8383/reply/${bno}`;

  try {
    // fetch API를 사용하여 GET 요청 보내기
    const response = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });

    // 응답 데이터를 JSON으로 변환
    const data = await response.json();

    // 서버로부터 받은 데이터를 처리하는 로직
    console.log(data);

    // 배열을 추출
    const replies = data.replies;

    // 예: 댓글 목록을 HTML에 표시하기
    displayReplies(replies);
  } catch (error) {
    console.error("Error:", error);
  }
}

document.getElementById("submitBtn").addEventListener("click", function () {

  const nickName = document.getElementById("nickName");
  const replyPassword = document.getElementById("replyPassword");
  const replyContent = document.getElementById("replyContent");

  // if (!nickName || !replyPassword || !replyContent) {
  //   alert("모든 필드를 입력해 주세요.");
  //   return;
  // }

  console.log(bno);

  saveReply(bno, nickName, replyContent, replyPassword);
});

async function saveReply(bno, nickName, replyContent, replyPassword) {
  const url = `http://localhost:8383/reply`;

  const payload = {
    nickName: nickName.value,
    replyContent: replyContent.value,
    boardId: bno,
    replyPassword: replyPassword.value,
  };

  console.log(payload);

  const response = await fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ payload }),
  });

  const data = await response.json();

  console.log(data);
}

// 댓글 목록을 HTML에 표시하는 함수 (예시)
function displayReplies(replies) {
  const $replyContainer = document.getElementById("replyContainer");
  $replyContainer.innerHTML = ""; // 기존 댓글 목록 초기화

  // 댓글 목록 렌더링
  let tag = "";
  if (replies && replies.length > 0) {
    replies.forEach(({ nickName, replyCreatedAt, replyContent }) => {
      tag += `
       <div class="reply">
            <div class="meta">
              작성자: ${nickName} | 작성일: ${replyCreatedAt}
            </div>
            <div class="content">
              <p>${replyContent}</p>
            </div>
        </div>
       `;
    });
  } else {
    tag = `<div class="reply">댓글이 없습니다.</div>`;
  }

  $replyContainer.innerHTML = tag;
}

// 페이지 로드 시 댓글을 조회
document.addEventListener("DOMContentLoaded", () => {
  fetchReplies(bno);
});

// 댓글 목록 서버에서 불러오기
// fetchReplies();
//fetchInfScrollReplies(); // 일단 1페이지 데이터 그려놓기
// setupInfiniteScroll(); // 무한 스크롤 이벤트 등록

// 댓글 작성 이벤트 등록
//document.getElementById('replyAddBtn').addEventListener('click', e => {
//  // 댓글 등록 로직
//  fetchReplyPost();
//});

// 댓글 삭제 이벤트 등록
//removeReplyClickEvent();
//modifyReplyClickEvent();

// 댓글 페이지 클릭이벤트 등록
// replyPageClickEvent();
