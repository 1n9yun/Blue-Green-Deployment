# Blue-Green-Deployment

Example of Blue-Green Deployment with Docker, Nginx, Jenkins  
    
## Docker 구성

|Container|Port|Image|
|---------|----|-----|
|nginx|80:80|nginx:latest|
|api-server_blue|8081:8080|./api-server|
|api-server_green|8082:8080|./api-server|

## nginx Configuration

```nginx
#! /etc/nginx/nginx.conf

user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {

    upstream backend{
        least_conn;
        server 127.0.0.1:8081 weight=10 max_fails=3 fail_timeout=10s;
        server 127.0.0.1:8082 weight=10 max_fails=3 fail_timeout=10s;
    }

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        # include /etc/nginx/default.d/*.conf;

        location / {
                proxy_pass http://backend;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
        }
    }
}
```

## Test

### Request

지속적으로 버전을 확인하는 요청을 서버로 보낸다.

```python
from time import sleep
import requests

URI = 'http://localhost/ver'

while True:
    response = requests.get(URI)
    print(response.text)
    sleep(0.5)
```

### Backend

`my-server.property.version`을 업데이트하여 `push`하면 새 버전으로 빌드한 `Green Server`를 올리게 된다.  
그럼 이제 파이썬으로 보낸 요청의 응답이 기존 `version`에서 새 `version`으로 바뀌고, 그 과정에서 실패하는 요청이 없기를 기대한다.

```java
@RestController
public class VersionController {

    @Value("${my-server.property.version}")
    private Integer serverVersion;

    @GetMapping("/ver")
    public int getVersion(){
        return this.serverVersion;
    }

}
```