package com.servlet;

import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.common.uilt.Verifcation;



/**
 * Servlet implementation class VerifcationServlet
 * 调用工具类生成验证码图片返回给页�?
 * @author lenove-x
 * @version 1.1
 * 
 */
public class VerifcationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VerifcationServlet() {
		super();

	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("image/jpeg");
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "No-cache");
		resp.setDateHeader("Expires", 0);
		
		Verifcation verifcation = new Verifcation();
		ServletOutputStream out = resp.getOutputStream();
		HttpSession seesion = req.getSession();
		
		
		ImageIO.write(verifcation.Draw(), "JPEG", out);
		seesion.setAttribute("vc", verifcation.getStrVC());
	}
}
