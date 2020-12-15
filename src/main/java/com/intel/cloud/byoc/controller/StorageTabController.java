package com.intel.cloud.byoc.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.intel.cloud.byoc.model.StorageTab;
import com.intel.cloud.byoc.service.StorageTabService;

@RestController
@RequestMapping(value = "/api/v1/storages")
public class StorageTabController {

	private static final Logger logger = LoggerFactory.getLogger(StorageTabController.class);
	
	@Autowired
	private StorageTabService storageTabService;

	@PostMapping("/")
	public ResponseEntity<StorageTab> saveStorage(@RequestBody StorageTab storageTab) {
		logger.info("create request for Storage Tag user id := " + storageTab.getUserId());
		storageTabService.saveStorage(storageTab);
		return new ResponseEntity<>(storageTab, HttpStatus.CREATED);
	}

	@GetMapping("/{userid}")
	public ResponseEntity<StorageTab> getStorageUserId(@PathVariable int userid) {
		logger.info("getting user id := " + userid);
		StorageTab storageTab = storageTabService.finByuserId(userid);
		return new ResponseEntity<>(storageTab, HttpStatus.OK);
	}

	@GetMapping("/getAll")
	public ResponseEntity<List<StorageTab>> getStorageAllUsers() {
		return new ResponseEntity<>(storageTabService.getStorage(), HttpStatus.OK);
	}

}
