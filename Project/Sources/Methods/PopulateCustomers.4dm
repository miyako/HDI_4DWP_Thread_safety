//%attributes = {}
//C_TEXT($companyName)
//FakeData_ArraysInit ("en")

//ARRAY POINTER($Ptr;40)

//  //$Ptr{1} := pointer on TITLE
//  //$Ptr{2} := pointer on ABREVIATED TITLE
//$Ptr{3}:=->[CUSTOMER]Firstname
//  //$Ptr{4} := pointer on SECONDNAME
//$Ptr{5}:=->[CUSTOMER]Lastname
//  //$Ptr{6} := pointer on SUFFIX (ex: Jr)
//  //$Ptr{7} := pointer on MAIDEN NAME
//  //$Ptr{8} := pointeur on GENDER (`false = male; true = female) ->BOOLEAN
//  //$Ptr{9} := pointer on LASTNAME2 (when two lastnames are needed)
//  //$Ptr{10} := ---- unused yet ---

//$Ptr{11}:=->[CUSTOMER]Adress
//$Ptr{12}:=->[CUSTOMER]ZipCode
//$Ptr{13}:=->[CUSTOMER]City
//  //$Ptr{14} := pointer on STATE
//  //$Ptr{15} := pointer on COUNTRY
//$Ptr{16}:=->[CUSTOMER]Phone
//  //$Ptr{17} := pointer on MOBILE
//  //$Ptr{18} := pointer on FAX
//$Ptr{19}:=->[CUSTOMER]Email
//  //$Ptr{20} := ---- unused yet ---

//$Ptr{21}:=->$companyName
//  //$Ptr{22} := pointer on JOB TYPE
//  //$Ptr{23} := pointer on DEPARTMENT NAME
//  //$Ptr{24} := ---- unused yet ---
//  //$Ptr{25} := ---- unused yet ---
//  //$Ptr{26} := ---- unused yet ---
//  //$Ptr{27} := ---- unused yet ---
//  //$Ptr{28} := ---- unused yet ---
//  //$Ptr{29} := ---- unused yet ---
//  //$Ptr{30} := ---- unused yet ---

//  //$Ptr{31} := pointer on FAKE TEXT (ex: descriptions, etc.)
//  //$Ptr{32} := pointer on FAKE TEXT (ex: descriptions, etc.)
//  //$Ptr{33} := pointer on FAKE TEXT (ex: descriptions, etc.)
//  //$Ptr{34} := pointer on fake NUMERIC
//C_LONGINT($i)
//For ($i;1;133)

//CREATE RECORD([CUSTOMER])

//FakeData_FillFields (->$Ptr)

//SAVE RECORD([CUSTOMER])

//End for 

