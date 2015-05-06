package com.common.uilt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Utils {

	public static String md5(String text) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(text.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}

			return buf.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "";
		}
	}
	public final static String MD52(String s) {   
		  char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',   
		    'a', 'b', 'c', 'd', 'e', 'f' };   
		  try {   
		   byte[] strTemp = s.getBytes();   
		   MessageDigest mdTemp = MessageDigest.getInstance("MD5");   
		   mdTemp.update(strTemp);   
		   byte[] md = mdTemp.digest();   
		   int j = md.length;   
		   char str[] = new char[j * 2];   
		   int k = 0;   
		   for (int i = 0; i < j; i++) {
		    byte byte0 = md[i];   
		    str[k++] = hexDigits[byte0 >>> 4 & 0xf];   
		    str[k++] = hexDigits[byte0 & 0xf];   
		   }   
		   return new String(str);   
		  } catch (Exception e) {   
		   return null;   
		  }   
		 }   
	public static void main(String[] args) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update("123".getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			
			System.out.println("result: " + buf.toString());// 32位的加密

			System.out.println("result: " + buf.toString().substring(8, 24));// 16位的加密
			System.out.println("aaa:"+md5("aaa"));
			System.out.println("aaa:"+MD52("aaa"));
			
			 String s = new String("admin");   
			  System.out.println("原始：" + s);   
			  System.out.println("MD5后：" + MD52(s));   
			  System.out.println("MD5后再加密：" + KL(MD52(s)));   
			  System.out.println("解密为MD5后的：" + JM(KL(MD52(s))));   
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String KL(String inStr) {   
		  // String s = new String(inStr);   
		  char[] a = inStr.toCharArray();   
		  for (int i = 0; i < a.length; i++) {   
		   a[i] = (char) (a[i] ^ 't');   
		  }   
		  String s = new String(a);   
		  return s;   
		 }   
		  
		 // 加密后解密   
		 public static String JM(String inStr) {   
		  char[] a = inStr.toCharArray();   
		  for (int i = 0; i < a.length; i++) {   
		   a[i] = (char) (a[i] ^ 't');   
		  }   
		  String k = new String(a);   
		  return k;   
		 }   
		    
 

}
