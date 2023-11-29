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
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_RFCTEST', 'foo');">
    <!-- 
    %ifvar todo equals('Clear Inputs')%
      %invoke wm.sap.Rfc:clearInputs%
      %endinvoke%
    %endif%
    -->
    %invoke wm.sap.Rfc:prepare%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Function Module Signature &gt; Function Module Test</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return to Lookup</a></li>
	    <li><a href="lookupRFC.dsp?systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return 
		to Function Module Signature for %value $rfcname%</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form method="post" action="lookupRFCInvokeResults.dsp">
	    <input type="hidden" name="systemId" value="%value systemId%"></input>
	    <input type="hidden" name="$rfcname" value="%value $rfcname%"></input>
	    <table class="tableView">
	      <tr>
		<td class="heading" colspan="2">%value $rfcname%</td>
	      </tr>
	      <!-- %ifvar imports% -->
	      <tr>
		<td class="subHeading" colspan="2">Import parameters</td>
	      </tr>
	      <!-- %loop imports% -->
	      <!-- %ifvar fields%%comment% this is a structure %endcomment% -->
	      <tr>
		<td class="rowlabel">%value name%</td>
		<td class="evenrowdata-l" valign="top"
		    style="padding: 0px;">
		    %include lookupRFCInvokeStructures.html%
		</td>
	      </tr>
	      <!-- %else% -->
	      <tr>
		<td class="rowlabel">%value name%</td>
		<td class="evenrowdata-l">
            <!-- %ifvar maxlength equals(-1)%%comment% STRING or XSTRING no length limit %endcomment% -->
	       <input name="%value name%" size="42" value="%value default%"></input>
            <!-- %else%%comment% now a structure again ... %endcomment% -->
	       <input name="%value name%" maxlength="%value maxlength%" size="%value maxlength%" value="%value default%"></input>
            <!-- %endif% -->
		</td>
	      </tr>
	      <!-- %endif% -->
	      <!-- %endloop% -->
	      <!-- %endif% -->
	      
	      <!-- %ifvar tables% -->
	      <tr>
		<td class="subHeading" colspan="2">Tables</td>
	      </tr>
	      <!-- %loop tables% -->
	      <tr>
		<td class="rowlabel">%value name%
		  <input type="hidden" name="$T_%value /$rfcname%:%value name%" value=""></input>
		</td>
		<td class="evenrowdata-l" valign="middle">
		    <!-- %ifvar entries equals('1')% -->
		  &nbsp;1&nbsp;<a href="lookupRFCInvokeEditTable.dsp?tableName=%value -urlencode /$rfcname%:%value -urlencode name%&amp;fullName=%value -urlencode name%&amp;$rfcname=%value -urlencode /$rfcname%&amp;systemId=%value -urlencode /systemId%">entry</a>
		    <!-- %else% -->
		  &nbsp;%value entries%&nbsp;<a href="lookupRFCInvokeEditTable.dsp?tableName=%value -urlencode /$rfcname%:%value -urlencode name%&amp;fullName=%value -urlencode name%&amp;$rfcname=%value -urlencode /$rfcname%&amp;systemId=%value -urlencode /systemId%">entries</a>
		    <!-- %endif% -->
		</td>
	      </tr>
	      <!-- %endloop% -->
	      <!-- %endif% -->
	      <tr>
		<td class="subHeading" colspan="2">
		  <input type="submit" name="todo" value="Test Function"></input>
		  <input onclick="this.form.action='lookupRFCInvoke.dsp'; return true;" 
			 type="submit" name="todo" value="Clear Inputs"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>