package com.workwave.entity;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@EqualsAndHashCode
@ToString
@Builder
public class TeamCalendar {
    private int teamCalendarId;
    private Integer teamEventId; //int는 null 처리할 수 없음 반면 integer는 null을 처리할 수 있음
    private LocalDateTime teamEventDate;
    private String teamEventTitle;
    private String teamEventDescription;
    private LocalDateTime teamCCreateAt;
    private Integer colorIndexId;
    private LocalDateTime teamCUpdateAt;
    private Integer teamTodoId;
    private Integer noticeId;
    private String departmentId;
    private String userId;


}
