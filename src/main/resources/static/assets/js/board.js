const BASE_URL = "http://localhost:8383/board";
const boardId = document.getElementById("reply-container").dataset.bno;
const likeLoggedId = document.getElementById("likeCount").dataset.id;
const dislikeLoggedId = document.getElementById("dislikeCount").dataset.id;

const likeButton = document.getElementById("likeButton");
const dislikeButton = document.getElementById("dislikeButton");

likeButton.addEventListener("click", async (e) => {

  if (e.target === likeButton) {
    const likeCountElem = document.getElementById("likeCount");
    if (likeCountElem.dataset.id === likeLoggedId + "-clicked") {
      await clickDownLikes(boardId);
    } else {
      await clickUpLikes(boardId);
      const dislikeCountElem = document.getElementById("dislikeCount");
      if (dislikeCountElem.dataset.id === dislikeLoggedId + "-clicked") {
        await clickDownDislikes(boardId);
      }
    }
  }

});

dislikeButton.addEventListener("click", async (e) => {

  if (e.target === dislikeButton) {
    const dislikeCountElem = document.getElementById("dislikeCount");
    if (dislikeCountElem.dataset.id === dislikeLoggedId + "-clicked") {
      await clickDownDislikes(boardId);
    } else {
      await clickUpDislikes(boardId);
      const likeCountElem = document.getElementById("likeCount");
      if (likeCountElem.dataset.id === likeLoggedId + "-clicked") {
        await clickDownLikes(boardId);
      }
    }
  }
  
});

async function clickUpLikes(boardId) {
  const url = BASE_URL + `/upLike?bno=${boardId}`;

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

  document.getElementById("likeCount").dataset.id = likeLoggedId + "-clicked";
  document.getElementById("likeCount").textContent = data.likes;
}

async function clickDownLikes(boardId) {
  const url = BASE_URL + `/downLike?bno=${boardId}`;

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

  document.getElementById("likeCount").dataset.id = likeLoggedId;
  document.getElementById("likeCount").textContent = data.likes;
}

async function clickUpDislikes(boardId) {
  const url = BASE_URL + `/upDislike?bno=${boardId}`;

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

  document.getElementById("dislikeCount").dataset.id =
    dislikeLoggedId + "-clicked";
  document.getElementById("dislikeCount").textContent = data.dislikes;
}

async function clickDownDislikes(boardId) {
  const url = BASE_URL + `/downDislike?bno=${boardId}`;

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

  document.getElementById("dislikeCount").dataset.id = dislikeLoggedId;
  document.getElementById("dislikeCount").textContent = data.dislikes;
}
