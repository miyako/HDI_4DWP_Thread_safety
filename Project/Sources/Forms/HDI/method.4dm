//%attributes = {"invisible":true}
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form.quit:=False
		
		//check if the database run with a 64-bit version
		If (Version type:C495 ?? 64 bit version:K5:25)
			OBJECT SET VISIBLE:C603(*; "TxtNotPreemptive"; False:C215)
			
			//not 64bits version
		Else 
			OBJECT SET VISIBLE:C603(*; "TxtNotPreemptive"; True:C214)
		End if 
		
End case 
