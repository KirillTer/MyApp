//
//  TableViewCell.h
//  MyApp
//
//  Created by Admin on 11/24/16.
//  Copyright © 2016 KirillTer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDayLabel;


@end
