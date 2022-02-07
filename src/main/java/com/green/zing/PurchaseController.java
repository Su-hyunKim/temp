package com.green.zing;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;

import service.PurchaseService;

@Controller
public class PurchaseController {
	
	@Autowired
	PurchaseService service;
	@Autowired
	PasswordEncoder passwordEncoder;
}
