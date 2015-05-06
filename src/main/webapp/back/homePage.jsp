<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${path }/dist/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/compiled/homePage.css">
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/compiled/icons.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">

<!-- libraries -->
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/font-awesome.css">


<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
</head>
<div id="main-stats">
			<div class="row stats-row">
				<div class="col-md-3 col-sm-3 stat">
					<div class="data">
						<span class="number">1054</span> 访问
					</div>
					<span class="date">今天</span>
				</div>
				<div class="col-md-3 col-sm-3 stat">
					<div class="data">
						<span class="number">10</span> 用户
					</div>
					<span class="date">2013年11月</span>
				</div>
				<div class="col-md-3 col-sm-3 stat">
					<div class="data">
						<span class="number">322</span> 0.0
					</div>
					<span class="date">本周</span>
				</div>
				<div class="col-md-3 col-sm-3 stat last">
					<div class="data">
						<span class="number">$2,340</span> 0.0
					</div>
					<span class="date">最近30天</span>
				</div>
			</div>
		</div>
<dir id="pad-wrapper">
	<div class="table-wrapper products-table section">
		<div class="row head">
			<div class="col-md-12">
				<h4>Products</h4>
			</div>
		</div>

		<div class="row filter-block">
			<div class="pull-right">
				<div class="ui-select">
					<select>
						<option>Filter users</option>
						<option>Signed last 30 days</option>
						<option>Active users</option>
					</select>
				</div>
				<input type="text" class="search"> <a
					class="btn-flat success new-product">+ Add product</a>
			</div>
		</div>

		<div class="row">
			<table class="table table-hover">
				<thead>
					<tr>
						<th class="col-md-3"><input type="checkbox"> Product</th>
						<th class="col-md-3"><span class="line"></span>Description</th>
						<th class="col-md-3"><span class="line"></span>Status</th>
					</tr>
				</thead>
				<tbody>
					<!-- row -->
					<tr class="first">
						<td><input type="checkbox">
							<div class="img">
								<img src="img/table-img.png">
							</div> <a href="#" class="name">Generate Lorem </a></td>
						<td class="description">if you are going to use a passage of
							Lorem Ipsum.</td>
						<td><span class="label label-success">Active</span>
							<ul class="actions">
								<li><a href="#">Edit</a></li>
								<li class="last"><a href="#">Delete</a></li>
							</ul></td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
</dir>

<!-- end products table -->
<!-- end sidebar -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${path }/dist/js/bootstrap.min.js"></script>

<script src="${path }/dist/js/theme.js"></script>
</body>
</html>