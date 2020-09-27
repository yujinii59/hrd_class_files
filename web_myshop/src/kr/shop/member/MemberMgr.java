package kr.shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberMgr {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public MemberMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("MemberMgr err : " + e);
		}
	}
	
	//우편번호 검색
	public ArrayList<ZipcodeDto> zipcodeRead(String dongName, String gilName){
		ArrayList<ZipcodeDto> list = new ArrayList<ZipcodeDto>();
		
		
		try {
			conn = ds.getConnection();
			if(gilName.isEmpty()) {
				String sql = "select * from newzip where zip_oarea1 like ? or "
						+ "substr(zip_oarea1,instr(zip_oarea1,'(')+1,instr(zip_oarea1,')')-instr(zip_oarea1,'(')-1) like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dongName + "%");
				pstmt.setString(2, dongName + "%");
			}else {
				String sql = "select * from newzip where zip_narea3 like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, gilName + "%");
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				//System.out.println(rs.getString("zip_code"));
				ZipcodeDto dto = new ZipcodeDto();
				dto.setZip_code(rs.getString("zip_code"));
				dto.setZip_narea1(rs.getString("zip_narea1"));
				dto.setZip_narea2(rs.getString("zip_narea2"));
				dto.setZip_narea3(rs.getString("zip_narea3"));
				dto.setZip_narea4(rs.getString("zip_narea4"));
				dto.setZip_narea5(rs.getString("zip_narea5"));
				dto.setZip_oarea1(rs.getString("zip_oarea1"));
				dto.setZip_oarea2(rs.getString("zip_oarea2"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("zipcodeRead err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return list;
	}
	
	public boolean checkId(String id) {
		boolean b = false;
		
		String sql = "select id from member where id = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			b = rs.next();
			
		} catch (Exception e) {
			System.out.println("checkId err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	public boolean memberInsert(MemberBean bean) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into member values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPasswd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getNewaddress());
			pstmt.setString(8, bean.getAddress());
			pstmt.setString(9, bean.getDetailaddress());
			pstmt.setString(10, bean.getJob());
			
			if(pstmt.executeUpdate() > 0) b=true;
			
		} catch (Exception e) {
			System.out.println("memberInsert err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	public boolean loginCheck(String id, String passwd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select id, passwd from member where id = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("loginCheck err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	public MemberDto getMember(String id) {
		MemberDto dto = null;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDto();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setNewaddress(rs.getString("newaddress"));
				dto.setAddress(rs.getString("address"));
				dto.setDetailaddress(rs.getString("detailaddress"));
				dto.setJob(rs.getString("job"));
				
			}
		} catch (Exception e) {
			System.out.println("getMember err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return dto;
	}
	
	public boolean memberUpdate(MemberBean bean, String id) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "update member set passwd=?, name=?, email=?, phone=?, zipcode=?, newaddress=?, address=?, detailaddress=?, job=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPasswd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getPhone());
			pstmt.setString(5, bean.getZipcode());
			pstmt.setString(6, bean.getNewaddress());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getDetailaddress());
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, id);
			
			if(pstmt.executeUpdate() > 0) b = true;
			
		} catch (Exception e) {
			System.out.println("memberUpdate err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	//관리자 로그인 관련
	public boolean adminLoginCheck(String adminid, String adminpasswd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from admin where admin_id = ? and admin_passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adminid);
			pstmt.setString(2, adminpasswd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("adminLoginCheck err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	//관리자로 전체 회원 자료 읽기
	public ArrayList<MemberDto> getMemberAll(){
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from member order by id asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setNewaddress(rs.getString("newaddress"));
				dto.setAddress(rs.getString("address"));
				dto.setDetailaddress(rs.getString("detailaddress"));
				dto.setJob(rs.getString("job"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getMemberAll err : " + e);
		} finally { 
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
}
