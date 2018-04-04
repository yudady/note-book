# tomcat.multiple.host


```
    <Host name="domain1.com" autoDeploy="true" appBase="webapps" unpackWARs="true">
        <Alias>www.domain1.com</Alias>
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t "%r" %s %b" resolveHosts="false"/>
        <Context path="" docBase="domain1" debug="0" reloadable="true"/>
    </Host>

    <Host name="domain2.com" autoDeploy="true" appBase="webapps" unpackWARs="true">
        <Alias>www.domain2.com</Alias>
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log." suffix=".txt"
               pattern="%h %l %u %t "%r" %s %b" resolveHosts="false"/>
        <Context path="" docBase="domain2" debug="0" reloadable="true"/>
    </Host>

```


