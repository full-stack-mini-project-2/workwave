package com.workwave.entity;

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
    private LocalDateTime todoDate;
    private int colorIndexId;
    private int noticeId;
    private String departmentId;
    private String userId;
}
