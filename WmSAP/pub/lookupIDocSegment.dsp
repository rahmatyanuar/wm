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
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_IDOCSEG', 'foo');">
    %invoke wm.sap.Ale:getSegmentDefinition%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif% 
	  %ifvar grandParentSegmentDefinition%&gt; Segment %value grandParentSegmentDefinition%%endif% %ifvar parentSegmentDefinition%&gt; Segment %value parentSegmentDefinition%%endif% &gt; Segment %value segmentDefinition% 
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%">Return to Lookup</a></li>
	    <li><a href="lookupIDoc.dsp?systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%">Return to IDoc %value iDocType%%ifvar cimType -notempty%/%value cimType%%endif%%ifvar iDocRelease -notempty%(%value iDocRelease%)%endif%</a></li>
	    %ifvar parentSegmentDefinition%<li><a href="lookupIDocSegment.dsp?systemId=%value -urlencode systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%&amp;segmentDefinition=%value -urlencode parentSegmentDefinition%%ifvar grandParentSegmentDefinition%&amp;parentSegmentDefinition=%value -urlencode grandParentSegmentDefinition%%endif%">Return to parent Segment %value parentSegmentDefinition%</a></li>%endif%
 	  </ul>
	</td>
      </tr>
      <!-- %ifvar segments% -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
 	  <table class="tableView" width="100%">
	    <thead>
	      <tr>
		<td class="heading" colspan="8">Segment %value segmentDefinition%</td>
	      </tr>
	    </thead>
	    <thead>
	      <tr>
		<td class="subHeading" colspan="8">Child Segments</td>
	      </tr>
	    </thead>
	    <tbody>
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
	    </tbody>
	    <tbody id="tbodyNode" colspan="7">
	      <!-- %loop segments% -->
	      <tr>
		<td class="evenrowdata-l"><a href="lookupIDocSegment.dsp?systemId=%value -urlencode ../systemId%&amp;iDocType=%value -urlencode ../iDocType%&amp;cimType=%value -urlencode ../cimType%&amp;iDocRelease=%value -urlencode ../iDocRelease%&amp;segmentDefinition=%value -urlencode segmentDefinition%&amp;parentSegmentDefinition=%value -urlencode ../segmentDefinition%%ifvar ../parentSegmentDefinition%&amp;grandParentSegmentDefinition=%value -urlencode ../parentSegmentDefinition%%endif%">%value segmentType%</a></td>
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
	    <script>swapColor('tbodyNode', false);</script>
	  </table>
	</td>
      </tr>
      <!-- %endif% -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
 	  <table class="tableView" width="100%">
	    <thead>
	      <tr>
		<td class="heading" colspan="5">Segment %value segmentDefinition%</td>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
		<td class="subHeading" colspan="5">Segment Fields</td>
	      </tr>
	    </tbody>
	    <tbody>
	      <tr>
		<td class="oddcol">Pos</td>
		<td class="oddcol">Field</td>
		<td class="oddcol">Offset</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </tbody>
	    <tbody id="tbodyNode2">
	      <!-- %loop fields% -->
	      <tr>
		<td class="evenrowdata-r">%value position%</td>
		<td class="evenrowdata-l"><a href="lookupIDocField.dsp?systemId=%value -urlencode ../systemId%&amp;iDocType=%value -urlencode ../iDocType%&amp;cimType=%value -urlencode ../cimType%&amp;iDocRelease=%value -urlencode ../iDocRelease%&amp;segmentDefinition=%value -urlencode ../segmentDefinition%%ifvar ../parentSegmentDefinition%&amp;parentSegmentDefinition=%value -urlencode ../parentSegmentDefinition%%endif%%ifvar ../grandParentSegmentDefinition%&amp;grandParentSegmentDefinition=%value -urlencode ../grandParentSegmentDefinition%%endif%&amp;fieldName=%value -urlencode fieldName%">%value fieldName%</a></td>
		<td class="evenrowdata-r">%value offset%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <tbody>
	      <tr>
		<td class="subHeading">Length</td>
		<td class="oddrowdata-r" colspan="4">%value segmentLength%</td>
	      </tr>
	    </tbody>
	    <script>swapColor('tbodyNode2', false);</script>
	  </table>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>