<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
	<title>WmSAP - Statistics</title>
	<meta http-equiv="Pragma" content="no-cache"></meta>
	<meta http-equiv="Expires" content="-1"></meta>
	<link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
	
	<script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/statistics.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_MG', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Monitoring</td>
      </tr>
      <tr>
	<td colspan="2">
		  %invoke sap.monitor.ccms.admin:getStatus%
	  <ul>
	    <li><a href="/SAPMonitoring/remoteMonitoring.dsp">Remote Monitoring</a></li>
	    <li><a href="statistics.dsp?adapterTypeName=WmSAP">Refresh</a></li>
	  </ul>
		  %onerror%
	  <ul>
	    <li><a href="statistics.dsp?adapterTypeName=WmSAP">Refresh</a></li>
	  </ul>
		  %endinvoke%
	</td>
      </tr>
      <tr>
	
	<td>
	  <!-- Repository pools -->
	  %invoke wm.sap.Statistics:getPools%
	  <table class="tableView" width=100%>
	    <thead>
	      <tr>
		<td class="heading" colspan="6" width=100%>SAP Repository Connection Pools</td>
	      </tr>
	      <tr class="subheading2">
		<td class="oddcol" colspan="2">System ID</td>
		<td class="oddcol">Current Size</td>
		<td class="oddcol">Peak Size</td>
		<td class="oddcol">Max Size</td>
		<td class="oddcol">Current Used</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop pools% -->
	      <tr>
		<td class="oddrowdata-l" colspan="2">%value poolName%</td>
		<td class="oddrowdata">%value currentSize%</td>
		<td class="oddrowdata">%value peakSize%</td>
		<td class="oddrowdata">%value maxSize%</td>
		<td class="oddrowdata">%value currentUsed%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  <script>swapColor('tbodyNode', false);</script>
	  %onerror% %include error.html%
	  %endinvoke%

	  <!-- Client pools -->
	  %invoke wm.sap.Statistics:listConnections%
	    <tbody>
	      <tr><td class="space" colspan="6">&nbsp;</td></tr>
	      <tr>
		<td class="heading" colspan="6">SAP Client Connections</td>
	      </tr>
	      <tr class="subheading2">
		<td class="oddcol" colspan="2">Connection Alias</td>
		<td class="oddcol">Pools</td>
		<td class="oddcol" colspan="2">Locked Connections</td>
		<td class="oddcol"></td>
	      </tr>
	    </tbody>
	    <tbody id="tbodyNode">
	      <!-- %loop conns% -->
	      <tr>
		<td class="oddrowdata-l" colspan="2">%value alias%</td>
		<td class="oddrowdata">
		  <a href="statisticsPools.dsp?adapterTypeName=WmSAP&serverAlias=%value alias%">%value poolCount empty='0' encode(html)%</a>
		</td>
		<td class="oddrowdata" colspan="2">
		  <a href="statisticsLockedConns.dsp?adapterTypeName=WmSAP&serverAlias=%value alias%">%value lockedCount empty='0' encode(html)%</a>
		</td>
		<td class="oddrowdata"></td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  <script>swapColor('tbodyNode', false);</script>
	  %onerror% %include error.html%
	  %endinvoke%

	  <!-- Listener Threads -->
	  %invoke wm.sap.Statistics:getListenerThreadInfo%
	  <tbody>
	    <tr><td class="space" colspan="6">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="6">SAP Listener Status</td>
	    </tr>
	    <tr class="subheading2">
	      <td class="oddcol">Listener</td>
	      <td class="oddcol">Status</td>
	      <td class="oddcol">Threads</td>
	      <td class="oddcol">Active</td>
	      <td class="oddcol">Busy</td>
	      <td class="oddcol">Max Busy</td>
	    </tr>
	  </tbody>
	  <tbody id="tbodyNode1">
	    <!-- %loop listenerInfos% -->
	    <tr>
	      <td class="oddrowdata-l">%value alias%</td>
	      <td class="oddrowdata">%value status%</td>
	      <td class="oddrowdata">%value threads%</td>
	      <td class="oddrowdata">%value active%</td>
	      <td class="oddrowdata">%value busy%</td>
	      <td class="oddrowdata">%value maxBusy%</td>
	    </tr>
	    <!-- %endloop% -->
	  </tbody>
	  <script>swapColor('tbodyNode1', false);</script>
	  %onerror% %include error.html%
	  %endinvoke%

	  <!-- Monitor -->
	  %invoke wm.sap.Statistics:getMonitorRequestSummary%
	  <tbody>
	    <tr><td class="space" colspan="6">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="6">Component Responsetime Monitor</td>
	    </tr>
	    <tr>
	      <td class="subHeading" colspan="6">Request Summary</td>
	    </tr>
	    <tr>
	      <td class="oddrow" colspan="2">Requests total</td>
	      <td class="oddrowdata-r">%value requests%</td>
	      <td class="oddrow" colspan="2">Request rate (1/s)</td>
	      <td class="oddrowdata-r">%value requestRate%</td>
	    </tr>
	    <tr>
	      <td class="evenrow" colspan="2">Requests ok</td>
	      <td class="evenrowdata-r">%value requestsOk%</td>
	      <td class="evenrow" colspan="2">Requests with errors</td>
	      <td class="evenrowdata-r">%value requestsNotClosed%</td>
	    </tr>
	    <tr>
	      <td class="oddrow" colspan="2">Components total</td>
	      <td class="oddrowdata-r">%value components%</td>
	      <td class="oddrow" colspan="2">Components per request</td>
	      <td class="oddrowdata-r">%value averageComponents%</td>
	    </tr>
	    <tr>
	      <td class="evenrow" colspan="2">Total time (ms)</td>
	      <td class="evenrowdata-r">%value totalTime%</td>
	      <td class="evenrow" colspan="2">Average time (ms)</td>
	      <td class="evenrowdata-r">%value averageTime%</td>
	    </tr>
	  </tbody>
	  <form action="statisticsMonitorRequests.dsp?adapterTypeName=WmSAP" method="post">
	    <tbody>
	      <tr>
		<td colspan="6" class="subHeading">Query Requests</td>
	      </tr>
	      <tr>
		<td class="oddrow">Info for ...</td>
		<td class="oddrow-l" colspan="2"><input name="requestPattern" value="*"></input></td>
		<td class="oddrow" colspan="2">max. listed requests</td>
		<td class="oddrow-l">
		  <input type="text" name="maxRequests" value="25"
		    size="3" maxlength="3"></input>
		</td>
	      </tr>
	      <tr>
		<td colspan="6" class="action">
		  <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
		  <input type="submit" value="Show"></input>
		</td>
	      </tr>
	    </tbody>
	  </form>
	  <form action="statisticsMonitorComponents.dsp?adapterTypeName=WmSAP" method="post">
	    <tbody>
	      <tr>
		<td colspan="6" class="subHeading">Query Components</td>
	      </tr>
	      <tr>
		<td class="oddrow">Info for ...</td>
		<td colspan="5" class="oddrow-l"><input name="componentPattern" value="*"></input></td>
	      </tr>
	      <tr>
		<td colspan="6" class="action">
		  <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
		  <input type="submit" value="Show"></input>
		</td>
	      </tr>
	    </tbody>
	  </form>
	  </table>
	  %onerror% %include error.html%
	  %endinvoke%
	</td>
      </tr>
    </table>
  </body>
</html>
