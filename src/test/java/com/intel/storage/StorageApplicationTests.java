package com.intel.storage;

import com.intel.common.request.Access;
import com.intel.common.util.JwtTokenUtil;
import com.intel.storage.model.StorageDTO;
import com.intel.storage.service.StorageService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.HashMap;
import java.util.Map;

/**
 * @author arpallet
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class StorageApplicationTests {

	private static final Logger LOGGER= LoggerFactory.getLogger(StorageApplicationTests.class);

	@MockBean
	StorageService storageService;

	@Autowired
	private MockMvc mockMvc;

	@Test
	public void testAllotStorage() throws Exception {
		String accessToken = generateToken();
		Mockito.when(storageService.allotStorage(Mockito.anyInt())).thenReturn(true);
		RequestBuilder requestBuilder = MockMvcRequestBuilders.post("/api/v1/storage/allot")
				.header("Authorization", "Bearer " + accessToken).accept(MediaType.APPLICATION_JSON);
		MvcResult result = mockMvc.perform(requestBuilder).andReturn();
		//Assert.assertEquals(true, result.getResponse());

	}


	@Test
	public void testGetPV() throws Exception {
		String accessToken = generateToken();
		String pvName = "test123";
		StorageDTO storageDTO = new StorageDTO();
		storageDTO.setPvName(pvName);
		storageDTO.setPvcName(pvName);
		Mockito.when(storageService.getPV(Mockito.anyInt())).thenReturn(storageDTO);
		RequestBuilder requestBuilder = MockMvcRequestBuilders.get("/api/v1/storage/pv")
				.header("Authorization", "Bearer " + accessToken).accept(MediaType.APPLICATION_JSON);
		MvcResult result = mockMvc.perform(requestBuilder).andReturn();
		//Assert.assertEquals(pvName, result.getResponse());

	}

	private static String generateToken() {
		Map<String, Object> claims = new HashMap<>();
		Access access = new Access();
		access.setRole("Admin");
		String[] privileges = new String[] { "READ", "WRITE" };
		access.setPrivileges(privileges);
		Access[] accessArr = new Access[] { access };
		claims.put("userId", "1");
		claims.put("userName", "JwtUser");
		claims.put("access", accessArr);
		claims.put("accountExpiry", "2022-12-31");
		return JwtTokenUtil.doGenerateToken(claims, "JwtUser");
	}

}
