<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Logging</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/monitoring.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LG', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Logging</td>
      </tr>
      <!-- %ifvar RFCmessage% -->
      <tr><td colspan="2" class="space">&nbsp;</td></tr>
      <tr>
	<td class="message" colspan="2">%value RFCmessage%</td>
      </tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      <!-- %endif% -->
      <!-- %ifvar SAPmessage% -->
      <tr><td colspan="2" class="space">&nbsp;</td></tr>
      <tr>
	<td colspan="2" class="message">%value SAPmessage%</td>
      </tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      <!-- %endif% -->
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="monitoring.dsp?adapterTypeName=WmSAP">Refresh</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  %invoke wm.sap.Monitor:getList%
	  <!-- RFC Trace Files -->
	  <table width="95%" class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="4">Overview over RFC Trace Files</td>
	      </tr>
	    </thead>
	    <!-- %ifvar propertyTable% -->
	    <tbody>
	      <tr>
		<td class="oddcol" width="14%">Trace File</td>
		<td class="oddcol" width="14%">Size (byte)</td>
		<td class="oddcol">Created On</td>
		<td class="oddcol">Delete
		  <a href="../invoke/wm.sap.Monitor/deleteAll?type=RFC"><small>Delete All</small></a>
		</td>
	      </tr>
	    </tbody>
	    <tbody id="tbodyNode">
	      <!-- %loop propertyTable% -->
	      <tr>
		<td class="oddrowdata">
		  <a href="monitoringRfcTrace.dsp?adapterTypeName=WmSAP&name=%value -urlencode index=0%">%value index=0%</a>
		</td>
		<td class="oddrowdata-r">%value index=1%</td>
		<td class="oddrowdata-r">%value index=2%</td>
		<td class="oddrowdata" width="55">
		  <a href="/invoke/wm.sap.Monitor/deleteSingle?fullName=%value -urlencode index=0%">
		    <img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img>
		  </a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <!-- %else% -->
	     <!-- %ifvar invalidDir% -->
	      <tbody id="tbodyNode">
	       <tr>
		 <td class="message" colspan="4">Invalid RFC trace directory: %value invalidDir%</td>
	       </tr>
	      </tbody>
	     <!-- %else% -->
	      <tbody id="tbodyNode">
	       <tr>
		 <td class="message" colspan="4">There are currently no RFC
		   trace files</td>
	       </tr>
	      </tbody>
	     <!-- %endif% -->
	    <!-- %endif% -->

	    <!-- IS Log Files -->
	    <tbody>
	      <tr><td class="space" colspan="4">&nbsp;</td></tr>
	      <tr>
		<td class="heading" colspan="4">Overview over IS Log Files</td>
	      </tr>
	    </tbody>
	    <!-- %ifvar logPropertyTable% -->
	    <tbody>
	      <tr>
		<td class="oddcol" width="14%">Log File</td>
		<td class="oddcol" width="14%">Size (byte)</td>
		<td class="oddcol" colspan=2>Created On</td>
	      </tr>
	    </tbody>
	    <tbody id="tbodyNode2">
	      <!-- %loop logPropertyTable% -->
	      <tr>
		<td class="oddrowdata">
		  <a href="monitoringSapLog.dsp?adapterTypeName=WmSAP&fullName=%value -urlencode path%%value -urlencode index=0%">%value index=0%</a>
		</td>
		<td class="oddrowdata-r">%value index=1%</td>
		<td class="oddrowdata-r" >%value index=2%</td>
		<td class="oddrowdata-r" ></td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <!-- %else% -->
	    <tbody id="tbodyNode2">
	      <tr>
		<td colspan="4" class="message">There are currently no
		  IS log files</td>
	      </tr>
	    </tbody>
	    <!-- %endif% -->
	  </table>
	  <script type="text/javascript">swapColor('tbodyNode', false);</script>
	  <script type="text/javascript">swapColor('tbodyNode2', false);</script>
	  %onerror%
	  %include error.html%
	  %endinvoke%
	</td>
      </tr>
    </table>
  </body>
</html>
