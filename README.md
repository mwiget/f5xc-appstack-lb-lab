# f5xc-appstack-lb-lab

Deploy webserver on existing 3-node app stack site and use it as origin for
public load balancer (via RE) and via public custom VIP.

```
+----------+    |
| master-0 |----|
+----------+    |
+----------+    |   customVIP
| master-1 |----| 94.231.81.88
+----------+    |
+----------+    |-----------------{ Internet }
| master-1 |----|
+----------+    |
```    

- Load Balancer 1: http://mwlb.mwlabs.net [94.231.81.88]
- Load Balancer 2: https://mwlb.adn-qs.helloclouds.app

Origin pool: ghcr.io/mwiget/webserver deployment with replicas set to 1 on App stack site marcel-colo.

```
$ kubectl get pods -o wide -n mwlb
NAME                         READY   STATUS    RESTARTS   AGE   IP           NODE    NOMINATED NODE   READINESS GATES
webserver-655d985599-r8rd9   2/2     Running   0          21h   10.1.2.112   xeon1   <none>           <none>

$ kubectl get services -n mwlb
NAME        TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
webserver   ClusterIP   10.3.1.42    <none>        8080/TCP   21h
```

```
$ curl mwlb.mwlabs.net

<style type="text/css">
 <!--
 body {
  color: white;
  background-image: url(panorama.jpg);
  background-repeat: no-repeat;
  background-size: cover;
 }
 -->
</style>
<html>
<h1><p style="color:white;">f5-xc-lb-webserver</p></h1>
<a href="https://github.com/mwiget/f5-xc-lb-webserver">https://github.com/mwiget/f5-xc-lb-webserver</a>
<p><pre>
{
  "ip": "94.231.81.90",
  "city": "Zürich",
  "region": "Zurich",
  "country": "CH",
  "loc": "47.3667,8.5500",
  "org": "AS48971 DATAWIRE AG",
  "postal": "8000",
  "timezone": "Europe/Zurich",
  "readme": "https://ipinfo.io/missingauth"
}<p>
KUBERNETES_PORT=tcp://10.3.0.1:443
KUBERNETES_SERVICE_PORT=443
WEBSERVER_PORT_8080_TCP_ADDR=10.3.1.42
WEBSERVER_SERVICE_HOST=10.3.1.42
HOSTNAME=webserver-655d985599-r8rd9
WEBSERVER_PORT_8080_TCP_PORT=8080
SHLVL=1
WEBSERVER_PORT_8080_TCP_PROTO=tcp
HOME=/root
WEBSERVER_PORT=tcp://10.3.1.42:8080
WEBSERVER_SERVICE_PORT=8080
WEBSERVER_PORT_8080_TCP=tcp://10.3.1.42:8080
KUBERNETES_PORT_443_TCP_ADDR=10.3.0.1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP=tcp://10.3.0.1:443
KUBERNETES_SERVICE_HOST=10.3.0.1
PWD=/
</pre> <p> </body> </html>
```

```
$ curl https://mwlb.adn-qs.helloclouds.app

<style type="text/css">
 <!--
 body {
  color: white;
  background-image: url(panorama.jpg);
  background-repeat: no-repeat;
  background-size: cover;
 }
 -->
</style>
<html>
<h1><p style="color:white;">f5-xc-lb-webserver</p></h1>
<a href="https://github.com/mwiget/f5-xc-lb-webserver">https://github.com/mwiget/f5-xc-lb-webserver</a>
<p><pre>
{
  "ip": "94.231.81.90",
  "city": "Zürich",
  "region": "Zurich",
  "country": "CH",
  "loc": "47.3667,8.5500",
  "org": "AS48971 DATAWIRE AG",
  "postal": "8000",
  "timezone": "Europe/Zurich",
  "readme": "https://ipinfo.io/missingauth"
}<p>
KUBERNETES_PORT=tcp://10.3.0.1:443
KUBERNETES_SERVICE_PORT=443
WEBSERVER_PORT_8080_TCP_ADDR=10.3.1.42
WEBSERVER_SERVICE_HOST=10.3.1.42
HOSTNAME=webserver-655d985599-r8rd9
WEBSERVER_PORT_8080_TCP_PORT=8080
SHLVL=1
WEBSERVER_PORT_8080_TCP_PROTO=tcp
HOME=/root
WEBSERVER_PORT=tcp://10.3.1.42:8080
WEBSERVER_SERVICE_PORT=8080
WEBSERVER_PORT_8080_TCP=tcp://10.3.1.42:8080
KUBERNETES_PORT_443_TCP_ADDR=10.3.0.1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP=tcp://10.3.0.1:443
KUBERNETES_SERVICE_HOST=10.3.0.1
PWD=/
</pre> <p> </body> </html>
```

