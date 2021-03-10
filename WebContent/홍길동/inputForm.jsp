<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
var oTbl;

function insRow() {//Row 추가
  oTbl = document.getElementById("addTable");
  var oRow = oTbl.insertRow();
  oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
  var oCell = oRow.insertCell();
  //삽입될 Form Tag
  var frmTag = "<input type='text' name='product'>";
  oCell.innerHTML = frmTag;
  oCell = oRow.insertCell();
  //삽입될 Form Tag
  frmTag = "<input type='text' name='price'>";
  oCell.innerHTML = frmTag;
  oCell = oRow.insertCell();
  //삽입될 Form Tag
  frmTag = "<input type='text' name='qty'>";
  frmTag += "<input type=button value='삭제' onClick='removeRow()' style='cursor:hand'>";
  oCell.innerHTML = frmTag;
} 

function removeRow() {//Row 삭제
  oTbl.deleteRow(oTbl.clickedRowIndex);
}
</script>
<body>
<form name="f" action="inputReg.jsp" method="post">
상품주문 기본
<table border="1">
<tr><td>주문번호</td>
	<td><input type="text" name="order_no"/></td></tr>
<tr><td>이름</td>
	<td><input type="text" name="name"/></td></tr>
<tr><td>주소</td>
	<td><input type="text" name="addr"/></td></tr>
<tr><td>전화번호</td>
	<td><input type="text" name="phone"/></td></tr>
</table>
<br>
상품주문 상세
<table border="1" id="addTable">
<tr><td>상품</td><td>가격</td><td>개수</td></tr>
<tr><td colspan="3">
<input name="addButton" type="button" style="cursor:hand" onClick="insRow()" value="입력창 추가"></td></tr>
<tr><td><input type="text" name="product"></td>
	<td><input type="text" name="price"></td>
	<td><input type="text" name="qty"></td></tr>
</table>
<table>
<tr><td><input type="submit" value="등록"/>
		<input type="button" value="조회" onclick="location.href='output.jsp'"/>	
</td></tr>
</table>
</form>
</body>
</html>