package com.workwave.dto.scheduleDto.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CalendarEventDTO {
    private int cEventId;
    private LocalDateTime cEventDate;
    private String cEventTitle;
    private String cEventDescription;
    private LocalDateTime cECreateAt;
    private LocalDateTime cEUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private Integer noticeId; // Integer로 선언하여 null 값을 허용
    private String userId;
    private String departmentId;
    private Integer calendarId; // Integer로 선언하여 null 값을 허용
    private Integer tCalendarId; // Integer로 선언하여 null 값을 허용

}
