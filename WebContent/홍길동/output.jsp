<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, db.JdbcUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs= null;

try{
	con=JdbcUtil.getConnection();
	String sql="select o.order_no, name, addr, phone, product, price, qty " 
		+ "from order_tb o left join order_detail d on o.order_no=d.order_no order by order_no";
	pstmt=con.prepareStatement(sql);
	rs= pstmt.executeQuery();
	
	if(rs.next()){
%>
	<table border="1">
	<tr><td>주문번호</td><td>이름</td><td>주소</td><td>전화번호</td>
		<td>상품</td><td>개수</td><td>가격</td></tr>
<%		String orderNoTmp="";
		do{
			if(!orderNoTmp.equals(rs.getString(1))){%>
	<tr><td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td><td><%=rs.getString(3) %></td>
		<td><%=rs.getString(4) %></td>
		<td><%=rs.getString(5) %></td><td><%=rs.getString(6) %></td><td><%=rs.getString(7) %></td>
		</tr>				
<%				orderNoTmp=rs.getString(1);
			}else{%>
	<tr><td colspan="4"></td>
		<td><%=rs.getString(5) %></td><td><%=rs.getString(6) %></td><td><%=rs.getString(7) %></td>
		</tr>				
<%			}		
		}while(rs.next());
%>	
	</table>	
<%		
	}else{
		out.println("불러올 데이터가 없습니다.");
	}
	
}catch (Exception e) {
	e.printStackTrace();
	out.println("<script>");
	out.println("alert('데이터 출력 오류');");
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