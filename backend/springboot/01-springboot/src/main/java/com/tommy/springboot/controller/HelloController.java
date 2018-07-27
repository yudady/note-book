package com.tommy.springboot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tommy.mybatis.model.PyCust;
import com.tommy.springboot.App;
import com.tommy.springboot.dynamic.DynamicRegisterBean2SpringContainer;
import com.tommy.springboot.service.mypaycenter.CenterCustService;
import com.tommy.springboot.service.rd.RdCustService;
import com.tommy.springboot.test.User;
import com.tommy.springboot.test.UserService;

@Controller
public class HelloController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CenterCustService centerCustService;

	@Autowired
	private RdCustService rdCustService;

	@Autowired
	DynamicRegisterBean2SpringContainer dynamicRegisterBean2SpringContainer;

	@RequestMapping(value = "/")
	public @ResponseBody String index() {
		logger.debug("HelloController");

		{
			List<PyCust> pyCusts = centerCustService.selectAll();
			pyCusts.stream().forEach(e -> logger.debug(ToStringBuilder.reflectionToString(e)));
			logger.warn("centerCustService	" + pyCusts.size());
		}
		logger.debug("--------------");
		logger.debug("--------------");
		logger.debug("--------------");
		logger.debug("--------------");
		logger.debug("--------------");
		{
			List<PyCust> pyCusts = rdCustService.selectAll();
			pyCusts.stream().forEach(e -> logger.debug(ToStringBuilder.reflectionToString(e)));
			logger.warn("rdCustService   " + pyCusts.size());
		}

		return "123123";
	}

	public @ResponseBody String index23423423() {

		{
			Map<String, Object> propertyValue = new HashMap<>();
			propertyValue.put("name", "张三");
			dynamicRegisterBean2SpringContainer.dynamicCreateBeanByValue(User.class, propertyValue);
		}

		{

			Map<String, String> propertyReference = new HashMap<>();
			propertyReference.put("user", "user");
			dynamicRegisterBean2SpringContainer.dynamicCreateBeanByReference(UserService.class,
				propertyReference);
		}

		System.out.println("index");
		ConfigurableApplicationContext ctx = App.getContext();
		// 获取动态注册的bean.

		System.out.println("user . " + ctx.containsBean("user"));
		System.out.println("userService . " + ctx.containsBean("userService"));
		User testService = (User) ctx.getBean("user");
		testService.print();

		//
		dynamicRegisterBean2SpringContainer.dynamicDeleteBean(User.class);

		System.out.println(ctx.containsBean("user"));

		return "123";
	}
}
