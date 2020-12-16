package com.intel.cloud.byoc.Application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication(scanBasePackages="com.intel.cloud.byoc")
@EnableJpaRepositories("com.intel.cloud.byoc.repository")
@EntityScan("com.intel.cloud.byoc.model")
@EnableSwagger2
public class ByocApplication {

	public static void main(String[] args) {
		SpringApplication.run(ByocApplication.class, args);
	}

}
