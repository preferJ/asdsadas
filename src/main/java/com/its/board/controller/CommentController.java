package com.its.board.controller;

import com.its.board.dto.CommentDTO;
import com.its.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @PostMapping("/save")
    public @ResponseBody List<CommentDTO> save(@ModelAttribute CommentDTO commentDTO, Model model) {

        commentService.save(commentDTO);


        List<CommentDTO> newCommentDTOList = commentService.findAll(commentDTO.getBoardId());

        model.addAttribute("commentList", newCommentDTOList);

        return newCommentDTOList;
    }

    @GetMapping("/delete")
    public @ResponseBody List<CommentDTO> save(@RequestParam("commentId") long id,
            @RequestParam("boardId") long boardId, Model model) {

        commentService.delete(boardId,id);
        List<CommentDTO> newCommentDTOList = commentService.findAll(boardId);
        model.addAttribute("commentList", newCommentDTOList);
        return newCommentDTOList;
    }


}
