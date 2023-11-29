<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript" src="/WmART/webMethods.js.txt"></script>
    <!-- %invoke pub.sap.bapi:createTemplate% -->
    <!-- %ifvar $redirect% -->
    <meta http-equiv="refresh" content="5;url=lookupBO%value $redirect%.dsp?systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode objectName%"></meta>
    <!-- %endif% -->
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_BOTEMP', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; BAPI-XML Template
	  <!-- %ifvar $redirect% -->
	  &gt; Error
	  <!-- %endif% -->
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode objectName%&amp;bapiName=%value -urlencode bapiName%">Return to Lookup</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <!-- %ifvar $redirect% -->
	  <table width="80%" class="tableView">
	    <tr>
	      <td class="subHeading">%value errorMessage%</td>
	    </tr>
	    <tr>
	      <td class="oddrowdata-l">
		<!-- %ifvar $redirect equals('All')% -->
		Business Object %value /objectName% not found. Check <a href="lookupBOAll.dsp?systemId=%value -urlencode /systemId%">object list to select another business object</a>
		<!-- %else% -->
		BAPI %ifvar /objectName -notempty%%value /objectName%.%endif%%value /bapiName%
		not found. Check <a href="lookupBO.dsp?systemId=%value -urlencode /systemId%&amp;objectName=%value -urlencode /objectName%">%value /objectName% overview page</a>.
		<!-- %endif% -->
	      </td>
	    </tr>
	  </table>
	  <!-- %else% -->
	  <form method="post" action="/invoke/wm.sap.Rfc/handleBXmlPost">
	    <table class="tableForm">
	      <tr>
		<td class="subheading2" colspan="2">bXML template for %value objectName%.%value bapiName%</td>
	      </tr>
	      <tr>
		<td class="oddrow"> 
		  <textarea name="xmlData" rows="25" cols="75">%value encode(xml) xmlData%
		  </textarea>
		</td>
	      </tr>
	      <tr>
		<td class="action">
		  <select size="1" name="mode">
		    <option selected="selected" value="sync">synchronous call to
		      %value systemId% via RFC </option> 
		    <option value="async">asynchronous call to %value systemId% via ALE </option>
		    <option value="routing">apply routing notification</option>
		  </select>
		  <input type="hidden" name="systemId" value="%value systemId%"></input>
		  <input type="submit" value="Invoke" name="B1"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	  <!-- %endif% -->
	</td>
      </tr>
    </table>
  </body>
  <!-- %onerror% -->
  </head>
  <body>
  %include error.html%
  </body>
  <!-- %endinvoke% -->
</html>
