<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     <footer class="footer-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-2 col-4">
            <div class="footer-left">
              <div class="footer-logo">
                <a href="${pageContext.request.contextPath}/front-end/index.jsp"><img src="${pageContext.request.contextPath}/front-template/images/01.png" alt="" /></a>
              </div>
<!--               <div class="footer-social"> -->
<!--                 <a href="#"><i class="fa fa-facebook"></i></a> -->
<!--                 <a href="#"><i class="fa fa-instagram"></i></a> -->
<!--                 <a href="#"><i class="fa fa-twitter"></i></a> -->
<!--                 <a href="#"><i class="fa fa-pinterest"></i></a> -->
<!--               </div> -->
            </div>
          </div>
          <div class="col-lg-4 col-8">
         	<div class="footer-widget">
               <ul class="modefemmeinfo">
                <li>Address: 320桃園市中壢區復興路46號8樓</li>
                <li>Phone: +886 3425-8183</li>
                <li>Email: modefemme@gmail.com</li>
              </ul>
             </div>
           </div>
          <div class="col-lg-2 col-6">
            <div class="footer-widget">
              <h5>Information</h5>
              <ul>
<!--                 <li><a href="#">關於Mode Femme</a></li> -->
                <li><a href="<%=request.getContextPath()%>/front-end/qa/qna.jsp">常見問題</a></li>
<!--                 <li><a href="#">聯絡我們</a></li> -->
<!--                 <li><a href="#">Serivius</a></li> -->
              </ul>
            </div>
          </div>
          <div class="col-lg-2 col-6">
            <div class="footer-widget">
              <h5>前往其它</h5>
              <ul>
                <li><a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">會員專區</a></li>
                <li><a href="<%=request.getContextPath()%>/front-end/productsell/shop.jsp">商品專區</a></li>
                <li><a href="<%=request.getContextPath()%>/front-end/live/liveWall.jsp">直播專區</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
        <div class="copyright-reserved">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="copyright-text">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </div>
                        <div class="payment-pic">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>