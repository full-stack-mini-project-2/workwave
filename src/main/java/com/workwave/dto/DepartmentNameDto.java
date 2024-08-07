package com.workwave.dto;

import lombok.*;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class DepartmentNameDto {
    private String DepartmentId;
    private String DepartmentName;
}
