package com.workwave.entity;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@EqualsAndHashCode
@ToString
@Builder
public class Calendar {
    private int calendarId;
    private LocalDateTime teamDate;
    private String eventType;
    private int eventId;
    private LocalDateTime todoDate;
    private LocalDate eventDate;
    private int colorIndexId;
    private Integer teamTodoId;
    private Integer noticeId;
    private String departmentId;
    private String userId;
    private Integer noticeColorIndexId;
    private Notice noticeColorIndex;
    private ColorIndex colorIndex;
    private TeamTodoList teamTodoList;
    private Notice notice;
    private Department department;
    private User user;
}
