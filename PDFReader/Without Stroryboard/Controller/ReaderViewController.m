//
//  ReaderViewController.m
//  PDFReader
//
//  Created by Ivan Kholod on 14.05.2018.
//  Copyright © 2018 Ivan Kholod. All rights reserved.
//

#import "ReaderViewController.h"
#import "ColorsPopoverViewController.h"
#import "PagesAnnotationsViewController.h"
#import "SearchWordsInAnnotationViewController.h"

#import <PDFKit/PDFKit.h>

@interface ReaderViewController () <UIDocumentPickerDelegate, PDFDocumentDelegate, PDFViewDelegate, ColorsPopoverViewControllerDelegate, PagesAnnotationsViewControllerDelegate,SearchWordsInAnnotationViewControllerDelegate>

@property (strong, nonatomic) UIDocumentPickerViewController* documentPickerViewController;

@property (strong, nonatomic) PDFView* readerPDF;
@property (strong, nonatomic) PDFDocument* currentDocument;

@property (strong, nonatomic) UIImageView* logoImageView;

@property (strong, nonatomic) UIColor* mainThemeDarkColor;
@property (strong, nonatomic) UIColor* mainThemeLightColor;

@property (strong, nonatomic) UIBarButtonItem* addBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* highlightTextBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* undoBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* colorsBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* searchBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* homeBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem* noteBarButtonItem;

@property (strong,nonatomic) PDFAnnotation* annotation;

@property (strong, nonatomic) PDFAnnotation* drawAnnotation;
@property (strong, nonatomic) NSMutableArray* annotationDrawArray;
@property (strong, nonatomic) NSMutableArray* arrayOfIndexPageWithAnnotations;
@property (strong, nonatomic) NSMutableArray* previewImage;

@property (assign, nonatomic) CGPoint fingerCoordinates;
@property (assign, nonatomic) CGPoint coordinatesForPDF;

@property (strong, nonatomic) UIView* viewIndicator;
@property (strong, nonatomic) UIView* viewForTouch;

@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint endPoint;
@property (assign, nonatomic) CGPoint currentMovePoint;

@property (strong, nonatomic) UILabel* textForViewIndicator;

@property (strong, nonatomic) PDFSelection* selectionTest;

@property (assign, nonatomic) NSInteger indexForSearch;

@property (strong, nonatomic) NSString* wordForSearch;
@property (strong, nonatomic) NSString* testWordForSearch;
@property (strong, nonatomic) UIPopoverController* popoverSearch;

@property (strong, nonatomic) UIActivityIndicatorView* indicator;

@property (strong, nonatomic) CAGradientLayer* gradient;


@property (assign, nonatomic) BOOL isHighlited;

@end

@implementation ReaderViewController

#pragma mark - View Life Cycle


- (void)layoutSubviews {
    // resize your layers based on the view's new frame
    self.gradient.frame = self.view.bounds;
}


- (void) loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Index for Search
    
   
    self.indexForSearch = 0;
    
    // Device Orientation
    
    
    // UITouch
    
    
    // UICollection View
    
   
    
    // Menu Item Controller
    
    UIMenuItem* item = [[UIMenuItem alloc] initWithTitle:@"Highlight"
                                                  action:@selector(addHighlightAnnotation)];
    
    UIMenuItem* item2 = [[UIMenuItem alloc] initWithTitle:@"Stroke"
                                                   action:@selector(addStrikeAnnotation)];
    
    UIMenuItem* item3 = [[UIMenuItem alloc] initWithTitle:@"Remove"
                                                   action:@selector(removeSelectedAnnotation)];

    UIMenuController* menuController = [UIMenuController sharedMenuController];
    
    
    [menuController setMenuItems:@[item, item2, item3]];
    
    // Color Annotation
    
    self.currentAnnotationColor = [UIColor yellowColor];
    
    // Check highlightText BarButtonItem
    
     self.isHighlited = NO;
    
    // Init Main Theme Color
    
//    UIColor* blueThemeColor = [UIColor colorWithRed: 10.f / 255.f
//                                              green: 52.f / 255.f
//                                               blue: 76.f / 255.f
//                                              alpha: 1.0];
    
    self.mainThemeDarkColor = [UIColor blackColor];
//    [UIColor colorWithRed:33.f/255.f
//                                              green:86.f/255.f
//                                               blue:102.f/255.f
//                                              alpha:1.0];
    
    self.mainThemeLightColor = [UIColor colorWithRed: 33.f  / 255.f
                                               green: 86.f  / 255.f
                                                blue: 102.f / 255.f
                                               alpha: 0.5];
    

    // Gradient
    
    
    
    UIColor *topColor = [UIColor colorWithRed: 255.f  / 255.f
                                        green: 110.f / 255.f
                                         blue: 110.f / 255.f
                                        alpha: 1.0];
    
    UIColor *bottomColor = [UIColor colorWithRed: 211.f  / 255.f
                                           green: 64.f  / 255.f
                                            blue: 64.f  / 255.f
                                           alpha: 1.0];
    
    
    self.gradient = [CAGradientLayer layer];
    self.gradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    self.gradient.frame = self.view.bounds;
    
    //[self.gradient setAutoreverses:YES];
   
    [self.view.layer insertSublayer:self.gradient atIndex:0];
    

     
    
    
    self.view.backgroundColor = self.mainThemeLightColor;
    
    
    
    
    // Init PDFReader Logo Image
    
    
    UIImage* logoImage = [UIImage imageNamed:@"logo.png"];
    
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 65,
                                                                       CGRectGetMidY(self.view.frame) - (CGRectGetMidY(self.view.frame) - 130),
                                                                       130,
                                                                       130)];
    
  
    [self.logoImageView setImage:logoImage];
    
    self.logoImageView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin   | UIViewAutoresizingFlexibleTopMargin   |
                                           UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleBottomMargin ;
    

    // Init Label text
    
    UILabel* labelWelcome = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) / 4 ,
                                                                      CGRectGetMaxY(self.view.frame) / 4 ,
                                                                      self.view.frame.size.width,
                                                                      self.view.frame.size.height)];
    
    labelWelcome.textColor = [UIColor whiteColor];
    
    labelWelcome.text = @"Welcome to PDFReader!";
    
    [labelWelcome setAdjustsFontSizeToFitWidth:YES];
    
    [labelWelcome setFont:[UIFont systemFontOfSize:42.f]];
    
    labelWelcome.autoresizingMask =     UIViewAutoresizingFlexibleLeftMargin   | UIViewAutoresizingFlexibleTopMargin   |
                                        UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleBottomMargin ;
    
    [self.view addSubview:labelWelcome];
 
    // NavigationItem Preferences
    
    self.navigationItem.title = @"PDFReader";
    
    self.addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(addPDFDocumentFromFiles)];
    
    self.highlightTextBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pencilButton.png"]
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(highlightTextAction)];
    
    self.undoBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"undo.png"]
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(undoBarButtonAction)];
    
    
    self.colorsBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"colors.png"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(setColorsForPen)];
    
    self.searchBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                             target:self
                                                                             action:@selector(searchActionBarButton)];
    
    
    self.homeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"library.png"]
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(goMainMenu)];
    
    self.noteBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"note.png"]
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(showPagesWithAnnotations)];
    
    
    self.navigationItem.leftBarButtonItems = @[self.addBarButtonItem,
                                               self.homeBarButtonItem,
                                               self.noteBarButtonItem];
    
    self.navigationItem.rightBarButtonItems = @[//self.undoBarButtonItem,
                                                self.colorsBarButtonItem,
                                                self.searchBarButtonItem,
                                                self.highlightTextBarButtonItem];
    
    if (!self.isHighlited) {
        self.highlightTextBarButtonItem.tintColor = self.mainThemeLightColor;
    }


    // NavigationBar Preferences
    
    self.navigationController.navigationBar.tintColor = self.mainThemeDarkColor;
    
    self.navigationController.navigationBar.backgroundColor = self.mainThemeDarkColor;
    
    // Make PDFView
    
    self.readerPDF = [[PDFView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,
                                                               self.view.frame.origin.y,
                                                               self.view.frame.size.width,
                                                               self.view.frame.size.height)];
    
    self.readerPDF.autoresizingMask =   UIViewAutoresizingFlexibleWidth   | UIViewAutoresizingFlexibleTopMargin   |
                                        UIViewAutoresizingFlexibleHeight  | UIViewAutoresizingFlexibleBottomMargin ;
    
    self.readerPDF.backgroundColor = topColor;
    

    self.readerPDF.delegate = self;
    
    [self.navigationController setHidesBarsOnTap:YES];
    
    
    // Configure PDFView
    
    //self.myReader.displaysAsBook = YES;
    //self.myReader.displayMode = kPDFDisplaySinglePage;

    
    self.readerPDF.displayDirection = kPDFDisplayDirectionHorizontal;
    self.readerPDF.autoScales = YES;
    [self.readerPDF usePageViewController:YES withViewOptions:nil];
    
  
    // Animations
    
//    [UIView animateWithDuration:1.3f
//                          delay:0
//                        options:    UIViewAnimationOptionCurveEaseInOut
//                                  //| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
//                     animations:^{
//                         labelWelcome.frame = CGRectMake(self.logoImageView.frame.origin.y,
//                                                         self.logoImageView.frame.origin.x,
//                                                         300,
//                                                         150);
//
//
//                     } completion:^(BOOL finished) {
//                         labelWelcome.text = @"Hello!\n";
//                         [labelWelcome setFrame:CGRectMake(labelWelcome.frame.origin.x,
//                                                           labelWelcome.frame.origin.y,
//                                                           500, 500)];
//                         [labelWelcome setAdjustsFontSizeToFitWidth:YES];
//
//                     }];
//
    NSLog(@"viewDidLoad");
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Bar Button Actions

- (void) showPagesWithAnnotations {
    
    PagesAnnotationsViewController* vc = [[PagesAnnotationsViewController alloc] init];
    vc.indexPages = self.arrayOfIndexPageWithAnnotations;
    vc.PDFDocument = self.currentDocument;
    
    NSLog(@"%ld",[vc.PDFDocument pageCount]);
    
    //vc.image = [[self.currentDocument pageAtIndex:1] thumbnailOfSize:CGSizeMake(90, 90) forBox:kPDFDisplayBoxArtBox];
    vc.imagesArray = self.previewImage;
    vc.delegate = self;
    
    
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    popover.backgroundColor = [UIColor whiteColor];
    [popover setPopoverContentSize:CGSizeMake(500, 600) animated:YES];
    [popover presentPopoverFromBarButtonItem:self.noteBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    NSLog(@"%ld", [vc.indexPages count]);
    NSLog(@"showPagesWithAnnotations");
}

- (void) goMainMenu {
    NSLog(@"goMainMenu");
    
    // Save changes
    
    [self saveChages];
    
    [self.readerPDF removeFromSuperview];
    
    self.navigationItem.title = @"PDFReader";
    
}


- (void) searchActionBarButton {
    
    // GET STRING FROM ANNOTATIONS ON CURRENT PAGES
    

    SearchWordsInAnnotationViewController* vc = [[SearchWordsInAnnotationViewController alloc] init];
    
     vc.delegate = self;
    
    self.popoverSearch = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    [self.popoverSearch presentPopoverFromBarButtonItem:self.searchBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [self.popoverSearch setPopoverContentSize:CGSizeMake(450, 75)];
    
    NSLog(@"searchActionBarButton");
    
}

- (void) setColorsForPen {
    NSLog(@"SetColors");
    
    ColorsPopoverViewController* vc = [[ColorsPopoverViewController alloc] init];
    vc.delegate = self;
    
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    [popover setPopoverContentSize:CGSizeMake(250, 350) animated:YES];
    
    popover.backgroundColor = [UIColor whiteColor];
    
    //[popover dismissPopoverAnimated:YES];
    
    [popover presentPopoverFromBarButtonItem:self.colorsBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    self.annotation.color = self.currentAnnotationColor;
}

- (void) undoBarButtonAction {
    
    if (self.isHighlited) {
        
        if ([self.readerPDF.currentPage.annotations count] != 0) {
           
            PDFAnnotation* lastAnnotation = [self.readerPDF.currentPage.annotations lastObject];
            
            [self.readerPDF.currentPage removeAnnotation: lastAnnotation];
            
            NSLog(@"undoBarButtonAction remove annotation");
            
        } else {
            NSLog(@"undoBarButtonAction cant remove annotation : array object zero");
        }
    }
    
    
}

- (void) highlightTextAction {
 
    if (self.isHighlited) {
        
        self.isHighlited = NO;
        
        self.highlightTextBarButtonItem.tintColor = self.mainThemeLightColor;
        

        [self.viewForTouch removeFromSuperview];
        
        NSLog(@"highlightTextAction OFF");
        
    } else {
        
        self.highlightTextBarButtonItem.tintColor = self.mainThemeDarkColor;
        
        self.isHighlited = YES;
        
        NSLog(@"%@", self.readerPDF.currentPage);
        
        //[self.readerPDF addGestureRecognizer:self.finger];
        
        
        // Add View
        
        self.viewForTouch = [[UIView alloc] initWithFrame:self.readerPDF.frame];
        
        [self.readerPDF addSubview:self.viewForTouch];
        

        NSLog(@"highlightTextAction ON");
        
    }
    
}

- (void) addPDFDocumentFromFiles {
   
    self.documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:[self typesPDF] inMode:UIDocumentPickerModeOpen];
    
    self.documentPickerViewController.delegate = self;
    
    // Save changes
    
    [self saveChages];
    
   
    [self.navigationController presentViewController:self.documentPickerViewController animated:YES completion:nil];
    
    
}


#pragma mark - Touches

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.viewForTouch];
    
    self.startPoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];
    
    
    // Tap and Remove
    
    NSArray* annotations = self.readerPDF.currentPage.annotations;
    NSMutableArray* annotationForDel = [NSMutableArray array];
    
    for (PDFAnnotation* annotation in annotations) {
        if (CGRectContainsPoint(annotation.bounds , self.startPoint )) {
            [annotationForDel addObject:annotation];
        }
    }
   
    // Remove selected annotations from page
    
    for (PDFAnnotation* annotation in annotationForDel) {
        [self.readerPDF.currentPage removeAnnotation:annotation];
    }
    

    
    
    NSLog(@"touchesBegan");
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.viewForTouch];
    
    self.endPoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];
    self.currentMovePoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];
    
    PDFSelection* selection = [self.readerPDF.currentPage selectionFromPoint:self.startPoint toPoint:self.currentMovePoint];
    NSArray* arraySelections = [selection selectionsByLine];
    
    [self.readerPDF setHighlightedSelections:arraySelections];
    [self.readerPDF setCurrentSelection: selection];
    
    
    

    //NSLog(@"touchesMoved");
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.viewForTouch];
    
    self.endPoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];

    PDFSelection* selection = [self.readerPDF.currentPage selectionFromPoint:self.startPoint toPoint:self.endPoint];
    
    NSArray* array = [selection selectionsByLine];
    

            for (PDFSelection* select in array) {
    
                PDFAnnotation* annotation = [[PDFAnnotation alloc] initWithBounds:[select boundsForPage:self.readerPDF.currentPage] forType:PDFAnnotationSubtypeHighlight withProperties:nil];
                
                //[annotation setColor:[UIColor redColor]];
                
                [self.readerPDF.currentPage addAnnotation:annotation];
            
                //NSLog(@"%@",select.string);
                
            }
    
    [self getInformationFromDocument];
    
    NSLog(@"touchesEnded");
}

#pragma mark - Help Methods

- (void) saveChages {
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.indicator setFrame:CGRectMake(CGRectGetMaxX(self.view.frame) / 2,
                                        CGRectGetMaxY(self.view.frame) / 2,
                                         50,
                                         50)];
    

    if (self.readerPDF.document) {
        [self.readerPDF addSubview:self.indicator];
        [self.indicator startAnimating];
        
        [self.readerPDF.document writeToURL:self.readerPDF.document.documentURL];
        
       // [self.indicator stopAnimating];
       // [self.indicator removeFromSuperview];
    }
    
}

- (NSArray*) typesPDF {
    
    NSArray *types = @[@"public.composite-content"];
    return types;
}

#pragma mark - Alerts

- (void) showAlertWhenUserTookWrongDocument {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Its not PDF Document" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - DocumentPickerControllerDelegate


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls {
    
    NSString* string = [[urls lastObject] path];
    NSLog(@"%@", string);

    NSLog(@"%@",[urls lastObject]);
    
    NSString *documentFolderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) firstObject] stringByAppendingString:@"/"];
    NSString *fileName = [[string componentsSeparatedByString:@"/"] lastObject];
    
    NSError *error;
    
    [[NSFileManager defaultManager] copyItemAtPath:string toPath:[documentFolderPath stringByAppendingString:fileName] error:&error];
//
//    PDFDocument* doc = [[PDFDocument alloc] initWithData: [[NSFileManager defaultManager] contentsAtPath:[documentFolderPath stringByAppendingString:fileName]]];
//    NSLog(@"%ld",[doc pageCount]);
//
    
    PDFDocument* doc = [[PDFDocument alloc] initWithURL:[urls lastObject]];
    
    if (doc.string) {
        self.navigationItem.title = doc.string;
    } else {
        self.navigationItem.title = @"Wrong document";
        
        [self.readerPDF removeFromSuperview];
        [self showAlertWhenUserTookWrongDocument];
        
    }
    
    
    
    
    [self.view addSubview:self.readerPDF];
    
    // Timer for update current pages
    
    [NSTimer scheduledTimerWithTimeInterval:0.3
                                     target:self
                                   selector:@selector(updateIndexOfCurrentPage)
                                   userInfo:nil
                                    repeats:YES];

    
    //[self.readerPDF addGestureRecognizer:self.doubleTapGesture];
    
   
    
    self.currentDocument = doc;
    

    [self.readerPDF setDocument:self.currentDocument];
    
    UIColor *topColorForPDF = [UIColor colorWithRed: 144.f / 255.f
                                              green: 203.f / 255.f
                                               blue: 235.f / 255.f
                                              alpha: 1.0];
    
    self.readerPDF.backgroundColor = topColorForPDF;
    

    [self.readerPDF scaleFactorForSizeToFit];
    [self.readerPDF setMaxScaleFactor:100];
    
    [self.readerPDF setMultipleTouchEnabled:YES];
    
    // Get UIImage from current page;
    
    [self.readerPDF.currentPage thumbnailOfSize:CGSizeMake(200, 215)
                                         forBox:kPDFDisplayBoxArtBox];
    
    //self.navigationController.hidesBarsOnTap = YES;
    
    // View Indicator [15 / 30]
    
    self.viewIndicator = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.readerPDF.frame) + 30,
                                                                  CGRectGetMinY(self.readerPDF.frame) + 1050,
                                                                  100,
                                                                  30)];
    
    self.viewIndicator.backgroundColor = [UIColor colorWithRed:33.f/255.f
                                                         green:100.f/255.f
                                                          blue:130.f/255.f
                                                         alpha:1.0];;
    
    self.viewIndicator.alpha = 0.8f;
    self.viewIndicator.layer.cornerRadius = 15;
    
    [self.readerPDF addSubview:self.viewIndicator];
    
    // Text For View Indicator
    
    self.textForViewIndicator = [[UILabel alloc] initWithFrame:CGRectMake(self.viewIndicator.bounds.origin.x + 25,
                                                                          self.viewIndicator.bounds.origin.y,
                                                                          self.viewIndicator.bounds.size.width,
                                                                          self.viewIndicator.bounds.size.height)];
    
    NSInteger numberCurrentPage = (unsigned long)[self.currentDocument indexForPage:self.readerPDF.currentPage] + 1;
    
    
    self.textForViewIndicator.text = [NSString stringWithFormat:@"%lu of %lu", numberCurrentPage , (unsigned long)[self.currentDocument pageCount]];
    
    
    
    self.textForViewIndicator.textColor = [UIColor whiteColor];
    [self.viewIndicator addSubview:self.textForViewIndicator];
    self.viewIndicator.autoresizingMask =    UIViewAutoresizingFlexibleRightMargin   | UIViewAutoresizingFlexibleTopMargin   |
                                             UIViewAutoresizingFlexibleLeftMargin    | UIViewAutoresizingFlexibleBottomMargin ;

    
    
    // Count page with annotations
    
    // Get index page with annotations
    
    [self getInformationFromDocument];
    
    self.arrayWithSelectionsForSearch = [NSMutableArray array];
    
    
   
    NSLog(@"didPickDocumentsAtURLs");
}


#pragma mark - Methods for NSTimers

- (void) updateIndexOfCurrentPage {
    self.textForViewIndicator.text = [NSString stringWithFormat:@"%lu of %lu", (unsigned long)[self.currentDocument indexForPage:self.readerPDF.currentPage] + 1, (unsigned long)[self.currentDocument pageCount]];
    
    [self.textForViewIndicator setAdjustsFontSizeToFitWidth:YES];
}

#pragma mark - ColorsPopoverViewControllerDelegate

- (void)changeColorAction:(UIColor *)color {
    
    // Set color
    self.currentAnnotationColor = [UIColor clearColor];
    self.currentAnnotationColor = color;
    
    // Init selection
    
    PDFSelection* select = [[PDFSelection alloc] initWithDocument:self.readerPDF.document];
    [select addSelection:self.readerPDF.currentSelection];
    
    CGRect rect = [select boundsForPage:self.readerPDF.currentPage];
 
    PDFAnnotation* annnotation = [[PDFAnnotation alloc] initWithBounds:rect forType:PDFAnnotationSubtypeHighlight withProperties:nil];
    
    [annnotation setColor:[UIColor clearColor]];
    [annnotation setColor:color];
    
    [self.readerPDF.currentPage addAnnotation:annnotation];
    [self.drawAnnotation setColor:color];
    
    
    
    // Profit!
    
}

#pragma mark - PDFView Delegate


- (void)PDFViewPerformGoToPage:(PDFView *)sender {
    NSLog(@"PDFViewPerformGoToPage");
}

- (void)PDFViewOpenPDF:(PDFView *)sender forRemoteGoToAction:(PDFActionRemoteGoTo *)action {
    NSLog(@"Open document");
}

#pragma mark - Make Annotation

- (void) makeAnnotationWithType:(PDFAnnotationSubtype) type andColor:(UIColor*) color {
    
    PDFSelection* select = [[PDFSelection alloc] initWithDocument:self.readerPDF.document];
    [select addSelection:self.readerPDF.currentSelection];
    
    NSArray* arrayByLine = self.readerPDF.currentSelection.selectionsByLine;
   
    for (PDFSelection* select in arrayByLine) {
        PDFAnnotation* annnotation = [[PDFAnnotation alloc] initWithBounds:[select boundsForPage:self.readerPDF.currentPage] forType:type withProperties:nil];
        
        [annnotation setColor:color];
        [self.readerPDF.currentPage addAnnotation:annnotation];
    }
    
}

#pragma mark - Add Annotation from UIMenuItem

- (void) addStrikeAnnotation {
    [self makeAnnotationWithType:PDFAnnotationSubtypeStrikeOut andColor:[UIColor redColor]];
}

- (void) addHighlightAnnotation {
    
    PDFSelection* select = [[PDFSelection alloc] initWithDocument:self.readerPDF.document];
    [select addSelection:self.readerPDF.currentSelection];
    
    NSArray* arrayByLine = self.readerPDF.currentSelection.selectionsByLine;
    
    CGRect rect = [select boundsForPage:self.readerPDF.currentPage];
    
    //NSLog(@"%@", NSStringFromCGRect(rect));
    //NSLog(@"%@", select.string);
    
    for (PDFSelection* select in arrayByLine) {
        PDFAnnotation* annnotation = [[PDFAnnotation alloc] initWithBounds:[select boundsForPage:self.readerPDF.currentPage] forType:PDFAnnotationSubtypeHighlight withProperties:nil];
    
        [self.readerPDF.currentPage addAnnotation:annnotation];
    }
    
    [self getInformationFromDocument];
    
}

- (void) removeSelectedAnnotation {
    
    // Get annotation after selected
    
    PDFSelection* select = [[PDFSelection alloc] initWithDocument:self.readerPDF.document];
    [select addSelection:self.readerPDF.currentSelection];
    
    NSLog(@"ANNOTATIONS COUNT: %ld", [self.readerPDF.currentPage.annotations count]);
    
    CGRect point = [select boundsForPage:self.readerPDF.currentPage];
    
    NSArray* annotations = self.readerPDF.currentPage.annotations;
    NSMutableArray* annotationForDel = [NSMutableArray array];
    
    for (PDFAnnotation* annotation in annotations) {
        if (CGRectContainsPoint(point , annotation.bounds.origin )) {
            [annotationForDel addObject:annotation];
        }
    }
    
    NSLog(@"%ld", [annotationForDel count]);
    
    
    // Remove selected annotations from page
    
    for (PDFAnnotation* annotation in annotationForDel) {
        [self.readerPDF.currentPage removeAnnotation:annotation];
    }
    

    // Remove other annotations
    
    NSArray* arrayAnnotation = self.readerPDF.currentPage.annotations;
    
    CGRect annotationInRect = [self.readerPDF.currentSelection boundsForPage:self.readerPDF.currentPage];
    
    for (PDFAnnotation* ann in arrayAnnotation) {
        
        NSLog(@"%@",NSStringFromCGRect(ann.bounds));
        NSLog(@"%@",NSStringFromCGRect(annotationInRect));
        
        if  (CGRectContainsPoint(ann.bounds, annotationInRect.origin)) {
            [self.readerPDF.currentPage removeAnnotation:ann];
            
            NSLog(@"%@",NSStringFromCGRect(ann.bounds));
            NSLog(@"%@",NSStringFromCGRect(annotationInRect));
            
            NSLog(@"Contains: Remove");
            
            return;
            //return;
        }
    }
    
    [self getInformationFromDocument];
}

- (void) testRemoveAnnotation {
    
    PDFSelection* select = [[PDFSelection alloc] initWithDocument:self.readerPDF.document];
    [select addSelection:self.readerPDF.currentSelection];
    
    CGRect annotationInRect = [self.readerPDF.currentSelection boundsForPage:self.readerPDF.currentPage];
    
    PDFAnnotation* annotation = [[PDFAnnotation alloc] init];
    [annotation setBounds:annotationInRect];
    
    NSArray* arrayAnnotation = self.readerPDF.currentPage.annotations;
    
    for (PDFAnnotation* ann in arrayAnnotation) {
        
        NSLog(@"%@",NSStringFromCGRect(ann.bounds));
        NSLog(@"%@",NSStringFromCGRect(annotationInRect));
       
       if  (CGRectContainsPoint(ann.bounds, annotationInRect.origin)) {
           [self.readerPDF.currentPage removeAnnotation:ann];
           
           NSLog(@"%@",NSStringFromCGRect(ann.bounds));
           NSLog(@"%@",NSStringFromCGRect(annotationInRect));
           
            NSLog(@"Contains: Remove");
           
           return;
           
        }
    }
}

#pragma mark - PagesAnnotationsViewControllerDelegate

- (void) goToPage:(NSInteger) pageIndex {

    PDFPage* page = [self.readerPDF.document pageAtIndex:pageIndex];
    [self.readerPDF goToPage:page];
}

#pragma mark - Get needed information from PDF Document

- (void) getInformationFromDocument {
    
    NSLog(@"%lu",[self.readerPDF.document pageCount]);
    
    NSInteger pageWithAnnotations = 0;
    self.arrayOfIndexPageWithAnnotations = [NSMutableArray array];
    self.previewImage  = [NSMutableArray array];
    NSMutableArray* arraySelections = [NSMutableArray array];
    
    for (int i = 0; i < [self.readerPDF.document pageCount]; i++ ) {
        
        PDFPage* curPage = [self.readerPDF.document pageAtIndex:i];
        
        if ([curPage.annotations count] != 0) {
            
            for (PDFAnnotation* ann in curPage.annotations) {
                
                //NSLog(@"%@",ann.type);
                
                if ([ann.type isEqualToString:@"Highlight"]) {
                    
                    PDFSelection* selection = [self.readerPDF.currentPage selectionForRect:[ann bounds]];
                    
                   
                    [arraySelections addObject:selection];
                    
                    NSLog(@"%ld",[arraySelections count]);
                    
                    NSLog(@"%@",[[arraySelections lastObject] string]);
                    
                    if ([NSNumber numberWithInt:i] != [self.arrayOfIndexPageWithAnnotations lastObject]) {
                        [self.arrayOfIndexPageWithAnnotations addObject:[NSNumber numberWithInt:i]];
                        
                        UIImage* image = [curPage thumbnailOfSize:CGSizeMake(220, 255) forBox:kPDFDisplayBoxMediaBox];
                        
                        [self.previewImage addObject:image];
                        pageWithAnnotations += 1;
                        
                    }
                }
            }
        }
    }
}
    

#pragma mark - Device Orientation

#pragma mark - SearchWordsInAnnotationViewControllerDelegate

- (void) goSearchWithString:(NSString*) text {
    
    self.wordForSearch =  text;
    
    NSLog(@"%@", self.wordForSearch);
    
    //[self.popoverSearch dismissPopoverAnimated:YES];
    
    NSInteger countPages = [self.readerPDF.document pageCount];
    
    for (NSInteger i = 0; i < countPages; i++) {

        PDFPage* page = [self.readerPDF.document pageAtIndex:i];
        
        for (PDFAnnotation* annotation in page.annotations) {
            
            if ([annotation.type isEqualToString:@"Highlight"]) {
                
                PDFSelection* selection = [page selectionForRect:annotation.bounds];
                
                PDFSelection* selectionFind = [self.readerPDF.document findString:self.wordForSearch fromSelection:selection withOptions:NSCaseInsensitiveSearch];
                
                [self.arrayWithSelectionsForSearch addObject:selectionFind];
              
                //PDFSelection* selectionWithWords = [self.readerPDF.document findString:text fromSelection:selection withOptions:NSCaseInsensitiveSearch];
                
//                if ([selection.string containsString:text]) {
//                     [self.arrayWithSelectionsForSearch addObject:selectionWithWords];
//           }
        }
    }
        
        for (PDFSelection* sel in self.arrayWithSelectionsForSearch) {
            NSLog(@"%@",sel.string);
        }
    
    if ([self.arrayWithSelectionsForSearch count] != 0) {
        
        PDFSelection* selectionn = [self.arrayWithSelectionsForSearch objectAtIndex:self.indexForSearch];
        
        self.selectionTest = [self.readerPDF.document findString:self.wordForSearch fromSelection:selectionn withOptions:NSCaseInsensitiveSearch];
        
        self.indexForSearch += 1;
        
        if (self.indexForSearch == [self.arrayWithSelectionsForSearch count] ) {
            self.indexForSearch = 0;
        }
        
        NSLog(@"ARRRAAAYYY: %ld", [self.arrayWithSelectionsForSearch count]);
        
        [self.readerPDF goToSelection:selectionn];
        [self.readerPDF setCurrentSelection:selectionn animate:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.readerPDF setCurrentSelection:nil];
        });
    }
    
        [self updateIndexOfCurrentPage];
        [self.arrayWithSelectionsForSearch removeAllObjects];
}


}

@end
