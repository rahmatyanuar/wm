<?xml version='1.0'?>
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
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_IDOCSEGFIELD', 'foo');">
    %invoke wm.sap.Ale:getFieldDefinition%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif% 
	  %ifvar grandParentSegmentDefinition%&gt; Segment %value grandParentSegmentDefinition%%endif% %ifvar parentSegmentDefinition%&gt; Segment %value parentSegmentDefinition%%endif% &gt; Segment %value segmentDefinition% 
	  &gt; Field %value fieldName%
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%">Return to Lookup</a></li>
	    <li><a href="lookupIDoc.dsp?systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%">Return to IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif%</a></li>
	    <li><a href="lookupIDocSegment.dsp?systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%&amp;segmentDefinition=%value -urlencode segmentDefinition%%ifvar parentSegmentDefinition%&amp;parentSegmentDefinition=%value -urlencode parentSegmentDefinition%%endif%%ifvar grandParentSegmentDefinition%&amp;grandParentSegmentDefinition=%value -urlencode grandParentSegmentDefinition%%endif%">Return to Segment %value segmentDefinition%</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Field %value fieldName%</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <tr>
		<td class="rowlabel">IDoc datatype</td>
		<td class="oddrowdata-l">%value fieldType%</td>
	      </tr>
	      <tr>
		<td class="rowlabel">Data dictionary type</td>
		<td class="oddrowdata-l">%value ddicType%</td>
	      </tr>
	      <tr>
		<td class="rowlabel">ISO Code</td>
		<td class="oddrowdata-l">%ifvar isISOCode equals('true')%yes%else%no%endif%</td>
	      </tr>
	    </tbody>
	    <!-- %ifvar values% -->
	    <tbody>
	      <tr>
		<td class="subHeading" colspan=2>Possible Values</td>
	      </tr>
	      <tr>
		<td class="oddcol">Value</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </tbody>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">%value value%</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <!-- %endif% -->
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>