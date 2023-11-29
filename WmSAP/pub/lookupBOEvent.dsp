<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_BOEVENT', 'foo');">
    <!-- %invoke wm.sap.Bapi:getEventDefinition% -->
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup &gt; Event
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode defObjectName%">Return to Lookup</a></li>
	    <li><a href="lookupBO.dsp?systemId=%value -urlencode systemId%&amp;internalName=%value -urlencode defObjectTypeName%">Return to Business Object %value defObjectName%</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="subheading2" colspan="2">Event %value eventName%</td>
	      </tr>
	      <tr>
		<td class="rowlabel">Declaration object name</td>
		<td class="oddrowdata-l">%value defObjectName% (%value defObjectTypeName%)</td>
	      </tr>
	      <tr>
		<td class="rowlabel">Internal name</td>
		<td class="oddrowdata-l">%value internalName%</td>
	      </tr>
	    </thead>
	    <!-- %ifvar -notempty parameterNames% -->
	    <tbody id="tbodyNode">
	      <tr>
		<td class="subHeading" colspan="2">Parameters</td>
	      </tr>
	      <!-- %loop parameterNames% -->
	      <tr>
		<td class="evenrowdata-l" colspan="2">
		  <a href="lookupBOParameter.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;eventName=%value -urlencode eventName%&amp;parameterName=%value -urlencode%">%value%</a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <!-- %endif% -->
	  </table>
	</td>
      </tr>
    </table>
    <!-- %onerror% -->
    %include error.html%
    <!-- %endinvoke% -->
  </body>
</html>