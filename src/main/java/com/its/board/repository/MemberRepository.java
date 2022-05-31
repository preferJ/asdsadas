package com.its.board.repository;

import com.its.board.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void saveReq(MemberDTO memberDTO) {
        sql.insert("Member.save",memberDTO);
    }

    public MemberDTO findById(String memberId) {System.out.println("실행");
        return sql.selectOne("Member.findById",memberId);
    }

    public void update(MemberDTO memberDTO) {
        System.out.println("Here is repo");
        System.out.println("memberDTO = " + memberDTO);
        sql.update("Member.update",memberDTO);
    }


    public List<MemberDTO> findAll() {
        return sql.selectList("Member.findAll");
    }

    public void delete(Long id) {
        sql.delete("Member.delete",id);
    }
}
