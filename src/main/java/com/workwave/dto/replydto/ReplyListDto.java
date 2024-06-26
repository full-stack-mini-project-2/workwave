package com.workwave.dto.replydto;

import com.workwave.common.boardpage.PageMaker;
import lombok.*;

import java.util.List;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class ReplyListDto {

    private PageMaker pageInfo;
    private List<ReplyDetailDto> replies;


}
