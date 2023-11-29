<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Statistics</title>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/statistics.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_MG_REQ', 'foo');">
    %invoke wm.sap.Statistics:getMonitorRequestOverview%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Monitoring  &gt; Request Overview</td>
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
	    <tr>
	      <td class="subheading2" colspan="6">Request Overview</td>
	    </tr>
	    <tr>
	      <td class="oddcol" style="border-bottom: 0px;">Request</td>
	      <td class="oddcol">User</td>
	      <td class="oddcol">Gross time</td>
	      <td class="oddcol">Start time</td>
	      <td class="oddcol">Status</td>
	      <td class="oddcol">Largest Net Time</td>
	    </tr>
	    <tr>
	      <td class="oddcol">&nbsp;</td>
	      <td class="oddcol" colspan="5">Components</td>
	    </tr>
	    <!-- %loop requests% -->
	    <tr>
	      <td class="evenrowdata-l" style="border-bottom: 0px;">%value requestName%</td>
	      <td class="evenrowdata">%value userName%</td>
	      <td class="evenrowdata-r">%value grossTime%</td>
	      <td class="evenrowdata-r">%value startTime%</td>
	      <td class="evenrowdata">%value status%</td>
	      <td class="evenrowdata">%value componentLargestNetTimeName% (%value componentLargestNetTime%)</td>
	    </tr>
	    <tr>
	      <td class="evenrowdata">&nbsp;</td>
	      <td class="evenrowdata" colspan="5" style="padding: 0px;">
		<table class="tableInline" cellspacing="1" width="100%">
		  <tr>
		    <td class="subHeading">Component name</td>
		    <td class="subHeading-r">Gross time</td>
		    <td class="subHeading-r">Net time</td>
		    <td class="subHeading-r">Level</td>
		  </tr>
		  <!-- %loop components% -->
		  <tr>
		    <td class="oddrowdata-l">%value componentName%</td>
		    <td class="oddrowdata-r">%value grossTime%</td>
		    <td class="oddrowdata-r">%value netTime%</td>
		    <td class="oddrowdata-r">%value level%</td>
		  </tr>
		  <!-- %endloop% -->
		  <tr>
		    <td class="subHeading-r">Component count</td>
		    <td class="oddrowdata-l" colspan="3">%value componentCount%</td>
		  </tr>
		</table>
	      </td>
	    </tr>
	    <!-- %endloop% -->
	  </table>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>