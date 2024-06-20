package com.workwave.dto.replydto;

import lombok.*;

import java.util.List;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class ReplyListDto {

    private List<ReplyDetailDto> replies;


}
