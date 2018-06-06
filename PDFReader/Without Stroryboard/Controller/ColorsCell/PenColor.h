//
//  PenColor.h
//  PDFReader
//
//  Created by Ivan Kholod on 16/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PenColor : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) UIColor* color;

+ (NSArray<PenColor*>*) arrayColors;

@end
