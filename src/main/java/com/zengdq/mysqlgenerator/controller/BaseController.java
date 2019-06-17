package com.zengdq.mysqlgenerator.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.zengdq.mysqlgenerator.vo.ResultVO;

import java.util.ArrayList;

/**
 * @description: 公共控制器
 * @author: zengdq
 * @create: 2018-10-25 15:06
 **/
public class BaseController {



    /**
     * @Author zengdq
     * @Description 成功返回值
     * @Date 18:17 2019/5/27
     * @Param
     * @return 
     **/
    protected  String success(Object object, Long count) {
        ResultVO resultVO = new ResultVO();
        resultVO.setData(object);
        resultVO.setCode(0);
        resultVO.setCount(count);
        resultVO.setMsg("成功");
        return JSONUtil.toJsonStr(resultVO);
    }


    protected  String success(Object object) {
        return success(object,0L);
    }

    protected  String  success() {
        return success(null,null);
    }

    /**
     * @Author zengdq
     * @Description 失败返回值
     * @Date 18:18 2019/5/27
     * @Param
     * @return
     **/
    protected  String error(Integer code, String msg) {
        ResultVO resultVO = new ResultVO();
        resultVO.setCode(code);
        resultVO.setMsg(msg);
        return JSONUtil.toJsonStr(resultVO);
    }


}
