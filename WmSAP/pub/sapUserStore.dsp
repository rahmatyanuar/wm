<?xml version='1.0'?>
<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - SAP Users</title>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
	<link REL="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/sapUserStore.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_TS', 'foo');">
    %invoke wm.sap.SAPUsers:list%
    <table width="100%">
      <tr>
		<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; SAP Users</td>
      </tr>
      <!-- %ifvar $message -notempty% -->
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	      class="message" colspan="2">%value $message%</td></tr>
      <!-- %endif% -->
      <!-- %ifvar $fault -notempty% -->
      <tr><td style="color: #781863; background-color: #ffe5e9; border-color: #781863;"
	      class="message" colspan="2">%value $fault%</td></tr>
      <!-- %endif% -->
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="sapUserView.dsp?$action=Edit&amp;$subAction=Add&amp;adapterTypeName=WmSAP">Add New User</a>
	    </li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="sapUserStore.dsp" method="post">
	  <table class="tableView" width="45%">
	<tr>
	<table class="tableView" width="45%">
		<thead>
	     <tr>
		   <td class="heading" colspan="3">SAP User List - %value userCount% Entries</td>
	      </tr>
		</thead>

	      <tr colspan="3">
		<td class="oddrowdata-l" nowrap="nowrap">User Alias</a>
		</td>
		<td class="oddrowdata-l" nowrap="nowrap">User Name</br>
		</td>
		<td class="oddrowdata" nowrap="nowrap">Delete<br/>
		</td>
	      </tr>
		
	    <tbody id="tbodyNode">
	      <!-- %loop userList% -->
	      <tr>
			<td class="oddrowdata-l">
			 <a title="View User Details" href="sapUserView.dsp?adapterTypeName=WmSAP&amp;userAlias=%value userAlias%&amp;userName=%value userName%&amp;userPassword=%value userPassword%">%value userAlias%</a>
			</td>
			<td class="oddrowdata-l">
			  %value userName%
			</td>
			<td class="oddrowdata">
			 <a title="Delete User" href="sapUserStore.dsp?adapterTypeName=%value displayName%&amp;$action=delete&amp;userAlias=%value userAlias%" 
		        onclick="return confirm('Warning: Do you really want to delete this SAP User entry?');">
		     <img alt="delete" src="/WmRoot/icons/delete.gif" border="0"></img></a>
			</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	  </table>
	  <script type="text/javascript">swapColor( 'tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>
