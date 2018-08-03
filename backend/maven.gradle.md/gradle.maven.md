# maven VS gradle

## gradle --> maven

build.gradle

```
apply plugin: 'maven'

group = 'com.company.root'
// artifactId is taken by default, from folder name
version = '0.0.1-SNAPSHOT'

task writeNewPom << {
    pom {
        project {
        }
    }.writeTo("pom.xml")
}
```


> gradle writeNewPom

## maven --> gradle

先保证本机安装了gradle 2.0以上的版本

然后在maven根目录下运行

gradle init --type pom