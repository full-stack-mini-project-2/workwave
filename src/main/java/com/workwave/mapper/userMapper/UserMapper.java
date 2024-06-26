package com.workwave.mapper.userMapper;

import com.workwave.dto.DepartmentNameDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    //회원가입
    boolean save(User user);

    //회원 정보 개별 조회
    User findOne(String account);
    //중복 확인 DB( 아이디, 이메일 )

    //부서 조회
    List<DepartmentNameDto> findDepartmentAll();

    //유저이름 조회하기
    String findUserName (String userId);

}
