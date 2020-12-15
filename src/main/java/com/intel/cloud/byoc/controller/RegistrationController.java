package com.intel.cloud.byoc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.intel.cloud.byoc.model.RegistrationTab;
import com.intel.cloud.byoc.service.RegistrationTabService;

@RestController
@RequestMapping(value = "/registration")
public class RegistrationController {
	
	@Autowired
	RegistrationTabService registrationTabService;

	@GetMapping(value = "/getAll" , produces = {"application/json"})
	public ResponseEntity<List<RegistrationTab>> getAll(){
		return new ResponseEntity<>(registrationTabService.getRegistration(),HttpStatus.OK);
	}
}
