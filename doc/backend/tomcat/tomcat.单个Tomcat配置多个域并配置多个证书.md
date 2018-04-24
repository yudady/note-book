 # 单个Tomcat配置多个域并配置多个证书
 
一个Tomcat运行两个应用，分别对应两个域名： www.domain1.com 和 www.domain2.cn ，对于http协议（80端口），只要配置Tomcat的虚拟主机就可以了。

      但朋友为了数据的安全性，分别为每个域名购买了一个CA证书。这就要求在一个Tomcat上配置两个证书。在网上搜了好久，没见有相同的案例。只查到有人说了两种办法：

一、两个域名使用不同的HTTPS端口，比如：www.domain1.com使用443端口，www.domain2.cn 使用8443端口，这种方式对于测试可以，但用于生产环境，要求普通用户在输入地址时还要输入端口8443，不方便不说，有些用户还不懂。所以这种方案只能暂时放弃。

二、使用两个公网IP，每个域名对应一个IP，这样就可以使每个域名都使用443作为HTTPS的端口，方便用户使用。但没有查到实际的配置案例。

      既然没有案例，那就自己动手，开始尝试。经过N次尝试之后，终于配置成功。为了防止忘记，也为了方便别人，把配置文件贴出来。为了减少篇幅，把大部分注释删除了。



```
<?xml version="1.0" encoding="UTF-8"?>

<Server port="8005" shutdown="SHUTDOWN">

    <!-- Comment these entries out to disable JMX MBeans support used for the administration web application -->
    <Listener className="org.apache.catalina.core.AprLifecycleListener"/>
    <Listener className="org.apache.catalina.mbeans.ServerLifecycleListener"/>
    <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener"/>
    <Listener className="org.apache.catalina.storeconfig.StoreConfigLifecycleListener"/>

    <!-- Global JNDI resources -->
    <GlobalNamingResources>

        <!-- Test entry for demonstration purposes -->
        <Environment name="simpleValue" type="java.lang.Integer" value="30"/>

        <!-- Editable user database that can also be used by  
             UserDatabaseRealm to authenticate users -->
        <Resource name="UserDatabase" auth="Container"
                  type="org.apache.catalina.UserDatabase"
                  description="User database that can be updated and saved"
                  factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                  pathname="conf/tomcat-users.xml"/>

    </GlobalNamingResources>

    <!-- Define the Tomcat Stand-Alone Service -->
    <Service name="Catalina">

        <!-- Define a non-SSL HTTP/1.1 Connector on port 80 -->
        <Connector port="80" maxHttpHeaderSize="8192"
                   maxThreads="150" minSpareThreads="25" maxSpareThreads="75"
                   enableLookups="false" redirectPort="8443" acceptCount="100"
                   connectionTimeout="20000" disableUploadTimeout="true"/>

        <!-- Define a SSL HTTP/1.1 Connector on port 443 -->
        <Connector port="443" maxHttpHeaderSize="8192"
                   maxThreads="150" minSpareThreads="25" maxSpareThreads="75"
                   enableLookups="false" disableUploadTimeout="true"
                   acceptCount="100" scheme="https" secure="true"
                   clientAuth="false" sslProtocol="TLS"
                   keystoreFile="D:/certs/mydomain1.com_keystore.jks" keystorePass="www.mydomain1.com"
                   keystoreType="JKS"
                   truststoreFile="D:/certs/mydomain1.com_keystore.jks" truststorePass="www.mydomain1.com"
                   truststoreType="JKS"
                   address="xxx.xxx.2.83"
        />

        <Connector port="443" maxHttpHeaderSize="8192"
                   maxThreads="150" minSpareThreads="25" maxSpareThreads="75"
                   enableLookups="false" disableUploadTimeout="true"
                   acceptCount="100" scheme="https" secure="true"
                   clientAuth="false" sslProtocol="TLS"
                   keystoreFile="D:/certs/mydomain2.cn_keystore.jks" keystorePass="www.mydomain2.cn"
                   keystoreType="JKS"
                   truststoreFile="D:/certs/mydomain2.cn_keystore.jks" truststorePass="www.mydomain2.cn"
                   truststoreType="JKS"
                   address="xxx.xxx.2.81"
        />

        <!-- Define an AJP 1.3 Connector on port 8009 -->
        <Connector port="8009" enableLookups="false" redirectPort="8443" protocol="AJP/1.3"/>

        <!-- Define the top level container in our container hierarchy -->
        <Engine name="Catalina" defaultHost="localhost">

            <!-- This Realm uses the UserDatabase configured in the global JNDI  
                 resources under the key "UserDatabase".  Any edits  
                 that are performed against this UserDatabase are immediately  
                 available for use by the Realm.  -->
            <Realm className="org.apache.catalina.realm.UserDatabaseRealm" resourceName="UserDatabase"/>

            <!-- Define the default virtual host  
                 Note: XML Schema validation will not work with Xerces 2.2.  
             -->
            <Host name="localhost" appBase="webapps" unpackWARs="true" autoDeploy="true" xmlValidation="false"
                  xmlNamespaceAware="false">
            </Host>

            <Host name="xxx.xxx.2.81" appBase="D:/mydomain2/webapp" unpackWARs="true" autoDeploy="true"
                  xmlValidation="false" xmlNamespaceAware="false">
                <Alias>mydomain2.cn</Alias>
                <Alias>www.mydomain2.cn</Alias>
            </Host>

            <Host name="xxx.xxx.2.83" appBase="D:/mydomain1/webapp" unpackWARs="true" autoDeploy="true"
                  xmlValidation="false" xmlNamespaceAware="false">
                <Alias>mydomain1.com</Alias>
                <Alias>tax.mydomain1.com</Alias>
                <Alias>www.mydomain1.com</Alias>
                <Alias>www.mydomain1.cn</Alias>
                <Alias>mydomain1.cn</Alias>
            </Host>


        </Engine>

    </Service>

</Server> 
```

 注意两个Port="443"的Connector配置，最后面的address参数是关键，如果不加address，那么Tomcat将会报错，说443端口已被使用。其他的配置信息，网络上都能找到例子或说明，就不多做说明了。