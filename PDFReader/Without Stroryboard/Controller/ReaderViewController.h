//
//  ReaderViewController.h
//  PDFReader
//
//  Created by Ivan Kholod on 14.05.2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface ReaderViewController : UIViewController


@property (strong, nonatomic) NSMutableArray* arrayWithSelectionsForSearch;
@property (strong, nonatomic) UIColor* currentAnnotationColor;


@end
