<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Statistics</title>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
  </head>
  <body onLoad="setNavigation('/WmSAP/statistics.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_MG_COMP', 'foo');">
    %invoke wm.sap.Statistics:getMonitorComponentOverview%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Monitoring &gt; Component Overview</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="/WmSAP/statistics.dsp?adapterTypeName=WmSAP">Return to Monitoring</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="subheading2" colspan="7">Component Overview</td>
	      </tr>
	      <tr>
		<td class="oddcol">Component name</td>
		<td class="oddcol">Gross time</td>
		<td class="oddcol">Average</td>
		<td class="oddcol">Net Time</td>
		<td class="oddcol">Average</td>
		<td class="oddcol">Calls</td>
		<td class="oddcol">Calls ok</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop components% -->
	      <tr>
		<td class="evenrowdata-l">%value componentName%</td>
		<td class="evenrowdata-r">%value grossTime%</td>
		<td class="evenrowdata-r">%value averageGrossTime%</td>
		<td class="evenrowdata-r">%value netTime%</td>
		<td class="evenrowdata-r">%value averageNetTime%</td>
		<td class="evenrowdata-r">%value componentCalls%</td>
		<td class="evenrowdata">%value grossTimeOk%/%value netTimeOk%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script type="text/javascript">swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>