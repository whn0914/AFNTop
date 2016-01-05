//
//  ViewController.m
//  AFNTop
//
//  Created by Haonan on 16/1/4.
//  Copyright © 2016年 Haonan. All rights reserved.
//

#import "ViewController.h"
#import "TopRequest.h"
#import "NetStatusMonitor.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataLabel.text = @"Try to Post";
    // 全局的网络状况检测
    [NetStatusMonitor reach];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postAction:(id)sender {
    NSString *url = [API_BASE_URL stringByAppendingString:USER_LOGIN];
    NSDictionary *postData = @{@"loginName":@"13588361419", @"password":@"123456"};
    [TopRequest execute:url params:postData callback:^(ResponseBody *response){
        self.dataLabel.text = response.msg;
    }];
}

@end
