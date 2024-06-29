package com.workwave.dto.user;

import com.workwave.entity.User;
import lombok.*;

@Getter @Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginUserInfoListDto {
    //클라이언트에 보낼 정보
    private String userId;     //계정명
    private String nickName;    //이름
    private String profile;        //프로필 경로
    private String departmentId;
    public LoginUserInfoListDto(User user){
        this.userId = user.getUserId();
        this.nickName = user.getUserName();
        this.profile=user.getProfileImg();
        this.departmentId = getDepartmentId();
    }

}
