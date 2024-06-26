<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Lunch Board</title>
</head>
<body>
<h1>Create New Lunch Mate Post</h1>
<form action="/lunchMateBoard/new" method="post">
    <label for="userId">User ID:</label>
    <input type="text" id="userId" name="userId" required><br>

    <label for="lunchPostTitle">Title:</label>
    <input type="text" id="lunchPostTitle" name="lunchPostTitle" required><br>

    <label for="lunchDate">Date:</label>
    <input type="datetime-local" id="lunchDate" name="lunchDate" required><br>

    <label for="lunchLocation">Location:</label>
    <input type="text" id="lunchLocation" name="lunchLocation" required><br>

    <label for="lunchMenuName">Menu Name:</label>
    <input type="text" id="lunchMenuName" name="lunchMenuName" required><br>

    <label for="lunchAttendees">Max Attendees:</label>
    <input type="number" id="lunchAttendees" name="lunchAttendees" required><br>

    <label for="progressStatus">Status:</label>
    <input type="text" id="progressStatus" name="progressStatus" required><br>

    <input type="submit" value="Submit">
</form>
</body>
</html>
