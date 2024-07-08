package com.workwave.dto.replydto;

import com.workwave.common.boardpage.PageMaker;
import com.workwave.dto.user.LoginUserInfoDto;
import lombok.*;

import java.util.List;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Builder
public class ReplyListDto {

    @Setter
    private LoginUserInfoDto loginUser;
    private PageMaker pageInfo;
    private List<ReplyDetailDto> replies;

}
