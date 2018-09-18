# WebSocket重连reconnecting-websocket.js的使用


## java servlet 
```

@ServerEndpoint("/receiveMessages.htc")
public class NotifyClientsController {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	public static void send2Clients(String mark, String level, String msg) throws Exception {
		synchronized (clients) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("mark", mark);
			jsonObject.put("level", level);
			jsonObject.put("msg", msg);
			for (Session client : clients) {
				client.getBasicRemote().sendText(jsonObject.toString());
			}
		}

	}

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		LogUtils.mycenter.trace("NotifyClientsController => " + session + " --- " + message);
	}

	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable thr) {
		try {
			clients.remove(session);
		} catch (Exception e) {
		}

	}
}
```

### javascript (webSocket + toastr)

```
<script type="text/javascript">
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-bottom-left",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "500",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };


    const wsUrl = "ws://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/receiveMessages.htc";

    try {
        let webSocket = new ReconnectingWebSocket(wsUrl, null, {debug: false, reconnectInterval: 5000});
        webSocket.onerror = function (event) {
        };
        webSocket.onmessage = function (event) {
            let data = $.parseJSON(event.data);
            let mark = data.mark || "";
            if ("notify" == mark) {
                if ("info" == data.level) {
                    toastr.options.timeOut = "60000";
                    console.log(toastr["info"](data.msg));
                }
                if ("warning" == data.level) {
                    toastr.options.timeOut = "300000";
                    console.log(toastr["warning"](data.msg));
                }
                if ("error" == data.level) {
                    toastr.options.timeOut = "0";
                    console.log(toastr["error"](data.msg));
                }
            }

            if ('getOtp' == mark){
                alert('請輸入OTP:');
            }
        };
        setInterval(function () {
            let sendStr = "<%=user.getName()%> : sendTime ->" + new Date().getTime();
            webSocket.send(sendStr);
        }, 3000);


    } catch (err) {
    }

    WEB_NUM ='${WEB_NUM}';
    CONTACT_US ='${CONTACT_US}';
</script>
```


