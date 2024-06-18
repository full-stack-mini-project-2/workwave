package com.workwave.dto.traffic;


import lombok.*;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class Station {

    private String longitude; // 경도
    private String latitude; // 위도
    private int stationId; // 역ID
    private String stationName; // 역이름
    private int line; //호선

}



