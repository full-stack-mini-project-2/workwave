package com.workwave.entity.schedule;

import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@EqualsAndHashCode
@ToString
@Builder
public class TodoList {
    private int todoId;
    private String todoContent;
    private String todoStatus;
    private LocalDateTime todoCreateAt;
    private LocalDateTime todoUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private String userId;
}
