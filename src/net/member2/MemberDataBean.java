package net.member2;

public class MemberDataBean {
	private String id;
	private String passwd;
	private String mname;
	private String email;
	private String zipcode;
	private String job; 
	private String address1;
	private String address2;
	private String mlevel;
	private String mdate;
	
	
	//기본생성자
	public MemberDataBean() {	}

	//getter, setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getMlevel() {
		return mlevel;
	}
	public void setMlevel(String mlevel) {
		this.mlevel = mlevel;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}	
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	//toString()
	@Override
	public String toString() {
		return "MemberDataBean [id=" + id + ", passwd=" + passwd + ", mname=" + mname + ",  email="
				+ email + ", zipcode=" + zipcode + ", job=" + job + ", address1=" + address1 + ", address2=" + address2
				+ ", mlevel=" + mlevel + ", mdate=" + mdate + "]";
	}	
	
}//class end
