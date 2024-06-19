package com.workwave.service;

import com.workwave.dto.DepartmentNameDto;
import com.workwave.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;
    // 부서명 전체 리턴
    public List<DepartmentNameDto> findDepartmentName(){
        List<DepartmentNameDto> dList = userMapper.findDepartmentAll();
        return dList;
    }


}
