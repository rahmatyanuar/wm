<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <meta http-equiv="Content-Type" content="text/html; charset=%value $mimeCharset%"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_RFC', 'foo');">
    %invoke pub.sap.client:getFunctionInterface%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Function Module Signature</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;$rfcname=%value -urlencode $rfcname%">Return to Lookup</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">Function module signature for %value $rfcname%</td>
	      </tr>
	      <tr>
		<td class="oddcol">Class</td>
		<td class="oddcol">Parameter</td>
		<td class="oddcol">Table</td>
		<td class="oddcol">Type</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Decimals</td>
		<td class="oddcol">Optional</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop params% -->
	      <tr>
		<td class="evenrowdata">%value paramClass%</td>
		<td class="evenrowdata-l">%value parameter%</td>
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
		<td class="evenrowdata-l"><a class="leftnav" href="lookupRFCStructure.dsp?structName=%value -urlencode tabName%&amp;systemId=%value -urlencode /systemId%&amp;$rfcname=%value -urlencode /$rfcname%">%value tabName%</a></td>
		<!-- %case 'TABLE'% -->
		<td class="evenrowdata-l"><a class="leftnav" href="lookupRFCStructure.dsp?structName=%value -urlencode tabName%&amp;systemId=%value -urlencode /systemId%&amp;$rfcname=%value -urlencode /$rfcname%">%value tabName%</a></td>
		<!-- %case% -->
		<td class="evenrowdata-l">%value tabName%</td>
		<!-- %endswitch% -->
		<td class="evenrowdata-l">%value type%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata">%value decimals%</td>
		<td class="evenrowdata">%value optional%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <tbody>
	      <tr>
		<td class="action" colspan="7">
		  <form action="lookupRFCInvoke.dsp">
		    <input type="hidden" name="$rfcname" value="%value $rfcname%"></input>
		    <input type="hidden" name="systemId" value="%value systemId%"></input>
		    <input type="submit" value="Test Function"></input>
		  </form>
		</td>
	      </tr>
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>
