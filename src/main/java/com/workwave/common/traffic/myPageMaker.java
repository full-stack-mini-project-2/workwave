package com.workwave.common.traffic;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@EqualsAndHashCode
public class myPageMaker {

    // 한 화면에 페이지를 몇개씩 배치할 것인가?
    private static final int PAGE_COUNT = 6;

    // 페이지 시작번호와 끝번호
    private int begin, end;

    // 현재 페이지 정보
    private myInfoPage pageInfo;

    public myPageMaker(myInfoPage page){
        this.pageInfo = page;
        makePageInfo();
    }


    // 페이지 생성에 필요한 데이터를 만드는 알고리즘
    private void makePageInfo(){


        this.end = (int) (Math.ceil(pageInfo.getPageNo()/(double) PAGE_COUNT)*PAGE_COUNT);

        this.begin = this.end - PAGE_COUNT + 1;


    }
}
