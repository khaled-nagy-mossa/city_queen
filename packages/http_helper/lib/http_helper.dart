import 'package:http_helper/model/super_response_model.dart';
import 'package:http_helper/status_code_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

//----------------------------------------------------------------------------
// Please read README.md Carefully before using or modify ,thanks
//----------------------------------------------------------------------------

///HttpHelper is A Helper class  (abstract class and static members)
///it help to do requests (post and get) easily
///
/// how (post and get) works
///1st => it assert if argument passed successfully (as method want)
///2nd => do request with (http.Request)
///3rd pass the status code to StatusCodeHandler.handle(res.statusCode);
///   to return what is the message of the status and check if the request done successfully or not
///4th => check request status to save data to SuperResponse Object that contain all data we will need and return it
// 5th => catch expected exception if occurs (normal exception , internet exception ,FormatException , ...etc )

///The Http Helper was created to
///facilitate the http request process,
///add new methods for ease of handling,
///write small code in place of the old code,
///and to ensure the execution status is easy,
///with all exceptions anticipated.

/// use package in all application requests cause if http updated in future you will just update code here
/// use the package because it is more secure and error handling
abstract class HttpHelper {
  // Average time Out Duration
  static final Duration _timeOutDuration = Duration(seconds: 30);

  // TO PATH ENDPOINT FOR BASE URL .
  static Uri url(String endPoint) => Uri.parse(endPoint);

  // TO PATH TOKEN AND MAKE GENERAL HEADER OF ALL REQUESTS .
  static Map<String, String> header(
      {String token, Map<String, String> moreHeaderKeys}) {
    var temp = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) temp['Authorization'] = 'Bearer $token';
    //if user needs to pass more header keys
    if (moreHeaderKeys != null) temp.addAll(moreHeaderKeys);
    return temp;
  }

  // GENERAL POST REQUEST
  // don't save json member in SuperResponseModel in post method
  static Future<SuperResponseModel> post(
    Uri url, {
    Map<String, String> header,
    Duration timeOut,
    dynamic body,
  }) async {
    assert(url != null);

    //a model to save all request  data
    var superResModel = SuperResponseModel();
    //simple httpResponse => declare out try and catch So it is easy to reach
    http.Response res;

    try {
      res = await http
          .post(url, headers: header, body: body)
          .timeout(timeOut ?? _timeOutDuration);

      superResModel.res = res; //save res

      // StatusCodeHandlerModel : it surrounds most of the expected status code
      // and check operation done successfully or not and return message error
      var model = StatusCodeHandler.handle(res.statusCode);

      if (model.success) {
        superResModel.hasError = false;
        return superResModel;
      } else {
        throw model.msg;
      }
    } on TimeoutException {
      superResModel.msg = 'Time out Exception 😱';
      superResModel.hasError = true;

      return superResModel;
    } on SocketException {
      superResModel.msg = 'No Internet connection 😑';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on FormatException {
      superResModel.msg = 'Bad response format 👎 ';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on HttpException catch (e) {
      superResModel.msg = "Couldn't find the post 😱 : ${e.toString()}";
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } catch (e) {
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};

      superResModel.msg ??= '';

      if (superResModel.res == null || superResModel.res.statusCode == null) {
        superResModel.msg += 'Error occured while Communication with Server';
      } else {
        superResModel.msg +=
            'Status Code : ${superResModel.res.statusCode} => ${StatusCodeHandler.handle(res.statusCode).msg}';
      }

      return superResModel;
    }
  }

// GENERAL POST REQUEST => use method cause if http updated in future
  static Future<SuperResponseModel> get(
    Uri url, {
    Duration timeOut,
    Map<String, String> header,
  }) async {
    assert(url != null);

    //a model to save all request  data
    var superResModel = SuperResponseModel();
    //simple httpResponse => declare out try and catch So it is easy to reach
    http.Response res;

    try {
      res = await http
          .get(url, headers: header)
          .timeout(timeOut ?? _timeOutDuration);

      superResModel.res = res; //save res

      // StatusCodeHandlerModel : it surrounds most of the expected status code
      // and check operation done successfully or not and return message error
      var model = StatusCodeHandler.handle(res.statusCode);

      if (model.success) {
        superResModel.hasError = false;
        return superResModel;
      } else {
        throw Exception();
      }
    } on TimeoutException {
      superResModel.msg = 'Time out Exception 😱';
      superResModel.hasError = true;

      return superResModel;
    } on SocketException {
      superResModel.msg = 'No Internet connection 😑';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on FormatException {
      superResModel.msg = 'Bad response format 👎 ';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on HttpException catch (e) {
      superResModel.msg = 'Couldn\'t find the post 😱 : ${e.toString()}';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } catch (e) {
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};

      superResModel.msg ??= '';

      if (superResModel.res == null || superResModel.res.statusCode == null) {
        superResModel.msg += 'Error occured while Communication with Server';
      } else {
        superResModel.msg +=
            'Status Code : ${superResModel.res.statusCode} => ${StatusCodeHandler.handle(res.statusCode).msg}';
      }

      return superResModel;
    }
  }

  // GENERAL GET REQUEST
  static Future<SuperResponseModel> getWithBodyData(
    Uri url, {
    Duration timeOut,
    Map<String, String> header,
    String body,
  }) async {
    assert(url != null);

    //a model to save all request  data
    var superResModel = SuperResponseModel();
    //simple httpResponse => declare out try and catch So it is easy to reach

    try {
      var request = http.Request('GET', url);
      if (body == null) {
        request.body = '''{}''';
      } else {
        request.body = body;
      }

      if (header != null) request.headers.addAll(header);

      var streamedResponse = await request.send();

      superResModel.res =
          await http.Response.fromStream(streamedResponse); //save res

      // StatusCodeHandlerModel : it surrounds most of the expected status code
      // and check operation done successfully or not and return message error
      var model = StatusCodeHandler.handle(superResModel.res.statusCode);

      if (model.success) {
        superResModel.hasError = false;
        return superResModel;
      } else {
        throw Exception();
      }
    } on TimeoutException {
      superResModel.msg = 'Time out Exception 😱';
      superResModel.hasError = true;

      return superResModel;
    } on SocketException {
      superResModel.msg = 'No Internet connection 😑';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on FormatException {
      superResModel.msg = 'Bad response format 👎 ';
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } on HttpException catch (e) {
      superResModel.msg = "Couldn't find the post 😱 : ${e.toString()}";
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};
      return superResModel;
    } catch (e) {
      superResModel.hasError = true;
      superResModel.json = <String, dynamic>{};

      superResModel.msg ??= '';

      if (superResModel.res == null || superResModel.res.statusCode == null) {
        superResModel.msg += 'Error occured while Communication with Server';
      } else {
        superResModel.msg +=
            'Status Code : ${superResModel.res.statusCode} => ${StatusCodeHandler.handle(superResModel.res.statusCode).msg}';
      }

      return superResModel;
    }
  }

  static String getCookie(Map<String, String> headers) {
    var rawCookie = headers['set-cookie'];
    if (rawCookie != null) {
      var index = rawCookie.indexOf(';');
      var cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      return cookie;
    }
    return headers['set-cookie'];
  }

  //use this method to do your request with safety (HttpHelper.post , HttpHelper.get)
  //it deals with most of the expected errors
  static Future<SuperResponseModel> simpleRequest(
    Future<SuperResponseModel> action, //[Our Post or Get Methods]
  ) async {
    //this model to save all request data
    var superResponseModel = SuperResponseModel();

    try {
      //await to do action (HttpHelper.post , HttpHelper.get)
      superResponseModel = await action;

      if (!superResponseModel.hasError) {
        final data =
            json.decode(superResponseModel.res.body) as Map<String, dynamic>;
        if (data['result']['errors'] == null) {
          superResponseModel.json = Map<String, dynamic>.from(data);
        } else {
          superResponseModel.hasError = true;
          final errors = List<Map<String, dynamic>>.from(
              (data['result']['errors'] as List));

          var errorMsg = '';
          errors.forEach((e) => errorMsg += e['msg'].toString() + '\n');
          superResponseModel.msg = errorMsg;
        }
      } else {
        if (superResponseModel.res == null) {
          return superResponseModel;
        } else {
          final errors = List<Map<String, dynamic>>.from(json
              .decode(superResponseModel.res.body)['result']['errors'] as List);

          var errorMsg = '';
          errors.forEach((e) => errorMsg += e['msg'].toString() + '\n');
          superResponseModel.msg = errorMsg;
        }
      }
    } catch (e) {
      superResponseModel.hasError = true;
      superResponseModel.msg ??= '';
      superResponseModel.msg += '\nmore: ${e.toString()}';
    }
    return superResponseModel;
  }
}
