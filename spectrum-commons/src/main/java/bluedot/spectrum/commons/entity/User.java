package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * User -> user
 * 2018-01-21
 */
public class User {
    /**
     * 用户id
     */
    private Long userId;

    /**
     * 用户真实姓名
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    /**
     * 进行加密的盐值
     */
    private String salt;

    /**
     * 非普通用户必填，以后不可修改(申请角色是必填)
     */
    private String idcard;

    /**
     * 手机号
     */
    private String phoneNumber;

    /**
     * 邮箱（根据邮箱登录）
     */
    private String email;

    /**
     * 生日(选填)
     */
    private Date birthday;

    /**
     * 1:男，0：女
     */
    private Integer sex;

    /**
     * 用户头像路径
     */
    private String photoUrl;

    /**
     * 个人地址（选填，申请完善）
     */
    private String personAddress;

    /**
     * 工作地址（选填，申请完善）
     */
    private String workAddress;

    /**
     * 账号状态(正常在线对应1,正常离线对应2,冻结对应0)
     */
    private Integer status;

    /**
     * 普通用户对应1 操作人员对应2 实验人员对应3 普通管理员对应4超级管理员对应5
     */
    private Long roleId;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getPersonAddress() {
        return personAddress;
    }

    public void setPersonAddress(String personAddress) {
        this.personAddress = personAddress;
    }

    public String getWorkAddress() {
        return workAddress;
    }

    public void setWorkAddress(String workAddress) {
        this.workAddress = workAddress;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", salt=" + salt
				+ ", idcard=" + idcard + ", phoneNumber=" + phoneNumber + ", email=" + email + ", birthday=" + birthday
				+ ", sex=" + sex + ", photoUrl=" + photoUrl + ", personAddress=" + personAddress + ", workAddress="
				+ workAddress + ", status=" + status + ", roleId=" + roleId + "]";
	}
    
}