package com.workwave.dto.scheduleDto.request;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ColorIndexDTO {
    private int color_index_id;
    private String color_code;
    private String color_name;
}
