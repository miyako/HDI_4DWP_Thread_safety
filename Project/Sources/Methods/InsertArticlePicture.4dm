//%attributes = {"invisible":true}

#DECLARE->$randomName : Text
$randomName:=String:C10(Random:C100)


vIcon:=[ARTICLES:5]Icon:8
pictRange:=WP Bookmark range:C1416(WParea; "Article_Icon")

If (True:C214)
	
	WP Insert picture:C1437(pictRange; vIcon; wk replace:K81:177)
	
End if 

