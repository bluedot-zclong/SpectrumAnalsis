package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * RoleFunction -> role_function
 * 2018-01-21
 */
public class RoleFunction {
    private Long roleFunctionId;

    /**
     * 角色编号
     */
    private Long roleId;

    /**
     * 功能编号
     */
    private Long functionId;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getRoleFunctionId() {
        return roleFunctionId;
    }

    public void setRoleFunctionId(Long roleFunctionId) {
        this.roleFunctionId = roleFunctionId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getFunctionId() {
        return functionId;
    }

    public void setFunctionId(Long functionId) {
        this.functionId = functionId;
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
}