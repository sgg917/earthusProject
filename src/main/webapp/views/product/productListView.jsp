<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@
	page import="java.util.ArrayList, com.us.common.model.vo.PageInfo, com.us.product.model.vo.*"
 %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo")); // 이전 페이지에서 넘겨준 카테고리 번호
	
	// 페이징
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
	int listCount = pi.getListCount();

	ArrayList<Category> cList = (ArrayList<Category>)request.getAttribute("cList"); // 전체 카테고리를 담은 ArrayList
	ArrayList<Product> pcList = (ArrayList<Product>)request.getAttribute("pcList"); // 카테고리별 상품 개수를 담은 ArrayList
	ArrayList<Product> pList = (ArrayList<Product>)request.getAttribute("pList");   // 카테고리, 페이지 별 상품 정보를 담은 ArrayList
	ArrayList<Product> bList = (ArrayList<Product>)request.getAttribute("bList");   // 카테고리별 베스트 상품을 담은 ArrayList
	ArrayList<WishList> wList = (ArrayList<WishList>)request.getAttribute("wList"); // 로그인 한 회원의 모든 상품 찜 여부를 담은 ArrayList
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Earth.Us</title>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

<style>
.btn_2 {
	background : #778C79 !important;
	color:#f2f2f2 !important;
}
</style>

</head>
<body>
	
	<%@ include file = "../common/menubar.jsp" %>
    <link rel="stylesheet" href="<%= contextPath %>/resources/sass/u_sass/_banner.scss">
    <link rel="stylesheet" href="<%= contextPath %>/resources/sass/u_sass/_product_list.scss">
    <link rel="stylesheet" href="<%= contextPath %>/resources/css/u_css_sumin/style.map">
 	<link rel="stylesheet" href="<%= contextPath %>/resources/css/u_css_sumin/price_rangs.css">
	<link rel="stylesheet" href="<%= contextPath %>/resources/js/custom.js">
	
	<!-- banner part start-->
	<section class="breadcrumb contents_bg">
	    <div class="container" style="max-width:3640px;">
	        <div class="row justify-content-center">
	            <div class="col-lg-8" style="max-width: 1080px; flex:100%">
	                <div class="breadcrumb_iner">
	                    <div class="breadcrumb_iner_item">
	                        <img style="width:100%; height:100%;" src="<%=contextPath%>/<%=cList.get(categoryNo-1).getCategoryImgPath()%>">
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
	<!-- banner part end -->
		
    <!-------- 상품 카테고리 -------->
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
            
            	<!-- 좌측 사이드바 -->
                <div class="col-lg-3">
                    <div class="left_sidebar_area"> 
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>상품 카테고리</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">

                                    <li>
                                    	<% if(categoryNo == 1) { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=1&cpage=1" class="category-1" style="font-weight:bold">Hair</a>
                                        	<span style="font-weight:bold">(<%= pcList.get(0).getProductCount() %>)</span>
                                    	<% } else { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=1&cpage=1" class="category-1">Hair</a>
                                        	<span>(<%= pcList.get(0).getProductCount() %>)</span>
                                    	<% } %>
                                    </li>
                                    
                                    <li>
                                    	<% if(categoryNo == 2) { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=2&cpage=1" class="category-2" style="font-weight: bold">Body</a>
                                        	<span style="font-weight: bold;">(<%= pcList.get(1).getProductCount() %>)</span>
                                    	<% } else { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=2&cpage=1" class="category-2">Body</a>
                                        	<span>(<%= pcList.get(1).getProductCount() %>)</span>
                                    	<% } %>
                                    </li>
                                    
                                    <li>
                                    	<% if(categoryNo == 3) { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=3&cpage=1" class="category-3" style="font-weight: bold">Kitchen</a>
	                                        <span style="font-weight: bold">(<%= pcList.get(2).getProductCount() %>)</span>
                                    	<% } else { %>
	                                        <a href="<%=contextPath%>/list.pro?categoryNo=3&cpage=1" class="category-3">Kitchen</a>
	                                        <span>(<%= pcList.get(2).getProductCount() %>)</span>
                                    	<% } %>
                                    </li>
                                    
                                    <li>
                                    	<% if(categoryNo == 4) { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=4&cpage=1" class="category-4" style="font-weight: bold">Bathroom</a>
                                        	<span style="font-weight: bold">(<%= pcList.get(3).getProductCount() %>)</span>
                                    	<% } else { %>
                                    		<a href="<%=contextPath%>/list.pro?categoryNo=4&cpage=1" class="category-4">Bathroom</a>
                                        	<span>(<%= pcList.get(3).getProductCount() %>)</span>
                                    	<% } %>
                                    </li>
                                    
                                </ul>
                            </div>
                        </aside>
                    </div>
                </div>
                <!-- 좌측 사이드바 끝 -->
                
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-lg-12"> 
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <!-- 상품 정렬 select -->
                                <div class="single_product_menu d-flex" id="selectArea">
                                    <h4 id="selectTitle">정렬기준 : </h4>
                                    <select class="custom-select" id="orderby">
                                        <option value="PRO_COUNT DESC">조회순</option>
                                        <option value="HOT">인기순</option>
                                        <option value="PRICE DESC">가격높은순</option>
                                        <option value="PRICE">가격낮은순</option>
                                    </select>
                                </div>
                                <!--  상품 정렬 select 끝 -->
                                
                                <!--상품 검색바 -->
                                <div class="single_product_menu d-flex">
                                    <div class="input-group">
                                        <input type="text" id="pNameKeyword" class="form-control" placeholder="상품명 검색"
                                            aria-describedby="inputGroupPrepend">
                                        <div class="input-group-prepend" style="align-items: flex-end;">
                                            <a style="display: inline-block;" onclick="searchPro();">
	                                            <span class="input-group-text" id="inputGroupPrepend" style="margin: auto;">
	                                            	<i class="ti-search"></i>
	                                            </span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!--상품 검색바 끝 -->
                            </div>
                        </div>
                    </div>

                    <!------- 베스트 상품 ------->
                    <% if(categoryNo != 5) { %>
                    <section class="product_list best_seller">
                        <div class="container">
                        
                            <div class="row justify-content-center"> 
                                <div class="col-lg-12">
                                    <div class="section_tittle">
                                        <h2>베스트 상품</h2>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row align-items-center justify-content-between">
                                <div class="col-lg-12">
                                    <div class="best_product_slider owl-carousel">
                                    	<% for(Product p : bList) { %>
	                                        <div class="single_product_item">
	                                            <img src="<%= contextPath %>/<%= p.getProImgPath() %>">
	                                            <div class="single_product_text">
	                                                <h4><%= p.getProName() %></h4>
	                                                <p><%= p.getPrice() %>원</p>&nbsp;&nbsp;&nbsp;
	                                                
					                                 <% if( loginUser != null ) { %> 
					                                 	<!-- 로그인 했을 경우 => 빈 하트로 보임  -->
					                              		<i class="fa fa-heart color-gray loginHeart"></i>
						                              		
					                                 <%	} else { %> 
					                                 	<!-- 로그인 안 했을 경우 => 하트 비활성화, 클릭 시 로그인 요청 모달 -->
					                                      	<i class="fa fa-heart color-gray" onclick="$('#unavailable').modal('show');" ></i>
					                                 <% } %>
					                                 
	                                              	<input type="hidden" name="proCode" value="<%= p.getProCode() %>">
	                                            </div>
	                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </section>
                    <% } %>
                    <!----- 베스트 상품 끝 -----> 
					<hr><br><br>
					
 					<!-- 전체 상품 영역 시작 -->
                    <div class="row align-items-center latest_product_inner">
                    	<% for(Product p : pList) { %>
	                      <div class="col-lg-4 col-sm-6">
	                          <div class="single_product_item">
	                              <img src="<%= contextPath %>/<%= p.getProImgPath() %>" alt="">
	                              <div class="single_product_text">
	                                  <h4><%= p.getProName() %></h4>
	                                  <p><%= p.getPrice() %>원</p>&nbsp;&nbsp;&nbsp;
	                                  
	                                  <% if(loginUser != null) {%>
		                                  <i class="fa fa-heart color-gray loginHeart"></i>
		                                  <a class="add_cart" onclick="insertCart('<%= p.getProCode() %>');">+ 장바구니 추가</a>
	                                  <% }else { %>
		                                  <i class="fa fa-heart color-gray" onclick="$('#unavailable').modal('show')"></i>
		                                  <a class="add_cart" onclick="$('#unavailable').modal('show')">+ 장바구니 추가</a>
	                                  <% } %>
	                                  <input type="hidden" name="proCode" value="<%= p.getProCode() %>">
	                              </div>
	                          </div>
	                      </div>
	                    <% } %>
		             	
		                <!-- 페이징바 -->
		                 <div class="col-lg-12">
		                    <nav class="blog-pagination justify-content-center d-flex">
		                        <ul class="pagination">
		                        	<% if(currentPage != 1) {%>
		                                <li class="page-item">
		                                    <button onclick="location.href='<%=contextPath%>/list.pro?categoryNo=<%= categoryNo %>&cpage=<%=currentPage-1%>';" class="page-link" aria-label="Previous">
		                                        <i class="ti-angle-left"></i>
		                                    </button>
		                                </li>
		                            <% } %>
		                            
		                            <% for(int p=startPage; p<=endPage; p++) { %>
							            <% if(p == currentPage){ %>
		                                    <li class="page-item active">
		                                        <button class="page-link" disabled><%= p %></button>
		                                    </li>
							            <% }else { %>
		                                    <li class="page-item">
		                                        <button class="page-link" onclick="location.href='<%=contextPath%>/list.pro?categoryNo=<%= categoryNo %>&cpage=<%= p %>';"><%= p %></button>
		                                    </li>
										<% } %>
									<% } %>
								
		                            <% if(currentPage != maxPage) { %>
		                                <li class="page-item">
		                                    <button onclick="location.href='<%= contextPath %>/list.pro?categoryNo=<%= categoryNo %>&cpage=<%= currentPage+1 %>';" class="page-link" aria-label="Next">
		                                        <i class="ti-angle-right"></i>
		                                    </button>
		                                </li>
		                            <% } %>
		                        </ul>
		                    </nav>
		                 </div>
		               <!-- 페이징바 끝 -->
			               
			            <!------------------- Modal ------------------->
			           	<!------- 장바구니 추가 완료 Modal ------->
		                <div class="modal fade" id="insertCartModal">
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
		                      
		               <!------- 장바구니 추가 실패 Modal ------->
		                <div class="modal fade" id="unavailable">
		                  <div class="modal-dialog">
		                    <div class="modal-content">
		
		                      <!-- Modal body -->
		                      <div class="modal-body" style="text-align:center; padding:50px 0px; line-height:30px;">
		                        로그인 된 회원만 이용 가능합니다.
		                      </div>
		                      
		                      <!-- Modal footer -->
		                      <div class="modal-footer" style="display:inline-block; text-align:center;">
		                        <button type="button" class="btn btn_2" onclick="location.href='<%=contextPath%>/views/member/goLogin.jsp'">확인</button>
		                        <button type="button" class="btn btn_2" data-dismiss="modal">취소</button>
		                      </div>
		             		
		                    </div>
		                  </div>
		                </div>
                      	<!------------------- Modal ------------------->
                      	
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <script>
    
    	// --------------- 카테고리 사이드 바 스타일 변경 ------------------
	    $(document).ready(function(){
			$('.cat_product_area .row').removeAttr('align-items');
		})
    

		// --------------- 카테고리별 상품 검색 -------------------
    	function searchPro(){
			location.href = "<%= contextPath %>/list.pro?categoryNo=" + <%= categoryNo %> + "&cpage=1&keyword=" + $("#pNameKeyword").val();                     		
    
    	}
    	
    
    	// -------------- 장바구니 추가 ajax ---------------
	    function insertCart(proCode){
			
			$.ajax({
				url:"<%=contextPath%>/insert.ca",
				data:{ proCode:proCode,
					   proQty:1
					 },
				type:"post",
				success: function(result){
					// 성공 완료 modal
					if(result > 0){
	    				$('#insertCartModal').modal('show');
					}
				},error: function(){
					console.log("장바구니 추가 ajax 통신 실패");
				}
	    		})
		}
    
    	
       	// ---------------- 찜 버튼 css 변경 -----------------
        $('.loginHeart').click(function(){
	        if( $(this).hasClass("color-gray") ){ 
	         	$(this).removeClass("color-gray").addClass("color-lightgreen");
	        }else{
	        	$(this).removeClass("color-lightgreen").addClass("color-gray");
	        }
        })
        
        // ------- 상품 이미지나 상품명, 가격 클릭 시 상품 상세 페이지로 이동 -------
        $(function(){
            $(".single_product_item img").click(function(){
            	const proCode = $(this).siblings('.single_product_text').children('input[type=hidden]').val();
            	location.href = "<%=contextPath%>/detail.pro?proCode=" + proCode + "&cpage=1";
            })
        })
    </script>
    
    <!--상품 목록 영역 끝-->
    <!--================상품 카테고리 영역 끝=================-->
    

    <!----- owl carousel 사용 시 필요한 링크와 구문 ----->
	<script src="<%= contextPath %>/resources/js/owl.carousel.min.js"></script>
	<script>
		$(function(){
			$(".owl-carousel").owlCarousel({
				loop:true,
				margin:10,
				nav:true,
				responsive:{
					0:{items:1},
					600:{item:3}
				}
			})
		})
	</script>
	
	<%@ include file = "../common/footerbar.jsp" %>
</body>
</html>