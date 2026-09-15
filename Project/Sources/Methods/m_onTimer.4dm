//%attributes = {"invisible":true}

var $timeToDie; $vStartTime : Time
var $isPreemptif; $nbOfCustomer; $nbOfTemplate; $nbWorker; $counterCustomer; $i; $currentPage : Integer
var $workerName : Text
var $timeFaster : Real

Case of 
		
		
	: (<>Step=0)
		vTher:=vTher+25
		
		//Get the time we want to create invoices. 
		$vStartTime:=Current time:C178
		$timeToDie:=$vStartTime+vNumSec
		
		
		// Launch preemptive
		
		$isPreemptif:=1  // 1 is for preemptif
		
		ALL RECORDS:C47([TEMPLATES:1])
		ALL RECORDS:C47([CUSTOMER:2])
		
		$nbOfCustomer:=Records in selection:C76([CUSTOMER:2])
		
		$nbWorker:=4  // for now only 4 workers
		
		//create invoices for each customer with different workers
		For ($counterCustomer; 1; $nbOfCustomer)
			//worker names are dynamic
			$workerName:="WorkerPreemp"+String:C10($counterCustomer%$nbWorker)
			
			//test if it is necessary to add work to the worker if the time is passed. 
			If (Current time:C178<$timeToDie)
				
				CALL WORKER:C1389($workerName; "launchInvoicesBuildPreemptive"; $isPreemptif; $timeToDie; $counterCustomer; $nbOfCustomer)
			Else 
				
				KILL WORKER:C1390($workerName)
			End if 
		End for 
		
		//wait until it is really finnish, the last worker need to finish his task
		While ($timeToDie>Current time:C178)
			DELAY PROCESS:C323(Current process:C322; 2)
		End while 
		// A little bit more time, in order to let the workers be killed. 
		DELAY PROCESS:C323(Current process:C322; 30)
		
		<>Step:=<>Step+1
		
		//progression
		vTher:=vTher+25
		
		// message on preemptively created invoices
		QUERY:C277([INVOICES_CREATED:9]; [INVOICES_CREATED:9]isPreemptif:5=1)
		nbInvoicesPreemptif:=Records in selection:C76([INVOICES_CREATED:9])
		vMessageGuiPreemp:="Preemptive process: "+String:C10(nbInvoicesPreemptif)
		OBJECT SET VISIBLE:C603(vMessageGuiPreemp; True:C214)
		
	: (<>Step=1)
		
		
		//get the time we want to create invoices.
		$vStartTime:=Current time:C178
		$timeToDie:=$vStartTime+vNumSec
		
		//Launch cooperative 
		$isPreemptif:=0  // 0 is for cooperative
		
		ALL RECORDS:C47([TEMPLATES:1])
		ALL RECORDS:C47([CUSTOMER:2])
		
		$nbOfCustomer:=Records in selection:C76([CUSTOMER:2])
		
		$nbWorker:=4  // for now only 4 workers
		
		//create invoices for each customer with different workers
		For ($counterCustomer; 1; $nbOfCustomer)
			//worker names are dynamic
			$workerName:="WorkerCoop"+String:C10($counterCustomer%$nbWorker)
			
			//test if it is necessary to add work to the worker if the time is passed. 
			If (Current time:C178<$timeToDie)
				
				CALL WORKER:C1389($workerName; "launchInvoicesBuildCooperative"; $isPreemptif; $timeToDie; $counterCustomer; $nbOfCustomer)
			Else 
				
				KILL WORKER:C1390($workerName)
			End if 
		End for 
		
		
		//wait until it is finnish
		While ($timeToDie>Current time:C178)
			DELAY PROCESS:C323(Current process:C322; 2)
		End while 
		// A little bit more time, in order to let the son workers to be killed. 
		DELAY PROCESS:C323(Current process:C322; 60)
		
		
		<>Step:=<>Step+1
		
		//progression
		vTher:=vTher+25
		
		// message on cooperatively created invoices
		QUERY:C277([INVOICES_CREATED:9]; [INVOICES_CREATED:9]isPreemptif:5=0)
		nbInvoicesCooperatif:=Records in selection:C76([INVOICES_CREATED:9])
		vMessageGuiCoop:="Cooperative process: "+String:C10(nbInvoicesCooperatif)
		OBJECT SET VISIBLE:C603(vMessageGuiCoop; True:C214)
		
		
	: (<>Step=2)
		vTher:=99
		
		vTher:=0
		
		$timeFaster:=nbInvoicesPreemptif/nbInvoicesCooperatif
		
		$timeFaster:=Trunc:C95($timeFaster; 1)
		vMessageGuiCompare:="Preemptive processes have been "+String:C10($timeFaster)+" times faster than cooperative ones"
		OBJECT SET VISIBLE:C603(vMessageGuiCompare; True:C214)
		
		//update message according the last invoices created if we are on the good page
		$currentPage:=FORM Get current page:C276
		If ($currentPage=2)
			QUERY:C277([INVOICES_CREATED:9]; [INVOICES_CREATED:9]isPreemptif:5=1)
			nbInvoicesPreemptif:=Records in selection:C76([INVOICES_CREATED:9])
			vMessageGuiPreemp:="Preemptive process: "+String:C10(nbInvoicesPreemptif)
			QUERY:C277([INVOICES_CREATED:9]; [INVOICES_CREATED:9]isPreemptif:5=0)
			nbInvoicesCooperatif:=Records in selection:C76([INVOICES_CREATED:9])
			vMessageGuiCoop:="Cooperative process: "+String:C10(nbInvoicesCooperatif)
			
			OBJECT SET VISIBLE:C603(vTher; False:C215)
			SET TIMER:C645(30)
		Else 
			SET TIMER:C645(0)
		End if 
End case 
