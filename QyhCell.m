//
//  QyhCell.m
//  GitDouBan
//
//  Created by ibokan on 13-4-18.
//  Copyright (c) 2013年 quyanhui. All rights reserved.
//

#import "QyhCell.h"

@implementation QyhCell
@synthesize nameLabel,imageV;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageV = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 65, 75)];
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 60)];
        nameLabel.numberOfLines = 0;
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        imageV.backgroundColor = [UIColor clearColor];
        [self addSubview:imageV];
        [self addSubview:nameLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
