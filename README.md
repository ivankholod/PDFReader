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
  - I solved this problem.
 
- Handle UITouchDelegate:
  - Put subview on PDFView when user turn on "Pencil Mode"
  - Subiew removed from super view when called method: UITouchEnden

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
 

