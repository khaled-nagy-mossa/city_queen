///StatusCodeHandlerModel it contain 3 members with zero method
/// it help you to contain
/// 1- success => if request done successfully and with status code (statusCode >= 100 && statusCode <= 299)
/// 2- msg => it save a request message (save the status code message => check lib/status_code_handler )
/// 3- status => it save status code from request

///this class used after do request to check if request done successfully or not
/// and what is the returned message

/// it used in StatusCodeHandler class in handle method => it is the returned value
class StatusCodeHandlerModel {
  bool success;
  String msg;
  int status;

  StatusCodeHandlerModel({this.success, this.msg, this.status});
}
