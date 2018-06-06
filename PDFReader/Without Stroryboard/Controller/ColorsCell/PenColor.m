//
//  PenColor.m
//  PDFReader
//
//  Created by Ivan Kholod on 16/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "PenColor.h"

@implementation PenColor

+ (NSArray*) arrayColors {
    
    // Create Colors
    
    PenColor* greenColor = [[PenColor alloc] init];
    
    greenColor.name = @"Green Color";
    greenColor.color = [UIColor colorWithRed: 116.f / 255.f
                                       green: 183.f / 255.f
                                        blue: 79.f  / 255.f
                                      alpha : 1.0];
    
    
    PenColor* orangeColor = [[PenColor alloc] init];
    
    orangeColor.name = @"Orange Color";
    orangeColor.color = [UIColor colorWithRed: 234.f / 255.f
                                        green: 135.f / 255.f
                                         blue: 46.f  / 255.f
                                       alpha : 1.0];
    
    PenColor* blueColor = [[PenColor alloc] init];
    
    blueColor.name = @"Blue Color";
    blueColor.color = [UIColor colorWithRed: 65.f  / 255.f
                                      green: 153.f / 255.f
                                       blue: 216.f / 255.f
                                      alpha: 1.0];
    
    PenColor* redColor = [[PenColor alloc] init];
    
    redColor.name = @"Red Color";
    redColor.color = [UIColor colorWithRed: 207.f / 255.f
                                     green: 70.f  / 255.f
                                      blue: 64.f  / 255.f
                                     alpha: 1.0];
    
    PenColor* yellowColor = [[PenColor alloc] init];
    
    yellowColor.name = @"Yellow Color";
    yellowColor.color = [UIColor colorWithRed: 241.f / 255.f
                                        green: 188.f / 255.f
                                         blue: 62.f  / 255.f
                                        alpha: 1.0];
    
    
    PenColor* blackColor = [[PenColor alloc] init];
    blackColor.name = @"Black Color";
    blackColor.color = [UIColor blackColor];
    
    
    PenColor* purpleColor = [[PenColor alloc] init];
    
    purpleColor.name = @"Purple Color";
    purpleColor.color = [UIColor colorWithRed: 139.f / 255.f
                                        green: 62.f  / 255.f
                                         blue: 148.f / 255.f
                                        alpha: 1.0];
    
    PenColor* grayColor = [[PenColor alloc] init];
    
    grayColor.name = @"Gray Color";
    grayColor.color = [UIColor grayColor];
    
    PenColor* lightBlue = [[PenColor alloc] init];
    
    lightBlue.name = @"LightBlue Color";
    lightBlue.color = [UIColor colorWithRed: 144.f / 255.f
                                      green: 203.f / 255.f
                                       blue: 235.f / 255.f
                                      alpha: 1.0];
    
    
    // Array Colors
    
    NSArray* array = [[NSArray alloc] initWithObjects:  greenColor,
                                                        yellowColor,
                                                        orangeColor,
                                                        redColor,
                                                        purpleColor ,
                                                        blueColor,
                                                        lightBlue ,
                                                        grayColor,
                                                        blackColor,
                                                        nil];
    
    return array;
}

@end
