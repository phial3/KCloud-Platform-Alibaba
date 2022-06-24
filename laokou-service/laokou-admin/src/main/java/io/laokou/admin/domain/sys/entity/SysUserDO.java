package io.laokou.admin.domain.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.laokou.common.entity.BaseDO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 用户管理
 * @author  Kou Shenhai
 */
@Data
@TableName("boot_sys_user")
public class SysUserDO extends BaseDO implements Serializable {

    @NotBlank(message = "{sys.user.password.require}")
    @ApiModelProperty(value = "密码",name = "password",required = true,example = "123456")
    @Length(min = 6, max = 18, message = "密码长度必须在 {min} - {max} 之间")
    @TableField("password")
    private String password;

    /**
     * 用户名
     */
    @NotBlank(message = "{sys.user.username.require}")
    @ApiModelProperty(value = "用户名",name = "username",required = true,example = "admin")
    @TableField("username")
    private String username;

    /**
     * 超级管理员 0：否 1：是
     */
    @ApiModelProperty(value = "超级管理员 0：否 1：是",name = "superAdmin",example = "1")
    @TableField("super_admin")
    @JsonProperty("superAdmin")
    private Integer superAdmin;

    /**
     * 头像url
     */
    @ApiModelProperty(value = "头像url",name = "imgUrl",example = "https://pic.cnblogs.com/avatar/simple_avatar.gif")
    @TableField("img_url")
    @JsonProperty("imgUrl")
    private String imgUrl;

    /**
     * 电子邮箱
     */
    @ApiModelProperty(value = "电子邮箱",name = "email",example = "2413176044@qq.com")
    @TableField("email")
    @JsonProperty("email")
    private String email;

    /**
     * 状态 0停用 1正常
     */
    @ApiModelProperty(value = "状态 0停用 1正常",name = "status",example = "1")
    @TableField("status")
    @JsonProperty("status")
    private Integer status;

    /**
     * 手机号
     */
    @ApiModelProperty(value = "手机号",name = "mobile",example = "18974432576")
    @TableField("mobile")
    @JsonProperty("mobile")
    private String mobile;

    /**
     * 支付宝唯一用户标识
     */
    @ApiModelProperty(value = "支付宝唯一用户标识",name = "zfbOpenid",example = "2088722720196501")
    @TableField("zfb_openid")
    @JsonProperty("zfbOpenid")
    private String zfbOpenid;

}