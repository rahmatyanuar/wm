<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP', 'foo');">
    %invoke wm.sap.Cache:listSystems%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="lookupForm" action="lookupRFCSearch.dsp" id="lookupForm">
	    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
	    <input type="hidden" name="$call" id="callindic" value="true"></input>
	    <table class="tableView">
	      <tr><td colspan="2" class="space">&nbsp;</td></tr>
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">Lookup...</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">System ID</td>
		<td class="oddrow-l">
		  <!-- %ifvar systemIds% -->
		  <select name="systemId">
		    <!-- %loop systemIds% -->
		    <!-- %ifvar systemId matches('*local*')% -->
		    <!-- %else% -->
		    <option value="%value systemId%"%ifvar systemId vequals(../systemId)% selected="selected"%endif%>%value systemId%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		  <!-- %else% -->
		  No SAP Servers Defined
		  <!-- %endif% -->
		</td>
	      </tr>
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">Function By Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">Function Name</td>
		<td class="oddrow-l"><input name="$rfcname" value="%value $rfcname%"/></input></td>
	      </tr>
	      <!-- %ifvar systemIds% -->
	      <tr>
		<td class="action" colspan="2">
		  <input onclick="this.form.action='lookupRFC.dsp'; return true;" 
			 type="submit" value="Lookup"></input>
		  <input onclick="this.form.action='lookupRFCCreateTemplate.dsp'; return true;"
			 type="submit" name="$envelope" value="RFC-XML"></input>
		  <input onclick="this.form.action='lookupRFCCreateTemplate.dsp'; return true;" 
			 type="submit" name="$envelope" value="bXML"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">Business Object By Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">Business Object</td>
		<td class="oddrow-l"><input name="objectName" value="%value objectName%"></input></td>
	      </tr>
	      <!-- %ifvar systemIds% -->
	      <tr>
		<td class="action" colspan="2">
		  <input onclick="this.form.action='lookupBOAll.dsp'; return true;" 
			 type="submit" value="Lookup"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">Function Search</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">Function Name</td>
		<td class="oddrow-l"><input name="functionPattern" value="%value functionPattern%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">Group Name</td>
		<td class="evenrow-l"><input name="groupPattern" value="%value groupPattern%"></input></td>
	      </tr>
	      <!-- %ifvar systemIds% -->
	      <tr>
		<td class="action" colspan="2">
		  <input type="submit" name="submit" value="Search"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">Table By Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">Table Name</td>
		<td class="oddrow-l"><input name="structName" value="%value structName%"></input></td>
	      </tr>
	      <!-- %ifvar systemIds% -->
	      <tr>
		<td class="action" colspan="2">
		  <input onclick="this.form.action='lookupRFCStructure.dsp'; return true;"
			 type="submit" name="submit" value="Lookup"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	    </table>
	    <table class="tableForm" width="80%">
	      <tr>
		<td class="heading" colspan="2">IDoc By Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="30%">IDoc Type</td>
		<td class="oddrow-l"><input name="iDocType" value="%value iDocType%"></input></td>
	      <tr>
	      </tr>
		<td class="oddrow" width="30%">IDoc Type Extension</td>
		<td class="oddrow-l"><input name="cimType" value="%value cimType%"></input></td>
	      <tr>
	      </tr>
		<td class="oddrow" width="30%">Release</td>
		<td class="oddrow-l"><input name="iDocRelease" value="%value iDocRelease%"></input></td>
	      </tr>
	      <!-- %ifvar systemIds% -->
	      <tr>
		<td class="action" colspan="2">
		  <input onclick="this.form.action='lookupIDoc.dsp'; return true;"
			 type="submit" name="submit" value="Lookup"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	    </table>
	  </form>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>