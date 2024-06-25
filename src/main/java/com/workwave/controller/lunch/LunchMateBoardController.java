package com.workwave.controller.lunch;

import com.workwave.entity.LunchMateBoard;
import com.workwave.service.lunchService.LunchMateBoardService;
import com.workwave.dto.lunchBoardDto.LunchBoardDetailResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/lunchMateBoard")
public class LunchMateBoardController {

    private final LunchMateBoardService lunchMateBoardService;

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
        List<LunchBoardDetailResponseDto> boardDTOs = boards.stream()
                .map(board -> new LunchBoardDetailResponseDto(
                        board.getUserId(),
                        board.getLunchPostTitle(),
                        board.getLunchDate(),
                        board.getLunchLocation(),
                        board.getLunchMenuName(),
                        board.getLunchAttendees(),
                        board.getProgressStatus()
                ))
                .collect(Collectors.toList());

        model.addAttribute("boards", boardDTOs);
        return "lunch/lunchboard"; // src/main/webapp/WEB-INF/views/lunch/lunchboard.jsp
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
        return "redirect:/lunchMateBoard/list"; // 다시 목록 페이지로 리다이렉트
    }

    // 게시글 상세보기
    @GetMapping("/view")
    public String view(@RequestParam("lunchPostNumber") int lunchPostNumber, Model model) {
        LunchMateBoard board = lunchMateBoardService.findOne(lunchPostNumber);
        model.addAttribute("board", board);
        return "lunch/viewLunchBoard"; // src/main/webapp/WEB-INF/views/lunch/viewLunchBoard.jsp
    }
}
