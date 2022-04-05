import 'package:http_helper/model/status_code_handler_model.dart';

///StatusCodeHandler is A Helper class  (abstract class and static members)
/// StatusCodeHandler it check if status code do operation or not
/// and return message of status code
/// it surrounds most of the expected status code
///reference : https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

abstract class StatusCodeHandler {
  //check if status code mean operation done successfully or not and return msg error
  static StatusCodeHandlerModel handle(int statusCode) {
    // StatusCodeHandlerModel have 3 members [you must complete it]
    var model = StatusCodeHandlerModel(status: statusCode);

    //1st member
    model.status = statusCode;

    // if (statusCode >= 100 && statusCode <= 199)
    //   model.success = true;
    // else if (statusCode >= 200 && statusCode <= 299)
    //   model.success = true;
    // else if (statusCode >= 300 && statusCode <= 399)
    //   model.success = false;
    // else if (statusCode >= 400 && statusCode <= 499)
    //   model.success = false;
    // else
    //   model.success = false;

    //2nd member
    if (statusCode >= 100 && statusCode <= 299) {
      model.success = true;
    } else {
      model.success = false;
    }
    var statusMsg = statusCodeDictionary[statusCode];

    //3st member
    //if status code == null set 'Unknown Status Code'
    model.msg = statusMsg ?? 'Unknown Status Code';

    return model;
  }

  static const Map<int, String> statusCodeDictionary = {
    // Informational responses
    100:
        '(Continue) should continue the request, or ignore the response if the request is already finished.',

    101:
        '(Switching Protocol) This code is sent in response to an Upgrade request header from the client',

    102:
        'Processing (WebDAV) the server has received and is processing the request, but no response is available yet.',

    103:
        '(Early Hints) letting the user agent start preloading resources while the server prepares a response.',

    200: '(OK) The request has succeeded.',

    201:
        '(Created) The request has succeeded and a new resource has been created as a result',

    202:
        '(Accepted) The request has been received but not yet acted upon. It is noncommittal,',

    203:
        '(Non-Authoritative Information) returned meta-information is not exactly the same as is available from the origin server,',

    204: '(No Content) There is no content to send for this request,',

    205: '(Reset Content) reset the document which sent this request.',

    206:
        '(Partial Content) the Range header is sent from the client to request only part of a resource.',

    207: 'Multi-Status (WebDAV) Conveys information about multiple resources,',

    208:
        'Already Reported (WebDAV) Used inside a <dav:propstat> response element to avoid repeatedly enumerating the internal members of multiple bindings to the same collection.',

    226:
        'IM Used (HTTP Delta encoding) The server has fulfilled a GET request for the resource,',

    // Redirection messages
    300: '(Multiple Choice) The request has more than one possible response.',

    301:
        '(Moved Permanently) The URL of the requested resource has been changed permanently. The new URL is given in the response.',

    302:
        '(Found) This response code means that the URI of requested resource has been changed temporarily.',

    303:
        '(See Other) The server sent this response to direct the client to get the requested resource at another URI with a GET request.',

    304:
        '(Not Modified) the response has not been modified, so can continue to use the same cached version of the response.',

    305: '(Use Proxy) a requested response must be accessed by a proxy. ',

    306: '(unused) This response code is no longer used; it is just reserved',

    307:
        '(Temporary Redirect) The server sends this response to direct the client to get the requested resource at another URI with same method that was used in the prior request. ',

    308:
        '(Permanent Redirect) This means that the resource is now permanently located at another URI, ',

    // Client error responses
    400:
        '(Bad Request) The server could not understand the request due to invalid syntax.',

    401: '(Unauthorized) must authenticate to get the requested response.',

    402: '(Payment Required ) This response code is reserved for future use. ',

    403: '(Forbidden) does not have access rights to the content;',

    404: '(Not Found) The server can not find the requested resource.',

    405:
        '(Method Not Allowed) The request method is known by the server but has been disabled and cannot be used,',

    406:
        '(Not Acceptable) This response is sent when the web server, after performing server-driven content negotiation,',

    407: '(Proxy Authentication Required) authentication is needed ',

    408:
        '(Request Timeout) the server would like to shut down this unused connection. ',

    409:
        '(Conflict) This response is sent when a request conflicts with the current state of the server.',

    410:
        '(Gone) This response is sent when the requested content has been permanently deleted from server, ',

    411:
        '(Length Required) Server rejected the request because the Content-Length header field is not defined and the server requires it.',

    412:
        '(Precondition Failed) the client has indicated preconditions in its headers which the server does not meet.',

    413:
        '(Payload Too Large) Request entity is larger than limits defined by server; the server might close the connection or return an Retry-After header field.',

    414:
        '(URI Too Long) The URI requested by the client is longer than the server is willing to interpret.',

    415:
        '(Unsupported Media Type) The media format of the requested data is not supported by the server, so the server is rejecting the request.',

    416:
        "(Range Not Satisfiable) The range specified by the Range header field in the request can't be fulfilled; it's possible that the range is outside the size of the target URI's data.",

    417:
        "(Expectation Failed) the expectation indicated by the Expect request header field can't be met by the server.",

    418:
        "(I'm a teapot) The server refuses the attempt to brew coffee with a teapot.",

    421:
        '(Misdirected Request) The request was directed at a server that is not able to produce a response.',

    422:
        'Unprocessable Entity (WebDAV) The request was well-formed but was unable to be followed due to semantic errors.',

    423: 'Locked (WebDAV)  The resource that is being accessed is locked.',

    424:
        'Failed Dependency (WebDAV) The request failed due to failure of a previous request.',

    425:
        '(Too Early) the server is unwilling to risk processing a request that might be replayed.',

    426:
        '(Upgrade Required) The server refuses to perform the request using the current protocol but might be willing to do so after the client upgrades to a different protocol.',

    428:
        '(Precondition Required) The origin server requires the request to be conditional.',

    429:
        '(Too Many Requests) The user has sent too many requests in a given amount of time .',

    431:
        '(Request Header Fields Too Large) The server is unwilling to process the request because its header fields are too large. The request may be resubmitted after reducing the size of the request header fields.',

    451:
        '(Unavailable For Legal Reasons) The user-agent requested a resource that cannot legally be provided,',

    // Server error responses
    500:
        "(Internal Server Error) The server has encountered a situation it doesn't know how to handle.",

    501:
        '(Not Implemented) The request method is not supported by the server and cannot be handled.',

    502:
        '(Bad Gateway) the server, while working as a gateway to get a response needed to handle the request, got an invalid response.',

    503: '(Service Unavailable) The server is not ready to handle the request.',

    504: '(Gateway Timeout) cannot get a response in time.',

    505:
        '(HTTP Version Not Supported) The HTTP version used in the request is not supported by the server.',

    506:
        '(Variant Also Negotiates) The server has an internal configuration error',

    507:
        '(Insufficient Storage (WebDAV)) The method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request.',

    508:
        '(Loop Detected (WebDAV)) The server detected an infinite loop while processing the request.',

    510:
        '(Not Extended) Further extensions to the request are required for the server to fulfill it.',

    511:
        '(Network Authentication Required) the client needs to authenticate to gain network access.',
  };
}
