C_LONGINT:C283($vNumRecordsInSel; $vNumCurrentRecord)

SAVE RECORD:C53([INVOICES_CREATED:9])
NEXT RECORD:C51([INVOICES_CREATED:9])


$vNumRecordsInSel:=Records in selection:C76([INVOICES_CREATED:9])

$vNumCurrentRecord:=Selected record number:C246([INVOICES_CREATED:9])

vRecNum:=String:C10($vNumCurrentRecord)+" of "+String:C10($vNumRecordsInSel)


Case of 
		
	: (($vNumRecordsInSel=0) | ($vNumRecordsInSel=1))
		OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
		
	: ($vNumCurrentRecord>=$vNumRecordsInSel)
		OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; True:C214)
		
	: ($vNumCurrentRecord=1)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)
		
	Else 
		OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)
		OBJECT SET ENABLED:C1123(*; "bPrevious"; True:C214)
		
End case 