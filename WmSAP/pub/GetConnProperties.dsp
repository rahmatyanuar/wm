%comment%----- Displays Connection Parameters and Properties -----%endcomment%

<HTML> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Connection Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></LINK>
		<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
				
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script SRC="/WmART/artconnjs.txt"></script>
        <script src="sap.js.txt"></script>
    </head>
    
    <body onload="init();">
        <form name="form" action="ListResources.dsp" method="POST" onsubmit="enableAll(form);">
        %ifvar lt8%<input type="hidden" name="lt8" value="true">%endif%
        <input type="hidden" name="action" value="saveConnection">
        <input type="hidden" name="passwordChange" value="false">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
        
     
        %invoke wm.art.admin:retrieveAdapterTypeData%
        %onerror%
        %endinvoke%
    
        <table width="100%">  
            <tr>
               <td class="breadcrumb" colspan=7>Adapters &gt; %value displayName% &gt; Configure Connection Type</td>
            </tr>
          
            <tr>
                <td colspan=2>
                    <ul>
			%comment%----- LG TRAX 1-KX9WM Added dspName=.LISTCONNECTIONTYPES -----%endcomment%
                        <li><a href="ListAdapterConnTypes.dsp?%ifvar lt8%lt8=true&amp;%endif%adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTCONNECTIONTYPES">Return to %value displayName% Connection Types</a>
                    </ul>
                </td>
            </tr>
           
            %comment%----------------------ConnectionProperties--------------%endcomment%     
            %invoke wm.art.admin.connection:getConnectionProperties%
			<td>
				<tr>
				<table class="tableView" width="100%">
				<tbody>
                <tr>
                    <td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
                </tr>
                %include DisplayConnectionProperties.dsp%         
            %onerror%
                <tr>
                    <td class="heading" colspan=2>Configure Connection Type</td>
                </tr>
                  %ifvar localizedMessage%
                    %comment%-- Localized error message supplied --%endcomment%
                    <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
                  %else%
                    %ifvar error%
                      <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
                    %endif%
                  %endif%
            %endinvoke%
    
            <tr>
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%  
                %invoke wm.art.admin.connection:getConnectionManagerProperties% 
                    %include ../../WmART/pub/DisplayConnectionManagerProperties.dsp% 
                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
                        %endif%
                    %endif%
                %endinvoke%
        </table>
    
        <table width=100%>
        <td class="action" colspan="2">
            <input type="submit" name="SUBMIT" value="Save Connection"  onclick="return validateForm(this.form)"></input>
            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%"> 
        </td>    
        </tr>
        </table>
		
	</tbody>
	</table>
	</td>
	</tr>	
        </form>    
    </body>
</html>
