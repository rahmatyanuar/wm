<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Logging</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/monitoring.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LG_RFC', 'foo');">
    %invoke wm.sap.Monitor:parseFile%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Logging &gt; RFC Trace Files</td>
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
		<td class="heading" colspan="2">Trace File %value name% has %value numOfParts% log
		  %ifvar numOfParts equals('1')%entry%else%entries%endif%:</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop parts[]% -->
	      <tr>
		<td class="evenrowdata">Time of entry:</td>
		<td class="evenrowdata">
		  <a href="monitoringDisplay.dsp?adapterTypeName=WmSAP&fullName=%value -urlencode name%&amp;begin=%value -urlencode parts[1]%&amp;end=%value -urlencode parts[2]%">
		    %value parts[0]%</a>
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