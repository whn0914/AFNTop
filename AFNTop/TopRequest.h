//
//  TopRequest.h
//  AFNTop
//
//  Created by Haonan on 16/1/4.
//  Copyright © 2016年 Haonan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URIDefine.h"
#import "ResponseBody.h"

@interface TopRequest : NSObject
+ (BOOL)execute:(NSString*) uri params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback;
@end
