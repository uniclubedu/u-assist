package com.intel.cloud.byoc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.intel.cloud.byoc.model.CredentialsTab;
import com.intel.cloud.byoc.service.CredentialsTabService;

@RestController
@RequestMapping(value = "/credentials")
public class CredentialsController {
	
	@Autowired
	CredentialsTabService credentialsTabService;
	
	@GetMapping(value = "/getAll" , produces = {"application/json"})
	public ResponseEntity<List<CredentialsTab>> getAll() {
		List<CredentialsTab> credentialsLst = credentialsTabService.getCredentials();
		return new ResponseEntity<>(credentialsLst,
				(credentialsLst != null && credentialsLst.size() > 0) ? HttpStatus.OK : HttpStatus.NO_CONTENT);

	}
}
