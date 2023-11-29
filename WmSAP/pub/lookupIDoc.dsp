<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../Wmart/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_IDOC', 'foo');">
    %invoke wm.sap.Ale:getIDocDefinition%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="8">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif% 
	</td>
      </tr>
      <tr>
	<td colspan="7">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%">Return to Lookup</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView" width="100%">
	    <thead>
	      <tr>
		<td class="heading" colspan="8">IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif% </td>
	      </tr>
	      <tr>
		<td class="subHeading" colspan="8">Top level segments</td>
	      </tr>
	      <tr>
		<td class="oddcol">Segment Type</td>
		<td class="oddcol">Segment Definition</td>
		<td class="oddcol">Hierarchy Level</td>
		<td class="oddcol">Required</td>
		<td class="oddcol">Min. Occurrence</td>
		<td class="oddcol">Max. Occurrence</td>
		<td class="oddcol">Qualified</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop segments% -->
	      <tr>
		<td class="evenrowdata-l"><a href="lookupIDocSegment.dsp?systemId=%value -urlencode ../systemId%&amp;iDocType=%value -urlencode ../iDocType%&amp;cimType=%value -urlencode ../cimType%&amp;iDocRelease=%value -urlencode ../iDocRelease%&amp;segmentDefinition=%value -urlencode segmentDefinition%">%value segmentType%</a></td>
		<td class="evenrowdata-l">%value segmentDefinition%</td>
		<td class="evenrowdata">%value hierarchyLevel%</td>
		<td class="evenrowdata">%ifvar required equals('true')%yes%else%no%endif%</td>
		<td class="evenrowdata">%value minOccurrence%</td>
		<td class="evenrowdata">%value maxOccurrence%</td>
		<td class="evenrowdata">%ifvar qualified equals('true')%yes%else%no%endif%</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	    <!-- %endloop% -->
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