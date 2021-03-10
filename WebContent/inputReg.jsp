<%@page import="org.eclipse.jdt.internal.compiler.apt.dispatch.HookedJavaFileObject"%>
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
	request.setCharacterEncoding("utf-8");
	String memId = request.getParameter("memId");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String address = request.getParameter("address");
	String[] hobby = request.getParameterValues("hobby");
	
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try{
		con=JdbcUtil.getConnection();
		con.setAutoCommit(false);
		String sql_m ="insert into mem values (?,?,?,?)";
		pstmt=con.prepareStatement(sql_m);
		pstmt.setString(1, memId);
		pstmt.setString(2, name);
		pstmt.setString(3, tel);
		pstmt.setString(4, address);
		int result = pstmt.executeUpdate();
		if(result > 0){
			
			for(int i=0;i<hobby.length;i++){
				int no = 1;
				pstmt=con.prepareStatement("select max(no) from mem_hobby");
				rs=pstmt.executeQuery();
				if(rs.next()) no=rs.getInt(1)+1;
				String sql_h="insert into mem_hobby values (?,?,?)";
				pstmt=con.prepareStatement(sql_h);
				pstmt.setInt(1, no);
				pstmt.setString(2, memId);
				pstmt.setString(3, hobby[i]);
				
				pstmt.executeUpdate();
			}
			con.commit();
			
			out.println("<script>");
			out.println("alert('데이터가 입력되었습니다.');");
			out.println("location.href='inputForm.jsp';");
			out.println("</script>");
		}else{
			con.rollback();
			out.println("<script>");
			out.println("alert('데이터가 정상적으로 입력되지 않았습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}catch(Exception e){
		con.rollback();
		e.printStackTrace();
		out.println("<script>");
		out.println("alert('데이터 입력에 오류가 발생했습니다.');");
		out.println("history.back();");
		out.println("</script>");
	}finally{
		if (rs!=null)rs.close();
		if (pstmt!=null)pstmt.close();
		if (con!=null)con.close();
	}
%>
<%=memId %><br>
<%=name %><br>
<%=tel %><br>
<%=address %><br>
<% for(int i=0; i<hobby.length;i++){ %>
<%=hobby[i] %>
<% }%>
</body>
</html>