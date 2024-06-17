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
    private LocalDateTime teamDate;
    private String teamEventType;
    private int teamEventId;
    private LocalDateTime teamTodoDate;
    private LocalDateTime teamEventDate;
    private int colorIndexId;
    private int teamTodoId;
    private int noticeId;
    private String departmentId;
    private String userId;
    private int noticeColorIndexId;


}
