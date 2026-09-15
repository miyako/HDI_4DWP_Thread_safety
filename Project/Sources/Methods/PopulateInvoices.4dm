//%attributes = {"invisible":true}
C_LONGINT:C283($nbArticles; $nbCustomers; $nbInvoices; $nbLines)
C_LONGINT:C283($i; $j; $k)

ALL RECORDS:C47([ARTICLES:5])
$nbArticles:=Records in selection:C76([ARTICLES:5])

ALL RECORDS:C47([CUSTOMER:2])
$nbCustomers:=Records in selection:C76([CUSTOMER:2])
For ($i; 1; $nbCustomers)
	
	GOTO SELECTED RECORD:C245([CUSTOMER:2]; $i)
	
	$nbInvoices:=1  //+(Random%5)  // 1 to 5 invoices by customers
	For ($j; 1; $nbInvoices)
		CREATE RECORD:C68([INVOICE:3])
		
		[INVOICE:3]InvoiceDate:3:=Add to date:C393(Current date:C33; 0; 0; (Random:C100%100)-100)
		[INVOICE:3]CustomerReference:4:=[CUSTOMER:2]CustomerNumber:9
		[INVOICE:3]OrderID:5:=String:C10(Random:C100%100; "000")+"-"+String:C10(Random:C100%100; "000")+"-"+String:C10(Random:C100%100; "000")
		
		$nbLines:=10+(Random:C100%11)  // 10 to 20 lines by invoice
		For ($k; 1; $nbLines)
			CREATE RECORD:C68([INVOICE_LINES:4])
			
			GOTO SELECTED RECORD:C245([ARTICLES:5]; (Random:C100%$nbArticles)+1)
			
			[INVOICE_LINES:4]InvoiceReference:2:=[INVOICE:3]InvoiceNumber:2
			[INVOICE_LINES:4]ArticleReference:3:=[ARTICLES:5]ArticleNumber:2
			[INVOICE_LINES:4]Quantity:4:=1+Num:C11(Random:C100>22000)  // usually one, sometimes 2
			
			SAVE RECORD:C53([INVOICE_LINES:4])
		End for 
		
		SAVE RECORD:C53([INVOICE:3])
	End for 
End for 

ALERT:C41("done")




