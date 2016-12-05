//
//  CreateViewController.m
//  MyApp
//
//  Created by Admin on 11/25/16.
//  Copyright © 2016 KirillTer. All rights reserved.
//

#import "CreateViewController.h"
#import "Backendless.h"
#import "test.h"

@interface CreateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *birthDayText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)saveAction:(id)sender {
    
    test *newTest = [test new];
    newTest.name = self.nameText.text;
    newTest.age = [self.ageText.text integerValue];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm/dd/yyyy hh:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    newTest.birthday = [NSDate date];
    
    [backendless.persistenceService save:newTest
    response:^(BackendlessEntity *result) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [[self navigationController] popToRootViewControllerAnimated:YES];
        });
    }error:^(Fault *fault) {
        
    }];
}

@end
