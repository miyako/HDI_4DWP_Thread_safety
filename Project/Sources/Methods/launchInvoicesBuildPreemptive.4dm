//%attributes = {"preemptive":"capable"}

C_LONGINT:C283($1; $isPreemptif; $3; $nbOfCustomer; $4; $counterCustomer)
C_TIME:C306($2; $timeToDie)

$isPreemptif:=$1
$timeToDie:=$2
$nbOfCustomer:=$3
$counterCustomer:=$4

//create invoices for each customer with the following method
For ($counterCustomer; 1; $nbOfCustomer)
	
	// the 8th template is my favorite. Select another template if you want to.
	BuildInvoices($CounterCustomer; 8; $isPreemptif; $timeToDie)
	
End for 
