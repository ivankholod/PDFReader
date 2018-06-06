//
//  PagesWithAnnotationTableViewCell.m
//  PDFReader
//
//  Created by Ivan Kholod on 21/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "PagesWithAnnotationTableViewCell.h"

@interface PagesWithAnnotationTableViewCell ()

@end

@implementation PagesWithAnnotationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void) configureWithImage:(UIImage*) image {
   _imageViewPDF.image = image;
}

@end
