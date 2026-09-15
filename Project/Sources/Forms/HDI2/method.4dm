//%attributes = {"invisible":true}
var $tutoPath : Text
var $vNumRecordsInSel; $vNumCurrentRecord : Integer

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		init_HDI
		
		vNumSec:=3  // set 3 sec for beginning
		
		vTotalHT:=0
		vTotalVAT:=0
		vTotalTTC:=0
		
		vMessageGuiCompare:=""
		vMessageGuiCoop:=""
		vMessageGuiPreemp:=""
		
		ALL RECORDS:C47([TEMPLATES:1])
		GOTO SELECTED RECORD:C245([TEMPLATES:1]; 8)
		WParea:=OB Copy:C1225([TEMPLATES:1]WP:2)
		
		//----------------------------------------------------------------
		deleteAllRecords
		
		ALL RECORDS:C47([CUSTOMER:2])
		ORDER BY:C49([CUSTOMER:2]; [CUSTOMER:2]Lastname:2; >)
		CREATE EMPTY SET:C140([CUSTOMER:2]; "$customersSet")
		ADD TO SET:C119([CUSTOMER:2]; "$customersSet")
		
		ARRAY LONGINT:C221(_processID; 0)
		
	: (Form event code:C388=On Page Change:K2:54)
		
		//for showing the invoices which have been created. 
		ALL RECORDS:C47([INVOICES_CREATED:9])
		GOTO SELECTED RECORD:C245([INVOICES_CREATED:9]; 1)
		$vNumRecordsInSel:=Records in selection:C76([INVOICES_CREATED:9])
		
		//message record number/record selected
		$vNumRecordsInSel:=Records in selection:C76([INVOICES_CREATED:9])
		$vNumCurrentRecord:=Selected record number:C246([INVOICES_CREATED:9])
		
		
		// the button next/previous record initialized
		OBJECT SET ENABLED:C1123(*; "bPrevious"; False:C215)
		If ($vNumRecordsInSel>0)
			OBJECT SET ENABLED:C1123(*; "bNext"; True:C214)
			vRecNum:=String:C10(1)+" of "+String:C10($vNumRecordsInSel)
		Else 
			OBJECT SET ENABLED:C1123(*; "bNext"; False:C215)
			vRecNum:=String:C10(0)+" of "+String:C10($vNumRecordsInSel)
		End if 
		
		
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		m_onTimer
		
End case 
