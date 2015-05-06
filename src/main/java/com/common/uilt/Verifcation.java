package com.common.uilt;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;
/**
 * 验证码生成
 * @author lenove-x
 *
 */
public class Verifcation {
	private String strVC;
	public String getStrVC() {
		return strVC;
	}
	public void setStrVC(String strVC) {
		this.strVC = strVC;
	}
	public BufferedImage Draw(){
		final int w = 80, h = 32;
		BufferedImage img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		Graphics g = img.getGraphics();

		g.setColor(new Color(0xDCDCDC));
		g.fillRect(0, 0, w, h);// ???????????

		// g.setColor(Color.black);
		// g.drawRect(0,0,w-1,h-1);//???

		g.setFont(getFont());
		Random r = new Random();
		String str = "";
		final String[] c = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
				"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
				"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
				"y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
				"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
				"W", "X", "Y", "Z" };
//		final String[] c = { "\u9752", "\u534a", "\u706b", "\u6cd5", "\u9898",
//				"\u5efa", "\u8d76", "\u4f4d", "\u5531", "\u6d77","\u7ec6",
//				"\u4e03", "\u5973", "\u4efb", "\u4ef6", "\u611f", "\u51c6",
//				"\u97f3", "\u7b54", "\u54e5", "\u9645", "\u65e7", "\u795e",
//				"\u5ea7", "\u7ae0", "\u538b", "\u6162", "\u53d4", "\u80cc",
//				"\u7684", "\u4e00", "\u4e86", "\u662f", "\u6211", "\u4e0d",
//				"\u5728", "\u4eba", "\u4eec", "\u6709"};
		for (int i = 0; i < 4; i++) {
			String sing = c[r.nextInt(c.length)];
			str += sing;

			g.setColor(new Color(r.nextInt(150) + 20, r.nextInt(150) + 20, r
					.nextInt(150) + 20));
			g.drawString(sing, r.nextInt(6) + 18 * i, 16 + r.nextInt(10));
		}
		for (int i = 0; i < 10; i++) {
			int x = r.nextInt(w);
			int y = r.nextInt(h);
			g.drawOval(x, y, 1, 1);
		}
		for (int i = 0; i < 50; i++) {

			g.setColor(getRandColor(140, 200));
			// g.setColor(new Color(r.nextInt(150) + 20, r.nextInt(150) + 20,
			// r.nextInt(150) + 20));

			int x = r.nextInt(w);

			int y = r.nextInt(h);

			int xl = r.nextInt(12);

			int yl = r.nextInt(12);

			g.drawLine(x, y, x + xl, y + yl);

		}

		g.dispose();

//		ImageIO.write(img, "JPEG", resp.getOutputStream());
//		req.getSession().setAttribute("vc", str);
		System.out.println(str);
		this.strVC=str;
		return img;

	}
	private Font getFont() {
		Random random = new Random();
		Font font[] = new Font[5];
		font[0] = new Font("Ravie", Font.PLAIN, 24);
		font[1] = new Font("Antique Olive Compact", Font.PLAIN, 24);
		font[2] = new Font("Forte", Font.PLAIN, 24);
		font[3] = new Font("Wide Latin", Font.PLAIN, 24);
		font[4] = new Font("Gill Sans Ultra Bold", Font.PLAIN, 24);
		return font[random.nextInt(5)];
	}

	private Color getRandColor(int fc, int bc) {

		Random random = new Random();

		if (fc > 255)

			fc = 255;

		if (bc > 255)

			bc = 255;

		int r = fc + random.nextInt(bc - fc);

		int g = fc + random.nextInt(bc - fc);

		int b = fc + random.nextInt(bc - fc);

		return new Color(r, g, b);

	}
}
