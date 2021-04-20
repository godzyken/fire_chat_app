class MessageMessageApnsHeaders{
//JsonName:apns-priority
String? apnsPriority;

MessageMessageApnsHeaders({this.apnsPriority,
});
}

class Message{
//JsonName:message
MessageMessage? message;

Message({this.message,
});
}

class MessageMessageApnsPayloadAps{
//JsonName:category
String? category;

MessageMessageApnsPayloadAps({this.category,
});
}

class MessageMessage{
//JsonName:notification
MessageMessageNotification? notification;

//JsonName:webpush
MessageMessageWebpush? webpush;

//JsonName:android
MessageMessageAndroid? android;

//JsonName:apns
MessageMessageApns? apns;

//JsonName:token
String? token;

MessageMessage({this.notification,
this.webpush,
this.android,
this.apns,
this.token,
});
}

class MessageMessageAndroidNotification{
//JsonName:click_action
String? clickAction;

MessageMessageAndroidNotification({this.clickAction,
});
}

class MessageMessageWebpushHeaders{
//JsonName:TTL
String? tTL;

MessageMessageWebpushHeaders({this.tTL,
});
}

class MessageMessageNotification{
//JsonName:title
String? title;

//JsonName:body
String? body;

MessageMessageNotification({this.title,
this.body,
});
}

class MessageMessageAndroid{
//JsonName:notification
MessageMessageAndroidNotification? notification;

//JsonName:ttl
String? ttl;

MessageMessageAndroid({this.notification,
this.ttl,
});
}

class MessageMessageApnsPayload{
//JsonName:aps
MessageMessageApnsPayloadAps? aps;

MessageMessageApnsPayload({this.aps,
});
}

class MessageMessageApns{
//JsonName:headers
MessageMessageApnsHeaders? headers;

//JsonName:payload
MessageMessageApnsPayload? payload;

MessageMessageApns({this.headers,
this.payload,
});
}

class MessageMessageWebpush{
//JsonName:headers
MessageMessageWebpushHeaders? headers;

MessageMessageWebpush({this.headers,
});
}

