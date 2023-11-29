<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Transactions</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
 
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/transactions.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_TS_TID', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Transactions &gt; TID %value $tid%</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="transactions.dsp?adapterTypeName=WmSAP&amp;$action=List&amp;$sortKey=%value $sortKey%&amp;$dir=%value $dir%&amp;senderFC=%value senderFC%&amp;receiverFC=%value receiverFC%&amp;msgTypeFC=%value msgTypeFC%&amp;stateFC=%value stateFC%&amp;tidFC=%value tidFC%&amp;startDateFC=%value startDateFC%&amp;endDateFC=%value endDateFC%">Return to Transaction List</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form method="get" action="transactions.dsp">
	    %invoke wm.sap.Transaction:get%
	    %invoke wm.sap.Transaction:getMessageBody%
	    %invoke wm.sap.Transaction:inspectPipeline%
	    <table class="tableView">
	      <thead>
		<tr>
		  <td class="heading" colspan="2">Header information</td>
		</tr>
		<tr>
		  <td class="oddrow">TID</td>
		  <td class="oddrowdata-l">%value $tid%</td>
		</tr>
		<tr>
		  <td class="evenrow">Sender</td>
		  <td class="evenrowdata-l">%value sender%</td>
		</tr>
		<tr>
		  <td class="oddrow">Receiver</td>
		  <td class="oddrowdata-l">%value receiver%</td>
		</tr>
		<tr>
		  <td class="evenrow">Message Type</td>
		  <td class="evenrowdata-l">%value msgType%</td>
		</tr>
		<tr>
		  <td class="oddrow">Date</td>
		  <td class="oddrowdata-l">%value date%</td>
		</tr>
		<tr><td class="space" colspan="2">&nbsp;</td></tr>
		<tr>
		  <td colspan="2" class="heading">Transaction Status</td>
		</tr>
		<tr>
		  <td class="oddrow">Current State</td>
		  <td class="oddrowdata-l">%value state%</td>
		</tr>
		<tr><td class="space" colspan="2">&nbsp;</td></tr>
		<tr>
		  <td colspan="2" class="heading">Received Message Body</td>
		</tr>
		<tr>
		  %ifvar -exists $msgBodyNotFound%
		    %ifvar $msgBodyNotFound equals('true')%
			<td colspan="2" class="oddrow-l">Message body not persisted...</td>
		    %else%
			<td colspan="2" class="oddrow-l">Error while reading message body file!</td>
		    %endif%
		  %else%
		   <td class="oddrow">View...</td>
		   <td class="oddrowdata-l">
		    <a href="/invoke/wm.sap.Transaction/viewAs?type=xml&amp;$tid=%value $tid%&amp;receiver=%value -urlencode receiver%&amp;msgType=%value -urlencode msgType%&amp;secureCSRFToken=%value secureCSRFToken%">message body as XML</a><br />
		   %ifvar represents equals('idoc')%
		     <a href="/invoke/wm.sap.Transaction/viewAs?type=html&amp;$tid=%value $tid%&amp;receiver=%value -urlencode receiver%&amp;msgType=%value -urlencode msgType%&amp;$sortKey=%value $sortKey%&amp;$dir=%value $dir%&amp;secureCSRFToken=%value secureCSRFToken%">message body as HTML</a><br />
		   %endif%
		     <a href="/invoke/wm.sap.Transaction/viewAs?type=values&amp;$tid=%value $tid%&amp;receiver=%value -urlencode receiver%&amp;msgType=%value -urlencode msgType%&amp;secureCSRFToken=%value secureCSRFToken%">complete pipeline</a>
		   </td>
		  %endif%
		</tr>
		<tr><td class="space" colspan="2">&nbsp;</td></tr>
		<tr>
		  <td colspan="2" class="heading">Audit Log</td>
		</tr>
	      </thead>
	      <tbody id="tbodyNode">
		<!-- %loop auditLog% -->
		<tr>
		  <td class="oddrowdata">%value date%</td>
		  <td class="oddrowdata-l">%value message%</td>
		</tr>
		<!-- %endloop% -->
	      </tbody>
	      <tbody>
		<tr><td class="space" colspan="2">&nbsp;</td></tr>
		<tr>
		  <td class="action" colspan="2" style="border: none;">
		    <input type="submit" name="$action" value="Delete"></input>
		    <input type="hidden" name="$tid" value="%value $tid%"></input>
		    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
		  </td>
		</tr>
	      </tbody>
	    </table>
	    %endinvoke%
	    <script>swapColor('tbodyNode', false);</script>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
