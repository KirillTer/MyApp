//
//  ChatViewController.m
//  MyApp
//
//  Created by Admin on 11/28/16.
//  Copyright © 2016 KirillTer. All rights reserved.
//

#import "ChatViewController.h"
#import "Backendless.h"
#import "MessagingService.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UITextView *chatText;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @try {
        Responder *responder = [[Responder alloc] initWithResponder:self
                                                 selResponseHandler:@selector(responseHandler:)
                                                    selErrorHandler:@selector(errorHandler:)];
        SubscriptionOptions *subscriptionOptions = [SubscriptionOptions new];
        BESubscription *subscription = [backendless.messagingService
                                      subscribe:@"default"
                                      subscriptionResponder:responder
                                      subscriptionOptions:subscriptionOptions];
        
        NSLog(@"SUBSCRIPTION: %@", subscription);
    }
    
    @catch (Fault *fault) {
        NSLog(@"FAULT = %@", fault);
    }
}

- (IBAction)sendAction:(id)sender {
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self publishMessageAsync:uniqueIdentifier];
}

-(void)publishMessageAsync:(NSString *)deviceId {
    
    [backendless.messaging
     publish:@"default" message:self.chatText.text
     response:^(MessageStatus *messageStatus) {
         NSLog(@"MessageStatus = %@ <%@>", messageStatus.messageId, messageStatus.status);
     }
     error:^(Fault *fault) {
         NSLog(@"FAULT = %@", fault);
     }];
}

-(id)responseHandler:(id)response {
    
    NSArray<Message*> *messages = response;
    for (Message *message in messages) {
        NSString *publisher = [message.headers objectForKey:@"publisher_name"];
        NSLog(@"%@ : '%@'", publisher ? publisher : @"Anonymous", message.data);
        self.chatLabel.text = [NSString stringWithFormat:@"%@\n %@",self.chatLabel.text, message.data];
    }
    return response;
}
              
-(void)errorHandler:(Fault *)fault {
    NSLog(@"FAULT = %@", fault);
}
              
@end
