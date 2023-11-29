<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Transactions</title>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<link REL="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/transactions.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_TS', 'foo');">
    %invoke wm.sap.Transaction:list%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Transactions</td>
      </tr>
      <!-- %ifvar $message -notempty% -->
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	      class="message" colspan="2">%value $message%</td></tr>
      <!-- %endif% -->
      <!-- %ifvar $fault -notempty% -->
      <tr><td style="color: #781863; background-color: #ffe5e9; border-color: #781863;"
	      class="message" colspan="2">%value $fault%</td></tr>
      <!-- %endif% -->
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="transactions.dsp?$action=DeleteSelected&amp;adapterTypeName=WmSAP"
		   onclick="return confirm('Warning: Do you really want to delete the filtered transaction entries?');">Delete Filtered Transactions</a>
	    </li>
	    <li><a href="transactions.dsp?$action=DeleteAll&amp;adapterTypeName=WmSAP"
		   onclick="return confirm('Warning: Do you really want to delete all transaction entries?');">Delete All Transactions</a>
	    </li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="transactions.dsp" method="post">
	  <table class="tableView" width="95%">
	    <thead>
	      <tr>
		<td class="heading" colspan="8">Transaction List Filter</td>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
		<td colspan="8" class="subHeading">Filter Criteria (Regular Expressions supported)</td>
	      </tr>
	      <tr>
		<td class="oddrow">Sender: </td>
		<td class="oddrow-l" colspan="1"><input type="text" size=20 name="senderFC" value="%value senderFC%"></input></td>
		<td class="oddrow">Receiver: </td>
		<td class="oddrow-l" colspan="1"><input type="text" name="receiverFC" value="%value receiverFC%"></input></td>
		<td class="oddrow">Message Type:</td>
		<td class="oddrow-l" colspan="3"><input type="text" name="msgTypeFC" value="%value msgTypeFC%"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow">TID: </td>
		<td class="oddrow-l" colspan="1"><input type="text" name="tidFC" value="%value tidFC%"></input></td>
		<td class="oddrow">State: </td>
		<td class="oddrow-l" colspan="1"><select name="stateFC">
		      	<!-- %scope rparam(stateOptions[]={state=''}|{state='Created'}|{state='Executed'}|{state='Rolledback'}|{state='Committed'}|{state='Confirmed'})% -->
		      	<!-- %loop stateOptions% -->
		      	<option value="%value state encode(htmlattr)%"%ifvar /stateFC vequals(state)% selected="selected"%endif%>%value state encode(html)%</option>
		      	<!-- %endloop% -->
		      	<!-- %endscope% -->
		      	</select></td>
		<td class="oddrow" colspan="3"></td>
	      </tr>
	      <tr>
		<td class="oddrow">Begin Date: </td>
		<td class="oddrow-l" colspan="1"><input type="text" name="startDateFC" value="%value startDateFC%"></input></td>
		<td class="oddrow">End Date: </td>
		<td class="oddrow-l" colspan="1"><input type="text" name="endDateFC" value="%value endDateFC%"></input></td>
		<td class="oddrow">Page Entries:</td>
		<td class="oddrow-l" colspan="3"><input type="text" name="pageEntries" value="%value pageEntries%"></input></td>
	      </tr>
	</tbody>
	
	
	<tr>
	<table class="tableView" width="95%">
		<thead>
	     <tr>
		 %ifvar transactionsTotalCount -notempty%
		  <td class="heading" colspan="8">Transaction List - %value transactionsCount% of %value transactionsTotalCount% Entries match the Filter</td>
		 %else%
		  <td class="heading" colspan="8">Transaction List - %value transactionsCount% Entries</td>
		 %endif%
	      </tr>
		</thead>

	      <!-- %ifvar transactions -notempty% -->
	      <tr>
		<td colspan="8" class="subHeading" style="text-align: center;">
		  %ifvar $from equals('1')%%else%
		  &nbsp;<a class="sort" title="Previous Entries" href="transactions.dsp?adapterTypeName=WmSAP&amp;$chunk=prev&amp;$from=%value $from%&amp;$sortKey=%value $sortKey%&amp;$dir=%value $dir%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">&lt;&lt;</a>&nbsp;
		  %endif%
		  Transactions %value $from% - %value $to%
		  [&nbsp;sorted by
		  %switch $sortKey%
		    %case '$tid'% TID
		    %case 'state'% Status
		    %case 'sender'% Sender
		    %case 'receiver'% Receiver
		    %case 'msgType'% Message Type
		    %case% Date
		  %endswitch%
		  %value $dir%&nbsp;]
		  %ifvar $maxReached -notempty%%else%
		  &nbsp;<a class="sort" title="Next Entries" href="transactions.dsp?adapterTypeName=WmSAP&amp;$chunk=next&amp;$from=%value $from%&amp;$sortKey=%value $sortKey%&amp;$dir=%value $dir%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">&gt;&gt;</a>&nbsp;
		  %endif%
		</td>
	      </tr>
	      <!-- %endif% -->
	      <tr colspan="8">
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Sort by Date %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=date&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">Date</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Sort by $tid %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=$tid&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">TID</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Sort by Status %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=state&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">Status</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Sort by Sender %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=sender&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">Sender</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Sort by Receiver %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=receiver&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">Receiver</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">
		  <a class="sort" title="Message Type %ifvar $dir equals('descending')%asc%else%desc%endif%" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=msgType&amp;$dir=%ifvar $dir equals('descending')%ascending%else%descending%endif%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%&amp">Message Type</a>
		</td>
		<td class="oddrowdata" nowrap="nowrap">Delete <br />
		</td>
	      </tr>
		
	    <tbody id="tbodyNode">
	      <!-- %loop transactions% -->
	      <tr>
		<td class="oddrowdata">
		  %ifvar date% %value date% %else% &nbsp; %endif%
		</td>
		<td class="oddrowdata">
		   <a title="View Message Details" href="transactionsView.dsp?adapterTypeName=WmSAP&amp;$tid=%value $tid%&amp;$sortKey=%value ../$sortKey%&amp;$dir=%value ../$dir%&amp;senderFC=%value ../senderFC%&amp;receiverFC=%value ../receiverFC%&amp;msgTypeFC=%value ../msgTypeFC%&amp;stateFC=%value ../stateFC%&amp;tidFC=%value ../tidFC%&amp;startDateFC=%value ../startDateFC%&amp;endDateFC=%value ../endDateFC%">%value $tid%</a>
		</td>
		<td class="oddrowdata">
		  %value state%
		</td>
		<td class="oddrowdata">
		  %ifvar sender% %value sender% %else% &nbsp; %endif%
		</td>
		<td class="oddrowdata">
		  %ifvar receiver% %value receiver% %else% &nbsp; %endif%
		</td>
		<td class="oddrowdata">
		  %ifvar msgType% %value msgType% %else% &nbsp; %endif%
		</td>
		<td class="oddrowdata">
		  <a title="Delete Message" href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=Delete&amp;$tid=%value $tid%&amp;$sortKey=%value ../$sortKey%&amp;$dir=%value ../$dir%&amp;$from=%value ../$from%&amp;senderFC=%value ../senderFC%&amp;receiverFC=%value ../receiverFC%&amp;msgTypeFC=%value ../msgTypeFC%&amp;stateFC=%value ../stateFC%&amp;tidFC=%value ../tidFC%&amp;startDateFC=%value ../startDateFC%&amp;endDateFC=%value ../endDateFC%&amp">
		    <img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
		<td colspan="8" class="action">
		  <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
		  <input type="submit" name="mode" value="Apply Filter"></input>
		</td>
	  </table>
	  <script type="text/javascript">swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>
