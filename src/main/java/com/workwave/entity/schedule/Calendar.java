package com.workwave.entity.schedule;

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
    private Integer eventId;
    private LocalDateTime eventDate;
    private String eventTitle;
    private String eventDescription;
    private LocalDateTime cCreateAt;
    private LocalDateTime cUpdateAt;
    private Integer colorIndexId;
    private Integer teamTodoId;
    private Integer noticeId;
    private String departmentId;
    private String userId;
    private Integer todoId;
}
