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
  <body>
    <!-- %invoke wm.sap.Rfc:listRows% -->
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Function Module Signature &gt; Function Module Test &gt; Results &gt; View Table</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="javascript:history.back()">Return to Results</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView" width="100%" style="margin-bottom: 0px;">
	    <tr>
	      <td class="subheading2">%value fullName%</td>
	    </tr>
	  </table>
	  <table class="tableView" width="100%">
	    <thead>
	      <!-- %comment% column info %endcomment% -->
	      <tr>
		   <!-- %loop cols% -->
		<td class="oddcol">%value%</td>
		   <!-- %endloop% -->
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop rows% -->
	      <tr>
		     <!-- %loop -struct% -->
		<td class="oddrowdata">%value%</td>
		     <!-- %endloop% -->
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    <!-- %onerror% -->
    %include error.html%
    <!-- %endinvoke% -->
  </body>
</html>

