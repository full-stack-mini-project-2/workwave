package com.workwave.entity.schedule;

import lombok.*;
import org.apache.tomcat.jni.Local;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@EqualsAndHashCode
@ToString
@Builder
public class TeamTodoList {
    private int teamTodoId;
    private String teamTodoContent;
    private String teamTodoStatus;
    private LocalDateTime teamTodoCreateAt;
    private LocalDateTime teamTodoUpdateAt;
    private Integer colorIndexId; // Integer로 선언하여 null 값을 허용
    private String userId;
    private String departmentId;
}
