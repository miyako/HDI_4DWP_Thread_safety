//%attributes = {"invisible":true,"preemptive":"incapable"}

#DECLARE($isPreemptif : Integer; $timeToDie : Time; $counterCustomer : Integer; $nbOfCustomer : Integer)

//create invoices for each customer with the following method
For ($counterCustomer; 1; $nbOfCustomer)
	
	// the 8th template is my favorite. Select another template if you want to.
	BuildInvoices($CounterCustomer; 8; $isPreemptif; $timeToDie)
	
End for 
