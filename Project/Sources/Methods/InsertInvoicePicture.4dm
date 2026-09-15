//%attributes = {}

C_PICTURE:C286($barcode)


C_TEXT:C284($0)
$0:=String:C10(Random:C100)

//C_PICTURE($0)
//$0:=[INVOICE]BarCode

//BEEP


$barcode:=[INVOICE:3]BarCode:6
TRANSFORM PICTURE:C988($barcode; Crop:K61:7; 0; 0; 200; 40)
pictRange:=WP Bookmark range:C1416(WParea; "Invoice_BarCode")
WP Insert picture:C1437(pictRange; $barcode; wk replace:K81:177)


//ARRAY TEXT(_Methods;0)
//APPEND TO ARRAY(_Methods;"InsertInvoicePicture")
//SET ALLOWED METHODS(_Methods)