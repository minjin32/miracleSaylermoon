package com.donzzul.spring.mzreview.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.donzzul.spring.common.PageInfo;
import com.donzzul.spring.common.Pagination;
import com.donzzul.spring.mzreview.domain.MzReview;
import com.donzzul.spring.mzreview.domain.MzReviewPhoto;
import com.donzzul.spring.mzreview.service.MzReviewService;
import com.donzzul.spring.pick.domain.Pick;
import com.donzzul.spring.recommendboard.domain.RecommendPhoto;
import com.donzzul.spring.reservation.domain.Reservation;
import com.donzzul.spring.shop.domain.Shop;
import com.donzzul.spring.shop.service.ShopService;
import com.donzzul.spring.user.domain.User;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Controller
public class MzReviewController {

	@Autowired
	private MzReviewService mService;
	@Autowired
	private ShopService sService;
	
	// ???????????? ?????? selectAll
	@RequestMapping(value="mReviewMain.dz", method=RequestMethod.GET)
	public ModelAndView mReviewMainView(ModelAndView mv,  @RequestParam(value="page", required=false) Integer page) {
		int currentPage = (page != null) ? page : 1;
		int listCount = mService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<MzReview> mList = mService.selectAllReview(pi);
		System.out.println(mList.toString());
		if(!mList.isEmpty()) {
			mv.addObject("mList", mList).addObject("pi", pi);
		} else {
			mv.addObject("msg", "???????????? ????????????");
		}
		mv.setViewName("board/mzReview/mReviewListView");
		return mv;
	}
	
	// ????????? selectOne
	@RequestMapping(value="mReviewDetail.dz", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView mReviewDetailView(ModelAndView mv, @RequestParam("mzReviewNo") int mzReviewNo, HttpServletResponse response, HttpServletRequest request) {
		MzReview mReview = mService.selectOneReview(mzReviewNo);
		if(mReview != null) {
			updateMzHit(response, request, mzReviewNo);
			mv.addObject("mReview", mReview).setViewName("board/mzReview/mReviewDetailView");
		} else {
			mv.addObject("msg", "???????????? ????????? ?????? ?????? ??????").setViewName("common/errorPage");
		}
		return mv;
	}
	
	public void updateMzHit(HttpServletResponse response, HttpServletRequest request, int mzReviewNo) {
		User user = (User)request.getAttribute("loginUser");
		Cookie[] reqCookie = request.getCookies(); // ???????????? ???????????????
		Cookie nullCookie = null; // null ????????????
		
		if(reqCookie != null && reqCookie.length > 0  && user != null) { // ????????? ???????????? ??????
			for(int i = 0; i < reqCookie.length; i++) {
				if(reqCookie[i].getName().equals("mReview" + user.getUserNo() + mzReviewNo)) {
					nullCookie = reqCookie[i];
				}
			}
		}
		if(reqCookie != null && reqCookie.length > 0 && user == null) { // ????????????
			for(int i = 0; i < reqCookie.length; i++) {
				if(reqCookie[i].getName().equals("mReview"+mzReviewNo)) {
					nullCookie = reqCookie[i];
				}
			}
		}
		if(user != null && nullCookie == null) { // ???????????????????????? ????????? ????????????
			Cookie cookie = new Cookie("mReview"+user.getUserNo() + mzReviewNo, "mReview"+user.getUserNo() + mzReviewNo);
			cookie.setMaxAge(60*60*24*365);
			response.addCookie(cookie);
			
			int result = mService.updateHit(mzReviewNo);
			
			if(result > 0 ) {
				System.out.println("????????? ?????? ??????");
			} else if(result <= 0) {
				System.out.println("????????? ?????? ??????");
			}
		}
		
		if(user == null && nullCookie == null) { // ?????????X
			Cookie cookie = new Cookie("mReview" + mzReviewNo, "mReview" + mzReviewNo);
			cookie.setMaxAge(60*60*24*365);
			response.addCookie(cookie);
			int result = mService.updateHit(mzReviewNo);
			
			if(result > 0 ) {
				System.out.println("????????? ?????? ??????");
			} else if(result <= 0) {
				System.out.println("????????? ?????? ??????");
			}
		}
	}
	
	// ???????????? ??????????????? - ????????????????????? ????????? *****
	@RequestMapping(value="mReviewWriteView.dz", method=RequestMethod.GET)
	public String mReviewWriteView(@RequestParam("shopNo") int shopNo, @RequestParam("reservationNo") int reservationNo, Model model ) {
		Shop shop = sService.selectShopOne(shopNo);
		model.addAttribute("shopNo", shopNo);
		model.addAttribute("reservationNo", reservationNo);
		model.addAttribute("shop", shop);
		return "board/mzReview/mReviewInsertForm";
	}
	
	// ????????? ?????? (??????????????????) insert
	@ResponseBody
	@RequestMapping(value="mReviewInsertForm.dz", method=RequestMethod.POST)
	public String mReviewRegister(@ModelAttribute MzReview mzReview, 
										@RequestParam("reservationNo") int reservationNo, 
										HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		if(user.getUserType().equals("3") || user.getUserType().equals("5")) {
			mzReview.setmReviewWriter(user.getUserName());
		} else {
			mzReview.setmReviewWriter(user.getUserNick());
		}
		mzReview.setUserType(user.getUserType());
		mzReview.setUserNo(user.getUserNo());
		ArrayList<MzReviewPhoto> mzPhotoList = null;
		
		if(session.getAttribute("mzPhotoList") != null) {
			mzPhotoList = (ArrayList<MzReviewPhoto>)session.getAttribute("mzPhotoList");
			System.out.println("????????? ?????? ?????? : " + mzPhotoList.toString());
		}
		
		String target = mzReview.getmReviewContent();
		Pattern pattern = Pattern.compile("<img[^>]*src=[\\\"']?([^>\\\"']+)[\\\"']?[^>]*>");
		Matcher matcher = pattern.matcher(target);
		String rtn = "false";
		ArrayList<String> realList = new ArrayList<String>();
		
		
		// rState update ??????????????????
		Reservation reservation = new Reservation();
		reservation.setReservationNo(reservationNo);
		reservation.setrState("H");
		
		int result = 0;
		result = mService.insertMzReview(mzReview, reservation);
		if(result > 0) {
			while(matcher.find()) {
				String realName = matcher.group(1).substring(matcher.group(1).lastIndexOf("=") + 1);
				realList.add(realName);
			}
			if(mzPhotoList != null) {
				for(int i = 0; i < mzPhotoList.size(); i++) {
					String mzPhotoRename = mzPhotoList.get(i).getMzReviewRenameFileName();
					if(!realList.contains(mzPhotoRename)) {
						fileDelete(mzPhotoRename, mzPhotoList.get(i).getMzReviewFilePath());
						continue;
					}
					int mzReviewNo = mzReview.getmReviewNo();
					mzPhotoList.get(i).setMzReviewNo(mzReviewNo);
					int photoResult = mService.insertPhoto(mzPhotoList.get(i));
					if(photoResult > 0) {
						rtn= "success";
					}
				}
			}
			rtn = "success";
			//mv.setViewName("home");
		} else {
			rtn = "fail";
			//mv.addObject("msg", "???????????? ????????? ??????").setViewName("common/errorPage");
		}
		savePhotoList = new ArrayList<MzReviewPhoto>();
		return rtn;
	}
	
	
	
	// ?????? delete
	@ResponseBody // ??????????????? ajax??? ???????????????, ??? ?????? ????????? ??????????????? ????????? ?????????
	@RequestMapping(value="mReviewDelete.dz", method=RequestMethod.GET)
	public String mReviewDelete(@RequestParam("mReviewNo") int mReviewNo, Model model) {
		ArrayList<MzReviewPhoto> photoList = mService.selectPhoto(mReviewNo);
		int result = mService.deleteMzReview(mReviewNo);
		if(result > 0) {
			for(int i = 0; i < photoList.size(); i++) {
				String mzPhotoRename = photoList.get(i).getMzReviewRenameFileName();
				String mzPhotoFilePath = photoList.get(i).getMzReviewFilePath();
				fileDelete(mzPhotoRename, mzPhotoFilePath);
			}
			return "success";
		} else {
			//model.addAttribute("msg", "????????? ????????? ??????????????????.");
			return "fail";
		}
	}
	
	// ????????????
	public void fileDelete(String fileName, String filePath) {
		// ???????????? ??????
		File deleteFile = new File(filePath+fileName);
		deleteFile.setExecutable(true);
		if(deleteFile.exists()) {
			deleteFile.delete();
			System.out.println("??????");
		} else {
			System.out.println("?????? ????????????");
		}
	}
	
	// ??????????????????
	ArrayList<MzReviewPhoto> savePhotoList = new ArrayList<MzReviewPhoto>();
	@RequestMapping(value="/uploadMReviewImg", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		
		HttpSession session = request.getSession(); // ??????
		JsonObject jsonObject = new JsonObject();
		// ??????????????? ??????
		String contextRoot = request.getSession().getServletContext().getRealPath("resources");
		String fileRoot = contextRoot+"/boardImg/MzReview/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//???????????? ?????????
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//?????? ?????????
		String savedFileName = "M" + UUID.randomUUID() + extension;	//????????? ?????? ???
		MzReviewPhoto mzReviewPhoto = new MzReviewPhoto();
		session.removeAttribute("mzPhotoList");
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//?????? ??????
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			jsonObject.addProperty("url", "/Mupload/imageView.dz?imgName="+savedFileName); // contextroot + resources + ????????? ?????? ?????????
			jsonObject.addProperty("responseCode", "success");
			mzReviewPhoto.setMzReviewOriginalFileName(originalFileName); // ??????????????????
			mzReviewPhoto.setMzReviewRenameFileName(savedFileName); // ?????? ????????????
			mzReviewPhoto.setMzReviewFileSize(targetFile.length()); // ?????? ?????????
			mzReviewPhoto.setMzReviewFilePath(fileRoot);
			mzReviewPhoto.setMzReviewFileTime(timestamp); // ?????? ???????????????
			
			savePhotoList.add(mzReviewPhoto);
	        session.setAttribute("mzPhotoList", savePhotoList);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//????????? ?????? ??????
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	
	@RequestMapping(value="/Mupload/imageView.dz")
	public void summerNoteImageView(@RequestParam("imgName") String imgName, HttpServletResponse response, HttpServletRequest request) throws Exception {
		OutputStream out = response.getOutputStream();
        FileInputStream fis = null;
        
        String contextRoot = request.getSession().getServletContext().getRealPath("resources");
		String fileRoot = contextRoot+"/boardImg/MzReview/";
        try {
            fis = new FileInputStream(fileRoot+imgName);
            FileCopyUtils.copy(fis, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException ioe) {
                    ioe.printStackTrace();
                }
            }
            out.flush();
            
        }
	}
	
	// ?????? ??????
	@RequestMapping(value="mReviewUpdateView.dz", method=RequestMethod.GET)
	public ModelAndView mReviewUpdateView(@RequestParam("mReviewNo") int mReviewNo, ModelAndView mv, HttpServletResponse response) throws IOException {
		MzReview mzReview = mService.selectOneReview(mReviewNo);
		if(mzReview != null) {
			mv.addObject("mzReview", mzReview);
			mv.setViewName("board/mzReview/mReviewUpdateForm");
		} else {
			mv.addObject("msg", "??????????????? ???????????? ?????????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	// ????????? update
	@ResponseBody
	@RequestMapping(value="mReviewModify.dz", method=RequestMethod.POST)
	public String mReviewUpdate(@ModelAttribute MzReview mzReview, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int mzReviewNo = mzReview.getmReviewNo();
		ArrayList<MzReviewPhoto> mzPhotoList = new ArrayList<MzReviewPhoto>();
		ArrayList<MzReviewPhoto> beforemzPhotoList = mService.selectPhoto(mzReviewNo);
		int beforePhotoResult = 0;
		
		// ????????? ??????????????? ?????? ???????????? ?????? ????????? ??????
		if(session.getAttribute("mzPhotoList") != null) {
			mzPhotoList = (ArrayList<MzReviewPhoto>)session.getAttribute("mzPhotoList");
			System.out.println("????????? ?????? : " + mzPhotoList.toString());
			beforePhotoResult = mService.deleteBeforePhoto(mzReviewNo);
			if(beforePhotoResult > 0) {
				System.out.println("?????? ?????? ??????");
			} else {
				System.out.println("?????? ?????? ??????");
			}
		}
		
		String target = mzReview.getmReviewContent();
		Pattern pattern = Pattern.compile("<img[^>]*src=[\\\"']?([^>\\\"']+)[\\\"']?[^>]*>"); // ????????? ????????????
		Matcher matcher = pattern.matcher(target);
		String rtn = "false";
		
		if(mzPhotoList != null && beforemzPhotoList != null) {
			mzPhotoList.addAll(beforemzPhotoList); // ???????????? ?????? ??????, ????????? ?????? ?????? ??????
		}
		
		ArrayList<String> realList = new ArrayList<String>();
		int result = mService.updateMzReview(mzReview);
		if(result > 0) {
			while(matcher.find()) {
				String realName = matcher.group(1).substring(matcher.group(1).lastIndexOf("=") + 1); 
				realList.add(realName); // ??????????????? ???????????? ????????? img?????? ?????????
			}
			if(mzPhotoList != null) {
				beforePhotoResult = mService.deleteBeforePhoto(mzReviewNo);
				for(int i = 0; i < mzPhotoList.size(); i++) {
					String mzRename = mzPhotoList.get(i).getMzReviewRenameFileName();
					if(!realList.contains(mzRename)) {
						fileDelete(mzRename, mzPhotoList.get(i).getMzReviewFilePath());
						if (beforePhotoResult > 0) {
							System.out.println("?????? ?????? ??????");
						} else {
							System.out.println("?????? ?????? ??????");
						}
						continue;
					}
					
					mzPhotoList.get(i).setMzReviewNo(mzReviewNo);
					int photoResult = mService.insertPhoto(mzPhotoList.get(i));
					if(photoResult > 0) {
						rtn = "success";
					}
				}
			}
			rtn = "success";
		} else {
			rtn = "fail";
		}
		savePhotoList = new ArrayList<MzReviewPhoto>();
		return rtn;
	}
	
	//D ???????????? ????????????
	@RequestMapping(value="mzReviewShop.dz", method=RequestMethod.GET)
	public void selectMzReview(@RequestParam("shopNo") int shopNo, HttpServletResponse response) throws Exception {
		ArrayList<MzReview> mzList = mService.selectAllMzReview(shopNo);
	
		response.setContentType("application/json"); // json ????????? ????????? ???????????? ??? ??????("text/html;charset=utf-8")
		response.setCharacterEncoding("utf-8"); // ????????? ?????? ?????? ?????? ?????? ??????!!
		
		Gson gson = new Gson();
		gson.toJson(mzList, response.getWriter());
	}
	
	// mz????????????????????? ?????? ???????????? ?????? 3??? ????????? ????????????
	@ResponseBody // ??????????????? ajax??? ???????????????, ??? ?????? ????????? ??????????????? ????????? ?????????
	@RequestMapping(value="mReviewDeleteAndSelectThree.dz", method=RequestMethod.GET)
	public ArrayList<MzReview> mReviewDeleteAndSelectThree(@RequestParam("mReviewNo") int mReviewNo, Model model, HttpSession session) {
		ArrayList<MzReviewPhoto> photoList = mService.selectPhoto(mReviewNo);
		int result = mService.deleteMzReview(mReviewNo);
		if(result > 0) {
			for(int i = 0; i < photoList.size(); i++) {
				String mzPhotoRename = photoList.get(i).getMzReviewRenameFileName();
				String mzPhotoFilePath = photoList.get(i).getMzReviewFilePath();
				fileDelete(mzPhotoRename, mzPhotoFilePath);
			}
			User user = (User)session.getAttribute("loginUser");
			ArrayList<MzReview> mList = mService.selectThreeReviewToMyPage(user.getUserNo());
			
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			String dateformat = sdf.format(mList.get(0).getmReviewUploadDate());
//			mList.get(0).setmReviewUploadDate(sdf.format(mList.get(0).getmReviewUploadDate()));
			
			return mList;
		} else {
			return null;
		}
	}
}
