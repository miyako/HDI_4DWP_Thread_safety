Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($vers)
		$vers:=Application version:C493
		
		
		If ($vers<"1600")  //1530 means 13R3   1501 means 15.1
			
			<>Quit:=True:C214
			OBJECT SET TITLE:C194(*; "BtnDemo"; "Quit 4D")
			OBJECT SET VISIBLE:C603(*; "TxtSorry@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
			
		Else 
			
			//check if the database run with a 64-bit version
			If (Version type:C495 ?? 64 bit version:K5:25)
				OBJECT SET VISIBLE:C603(*; "TxtNotPreemptive"; False:C215)
				<>Quit:=False:C215
				
				//not 64bits version
			Else 
				OBJECT SET VISIBLE:C603(*; "TxtNotPreemptive"; True:C214)
				<>Quit:=False:C215
			End if 
			
		End if 
End case 