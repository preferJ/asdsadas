package com.its.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
    private int id ;
    private String memberId;
    private String memberPassword;
    private String memberName ;
    private int memberAge;
    private String memberPhone ;
}
