//
//  ColorsPopoverViewController.m
//  PDFReader
//
//  Created by Ivan Kholod on 16/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "ColorsPopoverViewController.h"
#import "ReaderViewController.h"
#import "ColorTableViewCell.h"
#import "PenColor.h"

@interface ColorsPopoverViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* arrayColor;

@end

@implementation ColorsPopoverViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayColor = [PenColor arrayColors];

    // TableView Init
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake( self.view.frame.origin.x,
                                                                    self.view.frame.origin.y,
                                                                    250,
                                                                    350)
                      
                                                        style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    
    // Register Nib Cell
    
    UINib *cellNib = [UINib nibWithNibName:@"ColorTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"ColorTableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin   | UIViewAutoresizingFlexibleTopMargin   |
                                       UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleBottomMargin ;
    
    
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITable View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayColor count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"ColorTableViewCell";
    
    ColorTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
         cell =  [[ColorTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    PenColor* currentColor = [self.arrayColor objectAtIndex:indexPath.row];
    
    [cell configureWithText:[NSString stringWithFormat:@"Cell name: %@", currentColor.name]];
    [cell setBackgroundColor:currentColor.color];
    
   
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        PenColor* currentColor = [self.arrayColor objectAtIndex:indexPath.row];
    
        [self.delegate changeColorAction:currentColor.color];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 50.f;
}

@end
