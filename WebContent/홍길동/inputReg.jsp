<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, db.JdbcUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String orderNo = request.getParameter("order_no");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String[] product = request.getParameterValues("product");
	String[] price = request.getParameterValues("price");
	String[] qty = request.getParameterValues("qty");

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		con = JdbcUtil.getConnection();
		con.setAutoCommit(false);
		String sql_m = "insert into order_tb values (?,?,?,?)";
		String sql_s = "insert into order_detail values (?,?,?,?,?)";
		pstmt = con.prepareStatement(sql_m);
		pstmt.setString(1, orderNo);
		pstmt.setString(2, name);
		pstmt.setString(3, addr);
		pstmt.setString(4, phone);
		int result = pstmt.executeUpdate();
		if (result > 0) {
			for (int i = 0; i < product.length; i++) {
				int num = 1;
				pstmt = con.prepareStatement("select max(no) from order_detail");
				rs = pstmt.executeQuery();
				if (rs.next()) num = rs.getInt(1) + 1;

				pstmt = con.prepareStatement(sql_s);
				pstmt.setInt(1, num);
				pstmt.setString(2, orderNo);
				pstmt.setString(3, product[i]);
				pstmt.setString(4, price[i]);
				pstmt.setString(5, qty[i]);
				pstmt.executeUpdate();
			}
			con.commit();
			out.println("<script>");
			out.println("alert('데이터 입력 완료');");
			out.println("location.href='inputForm.jsp';");
			out.println("</script>");
		}else{
			con.rollback();
			out.println("<script>");
			out.println("alert('데이터가 입력되지 않았습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	} catch (Exception e) {
		e.printStackTrace();
		if(con!=null) con.rollback();
		out.println("<script>");
		out.println("alert('데이터 입력 오류');");
		out.println("history.back();");
		out.println("</script>");
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}
	%>
</body>
</html>