<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <!-- %invoke wm.sap.Monitor:chopSAPLog% -->
    <title>WmSAP - Logging</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1"></meta>
    <!-- %ifvar numOfParts equals('1')% -->
    <meta http-equiv="refresh"
	  content="0;url=/WmSAP/monitoringDisplay.dsp?adapterTypeName=WmSAP&fullName=%value urlName%&amp;begin=%value parts[0]%&amp;end=%value parts[1]%"></meta>
    <!-- %endif% -->
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/monitoring.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LG_SAPADA', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Logging &gt; Details of IS Log File</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a onmouseover="window.status='Back'; return true"
		   onmouseout="window.status='';return true"
		   href="/WmSAP/monitoring.dsp?adapterTypeName=WmSAP">Return to Logging</a></li>
	  </ul>
	</td>
      </tr>
      <!-- %ifvar message equals('Ok')% -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">IS Log File %value name%
		  has %value numOfParts% page(s) of
		  aprox. 500K:</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop parts[]% -->
	      <tr>
		<td class="evenrowdata" colspan="2">
		  <a href="monitoringDisplay.dsp?adapterTypeName=WmSAP&amp;fullName=%value -urlencode fullName%&amp;begin=%value -urlencode parts[0]%&amp;end=%value -urlencode parts[1]%">Bytes %value -urlencode parts[0]% to %value -urlencode parts[1]%</a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!-- %else% -->
      <tr>
	<td colspan="2" class="message">%value message%</td>
      </tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      <!-- %endif% -->
    </table>
    %onerror% 
	%include error.html%
    %endinvoke%
  </body>
</html>