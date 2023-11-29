<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <!-- %invoke wm.sap.Rfc:storeDefaults%%endinvoke% -->
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <!-- %invoke wm.sap.Rfc:invoke% -->
    <meta http-equiv="Content-Type" content="text/html; charset=%value $encoding%"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_RFCTESTRET', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Function Module Signature &gt; Function Module Test &gt;
	  Results</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return to Lookup</a></li>
	    <li><a href="lookupRFC.dsp?systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return 
		to Function Module Signature for %value $rfcname%</a></li>
	    <li><a href="lookupRFCInvoke.dsp?systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return 
		to Function Module Test for %value $rfcname%</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <tr>
	      <td class="heading" colspan="2">%value $rfcname%</td>
	    </tr>
	    <tr>
	      <td class="rowlabel">Runtime</td>
	      <td class="oddrowdata-l">%value $runtime% ms</td>
	    </tr>
	    <!-- %ifvar exports% -->
	    <tr>
		<td class="subHeading" colspan="2">Export parameters</td>
	    </tr>
	      <!-- %loop exports% -->
	        <!-- %ifvar fields%%comment% this is a structure %endcomment% -->
	    <tr>
		  <td class="rowlabel">%value name%</td>
		  <td class="evenrowdata-l" valign="top"
		    style="padding: 0px;">
		    %include lookupRFCInvokeResultsStructures.html%
		  </td>
	    </tr>
	        <!-- %else%%comment%scalar parameters %endcomment% -->
	    <tr>
	      <td class="rowlabel">%value name%</td>
	      <td class="evenrowdata-l">%value value%</td>
	    </tr>
            <!-- %endif% -->
	      <!-- %endloop% -->
        <!-- %endif% -->
	    <!-- %ifvar tables% -->
	    <tr>
	      <td class="subheading" colspan="2">Tables</td>
	    </tr>
	      <!-- %loop tables% -->
	    <tr>
	      <td class="rowlabel">%value name%</td>
	      <td class="evenrowdata-l" valign="middle">
		    <!-- %ifvar entries equals('1')% -->
		  &nbsp;1&nbsp;<a href="lookupRFCInvokeViewTable.dsp?tableName=$result_%value -urlencode /$rfcname%:%value -urlencode name%&amp;fullName=%value -urlencode name%&amp;$rfcname=%value -urlencode /$rfcname%&amp;systemId=%value -urlencode /systemId%">entry</a>
		    <!-- %else% -->
		  &nbsp;%value entries%&nbsp;<a href="lookupRFCInvokeViewTable.dsp?tableName=$result_%value -urlencode /$rfcname%:%value -urlencode name%&amp;fullName=%value -urlencode name%&amp;$rfcname=%value -urlencode /$rfcname%&amp;systemId=%value -urlencode /systemId%">entries</a>
		    <!-- %endif% -->
	      </td>
	    </tr>
	    <!-- %endloop% -->
	    <!-- %endif% -->
	  </table>
	</td>
      </tr>
    </table>
    <!-- %onerror% -->
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
  </head>
  <body>
    %include error.html%
    <!-- %endinvoke% -->
  </body>
</html>