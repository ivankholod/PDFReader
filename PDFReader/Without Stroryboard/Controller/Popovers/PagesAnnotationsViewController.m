//
//  PagesAnnotationsViewController.m
//  PDFReader
//
//  Created by Ivan Kholod on 21/05/2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "PagesAnnotationsViewController.h"
#import "PagesWithAnnotationTableViewCell.h"


@interface PagesAnnotationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* pagesForTableView;
@property (strong, nonatomic) PDFDocument* documentForTableView;


@property (strong,nonatomic) NSArray* imagesPDF;

@end

@implementation PagesAnnotationsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ld",[self.indexPages count]);
    

    self.pagesForTableView = [NSMutableArray array];
    self.pagesForTableView = self.indexPages;
    
    self.PDFDocument = self.documentForTableView;
    
    self.imagesPDF =  self.imagesArray;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,
                                                                   self.view.frame.origin.y,
                                                                   500,
                                                                   600
                                                                   ) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    UINib *cellNib = [UINib nibWithNibName:@"PagesWithAnnotationTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"PagesWithAnnotationTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
 
    NSLog(@"viewDidLoad");
}

#pragma mark - Memory Work

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%ld",[ self.pagesForTableView count]);
    
    return [self.pagesForTableView count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"PagesWithAnnotationTableViewCell";
    
    PagesWithAnnotationTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[PagesWithAnnotationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"";
    
    NSLog(@"Document: %ld",[self.documentForTableView pageCount]);
    
    [cell configureWithImage:[self.imagesPDF objectAtIndex:indexPath.row]];
    cell.pageNumberLabel.text = [NSString stringWithFormat:@"Page number: %ld", [[self.indexPages objectAtIndex:indexPath.row] integerValue] + 1];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = [[self.indexPages objectAtIndex:indexPath.row] integerValue];
    
    [self.delegate goToPage:index];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
}
@end
