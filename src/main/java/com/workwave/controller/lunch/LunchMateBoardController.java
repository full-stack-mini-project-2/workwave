package com.workwave.controller.lunch;

import com.workwave.entity.LunchMateBoard;
import com.workwave.service.lunchService.LunchMateBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/lunchMateBoard")
public class LunchMateBoardController {

    private final LunchMateBoardService lunchMateBoardService;

    @Autowired
    public LunchMateBoardController(LunchMateBoardService lunchMateBoardService) {
        this.lunchMateBoardService = lunchMateBoardService;
    }

    // 게시판 목록 페이지
    @GetMapping("/list")
    public String list(Model model) {
        List<LunchMateBoard> boards = lunchMateBoardService.findAll();
        model.addAttribute("boards", boards);
        return "lunch/lunchboard"; // src/main/webapp/WEB-INF/views/lunch/list.jsp
    }

    // 글 작성 페이지 이동
    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("board", new LunchMateBoard());
        return "lunch/createLunchBoard"; // src/main/webapp/WEB-INF/views/lunch/createLunchBoard.jsp
    }

    // 글 작성 처리
    @PostMapping("/new")
    public String create(@ModelAttribute("board") LunchMateBoard board) {
        lunchMateBoardService.save(board);
        return "redirect:/lunch/list"; // 다시 목록 페이지로 리다이렉트
    }

    // 게시글 상세보기
    @GetMapping("/view")
    public String view(@RequestParam("lunchPostNumber") int lunchPostNumber, Model model) {
        LunchMateBoard board = lunchMateBoardService.findOne(lunchPostNumber);
        model.addAttribute("board", board);
        return "lunch/viewLunchBoard"; // src/main/webapp/WEB-INF/views/lunch/viewLunchBoard.jsp
    }
}
