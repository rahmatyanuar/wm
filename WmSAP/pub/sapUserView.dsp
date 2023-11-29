<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - SAP Users</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
 
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/sapUserStore.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_TS_TID', 'foo');">
	%ifvar $action equals('Save')%
	  %invoke wm.sap.SAPUsers:update%
		%onerror% %include error.html%
	  %endinvoke%
	  %ifvar $message -notempty%
		<script language="javascript" type="text/javascript">
			<!--
			window.location.assign( "sapUserStore.dsp?adapterTypeName=WmSAP&$message=%value $message%");
			// -->
		</script>	  
	  %endifvar%
	%endifvar%
	%ifvar $action equals('Edit')%
	  %invoke wm.sap.SAPUsers:get%
		%onerror% %include error.html%
	  %endinvoke%
	%endifvar%
	<table width="100%">
<!-- %ifvar $action equals('Edit')% -->
      <tr>
		<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; SAP Users &gt; Modify User Alias %value userAlias%</td>
      </tr>
      <!-- %ifvar $fault -notempty% -->
      <tr><td style="color: #781863; background-color: #ffe5e9; border-color: #781863;"
	      class="message" colspan="2">%value $fault%</td></tr>
      <!-- %endif% -->
      <tr>
		<td colspan="2">
		<ul>
		  <li><a href="sapUserStore.dsp?adapterTypeName=WmSAP&amp;">Return to SAP User List</a></li>
		</ul>
		</td>
      </tr>
	  <tr>
		 <td class="space" colspan="2">&nbsp;</td>
	  </tr>
      <tr>
		<td class="padding">&nbsp;</td>
		<td>
		<form action="sapUserView.dsp" method="post">
		  <table class="tableView" width="40%">
			<thead>
				<tr>
				  <td class="heading" colspan="2">SAP User Attributes</td>
				</tr>
				<tr>
				  <td class="oddrow-l">User Alias</td>
				  <!-- %ifvar $subAction equals('Add')% -->
				   <td class="oddrow-l"><input name="userAlias" value="%value userAlias%"></input></td>
				  <!-- %else% -->
				   <td class="oddrowdata-l">%value userAlias%</td>
				  <!-- %endif% -->
				</tr>
				<tr>
				  <td class="evenrow-l">User Name</td>
				  <td class="evenrow-l"><input name="userName" value="%value userName%"></input></td>

				</tr>
				<tr>
				  <td class="oddrow-l">User Password</td>
				  <td class="oddrow-l"><input name="userPassword" autocomplete="off" type="password" size="20" maxlength="256" value="%value userPassword%"></input></td>
				</tr>
				<tr>
				  <td class="oddrow-l">Retype Password</td>
				  <td class="oddrow-l"><input name="userPassword2" autocomplete="off" type="password" size="20" maxlength="256" value="%value userPassword%"></input></td>
				</tr>
			</thead>
			<tbody>
				<tr>
				  <td class="space" colspan="2">&nbsp;</td>
				</tr>
				<tr>
				  <td class="action" colspan="2" style="border: none;">
				    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
				    <input type="hidden" name="userAlias" value="%value userAlias%"></input>
				    <input type="hidden" name="userName" value="%value userName%"></input>
				    <input type="hidden" name="userPassword" value="%value userPassword%"></input>
				    <input type="hidden" name="$subAction" value="%value $subAction%"></input>
				    <input type="submit" name="$action" value="Save"></input>
				    <input type="submit" name="$action" value="Cancel" formaction="sapUserStore.dsp?adapterTypeName=WmSAP&amp;"></input>
				  </td>
				</tr>
			</tbody>
	    </table>
	  </form>
	</td>
      </tr>
<!-- %else% -->
      <tr>
		<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; SAP Users &gt; User Alias %value userAlias%</td>
      </tr>
      <!-- %ifvar $message -notempty% -->
      <tr><td colspan="5">&nbsp;</td></tr>
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	      class="message" colspan="5">%value $message%</td></tr>
      <!-- %endif% -->
      <!-- %ifvar $fault -notempty% -->
      <tr><td colspan="5">&nbsp;</td></tr>
      <tr><td class="message" colspan="5">%value $fault%</td></tr>
      <!-- %endif% -->
      <tr>
		<td colspan="2">
		<ul>
		  <li><a href="sapUserStore.dsp?adapterTypeName=WmSAP&amp;">Return to SAP User List</a></li>
		</ul>
		</td>
      </tr>
	  <tr>
		 <td class="space" colspan="2">&nbsp;</td>
	  </tr>
      <tr>
		<td class="padding">&nbsp;</td>
		<td>
		<form action="sapUserView.dsp" method="post">
		  <table class="tableView" width="40%">
			<thead>
				<tr>
				  <td class="heading" colspan="2">SAP User Attributes</td>
				</tr>
				<tr>
				  <td class="oddrow-l">User Alias</td>
				  <td class="oddrowdata-l">%value userAlias%</td>
				</tr>
				<tr>
				  <td class="evenrow-l">User Name</td>
				  <td class="evenrowdata-l">%value userName%</td>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td class="space" colspan="2">&nbsp;</td>
			</tr>
				<tr>
				  <td class="action" colspan="2" style="border: none;">
				    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
				    <input type="hidden" name="userAlias" value="%value userAlias%"></input>
				    <input type="hidden" name="$subAction" value="Put"></input>
				    <input type="submit" name="$action" value="Edit"></input>
				  </td>
				</tr>
			</tbody>
	    </table>
	  </form>
	</td>
      </tr>
<!-- %endif% -->
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>
