//
//  MessageStatus.h
//  MyApp
//
//  Created by Admin on 11/28/16.
//  Copyright © 2016 KirillTer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublishStatusEnum"

@interface MessageStatus : NSObject
@property (strong, nonatomic) NSString *messageId;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSString *errorMessage;
-(id)initWithId:(NSString *)messageId;
-(id)initWithId:(NSString *)messageId status:(PublishStatusEnum)status;
-(id)initWithId:(NSString *)messageId status:(PublishStatusEnum)status errorMessage:(NSString *)errorMessage;

-(PublishStatusEnum)valStatus;
-(void)status:(PublishStatusEnum)status;
@end
