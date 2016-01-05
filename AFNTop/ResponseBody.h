//
//  ResponseBody.h
//  AFNTop
//
//  Created by Haonan on 16/1/4.
//  Copyright © 2016年 Haonan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBody : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSNumber *code;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSError *error;
@end
