package com.workwave.controller;

import com.workwave.dto.DepartmentNameDto;
import com.workwave.dto.JoinDto;
import com.workwave.service.UserService;
import com.workwave.util.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
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

        File root =new File(rootPath);
        log.debug("root: {}",root);
        if(!root.exists()) root.mkdirs(); //폴더 없으면 생성

        log.debug("parameter: {}", dto);
        // 프로필 사진 추출
        MultipartFile profileImage = dto.getProfileImage();
        String profilePath = null;
        if (!profileImage.isEmpty()) {
            log.debug("attached profile image name: {}", profileImage.getOriginalFilename());
            // 서버에 업로드 후 업로드 경로 반환
            profilePath = FileUtil.uploadFile(rootPath, profileImage);
            log.debug("profilePath:{}",profilePath);
        }

        boolean flag = userService.join(dto, profilePath);

        return flag ? "redirect:/login" : "redirect:/join";
    }
} //end MainControllerß

