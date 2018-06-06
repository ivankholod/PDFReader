//
//  ColorTableViewCell.m
//  PDFReader
//
//  Created by Ivan Kholod on 16/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "ColorTableViewCell.h"


@interface ColorTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end


@implementation ColorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithText:(NSString *)text {
    self.testLabel.text = @"";
    self.testLabel.textColor = [UIColor whiteColor];
}

@end
