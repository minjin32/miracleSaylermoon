package com.donzzul.spring.dreammypage.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.donzzul.spring.reservation.domain.Reservation;
import com.donzzul.spring.reservation.service.ReservationService;
import com.donzzul.spring.user.domain.User;

@Controller
public class DreamMyPageController {

	@Autowired
	private ReservationService rService;
	
	@RequestMapping(value="dreamMyPage.dz")
	public String DreamMyPageView(HttpSession session,
			Model model) {
		User user = (User) session.getAttribute("loginUser");
		int userNo = user.getUserNo();
		ArrayList<Reservation> rList = rService.rListByDreamUpToThree(userNo);
		if(!rList.isEmpty()) {
			model.addAttribute("rList",rList);
			return "dreamMyPage/DreamMyPage";
		}else {
			model.addAttribute("msg","예약목록 불러오는데 실패했지...!!");
			return "common/errorPage";
		}
	}
	
	// 예약 취소를 눌렀을때 예약 상태 변경하기
	@RequestMapping(value="cancelReservation.dz")
	public String deleteReservation(@RequestParam("reservationNo") int reservationNo, Model model) {
		System.out.println(reservationNo);
		Reservation reservation = rService.selectOne(reservationNo);
		String rStateResult = reservation.getrState();
		if(rStateResult.equals("O")) {
			int result = rService.cancleReservation(reservationNo);
			if(result > 0) {
				return "redirect:dreamMyPage.dz";
			}else {
				model.addAttribute("msg", "예약취소 실패");
				return "common/errorPage";
			}
		}else {
			model.addAttribute("msg", "예약취소 실패");
			return "common/errorPage";
		}
	}
	
	
	//꿈나무회원 마이페이지 예약 전체 불러오기
	@RequestMapping(value="rListDetailAllByDream.dz")
	public String reservaionAllListByDream(HttpSession session,
											Model model) {
		User user = (User)session.getAttribute("loginUser");
		int userNo = user.getUserNo();
		ArrayList<Reservation> rList = rService.reservationListByDream(userNo);
		if(!rList.isEmpty()) {
			model.addAttribute("rList",rList);
			return "dreamMyPage/DreamRListDetail";
		}else {
			model.addAttribute("msg","예약목록 전체 불러오는거다 크큭..");
			return "common/errorPage";
		}
	}
	
}

