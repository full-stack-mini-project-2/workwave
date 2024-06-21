package com.workwave.service;

import com.workwave.dto.DepartmentNameDto;
import com.workwave.dto.JoinDto;
import com.workwave.entity.User;
import com.workwave.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;
    private final PasswordEncoder encoder;

    // 부서명 전체 리턴
    public List<DepartmentNameDto> findDepartmentName() {
        List<DepartmentNameDto> dList = userMapper.findDepartmentAll();
        return dList;
    }

    public  boolean join(JoinDto dto, String profilePath) {
        User user = dto.toEntity();
        user.setProfileImage(profilePath); // 프로필 사진 경로 엔터티에 설정
        LocalDateTime currentDateTime = LocalDateTime.now();

        // 날짜와 시간 형식 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 형식화된 문자열로 출력
        String formattedDateTime = currentDateTime.format(formatter);
        System.out.println("Current Date and Time: " + formattedDateTime);
        user.setUserCreateAt(formattedDateTime);

        String encodedPassword = encoder.encode(dto.getPassword());
        user.setPassword(encodedPassword);

        return userMapper.save(user);
    }
}
