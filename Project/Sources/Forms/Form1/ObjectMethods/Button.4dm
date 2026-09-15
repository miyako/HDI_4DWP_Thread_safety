C_TEXT:C284($pathDirectory; $pathDocument)

$pathDirectory:=Get 4D folder:C485(Current resources folder:K5:16)+"Invoices"+Folder separator:K24:12
$pathDocument:=Select document:C905($pathDirectory; ""; ""; 0)

If (ok=1)
	WpAreaVisualizeDoc:=WP Import document:C1318(document)
End if 