// ====== 전역 변수 ========
const BASE_URL = "http://localhost:8383/reply";
const bno = document.getElementById("reply-container").dataset.bno;

document.getElementById("submitBtn").addEventListener("click", function () {
  const nickName = document.getElementById("nickName");
  const replyPassword = document.getElementById("replyPassword");
  const replyContent = document.getElementById("replyContent");

  console.log(bno);

  fetchSaveReply(bno, nickName, replyContent, replyPassword);
});

// 페이지 로드 시 댓글을 조회
document.addEventListener("DOMContentLoaded", () => {
  fetchReplies(bno);
});

// ====== 실행 코드 ========

// 댓글을 조회하는 요청
async function fetchReplies(bno) {
  // GET 요청을 보낼 URL
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

// 대댓글을 조회하는 요청
async function fetchSubReplies(rno) {
  // GET 요청을 보낼 URL
  const url = BASE_URL + `/sub/${rno}`;

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
    const subReplies = data.subReplies;

    let tag = "";

    if (subReplies && subReplies.length > 0) {
      subReplies.forEach(
        ({
          subReplyId,
          nickName,
          subReplyCreatedAt,
          subReplyContent,
          subReplyUpdatedAt,
        }) => {
          tag += `
          <div class="sub-reply">
            <div class="meta">
              작성자: ${nickName} | 작성일: ${subReplyCreatedAt}
              ${
                subReplyCreatedAt !== subReplyUpdatedAt
                  ? ` | 수정일: ${subReplyUpdatedAt}`
                  : ""
              }
            </div>
            <div class="content">
              <p>${subReplyContent}</p>
            </div>
            <div class="button-group">
              <button class="subReplyModify" type="button" data-rno=${subReplyId}>수정</button>
              <button class="subReplyDelete" type="button" data-rno=${subReplyId}>삭제</button>
            </div>

          </div>
          <div id="editSubReplyForm-${subReplyId}" class="reply-form" style="display: none" data-rno=${subReplyId}>
          </div>
          <div id="editDeleteSubReplyForm-${subReplyId}" class="reply-form" style="display: none" data-rno=${subReplyId}>
          </div>
          `;
        }
      );
    } else {
      return;
    }

    document.getElementById("subRepliesContainer").style.display = "block";
    document.getElementById("subRepliesContainer").innerHTML = tag;

    // 대댓글 수정버튼에 이벤트 리스너 추가
    document.querySelectorAll(".subReplyModify").forEach((button) => {
      button.addEventListener("click", function () {
        // const subReplyId = this.dataset.rno;
        // showSubEditForm(subReplyId);
        console.log("답글 수정");
      });
    });

    // 대댓글 삭제버튼에 이벤트 리스너 추가
    document.querySelectorAll(".subReplyDelete").forEach((button) => {
      button.addEventListener("click", function () {
        // const subReplyId = this.dataset.rno;
        // showSubEditForm(subReplyId);
        console.log("답글 삭제");
      });
    });
  } catch (error) {
    console.error("Error:", error);
  }
}

// 댓글 작성하는 비동기 요청
async function fetchSaveReply(bno, nickName, replyContent, replyPassword) {
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

// 대댓글을 작성하는 비동기 요청
async function fetchSaveSubReply(
  replyId,
  subNickName,
  subReplyContent,
  subReplyPassword
) {
  const url = BASE_URL + "/sub";

  const payload = {
    nickName: subNickName.value,
    subReplyContent: subReplyContent.value,
    replyId: replyId,
    subReplyPassword: subReplyPassword.value,
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
  subNickName.value = "";
  subReplyContent.value = "";
  subReplyPassword.value = "";
}

// 댓글을 수정하는 비동기 요청
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

// 댓글을 삭제하는 비동기 요청
async function fetchDeleteReply(bno, replyId, replyDeletePassword) {
  const url = BASE_URL;

  const payload = {
    boardId: bno,
    replyId: replyId,
    replyDeletePassword: replyDeletePassword.value,
  };

  console.log(payload);

  const response = await fetch(url, {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  const data = await response.json();

  console.log(data);

  fetchReplies(bno);

  replyDeletePassword.value = "";
}

// 댓글 목록을 HTML에 표시하는 요청
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
          <div class="button-group">
            <button class="replyModify" type="button" data-rno=${replyId}>수정</button>
            <button class="replyDelete" type="button" data-rno=${replyId}>삭제</button>
            <button class="subReply" type="button" data-rno=${replyId}>답글</button>
          </div>
          <div id="subRepliesContainer" style="display: none">
          </div>
        </div>
        <div id="editSubReplyForm-${replyId}" class="reply-form" style="display: none" data-rno=${replyId}>
        </div>
        <div id="editReplyForm-${replyId}" class="reply-form" style="display: none" data-rno=${replyId}>
        </div>
        <div id="editDeleteForm-${replyId}" class="reply-form" style="display: none" data-rno=${replyId}>
        </div>
        `;

        // 대댓글 목록 렌더링
        fetchSubReplies(replyId);
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

  // 삭제 버튼에 이벤트 리스너 추가
  document.querySelectorAll(".replyDelete").forEach((button) => {
    button.addEventListener("click", function () {
      const replyId = this.dataset.rno;
      showDeleteForm(replyId);
    });
  });

  // 답글 버튼에 이벤트 리스너 추가
  document.querySelectorAll(".subReply").forEach((button) => {
    button.addEventListener("click", function () {
      const replyId = this.dataset.rno;
      showEditSubReplyForm(replyId);
    });
  });
}

// 답글 버튼 클릭시 답글 입력화면 출력
function showEditSubReplyForm(replyId) {
  const editSubReplyForm = document.getElementById(
    `editSubReplyForm-${replyId}`
  );

  if (editSubReplyForm.style.display === "block") {
    editSubReplyForm.style.display = "none";
  } else {
    editSubReplyForm.style.display = "block";
    editSubReplyForm.innerHTML = `
       <div class="subReply-form">
        <h2>답글 작성</h2>
        <input type="hidden" id="replyId" value="${replyId}" />
        <input type="text" id="subNickName" placeholder="닉네임" required />
        <input
          type="password"
          id="subReplyPassword"
          placeholder="답글 비밀번호"
          required
        />
        <textarea id="subReplyContent" placeholder="답글 내용" required></textarea>
        <button id="submitSubReplyBtn" type="button">답글 등록</button>
      </div>
      `;
  }

  const subNickName = document.getElementById("subNickName");
  const subReplyContent = document.getElementById("subReplyContent");
  const subReplyPassword = document.getElementById("subReplyPassword");

  const submitSubReplyBtn = document.getElementById("submitSubReplyBtn");

  submitSubReplyBtn.addEventListener("click", (e) => {
    if (e.target === submitSubReplyBtn) {
      fetchSaveSubReply(
        replyId,
        subNickName,
        subReplyContent,
        subReplyPassword
      );
    }
  });
}

// 수정 버튼 클릭시 해당 댓글 수정 화면 출력
function showEditForm(replyId) {
  const editForm = document.getElementById(`editReplyForm-${replyId}`);

  if (editForm.style.display === "block") {
    editForm.style.display = "none";
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

  const editSubmitBtn = document.getElementById("editSubmitBtn");

  editSubmitBtn.addEventListener("click", (e) => {
    if (e.target === editSubmitBtn) {
      fetchUpdateReply(bno, replyId, editReplyContent, editReplyPassword);
    }
  });
}

// 삭제 버튼 클릭시 해당 댓글 삭제 화면 출력
function showDeleteForm(replyId) {
  const deleteForm = document.getElementById(`editDeleteForm-${replyId}`);

  if (deleteForm.style.display === "block") {
    deleteForm.style.display = "none";
  } else {
    deleteForm.style.display = "block";
    deleteForm.innerHTML = `
      <h2>댓글 삭제</h2>
        <input
          type="password"
          id="replyDeletePassword"
          placeholder="댓글 비밀번호"
          required
        />
        <button id="deleteSubmitBtn" type="button">확인</button>
      `;
  }

  const replyDeletePassword = document.getElementById("replyDeletePassword");

  const deleteSubmitBtn = document.getElementById("deleteSubmitBtn");

  deleteSubmitBtn.addEventListener("click", (e) => {
    if (e.target === deleteSubmitBtn) {
      fetchDeleteReply(bno, replyId, replyDeletePassword);
    }
  });
}
