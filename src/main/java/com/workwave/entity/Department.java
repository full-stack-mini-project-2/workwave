package com.workwave.entity;

import lombok.*;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Department {
    private String departmentName;
    private String departmentId;
}
