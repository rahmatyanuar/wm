<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
	<title>WmSAP - Settings</title>
	<meta http-equiv="Pragma" content="no-cache"></meta>
	<meta http-equiv="Expires" content="-1"></meta>
	<link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
	
	<script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript">
      function confirmRegister(adapterKey)
      {
         var s1 = "OK to register Adapter '"+adapterKey+"'\n";
         var s2 = "at the SAP SLD?\n\n";
         var s3 = "This may take some time.\n";
         return confirm (s1+s2+s3);
      }
      function confirmUnregister(adapterKey)
      {
         var s1 = "OK to unregister Adapter\n";
         var s2 = "'"+adapterKey+"'\n";
         var s3 = "at the SLD?\n\n";
         var s4 = "Unregistering an Adapter will also delete\n";
         var s5 = "all associated Instances to that Adapter.\n";
         return confirm (s1+s2+s3+s4+s5);
      }
    </script>
  </head>
  <body onLoad="setNavigation('/WmSAP/settings.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_SS', 'foo');">
    <!-- %switch action%
           %case 'register'%
             %invoke wm.sap.SLD:registerAdapterInstance%
             %endinvoke%
         %endswitch% -->
    <!--
	If DSP was requested from the Save button
	then invoke the setProperties service.

	%ifvar action equals('Save')%
	  %invoke wm.sap.Admin:setProperties%
	  %endinvoke%
	%endifvar%
	-->
	%invoke wm.sap.Admin:getProperties%
	<table width="100%">
	  <!-- %ifvar action equals('Edit')% -->
	  <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Settings &gt; Edit</td>
	  </tr>
	  <tr>
	<td colspan="2">
	  <ul>
		<li><a href="settings.dsp?adapterTypeName=WmSAP">Return to Settings</a></li>
	  </ul>
	</td>
	  </tr>
	  <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="settings.dsp" method="post">
	    <table class="tableForm">
	      <tr>
		<td class="heading" colspan="2">SAP Repository Connection Pools</td>
	      </tr>
	      <script LANGUAGE="JavaScript">
		        var membership = new Array (%loop facList% "%value Value%" %loopsep ', '% %endloop%);
			function enableAll()
			{
			  var optlist = document.forms[0].fac.options;
			  for (var i=0; i < membership.length; i++)
			  {
				optlist[i].selected = true;
			  }
			}
			function disableAll()
			{
			  var optlist = document.forms[0].fac.options;
			  for (var i=0; i < membership.length; i++)
			  {
				optlist[i].selected = false;
			  }
			}
	      </script>
	      <tr>
		<td class="oddrow-l">Timeout (minutes)</td>
		<td class="oddrow-l"><input name="timeout" value="%value timeout%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow-l">Timeout check period (seconds)</td>
		<td class="evenrow-l"><input name="timeoutCheckPeriod" value="%value timeoutCheckPeriod%"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow-l">Sessionpool size</td>
		<td class="oddrow-l"><input name="poolSize" value="%value poolSize%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow-l">Poolqueue waiting time (seconds)</td>
		<td class="evenrow-l"><input name="waitForPool" value="%value waitForPool%"></input></td>
	      </tr>

	      <tr>
		<td colspan="2">&nbsp;</td>
	      </tr>
	      <tr>
		<td class="heading" colspan="2">SAP Listeners</td>
	      </tr>
	      <tr>
		<td class="oddrow-l">Check time (minutes)</td>
		<td class="oddrow-l"><input name="checkTime" value="%value checkTime%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow-l">Response time (seconds)</td>
		<td class="evenrow-l"><input name="responseTime" value="%value responseTime%"></input></td>
	      </tr>

	      <tr>
		<td colspan="2">&nbsp;</td>
	      </tr>
	      <tr>
		<td class="heading" colspan="2">Misc</td>
	      </tr>
	      <tr>
		<td class="oddrow-l">Default XRFC version</td>
		<td class="oddrow-l">
		  %ifvar xrfcVersion equals('1.0')%
		  <input type="radio" name="xrfcVersion" value="1.0" checked="checked"></input>1.0&nbsp;
		  %else%
		  <input type="radio" name="xrfcVersion" value="1.0"></input>1.0&nbsp;
		  %endif%
		  %ifvar xrfcVersion equals('1.0')%
		  <input type="radio" name="xrfcVersion" value="0.9"></input>0.9
		  %else%
		  <input type="radio" name="xrfcVersion" value="0.9" checked="checked"></input>0.9
		  %endif%
		</td>
	      </tr>
	      <tr>
		<td class="evenrow-l">SNC library</td>
		<td class="evenrow-l"><input name="sncLibPath" value="%value sncLibPath%" size="50"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow-l">Log Throughput data</td>
		<td class="oddrow-l">
		  %ifvar throughput equals('true')%
		  <input type="radio" name="throughput" value="true" checked="checked"></input>On&nbsp;
		  %else%
		  <input type="radio" name="throughput" value="true"></input>On&nbsp;
		  %endif%
		  %ifvar throughput equals('false')%
		  <input type="radio" name="throughput" value="false" checked="checked"></input>Off
		  %else%
		  <input type="radio" name="throughput" value="false"></input>Off
		  %endif%
		</td>
	      </tr>
	      <tr>
		<td class="evenrow-l">Use Monitor</td>
		<td class="evenrow-l">
		  %ifvar monitor equals('true')%
		  <input type="radio" name="monitor" value="true" checked="checked"></input>On&nbsp;
		  %else%
		  <input type="radio" name="monitor" value="true"></input>On&nbsp;
		  %endif%
		  %ifvar monitor equals('false')%
		  <input type="radio" name="monitor" value="false" checked="checked"></input>Off
		  %else%
		  <input type="radio" name="monitor" value="false"></input>Off
		  %endif%
		</td>
	      </tr>
	      <tr>
		<td colspan="2">&nbsp;</td>
	      </tr>
	    <tr>
	      <td class="heading" colspan="2">SAP SLD</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l">Own Name</td>
	      <td class="oddrow-l"><input name="adapterKey" value="%value adapterKey%"</input></td>
	    </tr>
	    <tr>
	      <td class="evenrow-l">SLD Host</td>
	      <td class="evenrow-l"><input name="sldHost" value="%value sldHost%"</input></td>
	    </tr>
	    <tr>
	      <td class="oddrow-l">SLD Port</td>
	      <td class="oddrow-l"><input name="sldPort" value="%value sldPort%"</input></td>
	    </tr>
	    <tr>
	      <td class="evenrow-l">User</td>
	      <td class="evenrow-l"><input name="sldUser" value="%value sldUser%"</input></td>
	    </tr>
	    <tr>
	      <td class="oddrow-l">Password</td>
		<td class="oddrow-l"><input type="password" name="sldPasswd" value="%value sldPasswd%"></input></td>
	    </tr>
	    <tr><td colspan="2" class="space">&nbsp;</td></tr>

	      <tr>
		<td class="action" colspan="2">
		  <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
		  <input type="submit" name="action" value="Save"></input>
		  <input type="submit" name="action" value="Cancel"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
      <!-- %else% -->
      <tr>
	<td class="breadcrumb" colspan="4">Adapters &gt; %value displayName% &gt; Settings</td>
      </tr>
      <!-- %ifvar $message -notempty% -->
      <tr><td colspan="5">&nbsp;</td></tr>
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	      class="message" colspan="5">%value $message%</td></tr>
      <!-- %endif% -->
      <!-- %ifvar $fault -notempty% -->
      <tr><td colspan="5">&nbsp;</td></tr>
      <tr><td class="message" colspan="5">%value $fault%</td></tr>
      <!-- %endif% -->
      <tr>
	<td colspan="5">
	  <ul>
	    <li><a href="settings.dsp?adapterTypeName=WmSAP&amp;action=Edit">Change Settings</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <tr>
	      <td class="heading" colspan="5">SAP Repository Connection Pools</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l" colspan="2">Timeout (minutes)</td>
	      <td class="oddrowdata" colspan="3">%value timeout%</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l" colspan="2">Timeout check period (seconds)</td>
	      <td class="evenrowdata" colspan="3">%value timeoutCheckPeriod%</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l" colspan="2">Sessionpool size</td>
	      <td class="oddrowdata" colspan="3">%value poolSize%</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l" colspan="2">Poolqueue waiting time (seconds)</td>
	      <td class="evenrowdata" colspan="3">%value waitForPool%</td>
	    </tr>

	    <tr><td colspan="5" class="space">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="5">SAP Listeners</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l" colspan="2">Check time (minutes)</td>
	      <td class="oddrowdata" colspan="3">%value checkTime%</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l" colspan="2">Response time (seconds)</td>
	      <td class="evenrowdata" colspan="3">%value responseTime%</td>
	    </tr>

	    <tr><td colspan="5" class="space">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="5">Misc</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l" colspan="2">Default XRFC version</td>
	      <td class="oddrowdata" colspan="3">%value xrfcVersion%</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l" colspan="2">SNC library</td>
	      <td class="evenrowdata" colspan="3">%value sncLibPath%</td>
	    </tr>
	    <tr>
	      <td class="oddrow-l" colspan="2">Log Throughput data</td>
	      <td class="oddrowdata" colspan="3">%ifvar throughput equals('true')%On%else%Off%endif%</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l" colspan="2">Use Monitor</td>
	      <td class="evenrowdata" colspan="3">%ifvar monitor equals('true')%On%else%Off%endif%</td>
	    </tr>
	    <tr><td colspan="5" class="space">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="5">Adapter for SAP Group</td>
	    </tr>
	    %ifvar clusterState equals('true')%
	     <tr>
		 <td colspan="5" class="subHeading">Configuration</td>
	     </tr>
	    %endif%
	    <tr>
	      <td class="oddrow-l" colspan="2">Connected</td>
	      <td class="oddrowdata" colspan="3">%ifvar clusterState equals('true')%Yes%else%No%endif%</td>
	    </tr>
	    %ifvar clusterStore -notempty%
	     <tr>
	      <td class="evenrow-l" colspan="2">Store Access</td>
	      <td class="evenrowdata" colspan="3">%value clusterAccess%</td>
	     </tr>
	     <tr>
	      <td class="evenrow-l" colspan="2">Centralized Store</td>
	      <td class="evenrowdata" colspan="3">%value clusterStore%</td>
	     </tr>
	    %endifvar%

	    %ifvar clusterList -notempty%
	    <tr>
		<td colspan="5" class="subHeading">Adapters in this Group</td>
	    </tr>

	    <tr>
	      <td class="oddcol" colspan="2" nowrap="nowrap">Host</td>
	      <td class="oddcol" nowrap="nowrap">Port</td>
	      <td class="oddcol" nowrap="nowrap">CPU Load</td>
	      <td class="oddcol" nowrap="nowrap">Status</td>
	    </tr>
	    <!-- %loop clusterList% -->
	      <tr>
		<td class="oddrowdata-l" colspan="2">
		  %value host%
		</td>
		<td class="oddrowdata-l">
		  %value port%
		</td>
		<td class="oddrowdata">
		  %value load%
		</td>
		<td class="oddrowdata-l">
		  %value state%
		</td>
	      </tr>
	    <!-- %endloop% -->

	    %endifvar%

	    <tr><td colspan="5" class="space">&nbsp;</td></tr>
	    <tr>
	      <td class="heading" colspan="5">SAP SLD</td>
	    </tr>
	       <tr>
		 <td class="oddcol-l">Own Name</td>
		 <td class="oddcol-l">SLD Host</td>
		 <td class="oddcol-l">SLD Port</td>
		 <td class="oddcol-l">User</td>
		 <td class="oddcol-l">Register</td>
	    </tr>
	    <tr>
	 	 <td class="evenrow-l">%value adapterKey%</td>
		 <td class="evenrow-l">%value sldHost%</td>
		 <td class="evenrow-l">%value sldPort%</td>
		 <td class="evenrow-l">%value sldUser%</td>
		 <td class="evenrowdata">
		      <a title="Click to register"
		     class="imagelink" href="settings.dsp?action=register"
		     onclick="return confirmRegister('%value encode(javascript) adapterKey%');"><img src="/WmRoot/icons/checkdot.gif" border="0" height="13" width="13"></a>
		 </td>
	    </tr>

	  </table>
	</td>
      </tr>
      <!-- %endif% -->
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>