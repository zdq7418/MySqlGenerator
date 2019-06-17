package com.zengdq.mysqlgenerator.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ResultVO {
    private Integer code;
    private String msg;
    private Long count;
    private Object data;
}
