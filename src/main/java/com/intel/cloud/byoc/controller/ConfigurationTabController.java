package com.intel.cloud.byoc.controller;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.intel.cloud.byoc.model.ConfigurationTab;
import com.intel.cloud.byoc.service.ConfigurationTabService;

@RestController
@RequestMapping(value = "/api/v1/configurations")
public class ConfigurationTabController {

	private static final Logger logger = LoggerFactory.getLogger(ConfigurationTabController.class);

	@Autowired
	private ConfigurationTabService configurationTabService;

	@GetMapping("/getAll")
	public ResponseEntity<List<ConfigurationTab>> getAllConfiguration() {
		return new ResponseEntity<>(configurationTabService.getConfiguration(), HttpStatus.OK);
	}

}
