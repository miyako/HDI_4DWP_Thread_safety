//%attributes = {"invisible":true}
//the button already has "accept" standard action
If (FORM Event.code=On Clicked)
	
	If (Form.quit)
		INVOKE ACTION(ak return to design mode)
	Else 
		
		var $window : Integer
		$window:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		SET WINDOW TITLE(Get window title(Current form window); $window)
		DIALOG:C40("HDI2"; *)
		
	End if 
	
End if 
