# tomcat.multiple.host


```
    <Host name="domain1.com" autoDeploy="true" appBase="webapps/domain1" unpackWARs="true">
        <Alias>www.domain1.com</Alias>
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t "%r" %s %b" resolveHosts="false"/>
        <Context path="" docBase="C:/apache-tomcat-8.5.9/webapps/domain1" reloadable="true"/>
    </Host>

    <Host name="domain2.com" autoDeploy="true" appBase="webapps/domain2" unpackWARs="true">
        <Alias>www.domain2.com</Alias>
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t "%r" %s %b" resolveHosts="false"/>
        <Context path="" docBase="C:/apache-tomcat-8.5.9/webapps/domain2npm " reloadable="true"/>
    </Host>

```


