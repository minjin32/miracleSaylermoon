function showMap() {
    
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
         mapOption = { 
        center: new kakao.maps.LatLng(37.56557, 126.97808), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
        };
    
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    
    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
    map.setZoomable(false); 
    
    return map;
}


// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function mapJs(map, positions) {
		
	var selectedCenter = $("#center-value").val();
    
    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();
    
    // 지도조회 - 지역 선택시
     geocoder.addressSearch(selectedCenter, function(result, status) {
        
        // 정상적으로 검색이 완료됐으면 
         if (status === kakao.maps.services.Status.OK) {
    
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            map.setCenter(coords);
         }
    });


	// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // 마커 클릭시 기존에 열려있는 인포 윈도우 닫고 새로운 인포 윈도우 띄우기 위해
    // 커스텀 오버레이 전역변수 선언
    var selectedMarker = null;
    var selectedOverlay = null;
    var clickedMarker = null;
    var clickedOverlay = null;
    
    
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // 주소로 좌표를 검색합니다
    positions.forEach(function(shop, index){ 
        
        geocoder.addressSearch(shop.shopAddr, function(result, status) {
            
            // 정상적으로 검색이 완료됐으면 
             if (status === kakao.maps.services.Status.OK) {
        
                var imageSrc = '/resources/images/map/map_marker_blue_v2.png', // 마커이미지의 주소입니다    
                    imageSize = new kakao.maps.Size(27, 35); // 마커이미지의 크기입니다
                    imageOption = {offset: new kakao.maps.Point(27, 35)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                      
                // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                var markerImage = new kakao.maps.MarkerImage(imageSrc,imageSize, imageOption),
                    markerPosition = new kakao.maps.LatLng(result[0].y,result[0].x); // 마커가 표시될 위치입니다
                    
                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    position: markerPosition, 
                    image: markerImage // 마커이미지 설정 
                });
                
                // 마커가 지도 위에 표시되도록 설정합니다
                marker.setMap(map);
                
                
                // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ---------------------
                /// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				//var content = '<div class="customoverlay">' +
				//	 '  <div class="tail">' + 
				//    '    <span class="title" onclick="showShortInfo('+markerPosition+')">' + shop.shopName + '</span>' +
				//    '  </div>' +
				//    '</div>';
				
				// 커스텀 오버레이를 생성합니다
				//var titleOverlay = new kakao.maps.CustomOverlay({
				//    position: markerPosition,
				//    content: content,
				//    yAnchor: 2
				//});  
				
				
				// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ---------------------
			 	// 마커에 마우스오버 이벤트를 등록합니다
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					
			    	//if (clickedOverlay) {
				    //    kakao.maps.event.removeListener(marker, 'mouseover', function(event) {
					//		titleOverlay.setMap(map);
					//	});
				    //}
				    
					if(clickedMarker != null && clickedOverlay != null || selectedMarker != null) {
						//selectedOverlay.setMap(null);
						selectedMarker.setZIndex(0);
						//kakao.maps.event.addListener(marker, 'mouseover', function(event) {
						//	titleOverlay.setMap(null);
						//});
					}
				
					selectedMarker = marker;
					//selectedOverlay = titleOverlay;
					 
				    
					 // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
				    //titleOverlay.setMap(map);
				    
				    selectedMarker.setZIndex(10);
				    //selectedOverlay.setZIndex(10);
				    
				});
				
				
				// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ---------------------
				// 마커에 마우스아웃 이벤트를 등록합니다
				//kakao.maps.event.addListener(marker, 'mouseout', function() {
				    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
				    //titleOverlay.setMap(null);
				    
				//});
				
				
				// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ---------------------
				 // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
						
			    	// 선택된 마커
			    	clickedMarker = marker;
			    		
					var content = '<div class="wrap">' + 
			            '    <div class="info">' + 
			            '        <div class="title">' + shop.shopName + 
			            '            <div id="close" class="close" title="닫기"></div>' + 
			            '        </div>' + 
			            '        <div class="body">' + 
			            '            <div class="desc">' + 
			            '                <div class="shopTitle">' + 
			            '                	<div class="targetTitle">제공대상</div>' + 
			            '                	<div class="targetCon">'+shop.shopTarget+'</div>' + 
			            '                </div>' + 
			            '                <div class="shopCon">' +
				        '	                <div class="shopProduct">제공품목</div>' + 
				        '	                <div class="shopProductCon">'+shop.shopProduct+'</div>' + 
			            '                </div>' + 
			            '                <div class="shopTime">' +
				        '	                <div class="timeTitle">영업시간</div>' + 
				        '	                <div class="timeCon">'+shop.startTime+':00 - '+shop.endTime+':00</div>' + 
			            '                </div>' + 
			            '            </div>' + 
			            '            <div class="btnShop">' + 
						'				 <button type="button" class="btn btn-primary btn-sm" onclick="shopDetail('+shop.shopNo+')">자세히 보기</button></div>' + 
			            '            </div>' + 
			            '        </div>' + 
			            '    </div>' +    
			            '</div>';
			        
					
					
					// 마커 위에 커스텀오버레이를 표시합니다
					// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
					var overlay = new kakao.maps.CustomOverlay({
					    content: content,
					    map: map,
					    position: markerPosition,
					    zIndex: 10
					});
						
				    // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
					$(document).on("click","#close", function() {
				    	overlay.setMap(null);     
					});							
					
					// 마커 클릭시 기존에 열려있는 인포 윈도우 닫고 새로운 인포 윈도우 띄우기
					if (clickedOverlay) {
				        clickedOverlay.setMap(null);
				    }
				 	overlay.setMap(map);
				    clickedOverlay = overlay;
			    	
			    });
			    
			    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ---------------------
			    // 클릭한 마커 존재할 경우 해당 마커 마우스오버 막기
				//if(titleOverlay) {
			    	//kakao.maps.event.addListener(marker, 'mouseover', function(event) {
						//titleOverlay.setMap(null);
					//});
		    	//}
		    	    	
             }
        });
    });

    


}