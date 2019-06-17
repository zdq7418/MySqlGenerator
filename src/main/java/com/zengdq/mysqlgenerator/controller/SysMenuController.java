package com.zengdq.mysqlgenerator.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import javax.annotation.Resource;
import com.zengdq.mysqlgenerator.service.ISysMenuService;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zengdq.mysqlgenerator.dto.SysMenuDto;
import com.zengdq.mysqlgenerator.entity.SysMenu;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Controller;

/**
 * <p>
 * 菜单表 前端控制器
 * </p>
 *
 * @author zengdq
 * @since 2019-06-17
 */
@Controller
@RequestMapping("sysMenu")
public class SysMenuController extends BaseController {
   @Resource
   private ISysMenuService sysMenuService;
    /**
    * @Author zengdq
    * @Description 菜单表页面
    * @Date 2019-06-17
    * @Param
    * @return
    **/
    @RequestMapping("index")
    public String index(){
      return "SysMenu/index";
    }

   /**
   * @Author zengdq
   * @Description 查询菜单表
   * @Date 2019-06-17
   * @Param
   * @return
   **/
   @RequestMapping("list")
   @ResponseBody
   public String list(SysMenuDto sysMenuDto){
     Page<SysMenu> page=new Page<>(sysMenuDto.getPage(),sysMenuDto.getLimit());
     QueryWrapper<SysMenu> queryWrapper=new QueryWrapper<>();
     if (StrUtil.isNotBlank(sysMenuDto.getMenuName())){
         queryWrapper.like("menu_name",sysMenuDto.getMenuName());
     }
     if (StrUtil.isNotBlank(sysMenuDto.getMenuUrl())){
         queryWrapper.like("menu_url",sysMenuDto.getMenuUrl());
     }
     if (sysMenuDto.getPaternalId()!=null){
         queryWrapper.eq("paternal_id",sysMenuDto.getPaternalId());
     }
     if (StrUtil.isNotBlank(sysMenuDto.getMenuState())){
         queryWrapper.like("menu_state",sysMenuDto.getMenuState());
     }
     if (sysMenuDto.getSort()!=null){
         queryWrapper.eq("sort",sysMenuDto.getSort());
     }
     queryWrapper.orderByDesc("create_time");
     IPage<SysMenu> list=sysMenuService.page(page,queryWrapper);
     return success(list.getRecords(),list.getTotal());
   }

   /**
   * @Author zengdq
   * @Description 新增或者修改
   * @Date 2019-06-17
   * @Param
   * @return
   **/
   @RequestMapping("saveOrUpdate")
   @ResponseBody
   public String saveOrUpdate(SysMenu sysMenu){
    sysMenuService.saveOrUpdate(sysMenu);
    return success();
   }

   /**
   * @Author zengdq
   * @Description 删除
   * @Date 2019-06-17
   * @Param
   * @return
   **/
   @RequestMapping("del")
   @ResponseBody
   public String del(SysMenu sysMenu){
    sysMenuService.removeById(sysMenu.getId());
    return success();
   }
}
