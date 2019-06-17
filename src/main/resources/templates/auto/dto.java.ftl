package com.zengdq.mysqlgenerator.dto;

<#list table.importPackages as pkg>
import ${pkg};
</#list>
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
public class ${entity}Dto extends BaseDto implements Serializable {

    private static final long serialVersionUID = 1L;
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.propertyName!="deleted">
        /**
        * ${field.comment!}
        */
        private <#if field.propertyType=="LocalDateTime">String<#else>${field.propertyType}</#if> ${field.propertyName};
    </#if>
</#list>
<#------------  END 字段循环遍历  ---------->
}
