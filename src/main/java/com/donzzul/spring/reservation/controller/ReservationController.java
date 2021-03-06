package com.donzzul.spring.reservation.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.donzzul.spring.reservation.domain.Reservation;
import com.donzzul.spring.reservation.service.ReservationService;
import com.donzzul.spring.shop.domain.Shop;
import com.donzzul.spring.user.domain.User;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService service;
	//@RequestParam -> 화면에서 가져오는 하나의 값
	//@ModelAttribute
	
	// 노쇼도 생각하자
	@RequestMapping(value="reservationView.dz")
	public String reservationView(Model model,
								HttpServletRequest request,
								@ModelAttribute Shop shop) {
		HttpSession session = request.getSession();
		User userOne = (User)session.getAttribute("loginUser");
		int userPoint = userOne.getUserPoint();
		
		int startTime = Integer.parseInt(shop.getStartTime());
		int endTime = Integer.parseInt(shop.getEndTime());
		
		if(shop != null) {
			model.addAttribute("startTime",startTime);
			model.addAttribute("endTime",endTime);
			model.addAttribute("shop", shop);
			model.addAttribute("userPoint",userPoint);
			return "reservation/viewReservation";
		}else {
			model.addAttribute("msg","화면을 불러오는데 실패하였습니다.");
			return "reservation/viewReservation";
		}
	}
		
	
	
	
	// 예약할때 받아와야할  (트랜잭션 완료)
	// 날짜, 시간, 인원수, 가게고유번호, 회원고유번호, 회원타입번호
	@RequestMapping(value="reservationInsert.dz", method=RequestMethod.POST)
	public void reservationInsert(ModelAndView mv, @ModelAttribute Reservation reservation,
									@RequestParam("userPoint") int userPoint,
									@RequestParam("userNo") int userNo,
									 Model model,
									 HttpServletResponse response
									) throws Exception {
		int paymentPoint = String.valueOf(reservation.getPaymentPoint()) != "" ? reservation.getPaymentPoint() : 0;
		reservation.setUserNo(userNo);
		reservation.setPaymentPoint(paymentPoint);
		System.out.println("reservation" + reservation.toString());
		
		int rResult = service.insertReservation(reservation);	
		
		
		int shopNo = reservation.getShopNo();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if( rResult > 0) {
			out.println("<script>alert('예약하는데 성공하였습니다.'); location.href='shopDetail.dz?shopNo="+shopNo+"';</script>");
			out.flush();
			out.close();
		}else {
			out.println("<script>alert('예약하는데 실패하였습니다.')");
			out.flush();
			out.close();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="rCountCheck.dz", method=RequestMethod.GET)
	public String rCountCheck(@ModelAttribute Reservation reservation) {
		int result = service.confirmRCount(reservation);
		return ""+result;
	}
	
	
	  @ResponseBody
	  @RequestMapping(value="printReservation.dz", method=RequestMethod.POST)
	  public ArrayList<HashMap<String, String>> printReservation(@RequestParam("shopNo") int shopNo) {
	  ArrayList<Reservation> reservation = service.selectOneBySno(shopNo); // 얘를 json 먼저 만들어주고
	  
	  ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
	  // ArrayList가 기차고 HashMap이 기차 한칸이야!
	  
	  for (int i = 0; i < reservation.size(); i++) { 
		  HashMap<String, String> map = new HashMap<String, String>(); 
		  map.put("title", reservation.get(i).getUserNick());
		  map.put("start", reservation.get(i).getReserveDate()); 
		  map.put("end", reservation.get(i).getReserveDate());
		  
		  list.add(map); 
	  }
	  System.out.println(list+"list");
	  return list; 
	  }
	 
	
	 
	
	
	

}
