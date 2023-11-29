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
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_BAPIPARAM', 'foo');">
    %invoke wm.sap.Bapi:getParameterDefinition%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Parameter
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode defObjectName%">Return to Lookup</a></li>
	    <li><a href="lookupBO.dsp?systemId=%value -urlencode systemId%&amp;internalName=%value -urlencode defObjectTypeName%&amp;%ifvar eventName%eventName=%value -urlencode eventName%%else%bapiName=%value -urlencode bapiName%%endif%">Return to Business Object %value defObjectName%</a></li>
	    <!-- %ifvar eventName% -->
	    <li><a href="lookupBOEvent.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;eventName=%value -urlencode eventName%">Return to Event %value defObjectName%.%value eventName%</a></li>
	    <!-- %else% -->
	    <li><a href="lookupBOBapi.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;bapiName=%value -urlencode bapiName%">Return to BAPI %value defObjectName%.%value bapiName%</a></li>
	    <!-- %endif% -->
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <tr>
	      <td class="subheading2" colspan="2">Parameter %value parameterName%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Internal Name</td>
	      <td class="oddrowdata-l">%value internalName%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Direction</td>
	      <td class="evenrowdata-l">%value direction%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Optional</td>
	      <td class="oddrowdata-l">%value isOptional%</td>
	    </tr>
	    <!-- %ifvar type equals('TypeName')% -->
	    <tr>
	      <td class="rowlabel"> Business Object Type</td>
	      <td class="oddrowdata-l">
		<a href="lookupBO.dsp?systemId=%value -urlencode systemId%&amp;internalName=%value -urlencode ddicReference%">%value ddicReference%</a>
	      </td>
	    </tr>
	    <!-- %else% -->
	    <tr>
	      <td class="rowlabel">Table</td>
	      <td class="evenrowdata-l">%value isTable%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel"> ABAP Dictionary Type</td>
	      <td class="oddrowdata-l">
		<!-- %ifvar ddicStructure% -->
		<a href="lookupRFCStructure.dsp?structName=%value -urlencode ddicStructure%&amp;systemId=%value -urlencode systemId%&amp;parameterName=%value -urlencode parameterName%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;%ifvar eventName%eventName=%value -urlencode eventName%%else%bapiName=%value -urlencode bapiName%%endif%">%value ddicReference%</a>
 		<!-- %else% -->
   		%value ddicReference%
		<!-- %endif% -->
	      </td>
	    </tr>
	    <!-- %endif% -->
	  </table>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>