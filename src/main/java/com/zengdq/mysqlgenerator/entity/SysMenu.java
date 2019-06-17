package com.zengdq.mysqlgenerator.entity;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 菜单表
 * </p>
 *
 * @author zengdq
 * @since 2019-06-17
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class SysMenu implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
    * 
    */
    private Integer id;
    /**
    * 菜单名称
    */
    private String menuName;
    /**
    * 菜单URL
    */
    private String menuUrl;
    /**
    * 父级ID
    */
    private Integer paternalId;
    /**
    * 菜单状态 1启用 0禁用
    */
    private String menuState;
    /**
    * 排序
    */
    private Integer sort;
    /**
    * 创建人
    */
    @TableField(fill = FieldFill.INSERT)
    private String createUser;
    /**
    * 创建时间
    */
    private Date createTime;
    /**
    * 更新人
    */
    @TableField(fill = FieldFill.UPDATE)
    private String updateUser;
    /**
    * 更新时间
    */
    private Date updateTime;
}
