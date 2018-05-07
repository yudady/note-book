# Tomcat的目錄文件列表顯示功能

更改tomcat\conf\web.xml文件

```
<servlet> 
    <servlet-name>default</servlet-name> 
    <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class> 
    <init-param> 
        <param-name>debug</param- name> 
        <param-value>0</param-value> 
    </init-param> 
    <init-param> 
        <param-name> listings </param-name> 
        <param-value> false </param-value> 
    < /init-param> 
    <load-on-startup>1</load-on-startup> 
</servlet>
```


true表示文件目錄列表打開

false表示文件目錄列表關閉



設置成true後瀏覽器中輸入應用文件夾（不到具體文件）會顯示成目錄

false（不到具體文件）不會顯示















