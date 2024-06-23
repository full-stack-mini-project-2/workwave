package com.workwave.entity.schedule;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@EqualsAndHashCode
@ToString
@Builder
public class TeamCalendar {
    private int tCalendarId;
    private String tCalendarName;
    private LocalDateTime tCreatedAt;
    private String departmentId;


}
