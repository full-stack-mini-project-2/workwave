package com.workwave.controller;

import com.workwave.dto.DepartmentNameDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
@Slf4j
@RequiredArgsConstructor
public class MainController {
    @Value("${project.base.dir}")
    private String rootPath;
    private final UserService userService;

    @GetMapping("/")

    public String list() {
        return "index";
    }


    @GetMapping("/login")
    public String login() {
        return "/Login/login";
    }

    @GetMapping("/join")
    public String join(Model model) {
        //켜기 전에 부서 넘겨주기
        List<DepartmentNameDto> dList = userService.findDepartmentName();
        System.out.println("dList = " + dList);
        model.addAttribute("dList", dList);
        return "/Login/UserRegister";
    }

    @PostMapping("/join")
    public String signUp(@Validated JoinDto dto) {
        log.info("welcome~ /join POST ");
        log.debug("parameter: {}", dto);
        // 프로필 사진 추출
        return "/";
    }
} //end MainControllerß

