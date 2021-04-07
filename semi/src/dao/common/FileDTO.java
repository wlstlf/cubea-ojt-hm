package dao.common;

import java.util.Date;

public class FileDTO {
	private String file_idx;
	private String file_type;
	private String pa_idx;
	private String ori_name;
	private String sv_name;
	private Date in_date;
	private String in_user;
	private String in_ip;
	private String down_count;
	
	
	public String getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(String file_idx) {
		this.file_idx = file_idx;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getPa_idx() {
		return pa_idx;
	}
	public void setPa_idx(String pa_idx) {
		this.pa_idx = pa_idx;
	}
	public String getOri_name() {
		return ori_name;
	}
	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}
	public String getSv_name() {
		return sv_name;
	}
	public void setSv_name(String sv_name) {
		this.sv_name = sv_name;
	}
	public Date getIn_date() {
		return in_date;
	}
	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}
	public String getIn_user() {
		return in_user;
	}
	public void setIn_user(String in_user) {
		this.in_user = in_user;
	}
	public String getIn_ip() {
		return in_ip;
	}
	public void setIn_ip(String in_ip) {
		this.in_ip = in_ip;
	}
	public String getDown_count() {
		return down_count;
	}
	public void setDown_count(String down_count) {
		this.down_count = down_count;
	}
}
