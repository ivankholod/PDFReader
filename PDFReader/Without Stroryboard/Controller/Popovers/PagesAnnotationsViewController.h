//
//  PagesAnnotationsViewController.h
//  PDFReader
//
//  Created by Ivan Kholod on 21/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>


@protocol PagesAnnotationsViewControllerDelegate;


@interface PagesAnnotationsViewController : UIViewController

@property (weak, nonatomic)     NSObject <PagesAnnotationsViewControllerDelegate>* delegate;
@property (strong, nonatomic)   NSMutableArray* indexPages;
@property (strong, nonatomic)   PDFDocument* PDFDocument;
@property (strong, nonatomic)   NSMutableArray* imagesArray;
@property (strong, nonatomic)   UIImage* image;
@property (strong, nonatomic)   NSMutableArray* selectionsArray;


@end

@protocol PagesAnnotationsViewControllerDelegate
@required
- (void) goToPage:(NSInteger) pageIndex;

@end
