package com.workwave.entity.schedule;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@EqualsAndHashCode
@ToString
@Builder
public class Calendar {
    private int calendarId;
    private String calendarName;
    private LocalDateTime createdAt;
    private String userId;
}
