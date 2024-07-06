package com.workwave.dto.lunchBoardDto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LunchMemberDto {
    private String userId;
    private int lunchPostNumber;
    private String lunchPostTitle;

}
