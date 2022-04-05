# http_helper

A helper local Flutter package. [Please Read This file Carefully before using or modify ,thanks]

#index 
Directory Structure: 13
Getting Started: 26
How It Work: 34  (important)
Why This Package: 52 (very important)
packages: 61


## Directory Structure
    lib
    ├──model
    │   │
    │   ├─status_code_handler_model.dart
    │   │
    │   └─super_response_model.dart
    │   
    ├──http_helper.dart
    │ 
    └──status_code_handler.dart


## Getting Started

[Introduction] 
This package help you to connect with server easily
it  provides you with what you need (models , controller , easy requests, ...etc) 



## How It Work
first you call [HttpHelper] class (it helper class) to choose [post or get ]
after choose your method you want [Post or Get] pass api url by [HttpHelper.url] it convert your simple url to uri 
and use this method used because cause if http(package from pub.dev) has updated the url pass in all request Normally and update this method only
after that you pass [header] (if request want that) by [HttpHelper.header] 
it makes things easier it hold all the expected data (Content-type , Accept , Token, moreHeaderKeys)
after that pass [body] data (if you need)
First of all 
- the method assert the argument data
- do your request by [http.Response] and pass status to  StatusCodeHandler to check if request done successfully or not 
  and return [request message as string, status code as int  , success as boolean] as a [StatusCodeHandlerModel] Object
- check if response done successfully or not to store data and return data as a [SuperResponseModel] model    
- catch any error if occurs and handle it
[simpleRequest]
it is an item intended to handle this application requests 



## Why This Package
it help you to do you request easily 
and if http(package from pub.dev) has updated you do not need to update all requests code 
but you need to update this package only
this package help you to do your request safely it handle all expected exception (internet exception , normal exception , ..etc)
it handle all request operation from pass your data to return your data safely



## packages
[normal](https://pub.dev)
http
[local]
d_print
exception_messages
