package com.workwave.dto.traffic.request;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class totalTrafficInfoDto {

    private String arrival;
    private String departure;
    private LocalDateTime regDateTime;

}
