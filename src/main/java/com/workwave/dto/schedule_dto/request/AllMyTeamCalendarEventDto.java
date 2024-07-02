package com.workwave.dto.schedule_dto.request;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@Builder
public class AllMyTeamCalendarEventDto {
    private int calEventId;
    private String calEventDate;
    private String calEventTitle;
    private String calEventDescription;
    private LocalDateTime calEventCreateAt;
    private LocalDateTime calEventUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private String userId;
    private int teamCalendarId; // Integer로 선언하여 null 값을 허용
    private String departmentId;
    private String departmentName;
    private String userName;
    private String updateBy;
    private Integer noticeId; // Integer로 선언하여 null 값을 허용
}
