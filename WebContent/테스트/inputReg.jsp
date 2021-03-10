<%@page import="db.JdbcUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="db.JdbcUtil.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String addr = request.getParameter("addr");
	String[] hobby = request.getParameterValues("hobby");
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		con = JdbcUtil.getConnection();
		con.setAutoCommit(false);
		String sql = "insert into mem values (?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, tel);
		pstmt.setString(4, addr);
		int insertResult = pstmt.executeUpdate();
		if(insertResult > 0){
			String sql_h = "insert into mem_hobby values (?,?,?)";
			for(int i =0; i<hobby.length; i++){
				
				int no = 1;
				pstmt = con.prepareStatement("select max(no) from mem_hobby");
				rs = pstmt.executeQuery();			
				if(rs.next()) no = rs.getInt(1)+1;
			
				pstmt = con.prepareStatement(sql_h);
				pstmt.setInt(1, no);
				pstmt.setString(2, id);
				pstmt.setString(3, hobby[i]);				
				pstmt.executeUpdate();
			}	
			con.commit();
%>			
<script>alert('데이터가 입력 되었습니다.');	location.href='inputForm.jsp';</script>	
<%				
			
		}else{
			con.rollback();
%>			
<script>alert('데이터 입력 실패');history.back();</script>	
<%			
		}
		
	}catch(Exception e){
		e.printStackTrace();
		if(con != null) con.rollback();
%>			
<script>alert('데이터 입력 오류');history.back();</script>	
<%		
	}finally{
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
%>
</body>
</html>