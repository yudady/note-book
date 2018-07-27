package com.tommy.springboot.dynamic;

import java.util.Iterator;
import java.util.Map;
import java.util.Objects;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.tommy.springboot.App;

@Component
public class DynamicRegisterBean2SpringContainer {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public static String getCamelCase(Class clazz) {
		return clazz.getSimpleName().substring(0, 1).toLowerCase() + clazz.getSimpleName().substring(1);
	}

	public void dynamicCreateBeanByValue(Class clazz, Map<String, Object> propertyValue) {
		dynamicCreateBean(clazz, propertyValue, null);
	}

	public void dynamicCreateBeanByReference(Class clazz,Map<String, String> propertyReference) {
		dynamicCreateBean(clazz, null, propertyReference);
	}

	public void dynamicCreateBean(Class clazz, Map<String, Object> propertyValue,
		Map<String, String> propertyReference) {

		// 获取context.
		ApplicationContext ctx = App.getContext();

		// 获取BeanFactory
		DefaultListableBeanFactory defaultListableBeanFactory = (DefaultListableBeanFactory) ctx
			.getAutowireCapableBeanFactory();

		// 创建bean信息.
		BeanDefinitionBuilder beanDefinitionBuilder = BeanDefinitionBuilder.genericBeanDefinition(clazz);

		if (Objects.nonNull(propertyValue)) {
			Iterator<Map.Entry<String, Object>> iterator = propertyValue.entrySet().iterator();
			while (iterator.hasNext()) {
				Map.Entry<String, Object> pair = iterator.next();
				String key = pair.getKey();
				Object value = pair.getValue();

				// addPropertyValue
				beanDefinitionBuilder.addPropertyValue(key, value);
			}

		}

		if (Objects.nonNull(propertyReference)) {
			Iterator<Map.Entry<String, String>> iterator = propertyReference.entrySet().iterator();
			while (iterator.hasNext()) {
				Map.Entry<String, String> pair = iterator.next();
				String key = pair.getKey();
				String value = pair.getValue();

				// addPropertyReference
				beanDefinitionBuilder.addPropertyReference(key, value);
			}

		}

		// 动态注册bean.
		defaultListableBeanFactory.registerBeanDefinition(getCamelCase(clazz),
			beanDefinitionBuilder.getBeanDefinition());

	}

	public void dynamicDeleteBean(Class clazz) {
		// 获取context
		ApplicationContext ctx = App.getContext();

		// 获取BeanFactory
		DefaultListableBeanFactory defaultListableBeanFactory = (DefaultListableBeanFactory) ctx
			.getAutowireCapableBeanFactory();

		// 删除bean.
		defaultListableBeanFactory.removeBeanDefinition(getCamelCase(clazz));
	}

}
