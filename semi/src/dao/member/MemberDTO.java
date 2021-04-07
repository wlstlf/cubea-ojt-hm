package dao.member;

import java.util.Date;

public class MemberDTO {
	private int 	member_idx;
	private String 	member_type;
	private String 	member_id;
	private String 	member_pw;
	private String 	member_name;
	private String 	member_email;
	private String 	in_admin;
	private Date 	in_date;
	private String	up_admin;
	private Date	up_date;
	private String	use_yn;
	private int		dp_cnt;
	
	
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getIn_admin() {
		return in_admin;
	}
	public void setIn_admin(String in_admin) {
		this.in_admin = in_admin;
	}
	public Date getIn_date() {
		return in_date;
	}
	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}
	public String getUp_admin() {
		return up_admin;
	}
	public void setUp_admin(String up_admin) {
		this.up_admin = up_admin;
	}
	public Date getUp_date() {
		return up_date;
	}
	public void setUp_date(Date up_date) {
		this.up_date = up_date;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getDp_cnt() {
		return dp_cnt;
	}
	public void setDp_cnt(int dp_cnt) {
		this.dp_cnt = dp_cnt;
	}
	
	
}
