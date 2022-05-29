package com.its.board.service;

import com.its.board.dto.MemberDTO;
import com.its.board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public void saveReq(MemberDTO memberDTO) {
        memberRepository.saveReq(memberDTO);
    }

    public MemberDTO findById(String memberId){
        System.out.println("실행");return memberRepository.findById(memberId);
    }

    public void update(MemberDTO memberDTO) {
        memberRepository.update(memberDTO);
    }
}
