# PDFReader - Smart PDF Reader and Editor

![alt text](https://preview.ibb.co/mVtVv8/desk.png)

# Description

- Now it work only for all IPads, because i used UIPopovers. (You can change it, if you want)
- User can open PDFDocuments from native iOS application "Files"
- PDFDocument automatically saved and synchronizes in ICloud.
- User can highlighted annotation for selected area which finger determined.
- If you want delete annotations - turn on "Pencil Mode" and tap to area!

# How it works?

- I used native PDFKit:
  - https://developer.apple.com/documentation/pdfkit
- For work with documents: UIDocumentPickerViewController:
  - https://developer.apple.com/documentation/uikit/uidocumentpickerviewcontroller
  
- Highlighted text: UITouch and PDFSelection:
  - UITouch dont called when PDFDocument is open.
  - I solved this problem. (Read the text below)
 
- Handle UITouchDelegate:
  - Put subview on PDFView when user turn on "Pencil Mode"
  - Subiew removed from super view when called method: UITouchEnded
  - Use property:
  ``` objective-c
      @property (assign, nonatomic) CGPoint startPoint;
      @property (assign, nonatomic) CGPoint currentMovePoint;
      @property (assign, nonatomic) CGPoint endPoint;
     
  ```
- In touchesBegan: method we will get the coordinates of the first point.
- ❗️ Dont forget! PDFPage and UIVew - different coordinate systems
  - Call this method for convert points from UIView to PDFView page.
  
 ``` objective-c
     [PDFView* view convertPoint:point toPage:self.readerPDF.currentPage]
 ```
  
 ```  objective-c
      -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [super touchesBegan:touches withEvent:event];
    
        UITouch *touch = [touches anyObject];
    
        CGPoint point = [touch locationInView:self.viewForTouch];
    
        self.startPoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];
      
      }
  ```
  
   - In touchesMoved: method we will get the coordinates of the moved point.
   
   ```objective-c
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
   
    }
   ```
  - In touchesEnded: method:
   ```objective-c
     -(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [super touchesEnded:touches withEvent:event];
    
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.viewForTouch];
    
        self.endPoint = [self.readerPDF convertPoint:point toPage:self.readerPDF.currentPage];

        PDFSelection* selection = [self.readerPDF.currentPage selectionFromPoint:self.startPoint toPoint:self.endPoint];
    
        NSArray* array = [selection selectionsByLine];
    
            for (PDFSelection* select in array) {
    
                PDFAnnotation* annotation = [[PDFAnnotation alloc] initWithBounds:[select boundsForPage:self.readerPDF.currentPage] forType:PDFAnnotationSubtypeHighlight withProperties:nil];
                
                [self.readerPDF.currentPage addAnnotation:annotation];
            }
}

```
 
 - Well done! After this we get perfect PDFSelection. And add annotation to selections coordinats.

# Examples

# Just select and autohighlight:

![alt text](https://thumbs.gfycat.com/ThriftyInfiniteKob-size_restricted.gif)


# Also you can use colors from beautiful pallet color:

![alt text](https://thumbs.gfycat.com/WarlikeAntiqueHoatzin-size_restricted.gif)


# Look and navigate on all annotations:

![alt text](https://thumbs.gfycat.com/QuerulousAdolescentAnchovy-size_restricted.gif)

# Just Tap and Remove annotations! :

![alt text](https://thumbs.gfycat.com/HairyPotableHusky-size_restricted.gif)


# It's look so nice:

![alt text](https://image.ibb.co/fOZqv8/onDevice.png)
 

