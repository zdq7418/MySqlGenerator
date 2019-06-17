package ${package.Controller};


import org.springframework.web.bind.annotation.RequestMapping;
import javax.annotation.Resource;
import com.zengdq.mysqlgenerator.service.${table.serviceName};
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zengdq.mysqlgenerator.dto.${entity}Dto;
import com.zengdq.mysqlgenerator.entity.${entity};
import cn.hutool.core.util.StrUtil;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("${entity?uncap_first}")
public class ${table.controllerName} extends BaseController {
   @Resource
   private ${table.serviceName} ${(table.serviceName?substring(1))?uncap_first};
    /**
    * @Author ${author}
    * @Description ${table.comment!}页面
    * @Date ${date}
    * @Param
    * @return
    **/
    @RequestMapping("index")
    public String index(){
      return "${entity}/index";
    }

   /**
   * @Author ${author}
   * @Description 查询${table.comment!}
   * @Date ${date}
   * @Param
   * @return
   **/
   @RequestMapping("list")
   @ResponseBody
   public String list(${entity}Dto ${entity?uncap_first}Dto){
     Page<${entity}> page=new Page<>(${entity?uncap_first}Dto.getPage(),${entity?uncap_first}Dto.getLimit());
     QueryWrapper<${entity}> queryWrapper=new QueryWrapper<>();
     <#list table.fields as field>
      <#if !field.propertyName?contains("Time") && !field.propertyName?contains("User") && !field.propertyName?contains("id")>
       <#if field.propertyType=="String">
     if (StrUtil.isNotBlank(${entity?uncap_first}Dto.get${field.propertyName?cap_first}())){
         queryWrapper.like("${field.propertyName?replace("([a-z])([A-Z]+)","$1_$2","r")?lower_case}",${entity?uncap_first}Dto.get${field.propertyName?cap_first}());
     }
       </#if>
       <#if field.propertyType=="Integer">
     if (${entity?uncap_first}Dto.get${field.propertyName?cap_first}()!=null){
         queryWrapper.eq("${field.propertyName?replace("([a-z])([A-Z]+)","$1_$2","r")?lower_case}",${entity?uncap_first}Dto.get${field.propertyName?cap_first}());
     }
       </#if>
      </#if>
     </#list>
     queryWrapper.orderByDesc("create_time");
     IPage<${entity}> list=${(table.serviceName?substring(1))?uncap_first}.page(page,queryWrapper);
     return success(list.getRecords(),list.getTotal());
   }

   /**
   * @Author ${author}
   * @Description 新增或者修改
   * @Date ${date}
   * @Param
   * @return
   **/
   @RequestMapping("saveOrUpdate")
   @ResponseBody
   public String saveOrUpdate(${entity} ${entity?uncap_first}){
    ${(table.serviceName?substring(1))?uncap_first}.saveOrUpdate(${entity?uncap_first});
    return success();
   }

   /**
   * @Author ${author}
   * @Description 删除
   * @Date ${date}
   * @Param
   * @return
   **/
   @RequestMapping("del")
   @ResponseBody
   public String del(${entity} ${entity?uncap_first}){
    ${(table.serviceName?substring(1))?uncap_first}.removeById(${entity?uncap_first}.getId());
    return success();
   }
}
