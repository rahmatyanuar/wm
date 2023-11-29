<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - DDIC-Cache</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<link REL="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/ddic.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_DD', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; DDIC-Cache 
	  %switch what%
	  %case 'functions'%
	    &gt; Functions
	  %case 'structures'%
	    &gt; Structures
	  %case 'businessObjects'%
	    &gt; Business Objects
	  %case 'aleMappings'%
	    &gt; ALE Mappings
	  %case 'iDocs'%
	    &gt; IDocs
	  %case 'viewFunction'%
	    &gt; Functions &gt; Function Interface
	  %case 'viewStructure'%
	    &gt; Structures &gt; Structure Definition
	  %case%
	  %endswitch%
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <!-- %switch what% -->
	    <!-- %case 'functions'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <!-- %case 'structures'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <!-- %case 'businessObjects'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <!-- %case 'aleMappings'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <!-- %case 'iDocs'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <!-- %case 'viewFunction'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=functions">Return to Cached Functions</a></li>
	    <!-- %case 'viewStructure'% -->
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP">Return to DDIC-Cache</a></li>
	    <li><a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=structures">Return to Cached Structures</a></li>
	    <!-- %case% -->
	    <!-- %endswitch% -->
	  </ul>
	</td>
      </tr>
      <!-- 
      %switch what%
        %case 'functions'%
          %ifvar delete%
            %invoke wm.sap.Cache:removeFunction%
            %endinvoke%
          %endif%
          %invoke wm.sap.Cache:listFunctions%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached Functions</td>
	      </tr>
	      <tr>
		<td class="oddcol">Function Module</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;functionName=%value -urlencode functionName%&amp;what=viewFunction">%value functionName%</a>
		</td>
		<td class="evenrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;functionName=%value -urlencode functionName%&amp;what=functions&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'structures'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeStructure%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listStructures%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached Structures</td>
	      </tr>
	      <tr class="heading">
		<td class="oddcol">Structure</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode structName%&amp;what=viewStructure">%value structName%</a>
		</td>
		<td class="evenrowdata">
		  %switch structName%
		  %case 'RFC_FIELDS'%&nbsp;
		  %case 'SBC_FIELDS'%&nbsp;
		  %case 'RFC_FUNINT'%&nbsp;
		  %case 'SBCCALLENV'%&nbsp;
		  %case 'SBC_TABLEN'%&nbsp;
		  %case%
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode structName%&amp;what=structures&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		  %endswitch%
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'businessObjects'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeBusinessObject%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listBusinessObjects%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="3">Cached Business Objects</td>
	      </tr>
	      <tr>
		<td class="oddcol">Business Object</td>
		<td class="oddcol">Internal Name</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value objectName% 
		</td>
		<td class="evenrowdata-l">    	
		  %value internalName% 
		</td>
		<td class="evenrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;internalName=%value -urlencode internalName%&amp;what=businessObjects&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'aleMappings'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeALEMapping%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listALEMappings%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="2">Cached ALE Mappings</td>
	      </tr>
	      <tr>
		<td class="oddcol">BAPI</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value bapiName%
		</td>
		<td class="evenrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;bapiName=%value -urlencode bapiName%&amp;what=aleMappings&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'iDocs'%
        %ifvar delete%
          %invoke wm.sap.Cache:removeIDoc%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listIDocs%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="4">Cached IDocs</td>
	      </tr>
	      <tr>
		<td class="oddcol">IDoc Type</td>
		<td class="oddcol">IDoc Type Extension</td>
		<td class="oddcol">Release</td>
		<td class="oddcol">Remove</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">    	
		  %value iDocType%
		</td>
		<td class="evenrowdata-l">    	
		  %value cimType%
		</td>
		<td class="evenrowdata-l">    	
		  %value iDocRelease%
		</td>
		<td class="evenrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;iDocType=%value -urlencode iDocType%&amp;cimType=%value -urlencode cimType%&amp;iDocRelease=%value -urlencode iDocRelease%&amp;what=iDocs&amp;delete=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case 'viewStructure'%
        %invoke wm.sap.Cache:getStructureDefinition%
        %ifvar values%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="5">Structure definition for %value structName%</td>
	      </tr>
	      <tr>
		<td class="oddcol">Field</td>
		<td class="oddcol">Length</td>
		<td class="oddcol">Decimals</td>
		<td class="oddcol">Type</td>
		<td class="oddcol">Description</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata-l">%value fieldName%</td>
		<td class="evenrowdata-r">%value length%</td>
		<td class="evenrowdata-r">%value decimals%</td>
		<td class="evenrowdata">
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
		  <a class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value type%</a>
		<!-- %case 'TABLE'% -->
		  <a class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value type%</a>
		<!-- %case% -->
		  %value type%
		<!-- %endswitch% -->
		</td>
		<td class="evenrowdata-l">%value description%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endif%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'viewFunction'%
        %invoke wm.sap.Cache:getFunctionInterface%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">Function interface for %value functionName%</td>
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
	      <!-- %loop values% -->
	      <tr>
		<td class="evenrowdata">%value parameterType%</td>
		<td class="evenrowdata-l">%value parameterName%</td>
		<!-- %switch type% -->
		<!-- %case 'STRUCTURE'% -->
		<td class="evenrowdata-l"><a class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value tabName%</a></td>
		<!-- %case 'TABLE'% -->
		<td class="evenrowdata-l"><a class="leftnav" href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode /systemId%&amp;structName=%value -urlencode tabName%&amp;what=viewStructure">%value tabName%</a></td>
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
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
      <!--
        %endinvoke%
      %case%
        %ifvar clear%
          %invoke wm.sap.Cache:clear%
          %endinvoke%
        %endif%
        %invoke wm.sap.Cache:listSystems%
      -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <div class="space">&nbsp;</div>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">SAP Repository Cache</td>
	      </tr>
	      <tr>
		<td class="oddcol">System ID</td>
		<td class="oddcol">Functions</td>
		<td class="oddcol">Structures</td>
		<td class="oddcol">Business Objects</td>    
		<td class="oddcol">ALE Mappings</td>    
		<td class="oddcol">IDocs</td>    
		<td class="oddcol">Clear Cache</td>    
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop systemIds% -->
	      <tr>
		<td class="oddrowdata-l">%value systemId%</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=functions">%value functionCount%</a>
		</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=structures">%value structureCount%</a>
		</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=businessObjects">%value businessObjectCount%</a>
		</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=aleMappings">%value aleMappingCount%</a>
		</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;what=iDocs">%value iDocCount%</a>
		</td>
		<td class="oddrowdata">
		  <a href="ddic.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;clear=1"><img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
        %endinvoke%
      %endswitch%
    </table>
  </body>
</html>