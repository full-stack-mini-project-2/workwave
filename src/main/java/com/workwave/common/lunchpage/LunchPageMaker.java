package com.workwave.common.lunchpage;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

// 페이지 화면 렌더링에 필요한 정보들을 계산
@Getter
@ToString
@EqualsAndHashCode
public class LunchPageMaker {

    // 한 화면에 페이지를 몇개씩 배치할 것인지??
    private static final int PAGE_COUNT = 10;

    // 페이지 시작번호와 끝번호
    private int begin, end, finalPage;

    // 이전, 다음버튼 활성화 여부
    private boolean prev, next;

    // 총 게시물 수
    private int totalCount;

    // 현재 페이지 정보
    private LunchPage pageInfo;

    public PageMaker(LunchPage lunchPage, int totalCount) {
        this.pageInfo = lunchPage;
        this.totalCount = totalCount;
        makePageInfo();
    }

}
