<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="common/base.jsp"%>
<footer>
		<div class="inner-footer">
			<div class="container">
				<div class="row">
					<div class="col-md-4 f-about">
						<a href="index.jsp"><h1><span>T</span>echnical</h1></a>
						<p>感谢您的访问
						</p>
						
					</div>
					<div class="col-md-4 l-posts">
						<h3 class="widgetheading">友情链接</h3>
						<ul>
							<li><a href="#">Git Hub</a></li>
							<li><a href="#">CSND.NET</a></li>
							<li><a href="#">Bootstrap 中文网</a></li>
							<li><a href="#">java.com</a></li>
						</ul>
					</div>
					<div class="col-md-4 f-contact">
						<h3 class="widgetheading">联系我 &nbsp;<i class="icon-comments"></i></h3>
						<a href="#"><p><i class="icon-envelope-alt"></i>871839012@qq.com</p></a>
						<a href="#"><p><i class="icon-circle-arrow-right"></i>QQ:871839012</p></a>
						<a href="#"><p><i class="icon-phone"> 1236548238</i></p></a>

					</div>
				</div>
			</div>
		</div>
			
		<div class="last-div">
			<div class="container">
				<div class="row">
					<div class="copyright">
						© 2015 软件工程二班-谢圣强 
					</div>
					<nav class="foot-nav">
						<ul>
							<li><a href="#">Home</a></li>
							<li><a href="#">API</a></li>
							<li><a href="${path }/back/hello!loaginback">MS</a></li>
							<li><a href="#">EXIT</a></li>
							
						</ul>
					</nav>
					<div class="clear"></div>
				</div>
			</div>
			<a href="#" class="scrollup"><i class="icon-chevron-up" style="position: relative;top: 7px;"></i></a>	
		</div>		
	</footer>
	<script>
	$(document).ready(function() {
		$("[data-toggle='tooltip']").tooltip();
	});
	</script>