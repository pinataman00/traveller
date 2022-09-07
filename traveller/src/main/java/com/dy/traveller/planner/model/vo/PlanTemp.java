package com.dy.traveller.planner.model.vo;

import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PlanTemp {

	//0907) JS객체 배열을 FormData에 저장해 서버에 전송하기 위해
	private List<Plan[]> planList;
	
}
