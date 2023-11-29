<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Mapping</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/cbr.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_RG', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Routing/Mapping</td>
      </tr>
    %ifvar action equals('Save')%
      %invoke wm.sap.Cbr:updateRoutingServices%
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	  class="message" colspan="2">Routing/mapping settings updated.</td></tr>
      %onerror%
      <tr><td class="message" colspan="2">%value errorMessage%</td></tr>
      %endinvoke%
    %endif%
    %ifvar action equals('Register')%
      %invoke wm.sap.Cbr:registerService%
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	  class="message" colspan="2">Routing/mapping info service
	  "%value serviceName%" registered.</td></tr>
      %onerror%
      <tr><td class="message" colspan="2">%value errorMessage%</td></tr>
      %endinvoke%
    %endif%
    %ifvar action equals('Unregister')%
      %invoke wm.sap.Cbr:unregisterService%
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	  class="message" colspan="2">Routing/mapping info service
	  "%value serviceName%" unregistered.</td></tr>
      %onerror%
      <tr><td class="message" colspan="2">%value errorMessage%</td></tr>
      %endinvoke%
    %endif%
    %ifvar action equals('Cancel')%
      <tr><td style="color: #187863; background-color: #e5ffe9; border-color: #187863;"
	  class="message" colspan="2">Routing/mapping settings changes cancelled.</td></tr>
    %endif%
    %invoke wm.sap.Cbr:getRoutingServices%
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="cbrTypes.dsp?adapterTypeName=WmSAP&amp;action=Register">Register
		New User Exit Service</a></li>
	    <li><a href="cbrTypes.dsp?adapterTypeName=WmSAP&amp;action=Unregister">Unregister
		User Exit Service</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="cbr.dsp" method="post">
	    <input type="hidden" name="adapterTypeName" value="WmSAP"></input>
	    <table class="tableForm" width="95%">
	      <tr>
		<td class="heading" colspan="3">Content based Routing/Mapping Settings for IDocs</td>
	      </tr>
	      <tr>
		<td class="subHeading" colspan="3">Default handling for all IDocs</td>
	      </tr>
	      <tr>
		<td class="oddrowdata">&nbsp;</td>
		<td class="oddrowdata">Inbound Service</td>
		<td class="oddrowdata">Outbound Service</td>
	      </tr>
	      <!-- 
	      %loop services%
	      %ifvar msgType equals('$default')%
	      -->
	      <tr>
		<td class="evenrow">&nbsp;</td>
		<td class="evenrow">
		  <select name="defaultInbound">
		    <!-- %loop infoInbound% -->
		    <!-- %ifvar isActive equals('true')% -->
		    <option selected="selected" value="%value serviceName%">%value serviceName%</option>
		    <!-- %else% -->
		    <option value="%value serviceName%">%value serviceName%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
		<td class="evenrow">
		  <select name="defaultOutbound">
		    <!-- %loop infoOutbound% -->
		    <!-- %ifvar isActive equals('true')% -->
		    <option selected="selected" value="%value serviceName%">%value serviceName%</option>
		    <!-- %else% -->
		    <option value="%value serviceName%">%value serviceName%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
	      </tr>
	      <!--
	      %endif%
	      %endloop%
	      -->
	      <tr>
		<td colspan="3">&nbsp;</td>
	      </tr>
	      <tr>
		<td class="subHeading" colspan="3">Message type dependent settings</td>
	      </tr>
	      <tr>
		<td class="oddrowdata">Message Type</td>
		<td class="oddrowdata">Inbound Service</td>
		<td class="oddrowdata">Outbound Service</td>
	      </tr>
	      <!--
	      %loop services%
	      %ifvar msgType equals('$xml')%%else%
	      %ifvar msgType equals('$default')%%else% 
	      -->
	      <tr>
		<td class="evenrow-l">%value msgType%<input type="hidden" name="msgType" value="%value msgType%"></input></td>
		<td class="evenrow">
		  <select name="servicesInbound">
		    <!-- %loop infoInbound% -->
		    <!-- %ifvar isActive equals('true')% -->
		    <option selected="selected" value="%value serviceName%">%value serviceName%</option>
		    <!-- %else% -->
		    <option value="%value serviceName%">%value serviceName%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
		<td class="evenrow">
		  <select name="servicesOutbound">
		    <!-- %loop infoOutbound% -->
		    <!-- %ifvar isActive equals('true')% -->
		    <option selected="selected" value="%value serviceName%">%value serviceName%</option>
		    <!-- %else% -->
		    <option value="%value serviceName%">%value serviceName%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <!-- %endif% -->
	      <!-- %endloop% -->
	      <tr>
		<td colspan="3">&nbsp;</td>
	      </tr>
	      <tr>
		<td class="heading" colspan="3">Content based Routing Settings for XML</td>
	      </tr>
	      <tr>
		<td class="subHeading" colspan="3">Handling
		  for all incoming XML documents</td>
	      </tr>
	      <tr>
		<td class="oddrowdata">&nbsp;</td>
		<td class="oddrowdata">Inbound Service</td>
		<td class="oddrowdata">&nbsp;</td>
	      </tr>
	      <!-- 
	      %loop services%
	      %ifvar msgType equals('$xml')%
	      -->
	      <tr>
		<td class="evenrow">&nbsp;</td>
		<td class="evenrow">
		  <select name="xmlInbound">
		    <!-- %loop infoInbound% -->
		    <!-- %ifvar isActive equals('true')% -->
		    <option selected="selected" value="%value serviceName%">%value serviceName%</option>
		    <!-- %else% -->
		    <option value="%value serviceName%">%value serviceName%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
		<td class="evenrow">&nbsp;</td>
	      </tr>
	      <!--
	      %endif%
	      %endloop%
	      -->
	      <tr>
		<td colspan="3">&nbsp;</td>
	      </tr>
	      <tr>
		<td class="action" colspan="3">
		  <input type="submit" name="action" value="Save"></input>
		  <input type="submit" name="action" value="Cancel"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
    %onerror%
    %include error.html%
    %endinvoke%
  </body>
</html>
