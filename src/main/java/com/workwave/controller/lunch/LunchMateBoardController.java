package com.workwave.controller.lunch;

import com.workwave.common.lunchpage.LunchPage;
import com.workwave.common.lunchpage.LunchPageMaker;
import com.workwave.dto.lunchBoardDto.LunchBoardFindAllDto;
import com.workwave.entity.LunchMateBoard;
import com.workwave.entity.User;
import com.workwave.service.lunchService.LunchMateBoardService;
import com.workwave.util.LoginUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/lunchMateBoard")
public class LunchMateBoardController {

    @Autowired
    private LunchMateBoardService lunchMateBoardService;


    @Autowired
    public LunchMateBoardController(LunchMateBoardService lunchMateBoardService) {
        this.lunchMateBoardService = lunchMateBoardService;
    }

    // 기본 경로 매핑 추가
    @GetMapping
    public String defaultPage() {
        return "redirect:/lunchMateBoard/list";
    }

    // 게시판 목록 페이지
    @GetMapping("/list")
    public String list(Model model) {
        List<LunchMateBoard> boards = lunchMateBoardService.findAll();

        // LunchMateBoard를 LunchListDto로 변환
        List<LunchBoardFindAllDto> boardDTOs = boards.stream()
                .map(LunchMateBoard::toDto)
                .collect(Collectors.toList());

        model.addAttribute("boards", boardDTOs);
        return "lunch/lunchboard"; // src/main/webapp/WEB-INF/views/lunch/lunchboard.jsp
    }

    @GetMapping("/new")
    public String createForm(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser != null) {
            model.addAttribute("board", new LunchMateBoard());
            model.addAttribute("loggedInUser", currentUser); // 현재 로그인된 사용자 정보 추가
            return "lunch/createLunchBoard"; // src/main/webapp/WEB-INF/views/lunch/createLunchBoard.jsp
        } else {
            return "redirect:/login"; // 로그인되어 있지 않은 경우 로그인 페이지로 리다이렉트
        }
    }
    // 글 작성 처리
    @PostMapping("/new")
    public String create(@ModelAttribute("board") LunchMateBoard board, HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        String userId = LoginUtil.getLoggedInUser(session).getUserId();
        boolean loggedIn = LoginUtil.isLoggedIn(session);
        System.out.println(loggedIn);
        if (loggedIn) {
            board.setUserId(userId);  // 현재 로그인한 사용자의 userId를 설정
            lunchMateBoardService.save(board, userId);
            return "redirect:/lunchMateBoard/list"; // 다시 목록 페이지로 리다이렉트
        } else {
            return "redirect:/login"; // 로그인되어 있지 않은 경우 로그인 페이지로 리다이렉트
        }
    }

    @PostMapping("/joinLunch")
    public String joinLunch(@RequestParam("postId") int postId, RedirectAttributes redirectAttributes) {
        lunchMateBoardService.incrementProgressStatus(postId);
        return "redirect:/"; // 실제 JSP 페이지로 리디렉션
    }

    }

//    // 글 작성 처리
//    @PostMapping("/new")
//    public String create(@ModelAttribute("board") LunchMateBoard board) {
//        // 현재 시간을 작성 시간으로 설정
//        board.setLunchDate(LocalDateTime.now());
//        board.setProgressStatus("준비");
//        board.setEatTime(LocalDateTime.now().toString());
//        lunchMateBoardService.save(board);
//        return "redirect:/lunchMateBoard/list"; // 다시 목록 페이지로 리다이렉트
//    } 20240629 수정

//    // 글 작성 처리
//    @PostMapping("/new")
//    public String create(@ModelAttribute("board") LunchMateBoard board) {
//        lunchMateBoardService.save(board);
//        return "redirect:/lunchMateBoard/list"; // 다시 목록 페이지로 리다이렉트
//    }



//    // 게시글 상세보기
//    @GetMapping("/view")
//    public String view(@RequestParam("lunchPostNumber") int lunchPostNumber, Model model) {
//        LunchMateBoard board = lunchMateBoardService.findOne(lunchPostNumber);
//        model.addAttribute("board", board);
//        return "lunch/viewLunchBoard"; // src/main/webapp/WEB-INF/views/lunch/viewLunchBoard.jsp
//    }
