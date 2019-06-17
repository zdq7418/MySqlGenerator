package com.zengdq.mysqlgenerator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(basePackages="com.zengdq.mysqlgenerator.mapper")
@SpringBootApplication
public class MySqlGeneratorApplication {

    public static void main(String[] args) {
        SpringApplication.run(MySqlGeneratorApplication.class, args);
    }

}
