const BASE_URL = "http://localhost:8181/board";
const boardId = document.getElementById("reply-container").dataset.bno;

document
  .querySelector(".like-dislike-buttons")
  .addEventListener("click", (e) => {
    const likeButton = document.getElementById("likeButton");
    const dislikeButton = document.getElementById("dislikeButton");
    // const likeCount = document.getElementById("likeCount");
    // const dislikeCount = document.getElementById("dislikeCount");

    if (e.target === likeButton) {
      clickLikes(boardId);
    } else if (e.target === dislikeButton) {
      clickDislikes(boardId);
    } else {
      return;
    }
  });

async function clickLikes(boardId) {
  const url = BASE_URL + `/like?bno=${boardId}`;

  const payload = {
    boardId: boardId,
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

  document.getElementById("likeCount").textContent = data.likes;
}

async function clickDislikes(boardId) {
  const url = BASE_URL + `/dislike?bno=${boardId}`;

  const payload = {
    boardId: boardId,
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

  document.getElementById("dislikeCount").textContent = data.dislikes;
}
