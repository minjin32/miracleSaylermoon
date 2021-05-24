package com.donzzul.spring.reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
								HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userOne = (User)session.getAttribute("loginUser");

		Shop shop = new Shop();
		shop.setShopNo(3);
		shop.setStartTime("9");
		shop.setEndTime("18");
		shop.setBusinessDay(12345);
		shop.setShopName("라공방");
		shop.setShopMaxReserv(9);
		
		int startTime = Integer.parseInt(shop.getStartTime());
		int endTime = Integer.parseInt(shop.getEndTime());
		
		if(shop != null) {
			model.addAttribute("startTime",startTime);
			model.addAttribute("endTime",endTime);
			model.addAttribute("shop", shop);
			return "reservation/viewReservation";
		}else {
			model.addAttribute("msg","응 아니야 돌아가!!!");
			return "reservation/viewReservation";
		}
	}
		
	
	
	
	// 예약할때 받아와야할 
	// 날짜, 시간, 인원수, 가게고유번호, 회원고유번호, 회원타입번호
	@RequestMapping(value="reservationInsert.dz", method=RequestMethod.POST)
	public String reservationInsert(@ModelAttribute Reservation reservation,
									@RequestParam("paymentPoint") int paymentPoint,
									@RequestParam("userPoint") int userPoint,
									@RequestParam("userNo") int userNo,
									 Model model
									) {
		int rResult = service.insertReservation(reservation);
		int pResult = 0;
		if(paymentPoint > 0) {
			Reservation nReservation = new Reservation();
			nReservation.setReservationNo(service.getReservNo(userNo));
			nReservation.setUserNo(userNo);
			pResult = service.updateUserPoint(nReservation);
		}
		
		if( rResult > 0) {
			return "redirect:reservationView.dz";
		}else {
			model.addAttribute("msg","어림도 없지!!!!!!");
			return "redirect:reservationView.dz";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="rCountCheck.dz", method=RequestMethod.POST)
	public String rCountCheck(@ModelAttribute Reservation reservation) {
		int result = service.confirmRCount(reservation);
		return ""+result;
	}
	
	
	  @ResponseBody
	  
	  @RequestMapping(value="printReservation.dz", method=RequestMethod.POST)
	  public ArrayList<HashMap<String, String>> printReservation(@RequestParam("shopNo") int shopNo) {
	  System.out.println(shopNo); 
	  //HashMap<String, String>
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
		 
	  //HashMap<String, String> map =  new HashMap<String, String>();
	  //map.put("start", "2021-05-24");
	  //map.put("end", "2021-05-24");
	  //list.add(map);
	  //map =  new HashMap<String, String>();
	  //map.put("start", "2021-05-28");
	  //map.put("end", "2021-05-28");
	  //list.add(map);
	  //map =  new HashMap<String, String>();
	  //map.put("start", "2021-05-30");
	  //map.put("end", "2021-05-30");
	  //list.add(map);
	  return list; 
	  }
	 
	
	 
	
	
	

}
