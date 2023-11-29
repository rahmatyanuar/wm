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

   %switch todo%
      %case 'Add'%
        %invoke wm.sap.Rfc:addRow%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'Insert'%
        %invoke wm.sap.Rfc:insertRow%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'Save'%
        %invoke wm.sap.Rfc:updateRow%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'Delete'%
        %invoke wm.sap.Rfc:deleteRow%
        %onerror%
          %include error.html%
        %endinvoke%
      %case 'Edit'%
        %invoke wm.sap.Rfc:checkEditSelection%
        %onerror%
          %rename ../todo $dummy%
          %include error.html%
        %endinvoke%
    %endswitch%

    %invoke wm.sap.Rfc:listRows%
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; Function Module Signature &gt; Function Module Test &gt;
	  Edit Table</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="javascript:history.back()">Return to Function Module Test</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="lookupRFCInvokeEditTable.dsp" method="post">
	    <input type="hidden" name="tableName" value="%value tableName%"></input>
	    <input type="hidden" name="fullName" value="%value /fullName%"></input>
	    <input type="hidden" name="$rfcname" value="%value /$rfcname%"></input>
	    <input type="hidden" name="systemId" value="%value systemId%"></input>
	    <table class="tableView" width="100%" style="margin-bottom: 0px;">
	      <tr>
		<td class="subheading2">%value /fullName%</td>
	      </tr>
	      <tr>
		<td class="action">
		  <!-- %ifvar todo equals('Edit')% -->
		  <input type="submit" name="todo" value="Save"></input>
		  <input type="submit" name="todo" value="Cancel"></input>
		  <!-- %else% -->
		    <!-- %ifvar rowCount equals('0')% -->
		    <!-- %else% -->
		  <input type="submit" name="todo" value="Edit"></input>
		  <input type="submit" name="todo" value="Insert"></input>
		  <input type="submit" name="todo" value="Delete"></input>
		    <!-- %endif% -->
		  <input type="submit" name="todo" value="Add"></input>
		  <input onclick="this.form.action='lookupRFCInvoke.dsp'; return true;" type="submit" name="todo" value="Done"></input>
		  <!-- %endif% -->
		</td>
	      </tr>
	    </table>
	    <table class="tableView" width="100%">
		  <thead>
	       <!-- %comment% column info %endcomment% -->
	      <tr>
		<!-- %ifvar todo equals('Edit')% -->
		<!-- %else% -->
		<td class="oddcol">&nbsp;</td>
		<!-- %endif% -->
		<!-- %loop cols% -->
		<td class="oddcol">%value%</td>
		<!-- %endloop% -->
	      </tr>
		</thead>	      
	      <!-- %comment% existing rows %endcomment%-->
	    <tbody id="tbodyNode">
	      <!-- %loop rows% -->
	      <tr>
	    		    <!-- %ifvar ../todo equals('Edit')% -->
		    <!-- %else% -->
		<td class="rowlabel">
		  <input type="radio" name="rowNum" value="%value $index%"></input>
		</td>
		    <!-- %endif% -->
		    <!-- %ifvar ../todo equals('Edit')% -->
    		  <!-- %ifvar ../rowNum vequals($index)%%comment% this is the row to edit %endcomment% -->
    		    <!-- %rename ../rowNum rowNum -copy% -->
    		    <!-- %rename ../tableName tableName -copy% -->
    		    <!-- %rename ../systemId systemId -copy% -->
    		    <!-- %invoke wm.sap.Rfc:getRow% -->
				  <!-- %loop fields% -->
		<td class="oddrow-l">
		  <input name="rowNum" type="hidden" value="%value ../rowNum%"></input>
		            <!-- %ifvar maxlength equals(-1)%%comment% STRING or XSTRING no length limit %endcomment% -->
		  <input name="%value name%" size="42" value="%value value%"></input>
		            <!-- %else%%comment% other scalars %endcomment% -->
		  <input name="%value name%" maxlength="%value maxlength%" size="%value maxlength%" value="%value value%"></input>
		            <!-- %endif% -->
		</td>
		          <!-- %endloop% -->
		        <!-- %endinvoke% -->
		      <!-- %else% -->
		        <!-- %loop -struct%-->
		<td class="oddrowdata">%value%</td>
		        <!-- %endloop% -->
		      <!-- %endif% -->
		    <!-- %else% -->
		      <!-- %loop -struct% -->
		<td class="oddrowdata">%value%</td>
		      <!-- %endloop% -->
		    <!-- %endif% -->
		  </tr>
	      <!-- %endloop% -->
	    </tbody>
	      <!-- %comment% new row %endcomment% -->
	    <!-- %ifvar todo equals('Edit')% -->
		<!-- %else% -->
	      <tr>
		<td class="rowlabel">&nbsp;</td>
		  <!-- %loop cols% -->
		<td class="oddrowdata">
		  <input name="%value%" size="%value sizes%" maxlength="%value sizes%"></input>
		</td>
		  <!-- %endloop% -->
	      </tr>
	    <!-- %endif% -->
	    </table>
	  <script>swapColor('tbodyNode', false);</script>
	  </form>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
 </body>
</html>