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
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_RFCTEMP', 'foo');">
    %invoke pub.sap.rfc:createTemplate%
    <table width="100%">
      <tr>
	<td class="breadCrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; %value $envelope% Template</td>
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
	  <form method="post" action="/invoke/wm.sap.Rfc/handleRfcXmlPost">
	    <table class="tableForm">
	      <tr>
		<td class="heading" colspan="2">%value $envelope% template for %value $rfcname%</td>
	      </tr>
	      <tr>
		<td class="oddrow"> 
		  <textarea name="xmlData" rows="25" cols="75">%value encode(xml) xmlData%
		  </textarea>
		</td>
	      </tr>
	      <tr>
		<td class="subHeading">
		  <input type="hidden" name="systemId" value="%value systemId%"></input>
		  <input type="hidden" name="$envelope" value="%value $envelope%"></input>
		  <input type="hidden" name="$rfcname" value="%value $rfcname%"></input>
		  <!-- %ifvar $submit% -->
		  <input type="submit" value="Invoke on %value systemId%" name="B1"></input>
		  <!-- %else% -->
		  &nbsp;
		  <!-- %endif% -->
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