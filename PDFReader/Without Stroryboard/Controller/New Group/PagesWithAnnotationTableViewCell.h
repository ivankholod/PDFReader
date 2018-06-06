//
//  PagesWithAnnotationTableViewCell.h
//  PDFReader
//
//  Created by Ivan Kholod on 21/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagesWithAnnotationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPDF;
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;


- (void) configureWithImage:(UIImage*) image;

@end
