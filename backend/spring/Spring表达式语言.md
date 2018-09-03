# Spring表达式语言


[Spring 5 官方文档 表达式语言](http://ifeve.com/spring-6-spel/)

[Spring 表达式语言 (SpEL)](http://itmyhome.com/spring/expressions.html)



## bean引用

```
ExpressionParser parser = new SpelExpressionParser();
StandardEvaluationContext context = new StandardEvaluationContext();
context.setBeanResolver(new MyBeanResolver());

// This will end up calling resolve(context,"foo") on MyBeanResolver during evaluation
Object bean = parser.parseExpression("@foo").getValue(context);
```



