package com.workwave.entity.trrafic;

import lombok.*;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class Commute {

    private String userId; // 유저아이디
    private String employeeId; // 유저사번
    private String departure; // 출발지
    private String destination; // 도착지
    private String transportation; // 교통수단
    private String commuteTime; // 출퇴근시간
    private String favoriteTransportation; // 자주이용하는교통
    private String favoriteRoute; // 자주이용하는경로
    private Enum commuteType; // 출근정보
    private String trafficId; // 교통ID
    private String facilityId; //

}
