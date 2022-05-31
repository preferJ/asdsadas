package com.its.board.controller;

import com.its.board.dto.BoardDTO;
import com.its.board.dto.CommentDTO;
import com.its.board.dto.PageDTO;
import com.its.board.service.BoardService;
import com.its.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @Autowired
    private CommentService commentService;

    // 글쓰기 화면 요청
    @GetMapping("/save") // RequestMapping 적용
    public String saveForm(HttpSession session) {
        if (session.getAttribute("memberId") == null) {

            return "memberPages/login";
        }
        return "boardPages/saveFile"; //=> views/board/save.jsp
    }

    // 글쓰기 처리
    @PostMapping("/save") //
    public String save(@ModelAttribute BoardDTO boardDTO) {
        boolean result = boardService.save(boardDTO);
        if (result) {
            return "redirect:/board/findAll"; // => /board/findAll 주소 요청
        } else {
            return "boardPages/save-fail";
        }
    }

    // 목록 출력
    @GetMapping("/findAll")
    public String findAll(Model model) {
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "boardPages/pagingList";
    }

    // 상세조회
    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id, Model model,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        model.addAttribute("page", page);
        //댓글 목록도 추가
        List<CommentDTO> commentDTOList = commentService.findAll(id);
        model.addAttribute("commentList", commentDTOList);

        return "boardPages/detail";
    }

    // 비밀번호 체크 페이지
    @GetMapping("/passwordCheck")
    public String passwordCheck(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPages/passwordCheck";
    }

    // 삭제 처리
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        boardService.delete(id);
        return "redirect:/board/findAll";
    }

    // 수정 화면 요청
    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("boardUpdate", boardDTO);
        return "boardPages/update";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO) {
        boardService.update(boardDTO);
        return "redirect:/board/detail?id=" + boardDTO.getId(); // 수정처리 후 해당 글의 상세페이지 요청
    }

    // 글작성화면(파일)
    @GetMapping("/saveFile")
    public String saveFileForm() {
        return "boardPages/saveFile";
    }

    // 파일첨부 글작성 처리
    @PostMapping("/saveFile")
    public String saveFile(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.saveFile(boardDTO);
        return "redirect:/board/findAll";
    }

    @GetMapping("/paging")
    public String paging(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         Model model) {
        List<BoardDTO> boardList = boardService.pagingList(page);
        PageDTO paging = boardService.paging(page);
        model.addAttribute("boardList", boardList);
        model.addAttribute("paging", paging);
        return "boardPages/pagingList";
    }


    //검색처리
    @GetMapping("/search")
    public String search(
                         @RequestParam(value = "searchType", required = false, defaultValue = "1") String searchType,
                         @RequestParam(value = "q") String q, Model model) {
        List<BoardDTO> newBoardDTOList = boardService.search(searchType, q);
        model.addAttribute("boardList", newBoardDTOList);
        model.addAttribute("searchValue", q);
        return "boardPages/list";

    }

//    $("#comment-write-btn").click(function (){
//        //댓글, 작성자, 내용을 가져오기
//        //ajax 문법을 활용하여 /comment/save 주소로 post 방식으로 작성자, 내용, 글번호 이렇게
//        // 세개의 값을 보내는 코드를 작성!
//        // ㅈㄴ어렵네;; ㄹㅇ;
//            const id =  ${board.id}
//            const commentWriter = document.getElementById("commentWriter");
//            const commentContents = document.getElementById("commentContents");
//        $.ajax({
//                type: "post", // http request method
//                url: "board/comment/save", // 요청주소(컨트롤러 주소값)
//                data: {"id": id,"commentWriter": commentWriter,"commentContents": commentContents}, // 전송하는 파라미터
//        dataType: "json", // 리턴받을 데이터 형식
//            })

    @PostMapping("/comment/save")
    public String commentSave(@RequestParam long id, @RequestParam String commentWriter, @RequestParam String commentContents, Model model) {
        String a = "Asdasdsadasdasdsad";
        model.addAttribute("a", a);

        return a;

    }


}












