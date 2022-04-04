package com.namyang;

import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
//@EnableAspectJAutoProxy
//@EnableBatchProcessing
//@EnableScheduling
public class MigrationBatchApplication {

	public static void main(String[] args) {
		SpringApplication.run(MigrationBatchApplication.class, args);
	}

}
