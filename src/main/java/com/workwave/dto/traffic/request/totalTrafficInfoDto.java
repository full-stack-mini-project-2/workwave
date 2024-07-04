package com.workwave.dto.traffic.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class totalTrafficInfoDto {

    private String userId;
    private String arrival;
    private String departure;
    
    @JsonFormat(pattern = "yyyy년 MM월 dd일")
    private LocalDateTime regDateTime;

}
