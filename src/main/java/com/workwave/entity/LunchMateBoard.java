package com.workwave.entity;

/*
    CREATE TABLE lunch_posts (
    lunch_post_number INT PRIMARY KEY NOT NULL,
    user_id VARCHAR(50),
    lunch_post_title VARCHAR(100) NOT NULL,
    lunch_date TIMESTAMP,
    lunch_location VARCHAR(100),
    lunch_menu_name VARCHAR(100),
    lunch_attendees INT,
    progress_status VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
*/

import lombok.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

@Setter @Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LunchMateBoard {

    private int lunchPostNumber; // 게시글 번호 (안되면 빼기)
    private String userId; //유저 아이디
    private String lunchPostTitle; // 글 제목
    private LocalDateTime lunchDate; // 작성일시
    private String eatTime; // 식사 일정 (안되면 빼기)
    private String lunchLocation; // 식당 위치 (식당명)
    private String lunchMenuName; // 메뉴 이름
    private int lunchAttendees; // 최대 모집인원 수
    private String progressStatus; // 모집 인원 진행 상황

    public LunchMateBoard(ResultSet rs) throws SQLException {
        this.lunchPostNumber = rs.getInt("lunch_post_number");
        this.userId = rs.getString("user_id");
        this.lunchPostTitle = rs.getString("lunch_post_title");
        this.lunchDate = rs.getTimestamp("lunch_date").toLocalDateTime();
        this.eatTime = rs.getString("eat_time");
        this.lunchLocation = rs.getString("lunch_location");
        this.lunchMenuName = rs.getString("lunch_menu_name");
        this.lunchAttendees = rs.getInt("lunch_attendees");
        this.progressStatus = rs.getString("progress_status");

    }

}
