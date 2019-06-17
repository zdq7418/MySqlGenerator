package com.zengdq.mysqlgenerator.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @Description: 公共请求类
 * @Author: zengdq
 * @Date: 18:20 2019/5/27
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class BaseDto {
    /**
     * //layui默认分页参数 第几页
     */
    private Integer page;
    /**
     * //layui默认分页参数 一页多少条
     */
    private Integer limit;
}
