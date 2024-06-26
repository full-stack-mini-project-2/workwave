package com.workwave.dto.traffic.response;

import lombok.*;

import java.time.LocalDateTime;

/*
CREATE TABLE traffic(
user_id VARCHAR(50),
arrival VARCHAR(255),
departure VARCHAR(255),
station VARCHAR(255),
need_Time VARCHAR(255),
regDateTime TIMESTAMP
);
 */


@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class trafficInfoDto {

    private String userId; // 유저아이디
    private String arrival; // 도착지
    private String departure; // 출발지
    private String station; // 역
    private String needTime; // 소요시간
    private LocalDateTime regDateTime; // 현재시간

}