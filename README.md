# Description
1. 根据我自己的使用习惯，对AFNetworking的简单封装，便于使用。
2. 封装了GET请求方式，POST请求后期加上吧。
3. 除了请求方式封装之外，还封装了ResponseBody，可以根据自己需要自定义。每次请求只需要调用相应的execute，然后在主线程根据response里的返回字段进行响应的处理即可。
4. 建议每个请求根据返回字段独立封装ResponseBody，用于接收返回数据

# Usage
```objective-c
    NSString *url = [API_BASE_URL stringByAppendingString:USER_LOGIN];
    NSDictionary *postData = @{@"loginName":@"13588361419", @"password":@"123456"};
    [TopRequest execute:url params:postData callback:^(ResponseBody *response){
        // processing your response data
        //self.dataLabel.text = response.msg;
    }];
```

# Others
1. NetStatusMonitor用来检查网络状况的，可以写在viewDidLoad中。我在TopRequest里写在了每个请求的开头，见方法beforeExecute
2. 自己学习iOS过程中第一次使用AFN，尝试着简单封装，希望能够在日后的实践中慢慢改进
