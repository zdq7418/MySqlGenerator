package ${package.Entity};

<#list table.importPackages as pkg>
import ${pkg};
</#list>
import java.util.Date;
import com.baomidou.mybatisplus.annotation.*;
<#if entityLombokModel>
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
</#if>

/**
 * <p>
 * ${table.comment!}
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if entityLombokModel>
@Data
    <#if superEntityClass??>
@EqualsAndHashCode(callSuper = true)
    <#else>
@EqualsAndHashCode(callSuper = false)
    </#if>
@Accessors(chain = true)
</#if>
<#if table.convert>
@TableName("${table.name}")
</#if>
public class ${entity} implements Serializable {

    private static final long serialVersionUID = 1L;
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    /**
    * ${field.comment!}
    */
    <#if field.keyFlag>
    <#-- 主键 -->
        <#if field.keyIdentityFlag>
    @TableId(value = "${field.name}", type = IdType.AUTO)
        <#elseif idType??>
    @TableId(value = "${field.name}", type = IdType.${idType})
        <#elseif field.convert>
    @TableId("${field.name}")
        </#if>
    <#elseif field.convert>
        @TableField("${field.name}")
    </#if>
    <#if field.propertyName=="createUser">
    @TableField(fill = FieldFill.INSERT)
    </#if>
    <#if field.propertyName=="updateUser">
    @TableField(fill = FieldFill.UPDATE)
    </#if>
    <#if field.propertyName=="isDel">
    @TableLogic
    </#if>
    private <#if field.propertyType=="LocalDateTime">Date<#else>${field.propertyType}</#if> ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->
}
