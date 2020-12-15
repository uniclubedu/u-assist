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

import com.intel.cloud.byoc.model.ResultsTab;

import com.intel.cloud.byoc.service.ResultsTabService;;

@RestController
@RequestMapping(value = "/api/v1/results")
public class ResultsTabController {

	private static final Logger logger = LoggerFactory.getLogger(ResultsTabController.class);

	@Autowired
	private ResultsTabService resultsTabService;

	@GetMapping(value="/getAll" ,produces = {"application/json"})
	public ResponseEntity<List<ResultsTab>> getStorageAllUsers() {
		return new ResponseEntity<>(resultsTabService.getResults(), HttpStatus.OK);
	}

}
