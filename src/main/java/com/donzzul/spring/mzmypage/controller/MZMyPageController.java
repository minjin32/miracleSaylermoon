package com.donzzul.spring.mzmypage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.donzzul.spring.common.PageInfo;
import com.donzzul.spring.common.Pagination;
import com.donzzul.spring.mzreview.domain.MzReview;
import com.donzzul.spring.mzreview.service.MzReviewService;
import com.donzzul.spring.notiqna.domain.Qna;
import com.donzzul.spring.notiqna.service.QnaService;
import com.donzzul.spring.payment.domain.Don;
import com.donzzul.spring.payment.service.PaymentService;
import com.donzzul.spring.pick.domain.Pick;
import com.donzzul.spring.pick.service.PickService;
import com.donzzul.spring.recommendboard.domain.RecommendBoard;
import com.donzzul.spring.recommendboard.service.RecommendBoardService;
import com.donzzul.spring.reservation.domain.Reservation;
import com.donzzul.spring.reservation.service.ReservationService;
import com.donzzul.spring.user.domain.User;

@Controller
public class MZMyPageController {

	@Autowired
	private PaymentService pService;
	
    @Autowired
	private ReservationService rService;
    
    @Autowired
	private PickService pkService;
	
    @Autowired
    private MzReviewService mService;

    @Autowired
    private RecommendBoardService reService;

    @Autowired
    private QnaService qService;
    
	// (민애) mz마이페이지 메인뷰
  	@RequestMapping(value = "mzMyPage.dz")
	public String MZMyPageView(HttpSession session, Model model) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();

		// userPoint 조회
		User userPoint = pService.selectUserPoint(userNo);
		// 예약 목록
		ArrayList<Reservation> rList = rService.listByMZToThree(userNo);
		// 가고싶다 목록
		ArrayList<Pick> pList = pkService.dreamPickUpToThree(userNo);
		// 돈쭐 목록
		ArrayList<Don> dList = pService.selectDonListThree(userNo);
		// 내가 쓴 후기 목록
		ArrayList<MzReview> mList = mService.selectThreeReviewToMyPage(userNo);
		// 내가 쓴 추천 목록
		ArrayList<RecommendBoard> reList = reService.selectThreeRecommendToMyPage(userNo);
		// 내가 쓴 문의글 목록
		ArrayList<Qna> qList = qService.dreamQnaUpToThree(userNo);
		
		
		if(userPoint != null || !rList.isEmpty() || !pList.isEmpty() || !dList.isEmpty() || !mList.isEmpty()) {
			model.addAttribute("userPoint", userPoint.getUserPoint());
			model.addAttribute("rList", rList);
			model.addAttribute("pList", pList);
			model.addAttribute("dList", dList);
			model.addAttribute("mList", mList);
			model.addAttribute("reList", reList);
			model.addAttribute("qList", qList);
			model.addAttribute("msg", "0");
			model.addAttribute("Rmsg", "예약 내역이 없습니다.");
			model.addAttribute("Pmsg", "찜한 내역이 없습니다.");
			model.addAttribute("Dmsg", "돈쭐 내역이 없습니다.");
			model.addAttribute("Mmsg", "후기글이 없습니다.");
			model.addAttribute("REmsg", "추천글이 없습니다.");
			model.addAttribute("Qmsg", "문의글이 없습니다.");
			return "mzMyPage/MZMyPage";
		}else {
			model.addAttribute("msg", "0");
			model.addAttribute("Rmsg", "예약 내역이 없습니다.");
			model.addAttribute("Pmsg", "찜한 내역이 없습니다.");
			model.addAttribute("Dmsg", "돈쭐 내역이 없습니다.");
			model.addAttribute("Mmsg", "후기글이 없습니다.");
			model.addAttribute("REmsg", "추천글이 없습니다.");
			model.addAttribute("Qmsg", "문의글이 없습니다.");
			return "mzMyPage/MZMyPage";
		}
  	} // end of MZMyPageView
  	
  	// 구글mz마이페이지 메인뷰
   	@RequestMapping(value = "GoogleMyPage.dz")
 	public String GoogleMZMyPageView(HttpSession session, Model model) {
 		
 		User loginUser = (User)session.getAttribute("loginUser");
 		
 		
 		// 예약 목록
 		//ArrayList<Reservation> rList = rService.rListByMZUpToThree(userNo);
 		// 돈쭐 목록
 		//ArrayList<Don> dList = pService.selectDonListThree(userNo);
 		
 		//if(!rList.isEmpty() && !dList.isEmpty()) {
 			//model.addAttribute("rList", rList);
 			//model.addAttribute("dList", dList);
 			return "mzMyPage/MZMyPage";
 		//}else if(rList.isEmpty()){
 			//model.addAttribute("msg", "데이터가 없습니다.");
 			//return "mzMyPage/MZMyPage";
 		//}else if(dList.isEmpty()) {
 			//model.addAttribute("msg", "데이터가 없습니다.");
 			//return "mzMyPage/MZMyPage";
 		//}else {
 			//model.addAttribute("msg", "내역을 출력하는데 실패했습니다");
 			//return "common/errorPage";
 		//}
   	}
   	
   	// 카카오 mz마이페이지 메인뷰
   	@RequestMapping(value = "KakaoMyPage.dz")
 	public String KakaoMZMyPageView(HttpSession session, Model model) {
 		
 		User loginUser = (User)session.getAttribute("loginUser");
 		
 		
 		// 예약 목록
 		//ArrayList<Reservation> rList = rService.rListByMZUpToThree(userNo);
 		// 돈쭐 목록
 		//ArrayList<Don> dList = pService.selectDonListThree(userNo);
 		
 		//if(!rList.isEmpty() && !dList.isEmpty()) {
 			//model.addAttribute("rList", rList);
 			//model.addAttribute("dList", dList);
 			return "mzMyPage/MZMyPage";
 		//}else if(rList.isEmpty()){
 			//model.addAttribute("msg", "데이터가 없습니다.");
 			//return "mzMyPage/MZMyPage";
 		//}else if(dList.isEmpty()) {
 			//model.addAttribute("msg", "데이터가 없습니다.");
 			//return "mzMyPage/MZMyPage";
 		//}else {
 			//model.addAttribute("msg", "내역을 출력하는데 실패했습니다");
 			//return "common/errorPage";
 		//}
   	}
	
	// 예약 전체 목록보기
	@RequestMapping(value = "mzReservationList.dz", method = RequestMethod.GET)
	public ModelAndView MZReservationListView(HttpSession session,
										Model model,
										ModelAndView mv,
										@RequestParam(value="page", required=false) Integer page) {
		User user = (User)session.getAttribute("loginUser");
		int userNo = user.getUserNo();
		
		int currentPage = (page != null) ? page : 1;
		int listCount = rService.getListCount(userNo);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Reservation> rList = rService.reservationListByMZ(userNo, pi);
		
		if(!rList.isEmpty()) {
			mv.addObject("rList",rList);
			mv.addObject("pi",pi);
			mv.setViewName("mzMyPage/MZReservationList");
		}else {
			mv.addObject("msg","예약목록을 불러오는데 실패하였습니다.");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	// 예약 취소
   	@ResponseBody
 	@RequestMapping(value = "cancelMZReservation.dz")
 	public String cancelMZReservation(@RequestParam("reservationNo") int reservationNo, Model model, HttpSession session) {
 		User user = (User) session.getAttribute("loginUser");
 		int userNo = user.getUserNo();
 		Reservation reservation = rService.selectOne(reservationNo);
 		String rStateResult = reservation.getrState();
 		if (rStateResult.equals("O")) { 
 			reservation.setrState("X");
 			int result = rService.updateRstate(reservation); // Reservation테이블에 예약 상태값 변경하기

 			reservation.setUserNo(userNo);
 			reservation.setReservationNo(reservationNo);
 			int cancleResult = rService.cancleReservation(reservation); // User테이블에 포인트 돌려받기

 			if (result > 0 && cancleResult > 0) {
 				return "ok";
 			} else {
 				return "예약취소에 실패했습니다.";
 			}
 		} else {
 			model.addAttribute("msg", "예약취소에 실패했습니다.");
 			return "common/errorPage";
 		}
 	} //end of cancelMZReservation
   	
   	//후기작성 메소드는 - MzReviewController.java
	
	// 찜(가고싶다) 전체 목록보기
	@RequestMapping(value="mzPickList.dz", method=RequestMethod.GET)
	public ModelAndView listPick(HttpSession session, Model model, ModelAndView mv, 
								@RequestParam(value="page", required=false) Integer page) {
		User user = (User)session.getAttribute("loginUser");
		int userNo = user.getUserNo();
		
		int currentPage = (page != null) ? page : 1;
		int listCount = pkService.pickListCount(userNo);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Pick> pList = pkService.selectAllPick(userNo, pi);
		if(!pList.isEmpty()) {
			mv.addObject("pList",pList);
			mv.addObject("pi",pi);
			mv.setViewName("mzMyPage/MZPickList");
		}else {
			mv.addObject("msg","찜한 내역이 없습니다.");
			mv.setViewName("mzMyPage/MZPickList");
		}
		return mv;
	}
	
	// 가고싶다 삭제는 - PickController.java

	// 돈쭐 전체 목록보기
	@RequestMapping(value ="printDonAllList.dz", method = RequestMethod.GET)
	public ModelAndView printDonAllList(HttpSession session, ModelAndView mv, Model model, @RequestParam(value="page", required = false) Integer page) {
		// 결제 후 반환정보 파라미터로
		
		// 돈쭐 (3개 / 페이징) 클릭하면 로그인세션(userNo)로 검색
		User loginUser = (User)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		
		// 페이징
		int currentPage = (page != null) ? page : 1;
		int listCount = pService.getListCount(userNo);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Don> dList = pService.selectDonList(userNo, pi);
		System.out.println(dList.toString());
		if(!dList.isEmpty()) {
			mv.addObject("dList", dList);
			mv.addObject("pi", pi);
			mv.setViewName("mzMyPage/MZPaymentList"); // 마이페이지
		}else {
			mv.addObject("msg", "돈쭐 내역이 없습니다.");
			mv.setViewName("mzMyPage/MZPaymentList");
		}
		return mv;
	}
	
	// 후기 삭제는 MzReviewController.java
	
	
	// 후기 전체 목록 보기
	@RequestMapping(value ="printMZReviewAllListToMyPage.dz", method = RequestMethod.GET)
	public ModelAndView printMZReviewAllListToMyPage(HttpSession session, ModelAndView mv, Model model, @RequestParam(value="page", required = false) Integer page) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		
		int currentPage = (page != null) ? page : 1;
		int listCount = mService.getListCountToMyPage(userNo);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println(pi.getEndPage());
		ArrayList<MzReview> mList = mService.selectAllReviewToMyPage(userNo, pi);
		System.out.println(mList.toString());
		if(!mList.isEmpty()) {
			mv.addObject("mList", mList).addObject("pi", pi);
		} else {
			mv.addObject("msg", "게시글이 없습니다");
		}
		mv.setViewName("mzMyPage/MZReviewList");
		return mv;
		
	}
	
	// 추천 전체 목록 보기
		@RequestMapping(value ="printRecommendAllListToMyPage.dz", method = RequestMethod.GET)
		public ModelAndView printRecommendAllListToMyPage(HttpSession session, ModelAndView mv, Model model, @RequestParam(value="page", required = false) Integer page) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			int userNo = loginUser.getUserNo();
			
			int currentPage = (page != null) ? page : 1;
			int listCount = reService.getListCountToMyPage(userNo);
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			System.out.println(pi.getEndPage());
			ArrayList<RecommendBoard> reList = reService.selectAllRecommendToMyPage(userNo, pi);
			if(!reList.isEmpty()) {
				mv.addObject("reList", reList).addObject("pi", pi);
			} else {
				mv.addObject("msg", "게시글이 없습니다");
			}
			mv.setViewName("mzMyPage/MZRecommendList");
			return mv;
			
		}
		
		// 문의글 전체 목록 보기
		@RequestMapping(value ="printQnaAllListToMyPage.dz", method = RequestMethod.GET)
		public ModelAndView printQnaAllListToMyPage(HttpSession session, ModelAndView mv, Model model, @RequestParam(value="page", required = false) Integer page) {
			
			User loginUser = (User)session.getAttribute("loginUser");
			int userNo = loginUser.getUserNo();
			
			int currentPage = (page != null) ? page : 1;
			int listCount = qService.dreamListCount(userNo);
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			System.out.println(pi.getEndPage());
			ArrayList<Qna> qList = qService.qnaListBydream(userNo, pi);
			if(!qList.isEmpty()) {
				mv.addObject("qList", qList).addObject("pi", pi);
			} else {
				mv.addObject("msg", "게시글이 없습니다");
			}
			mv.setViewName("mzMyPage/MZQnaList");
			return mv;
			
		}
	
}
