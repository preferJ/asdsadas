package com.its.board.repository;

import com.its.board.dto.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public void save(CommentDTO commentDTO) {
        sql.insert("Comment.save", commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        return sql.selectList("Comment.findAll", boardId);
    }
    public List<CommentDTO> findAll() {
        return sql.selectList("Comment.findAllNoId");
    }



    public void delete(Map<String, Long> deleteCommentParam) {
        sql.delete("Comment.delete",deleteCommentParam);
    }
}
