const BASE_URL = "http://localhost:8383/board";
const boardId = document.getElementById("reply-container").dataset.bno;

document.addEventListener("click", (e) => {
  const likeButton = document.getElementById("likeButton");
  const dislikeButton = document.getElementById("dislikeButton");
  const likeCount = document.getElementById("likeCount");
  const dislikeCount = document.getElementById("dislikeCount");

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

  console.log(data);

  
}

async function clickDislikes() {
  dislikeCount + 1;
}
