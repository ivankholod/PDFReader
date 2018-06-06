//
//  SearchWordsInAnnotationViewController.h
//  PDFReader
//
//  Created by Ivan Kholod on 24/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchWordsInAnnotationViewControllerDelegate;

@interface SearchWordsInAnnotationViewController : UIViewController

@property (weak, nonatomic) NSObject <SearchWordsInAnnotationViewControllerDelegate>* delegate;

@end


@protocol SearchWordsInAnnotationViewControllerDelegate

@required

- (void) goSearchWithString:(NSString*) text;

@end
