//%attributes = {"invisible":true}
// load descriptions

var $platform : Integer
var $dataClass; $path; $project : Text

//check if the database run in compiled mode
If (Is compiled mode:C492=True:C214)
	OBJECT SET VISIBLE:C603(*; "txtNotCompiled@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "recNotCompiled@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "txtNotCompiled@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "recNotCompiled@"; True:C214)
End if 

For each ($dataClass; ds:C1482)
	If (ds:C1482[$dataClass].getCount()=0)
		$path:=File:C1566("/RESOURCES/"+$dataClass+".4ie").platformPath
		If (Test path name:C476($path)=Is a document:K24:1)
			$project:=File:C1566("/RESOURCES/"+$dataClass+".4si").getText()
			IMPORT DATA:C665($path; $project)
		End if 
	End if 
End for each 

ARRAY TEXT:C222(TabControl; 0)
ARRAY TEXT:C222(TextTabControl; 0)
ALL RECORDS:C47([SAMPLES:8])
ORDER BY:C49([SAMPLES:8]; [SAMPLES:8]SampleSort:4)
SELECTION TO ARRAY:C260([SAMPLES:8]Title:2; TabControl)
SELECTION TO ARRAY:C260([SAMPLES:8]Text:3; TextTabControl)
UNLOAD RECORD:C212([SAMPLES:8])

Var1:=TextTabControl{1}
Var2:=TextTabControl{2}

_O_PLATFORM PROPERTIES:C365($platform)

If ($platform=Windows:K25:3)
	ST SET ATTRIBUTES:C1093(Var1; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 18)
	ST SET ATTRIBUTES:C1093(Var2; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 8)
End if 
