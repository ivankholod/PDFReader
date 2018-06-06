//
//  SearchWordsInAnnotationViewController.m
//  PDFReader
//
//  Created by Ivan Kholod on 24/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "SearchWordsInAnnotationViewController.h"


@interface SearchWordsInAnnotationViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField* searchWordField;
@property (strong, nonatomic) UIButton* buttonStartSearch;

@end

@implementation SearchWordsInAnnotationViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init TextField Words For Search
    
   self.searchWordField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 50,
                                                                                 self.view.frame.origin.y + 25,
                                                                                 300,
                                                                                 25)];
    
    self.searchWordField.backgroundColor    = [UIColor whiteColor];
    self.searchWordField.borderStyle        = UITextBorderStyleRoundedRect;
    self.searchWordField.placeholder        = @"Search in annotations";
    
    self.searchWordField.delegate = self;
    
    [self.searchWordField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:self.searchWordField];
    
    
    
    // Init UIButton Search
    
    self.buttonStartSearch = [[UIButton alloc] initWithFrame:CGRectMake(self.searchWordField.frame.origin.x + self.searchWordField.frame.size.width + 15,
                                                                        self.searchWordField.frame.origin.y,
                                                                        50,
                                                                        25)];
    
    self.buttonStartSearch.backgroundColor = [UIColor colorWithRed: 241.f / 255.f
                                                             green: 188.f / 255.f
                                                              blue: 62.f  / 255.f
                                                             alpha: 1.0];
    
    [self.buttonStartSearch setTitle:@"Find" forState:UIControlStateNormal];
    [self.buttonStartSearch setTitle:@"Search" forState:UIControlStateHighlighted];
    [self.buttonStartSearch.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.buttonStartSearch.titleLabel.textColor = [UIColor whiteColor];
    
     self.buttonStartSearch.layer.cornerRadius = 5;
    
    [self.buttonStartSearch addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonStartSearch];
    
    NSLog(@"viewDidLoad");

}

-(void)dealloc {
    NSLog(@"dealloc SearchWordsInAnnotationViewController");
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Action for Button

- (void) searchButtonAction:(NSString*) text {
  
          text = self.searchWordField.text;
    
         [self.delegate goSearchWithString:text];
          NSLog(@"SEARCH");
}

#pragma mark - UITextField Notification

- (void) textFieldDidChange:(UITextField*) textField {
    NSLog(@"textFieldDidChange");
     [self.delegate goSearchWithString:textField.text];

}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //[self.delegate goSearchWithString:textField.text];
    
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}

@end
