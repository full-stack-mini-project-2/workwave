// ====== 전역 변수 ========
const BASE_URL = "http://localhost:8383/reply";
const bno = document.getElementById("reply-container").dataset.bno;

document.getElementById("submitBtn").addEventListener("click", function () {
  const nickName = document.getElementById("nickName");
  const replyPassword = document.getElementById("replyPassword");
  const replyContent = document.getElementById("replyContent");

  console.log(bno);

  saveReply(bno, nickName, replyContent, replyPassword);
});

// 페이지 로드 시 댓글을 조회
document.addEventListener("DOMContentLoaded", () => {
  fetchReplies(bno);
});

// ====== 실행 코드 ========

// 댓글을 조회하는 함수
async function fetchReplies(bno) {
  // GET 요청을 보낼 URL
  // const url = `http://localhost:8383/reply/${bno}`;
  const url = BASE_URL + `/${bno}`;

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

async function saveReply(bno, nickName, replyContent, replyPassword) {
  const url = BASE_URL;

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
    body: JSON.stringify(payload),
  });

  const data = await response.json();

  console.log(data);

  fetchReplies(bno);

  // 입력창 초기화
  nickName.value = "";
  replyContent.value = "";
  replyPassword.value = "";
}

async function fetchUpdateReply(
  bno,
  replyId,
  editReplyContent,
  editReplyPassword
) {
  const url = BASE_URL;

  const payload = {
    boardId: bno,
    replyId: replyId,
    editReplyContent: editReplyContent.value,
    editReplyPassword: editReplyPassword.value,
  };

  console.log(payload);

  const response = await fetch(url, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  const data = await response.json();

  console.log(data);

  fetchReplies(bno);

  // 입력창 초기화
  editReplyPassword.value = "";
  editReplyContent.value = "";
}

// 댓글 목록을 HTML에 표시하는 함수
function displayReplies(replies) {
  const $replyContainer = document.getElementById("replyContainer");
  $replyContainer.innerHTML = ""; // 기존 댓글 목록 초기화

  // 댓글 목록 렌더링
  let tag = "";
  if (replies && replies.length > 0) {
    tag = `<h2>댓글(${replies.length})</h2>`;
    replies.forEach(
      ({ replyId, nickName, replyCreatedAt, replyContent, replyUpdatedAt }) => {
        tag += `
        <div class="reply">
          <div class="meta">
            작성자: ${nickName} | 작성일: ${replyCreatedAt}
            ${
              replyCreatedAt !== replyUpdatedAt
                ? ` | 수정일: ${replyUpdatedAt}`
                : ""
            }
          </div>
          <div class="content">
            <p>${replyContent}</p>
          </div>
          <button class="replyModify" type="button" data-rno=${replyId}>수정</button>
          <button class="replyDelete" type="button" data-rno=${replyId}>삭제</button>
      </div>
      <div id="editReplyForm-${replyId}" class="reply-form" style="display: none" data-rno=${replyId}>
      </div>
       `;
      }
    );
  } else {
    tag = `<h2>댓글(0)</h2>
    <div class="reply">댓글이 없습니다.</div>`;
  }

  $replyContainer.innerHTML = tag;

  // 수정 버튼에 이벤트 리스너 추가
  document.querySelectorAll(".replyModify").forEach((button) => {
    button.addEventListener("click", function () {
      const replyId = this.dataset.rno;
      showEditForm(replyId);
    });
  });
}

// 수정 버튼 클릭시 해당 댓글 수정 화면 출력
function showEditForm(replyId) {
  const editForm = document.getElementById(`editReplyForm-${replyId}`);

  if (editForm.style.display === "block") {
    editForm.style.display = "none";
    editForm.innerHTML = "";
  } else {
    editForm.style.display = "block";
    editForm.innerHTML = `
      <h2>댓글 수정</h2>
        <input type="hidden" data-rno="editReplyId" />
        <input
          type="password"
          id="editReplyPassword"
          placeholder="댓글 비밀번호"
          required
        />
        <textarea
          id="editReplyContent"
          placeholder="댓글 내용"
          required
        ></textarea>
        <button id="editSubmitBtn" type="button">댓글 수정</button>
      `;
  }

  const editReplyContent = document.getElementById("editReplyContent");
  const editReplyPassword = document.getElementById("editReplyPassword");

  document.getElementById("editSubmitBtn").addEventListener("click", (e) => {
    fetchUpdateReply(bno, replyId, editReplyContent, editReplyPassword);
  });
}

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
