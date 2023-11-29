<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Mapping</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript" src="/WmART/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/cbr.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_RG_SVC', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; %ifvar action equals('Unregister')%Unregister%else%Register%endif%
	  User Exit Service</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="cbrTypes.dsp?adapterTypeName=WmSAP&amp;action=%value action%">Return to
		User Exit Types</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="cbr.dsp" method="post">
	    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
	    <input type="hidden" name="isInbound" value="%value isInbound%"></input>
	    <table class="tableForm" width="95%">
	      <tr>
		<td class="subheading2" colspan="2">%ifvar action equals('Unregister')%Unregister%else%Register%endif%
		  %ifvar msgType euqals('$default')%Default ALE%endif%
		  %ifvar msgType euqals('$xml')%Default XML%endif%
		  %ifvar isInbound equals('true')%Routing%else%Mapping%endif%
		  Info Service</td>
	      </tr>
	      <!-- %ifvar msgType% -->
	      <input type="hidden" name="msgType" value="%value msgType%"></input>
	      <!-- %else% -->
	      <tr>
		<td class="oddrow" width="30%">Message Type</td>
		<td class="oddrow-l"><input name="msgType"/></input></td>
	      </tr>
	      <!-- %endif% -->
	      <tr>
		<td class="oddrow" width="30%">Service Name</td>
		<td class="oddrow-l"><input name="serviceName"/></input></td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input type="submit" name="action" value="%value action%"></input>
		  <input type="submit" name="action" value="Cancel"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>