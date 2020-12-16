package com.intel.cloud.byoc.Application;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.intel.cloud.byoc.model.CredentialsTab;
import com.intel.cloud.byoc.model.ProfileTab;
import com.intel.cloud.byoc.model.QuotaTab;
import com.intel.cloud.byoc.service.CredentialsTabService;
import com.intel.cloud.byoc.service.ProfileTabService;
import com.intel.cloud.byoc.service.QuotaTabService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ByocApplicationTest {
	
	private static final Logger LOGGER= LoggerFactory.getLogger(ByocApplicationTest.class);
	
	@Autowired
	ProfileTabService profileTabService;
	
	@Autowired
	CredentialsTabService credentialsTabService;
	
	@Autowired
	QuotaTabService quotaTabService;

	@Test
	public void contextLoads() {
	}
	
	@Test
	public void testGetProfile() {
		List<ProfileTab> profileLst = profileTabService.getProfile();
		LOGGER.info("profileLst: {}", profileLst);
		
	}
	
	@Test
	public void testGetCredentials() {
		List<CredentialsTab> credentialsLst = credentialsTabService.getCredentials();
		LOGGER.info("credentialsLst: {}", credentialsLst);
		
	}

	
	@Test
	public void testGetQuota(){
		List<QuotaTab> quotaLst = quotaTabService.getQuota();
		LOGGER.info("quotaLst: {}", quotaLst);
		
	}
}
