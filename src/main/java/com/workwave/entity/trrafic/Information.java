package com.workwave.entity.trrafic;

import lombok.*;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@Builder
public class Information {

    private String facilityId;
    private String userFeedback;
    private String incidentReport;
    private String location;
    private String departure;
    private String destination;

}
