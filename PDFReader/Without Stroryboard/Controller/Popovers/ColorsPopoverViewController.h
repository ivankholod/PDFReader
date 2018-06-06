//
//  ColorsPopoverViewController.h
//  PDFReader
//
//  Created by Ivan Kholod on 16/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ColorsPopoverViewControllerDelegate;


@interface ColorsPopoverViewController : UIViewController
@property (weak, nonatomic) NSObject <ColorsPopoverViewControllerDelegate>* delegate;

@end

@protocol ColorsPopoverViewControllerDelegate
@required
- (void) changeColorAction:(UIColor*) color;

@end
