<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@
	page import="java.util.ArrayList, com.us.product.model.vo.Product, com.us.common.model.vo.PageInfo,
				 com.us.product.model.vo.ProQna, com.us.product.model.vo.WishList, com.us.product.model.vo.Review, com.us.common.model.vo.Attachment"
%>
<%
	Product p = (Product)request.getAttribute("p"); // 상품 정보
	
	PageInfo pi = (PageInfo)request.getAttribute("pi"); // 상품 문의 페이징 정보 객체
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getCurrentPage();
	int endPage = pi.getEndPage();
			
	ArrayList<ProQna> qlist = (ArrayList<ProQna>)request.getAttribute("list"); // 상품 문의 게시글 리스트
	WishList w = (WishList)request.getAttribute("w"); // 해당 상품 찜 여부
	
	int qnaCount = 0; // 상품 문의 게시글 수를 담을 변수
	for(int i=0; i<qlist.size(); i++){
		qnaCount++;		
	}
	
	// 해당 상품의 리뷰들을 담은 ArrayList
	ArrayList<Review> rlist = (ArrayList<Review>)request.getAttribute("rlist");
	
	// 해당 상품의 리뷰 개수
	int revCount = 0;
	for(int i=0; i<rlist.size(); i++){
		revCount++;
	}
	
	// 해당 상품의 리뷰 별점 평균
	double revAvg = 0;
	if(!rlist.isEmpty()){
		int sum = 0;
		for(int i=0; i<rlist.size(); i++){
			sum += rlist.get(i).getRevRate();		
		}
		revAvg = sum / rlist.size();			
	}
	
	// 리뷰들 중 사진 리뷰들의 사진 Attachment 리스트
	ArrayList<Attachment> picList = (ArrayList<Attachment>)request.getAttribute("picList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= p.getProName() %> - Earth.Us</title>

<style>
    .green {
    	background:#778C79 !important;
    }
    .white {
    	background:white !important;
    }
    .input-number {
		border:none;
		text-align:center;
	}
	
	.btn_2 {
	background : #778C79 !important;
	color:#f2f2f2 !important;
	}
	
	.fa fa-heart-o {
		font-size:large;
	}
	
	.col3 {
		text-align:center;
	}
	.section_padding {
    padding-top: 200px !important;
	}

	.pro_qna_answer .on {
		display:block;
	}
	
	#enrollBtn {
		float:right;
	}
	
	<!-- 리뷰 영역 스타일 -->
	#rate-star{
	  display:inline-block;
	  border:0px;
	  padding-left:10px;
	}
	#rate-star input[type=radio]{
	  display:none;
	}
	.review-rate{
	  color:#fbd600;
	}
	#profile p {
		text-align:center;
	}
</style>

</head>
<body>

<%@ include file="../common/menubar.jsp" %>

<!-- font awesome -->
<script src="https://use.fontawesome.com/e3cb36acfb.js"></script>
<!-- swiper CSS -->
 <link rel="stylesheet" href="<%= contextPath %>/resources/css/u_css_sumin/price_rangs.css">
 

 
 <!--================상품 상세 조회 영역=================-->
  <div class="product_image_area section_padding" style="padding-top:250px;">
    <div class="container">
      <div class="row s_product_inner justify-content-center">
      
      <!------ 썸네일 영역 (좌측) ------->
        <div class="col-lg-6 col-xl-4 "> 
          <div class="product_slider_img">
            <div id="vertical">
              <div data-thumb="<%= contextPath %>/<%= p.getProImgPath() %>">
                <img src="<%= contextPath %>/<%= p.getProImgPath() %>" />
              </div>
            </div>
          </div>
        </div>
      <!------ 썸네일 영역 끝 ------>
      
      <!------ 상품 설명란 (우측) ------>
        <div class="col-lg-6 col-xl-4">
          <div class="s_product_text">
            <h3><%= p.getProName() %></h3>
            <h5 style="color:rgb(119,140,121)"></h5>
            <ul class="list">
              <li>
                <hr>
                <span><%= p.getProInfo() %></span>
                <br>
                <br>
                <span>배송비</span>
                <span style="float:right">+3,000원</span>
                <br>
                <br>
                <!----- 수량 변경 버튼 ----->
                <div class="product_count" style="width:35%;">
                  <span class="inumber-decrement" id="minus" onclick="amount('m');" style="cursor:pointer"> <i class="ti-minus"></i></span>
                  <input class="input-number" id="qty" type="number" value="1" min="0" max="10" style="border:none; text-align:center;" readonly>
                  <span class="number-increment" id="pluse" onclick="amount('p');" style="cursor:pointer"> <i class="ti-plus"></i></span>
                </div>
                <br>
                <span>최종 금액</span>
                <span id="finPrice" style="float:right"></span>
                <br>
                <br>
              </li>
            </ul>
            <script>
            	// 상품 가격 천단위 콤마 찍기
           		price();
           		
           		// 선택 수량 변경 함수
           		function amount(t){ 
           			
            		var min_qty = 1;
           			var this_qty = $("#qty").val() * 1;
           			var max_qty = <%=p.getStock()%>;
           			
           			if(t == 'm'){ // 마이너스 아이콘 선택 시
           				this_qty -= 1;
           				if(this_qty < min_qty){
           					alert("수량은 1개 이상 입력해 주십시오.");
           					return;
           				}
           			}else if(t == 'p') { // 플러스 아이콘 선택 시
           				this_qty += 1;
           				if(this_qty > max_qty){
           					this_qty = max_qty;
           					return;
           				}
           			}
           			
           			// 현재 수량 표시
           			$('#qty').val(this_qty);
           			$("#proQty").val(this_qty);
           			
           			var num = <%= Integer.parseInt(p.getPrice()) %>; // 상품 개당 가격
           			var finNum = num * this_qty + 3000; // 총 가격
           			
           			$('.s_product_text>h5').text( num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원' );
           			$('#finPrice').text( finNum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원' );
           			
           		}
            			
           		// 가격 천단위 콤마 찍는 함수
           		function price(){ 
           			
           			var num = <%= Integer.parseInt(p.getPrice()) %>; // 상품 개당 가격
           			var amount = $('#qty').val(); // 상품 선택 개수
           			var finNum = num * amount + 3000; // 총 가격
           			
           			$('.s_product_text>h5').text( num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원' );
           			$('#finPrice').text( finNum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원' );
             		
           		}
            </script>
            
            <!-- 장바구니/바로결제 -->
            <div class="card_area d-flex justify-content-between align-items-center">
            
              <% if(loginUser != null){ %>
              	<button type="button" onclick="insertCart()" class="btn_3" style="background:#A8BFAA;">장바구니</button>
              	<form action="<%=contextPath%>/checkout.or" method="post">
	              	<button class="btn_3 font_bold_gray">바로결제</button>
	              	<input type="hidden" name="proCode" value="<%= p.getProCode() %>">
	              	<input type="hidden" name="proName" value="<%= p.getProName() %>">
	              	<input type="hidden" name="price" value="<%= p.getPrice() %>">
					<input type="hidden" id="proQty" name="proQty" value="1">	              	
              	</form>
              <%}else{ %>
              	<button type="button" onclick="$('#unavailable').modal('show');" class="btn_3" style="background:#A8BFAA;">장바구니</button>
              	<a href="#" onclick="$('#unavailable').modal('show');" class="btn_3 font_bold_gray">바로결제</a>
              <%} %>
              
              <script>
              	// 장바구니 추가
              	function insertCart(){
              		$.ajax({
              			url:"<%=contextPath%>/insert.ca",
              			data:{ proCode:<%=p.getProCode()%>,
             					   proQty:$('#qty').val()},
              			type:"post",
              			success: function(result){
              				// 성공 완료 modal 띄우기
              				if(result > 0){
               				$('#insertCartModal').modal('show');
              				}
              			},error: function(){
              				console.log("장바구니 추가 ajax 통신 실패");
              			}
               		})
              	}
              </script>
                
            <!-- 장바구니 이동 확인 Modal -->
            <div class="modal" id="insertCartModal">
               <div class="modal-dialog">
                  <div class="modal-content">

                      <!-- Modal body -->
                      <div class="modal-body" style="text-align:center; padding:50px 0px; line-height:30px;">
                        상품이 장바구니에 담겼습니다.<br>
                        장바구니로 이동하시겠습니까?
                      </div>
                      
                      <!-- Modal footer -->
                      <div class="modal-footer" style="display:inline-block; text-align:center;">
                        <button type="button" class="btn btn_2" onclick="location.href='<%=contextPath%>/list.ct'">확인</button>
                        <button type="button" class="btn btn_2" data-dismiss="modal">취소</button>
                      </div>
                      
                   </div>
          		</div>
        	</div>
                      
           <!-- 로그인 요청 Modal -->
            <div class="modal" id="unavailable">
              <div class="modal-dialog">
                <div class="modal-content">

                  <!-- Modal body -->
                  <div class="modal-body" style="text-align:center; padding:50px 0px; line-height:30px;">
                    로그인된 회원만 이용 가능합니다.
                  </div>
                  
                  <!-- Modal footer -->
                  <div class="modal-footer" style="display:inline-block; text-align:center;">
                    <button type="button" class="btn btn_2" onclick="location.href='<%=contextPath%>/views/member/goLogin.jsp'">확인</button>
                    <button type="button" class="btn btn_2" data-dismiss="modal">취소</button>
                  </div>
         		
                </div>
              </div>
            </div>

		  <!-- 찜 기능 -->
		  <!-- 회원은 찜 가능 -->
		  <% if(loginUser != null) { %> 
		  
		  	<!-- 찜 여부에 따라 찜버튼 색상 다르게 나타남 -->
		  	<% if(w != null) { %>
           		<a href="#" class="like_us green" onclick="checkWishlist();"><i class="fa fa-heart-o" style="font-size:large; color:#f2f2f2;"></i></a>
           	<% }else { %>
           		<a href="#" class="like_us white" onclick="checkWishlist();"><i class="fa fa-heart-o" style="font-size:large; color:#778c79;"></i></a>
           	<% } %>
           	
          <!-- 비회원은 로그인 요청 모달 나타남 --> 	
          <% }else { %>
          	<a href="#" class="like_us white" onclick="$('#unavailable').modal('show');"><i class="fa fa-heart-o" style="font-size:large;"></i></a>
          <% } %>
              
          <script>
          	// 찜 여부 검사
            function checkWishlist(){
            	
				$.ajax({
					url:"<%=contextPath%>/checkWish.pr",
					data:{
						proCode:'<%=p.getProCode()%>'
						},
					type:"post",
					success:function(wish){
		 				// 찜 안 되어 있으면 찜 추가 함수 실행
						if(wish == null){
		 					insertWish();
		 					
		 				// 찜 되어 있으면 찜 삭제 함수 실행
						}else{
							deleteWish();
						}
					},error:function(){
						console.log("찜 여부 확인용 ajax 통신 실패");
					}
				})
            }
            
          	// 찜 추가 함수
            function insertWish(){
            	$.ajax({
            		url:"<%=contextPath%>/insertWish.pr",
            		data:{proCode:'<%=p.getProCode()%>'},
            		type:"post",
            		success:function(){
            			// 추가 성공 --> 찜 버튼 스타일 변경
            			$('.like_us i').css('color', '#f2f2f2');
            			$('.like_us').removeClass('white').addClass('green');
            		},
            		error:function(){
            			console.log("위시리스트 추가용 ajax 통신 실패");
            		}
            	})
            }
            
          	// 찜 제거 함수
            function deleteWish(){
            	$.ajax({
            		url:"<%=contextPath%>/proDetailDelWish.pr",
            		data:{proCode:'<%=p.getProCode()%>'},
            		type:"post",
            		success:function(){
            			// 제거 성공 --> 찜 버튼 스타일 변경
            			$('.like_us i').css('color', '#778c79');
            			$('.like_us').removeClass('green').addClass('white');
            		},
            		error:function(){
            			console.log("위시리스트 삭제용 ajax 통신 실패");
            		}
            	})
            }
          </script>
        
      </div>
    </div>
  </div>
  <!--================End Single Product Area =================-->

  <!--================Product Description Area =================-->
  <section class="product_description_area" style="width:100%">
    <div class="container">
      <hr><br>
      
      <!-- 상품 상세 조회 네비게이션 -->
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
          <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
            aria-selected="true">상세정보</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
            aria-selected="false">필수표기정보</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
            aria-selected="false">상품 문의(<%=qnaCount%>)</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
            aria-selected="false">리뷰(<%= rlist.size() %>)</a>
        </li>
      </ul>

      <!-- 상세정보 -->
      <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
          <h4>상세정보</h4>
          <br><hr><br>
          <p>
            <img src="<%= contextPath %>/<%= p.getDetailImgPath() %>">
          </p>
        </div>

        <!-- 필수표기정보 -->
        <div class="tab-pane fade" role="tabpanel" id="profile" aria-labelledby="profile-tab">
          <div class="table-responsive">
            <br><br>
            <h4>필수표기정보</h4>
            <br><hr><br>
            <p>
              <img src="<%= contextPath %>/<%= p.getReqInfoImgPath() %>">
            </p>
          </div>
        </div>

        <!-- 상품 문의 -->
        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
          <div class="row">
          	<div id="pro-qna-area">
          		<div id="pro-qna-head">
          			<ul>
          				<li class="col1">No</li>
          				<li class="col2">상태</li>
          				<li class="col3" style="text-align:center">제목</li>
          				<li class="col4">작성자</li>
          				<li class="col5">작성일</li>
          			</ul>
          		</div>
          		<div id="pro-qna-body"> 
          		
          		<!-- 문의글 있을 때 -->
          		<% if(!qlist.isEmpty()) {%>
          		<% for(ProQna q : qlist) { %>
          			<!-- 목록 -->
          			<ul class="pro-qna-question">
          				<li class="col1"><%=q.getProQnaNo()%></li>
          				
          				<!-- 답변 미등록 상태면 -->
          				<% if(q.getProAEnrollDate() == null) { %> 
          				<li class="col2 waiting">답변대기중</li>
          				<% }else { %>
          				<li class="col2 completion">답변완료</li>
          				<% } %>
          				
          				<!-- 비밀글이면 -->
          				<% if(q.getProQnaPwd() != null) { %> 
          				<li class="col3">
          					비밀글입니다. &nbsp;					 
          					<i class="fa fa-lock"></i>
          					<input type="hidden" name="proQnaPwd" value="<%=q.getProQnaPwd()%>">
          				</li>
          				<input type="hidden" name="proQnaTitle" value="<%=q.getProQnaTitle()%>" >
          				
          				<% } else {%>  <!-- 공개글이면 -->	
          				<li class="col3">
          					<%=q.getProQnaTitle()%> &nbsp;
          				</li>
          				<% } %>	
          				
          				<% int length = q.getProQnaWriterName().length();
          				   String name= q.getProQnaWriterName().substring(0,length-1)+"*"; 
          				%>
          				<li class="col4"><%=name%></li>
          				<li class="col5"><%=q.getProQEnrollDate()%></li>
          			</ul>
          			<!-- 목록 -->
          			
          			<!-- 답변 -->
	          		<div class="pro-qna-answer">
	          			<p><%= q.getProQnaContent() %></p>
          			<% if(q.getProAEnrollDate() != null) { %> <!-- 답변 등록 상태면 -->
	          			<div class="pro-answer">
	          				<p><b>관리자</b>&nbsp;&nbsp;<%=q.getProAEnrollDate()%></p> 
	          				<%=q.getProAContent()%>
	          			</div>
	          		<% } %>
	          		</div>
	          		<!-- 답변 -->
	          	<% } %>
	          	<!-- 반복문 끝 -->
	          	
	          	<!-- 문의 글 없을 때 -->
	          	<% } else { %> 
	          		<ul class="pro-qna-question">
          				<li colspan="5" style="width:100%; text-align:center;">등록되어 있는 상품 문의가 없습니다. 상품 문의를 등록해 주세요.</li>
          			</ul>
          		<% } %>
          		</div>
          	<hr>
          	</div>
            
             <!-- 페이징바 영역 -->
                <div class="col-lg-12">
                   <nav class="blog-pagination justify-content-center d-flex">
                       <ul class="pagination">
                       	<% if(currentPage != 1) {%>
                               <li class="page-item">
                                   <button onclick="location.href='<%=contextPath%>/detail.pro?proCode=<%=p.getProCode()%>&cpage=<%=currentPage-1%>';" class="page-link" aria-label="Previous">
                                       <i class="ti-angle-left"></i>
                                   </button>
                               </li>
                           <% } %>
                           
                           <% for(int i=startPage; i<=endPage; i++) { %>
				            <% if(i == currentPage){ %>
                                   <li class="page-item active">
                                       <button class="page-link" disabled><%= i %></button>
                                   </li>
				            <% }else { %>
                                   <li class="page-item">
                                       <button class="page-link" onclick="location.href='<%=contextPath%>/detail.pro?proCode=<%=p.getProCode()%>&cpage=<%=i%>';"><%=i%></button>
                                   </li>
							<% } %>
						<% } %>
					
                           <% if(currentPage != maxPage) { %>
                               <li class="page-item">
                                   <button onclick="location.href='<%=contextPath%>/detail.pro?proCode=<%=p.getProCode()%>&cpage=<%=currentPage+1%>';" class="page-link" aria-label="Next">
                                       <i class="ti-angle-right"></i>
                                   </button>
                               </li>
                           <% } %>
                           	<li><a href="<%=contextPath%>/insertForm.pq?code=<%=p.getProCode()%>&name=<%=p.getProName()%>" class="btn-submit" id="z2"
                     						style="display:inline-block; text-align:center;">상품 문의하기</a>
                       		</li>
                       </ul>
                   </nav>
                </div>
              <!-- 페이징바 영역 끝 -->
            
          </div>
       </div>

       <script>
         
           // ========================= 문의글 클릭 이벤트 ======================
           $('.pro-qna-question').click(function(){ // 문의글 클릭했을 때

             var title = $(this).children('.col3'); // 문의글 제목
             
             if( title.children(0).hasClass('fa-lock') ){ // 비밀글일 경우 => 비밀번호 입력 받기
           	  
	             const check = prompt('비밀번호를 입력하세요.', '숫자 네자리로 입력');
	             var proQnaPwd = $(this).find('input[name=proQnaPwd]').val(); // 해당 문의글의 비밀번호
	
	             	if(check == null){ // 입력값이 없을 때
	             		 return;
	             	}else if(check == proQnaPwd){ // 입력값이 있을 때 번호 일치
	
		                 title.removeClass('fa-lock');
		                 title.text( $(this).find('input[name=proQnaTitle]').val() );
		                 
		                 $(this).next(".pro-qna-answer").stop().slideToggle(300);
		                 $(this).next("pro-qna-answer").siblings("pro-qna-answer").slideUp(300);
					 
	               } else { // 입력값이 있을 때 번호 불일치
	                 	 alert("비밀번호가 일치하지 않습니다.");
	               	 	 return;
	               }

             }else { // 비밀글이 아니거나, 비밀글 비번 풀려있는 경우
            	 
            	 title.text( $(this).find('input[name=proQnaTitle]').val() );
                 
                 $(this).next(".pro-qna-answer").stop().slideToggle(300);
                 $(this).next("pro-qna-answer").siblings("pro-qna-answer").slideUp(300);
             }
             

             if($(this).next('pro-qna-answer').is('display','none')){ // 글 안 펼쳐져 있으면
             	$(this).siblings('pro-qna-answer').attr('display', 'none');
              $(this).next('pro-qna-answer').show();
             }else{ // 펼쳐져 있으면
               $(this).next('pro-qna-answer').removeClass('on');
               $(this).next('pro-qna-answer').attr('display', 'none');
             }
           })
           // ====================== 문의글 클릭 이벤트 끝 ===========================
       </script>

        <!-- 아래부터 Review 영역!! -->
        <!-- 아래부터 Review 영역!! -->
        
        <div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
          <div class="row" style="width:800px; margin:auto;">
            <div class="col-lg-12">
            
            <% if(!rlist.isEmpty()) { %>
              <div class="row total_rate" style="padding-bottom:0px; padding-top:100px;">
                <div class="col-12" style="margin:auto;">
                  <div class="box_total"  style="background-color: #F2F2F2;">
                    <h5>평점</h5>
                    <h4 style="color:#778C79;"><%= revAvg %></h4>
                    <h6>(<%= rlist.size() %>명의 후기)</h6>
                  </div>
                </div>
              </div>
              <% } %>
              
              <!-- 리뷰 작성 버튼 부분 시작 -->
              <div class="col-lg-12" align="center" style="padding:0px; ">
				<% if(loginUser != null){ %>
                <form action="<%= contextPath %>/insert.re" method="post">
				<input type="hidden" name="userNo" value="<%= loginUser.getUserNo() %>">
				<input type="hidden" name="proCode" value="<%= p.getProCode() %>">	    
				<input type="hidden" name="proName" value="<%= p.getProName() %>">      
				<input type="hidden" name="price" value="<%= p.getPrice() %>">    
				<input type="hidden" name="proImgPath" value="<%= contextPath + "/" + p.getProImgPath() %>">
              	<button class="btn_4" style="width:100%; height:45px; margin-top:10px; border:none; color:#778C79;">리뷰 작성</button>
                </form>
				<% } %>
              </div>
              <!-- 리뷰 작성 버튼 부분 끝 -->
        		
              <br><br><br><br><br>
              
              <!-- 리뷰 조회 영역 -->
              <div class="review_list">
              	<% if( rlist.isEmpty() ) {%>
              		<div align="center">
              			<br><br><br><br><br><br>
	              		<p style="font-weight:bold; font-size:20px;">아직 등록된 리뷰가 없습니다.</p>              		
              		</div>
              	<% }else { %>
              	<!-- for문 시작 : 개별 리뷰 영역 -->
              		<% for(Review r : rlist) { %>
	                <div class="review_item">
	                  <div class="media">
	                    <table id="member-info">
	                      <tr>
	                        <td width="50px"><%= r.getUserName() %></td>
	                        <td width="100px;"><%= r.getRevDate() %></td>
	                      </tr>
	                    </table>
	                    <div class="media-body">
	                      <span>별점 : </span>
	                      <span style="color:#fbd600;"> 
	                      	<% for(int i=0; i<r.getRevRate(); i++) { %>
	                      		★
	                      	<% } %>
                       	  </span>
	                      <span style="color:#F2F2F2">
	                      	<% for(int i=5; i>r.getRevRate(); i--) { %>
								★
	                      	<% } %>
	                      </span>		
	                    </div>
	                  </div>
	                  
	                  <div class="review-content" style="height:100px;">
	                    <p class="review-content-text" style="width:70%; height:150px; float:left; box-sizing:border-box; word-break:break-all;">
	                      <%= r.getRevContent() %>
	                    </p>
	                    <% if( r.getRevType().equals("P") ) { %>
	                    	<% for(int i=0; i<picList.size(); i++){ %>
	                    		<% if( picList.get(i).getRefBNo() == r.getRevNo() ) { %>
				                    <div class="review-content-photo" style="width:30%; height:100px; padding-left:20px; float:left;">
				                      <a data-toggle="modal" data-target="#originalImage">
				                        <img src="<%= picList.get(i).getFilePath() + picList.get(i).getChangeName() %>" class="review-img" style="width:100%; height:100%;">
				                      </a>
				                    </div>
			                    <% } %>
		                    <% } %>
	                    <% } %>
	                  </div>
	                  <br><br>
	                </div>
	                <% } %>
                <% } %>
                <!-- for문 끝 : 개별 리뷰 끝 -->
                
              </div>
            </div>
          </div>
        </div>
        <!-- 리뷰 영역 끝!!! -->
        
        <!-- 리뷰 조회 - 이미지 크게 조회하는 모달 -->
		  <script>
		  	$(function(){
		  		$(".review-img").click(function(){
		  			$("#modal-original-img").prop( "src", $(this).attr("src") );
		  		})
		  	})
		  </script>
		  
        <!-- Modal Start -->
		<div id="originalImage" class="modal fade" role="dialog">
		  <div class="modal-dialog">
				
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      <div class="modal-body">
		        <img src="" id="modal-original-img">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!-- Modal End -->
		
      </div>
    </div>
  </section>
  </div>
  </div>
  </div>
  <!--================ 상품 상세 조회 끝 =================-->
		
<%@ include file="../common/footerbar.jsp" %>
</body>
</html>