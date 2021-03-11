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
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		con = JdbcUtil.getConnection();
		String sql = "select m.mem_id, mem_name, tel, address, hobby from mem m left join mem_hobby h on m.mem_id=h.mem_id";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			String id="";
%>
<table border="1">
	<tr><td>아이디</td><td>이름</td><td>전화</td><td>주소</td><td>취미</td></tr>
<%			
			boolean startrow = true;
			do{				
				if(!id.equals(rs.getString(1))){
					if(!startrow) out.println("</td></tr>");
					%>	
	<tr><td colspan="5"></td></tr>								
	<tr><td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td>
		<td><%=rs.getString(3) %></td><td><%=rs.getString(4) %></td>		
<%					
					out.print("<td>"+rs.getString(5));
					id=rs.getString(1);
					startrow = false;
				}else{
					out.print(", " + rs.getString(5));
				}			
			}while(rs.next());
%>
</table>
<%	}

	} catch (Exception e) {
		e.printStackTrace();
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