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
    private LocalDateTime todoEventDate;
    private String todoStatus;
    private LocalDateTime todoCreateAt;
    private LocalDateTime todoUpdateAt;
    private Integer colorIndexId;
    private String departmentId;
    private String userId;
}
