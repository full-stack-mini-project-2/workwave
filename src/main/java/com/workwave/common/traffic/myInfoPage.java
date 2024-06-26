package com.workwave.common.traffic;


import lombok.*;

@Getter @ToString
@EqualsAndHashCode
@AllArgsConstructor
@Builder
public class myInfoPage {

    private int pageNo;        // 현재 페이지 번호
    private int amount;       // 페이지당 출력할 데이터 개수

    public myInfoPage() {
        this.pageNo = 1;
        this.amount = 10;
    }

    public int getPageStart(){

        return (this.pageNo-1) * this.amount;
    }

    public void setPageNo(int pageNo) {
        if(pageNo < 1 || pageNo >Integer.MAX_VALUE){
            this.pageNo = 1;
            return;
        }
        this.pageNo = pageNo;
    }

    public void setAmount(int amount) {
        if(amount < 10 || amount > 100){
            this.amount = 10;
            return;
        }
        this.amount = amount;
    }
}
