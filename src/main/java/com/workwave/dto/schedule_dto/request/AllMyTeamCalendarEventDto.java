package com.workwave.dto.schedule_dto.request;

import lombok.*;

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
    private LocalDateTime calEventDate;
    private String calEventTitle;
    private String calEventDescription;
    private LocalDateTime calEventCreateAt;
    private LocalDateTime calEventUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private Integer noticeId; // Integer로 선언하여 null 값을 허용
    private Integer teamCalendarId; // Integer로 선언하여 null 값을 허용
    private String userName;
    private String departmentName;
}