<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<SCRIPT SRC="webMethods.js"></SCRIPT>

<style>

.disabledLink
{
   color:#0D109B;
}

</style>

</head>

<body onLoad="setNavigation('streaming-detail.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_StreamingAliasDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Streaming Settings &gt; Streaming Connection Alias</TD>
    </tr>
    %ifvar action equals('edit')%  
    
      %invoke wm.server.streaming:updateConnectionAlias% 
        <tr>
          <td colspan="2">&nbsp;</td>
          </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</TD>
        </tr>
      %endinvoke%
    %endif%

    %invoke wm.server.streaming:getConnectionAliasReport%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_streaming", "streaming.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("streaming.dsp","javascript:document.htmlform_settings_streaming.submit();","Return to Streaming Settings")</script>
		  </li>

          %ifvar enabled equals('false')%
		    <script>
		    createForm("htmlform_settings_streaming_edit", "streaming-edit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_streaming_edit", "name", "%value name encode(url)%");
		    </script>
            <li class="listitem">
			<script>getURL("streaming-edit.dsp?name=%value name encode(url)%","javascript:document.htmlform_settings_streaming_edit.submit();","Edit Streaming Connection Alias")</script>
			</li>
          %else%
            <li class="listitem"><div class="disabledLink">Edit Streaming Connection Alias</div></li>
          %endif%
        </ul>
      </td>
    </tr>
    <tr>
      <td>
        <table class="tableView" width="100%">

          <form>
          %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

          <!--                        -->
          <!-- General Settings       -->
          <!--                        -->

          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>
          <!-- Connection Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Connection Alias Name</td>
            <td class="oddrowdata-l">%value name encode(html)%</td>
          </tr>
          </tr>
          <!-- Description -->
          <tr>
            <td class="oddrow-l" scope="row">Description</td>
            <td class="oddrowdata-l">%value description encode(html)%</td>
          </tr>
		  <!-- Type -->
          <tr>
            <td class="oddrow-l" scope="row">Provider Type</td>
            <td class="oddrowdata-l">%value type encode(html)%</td>
          </tr>
          <!-- Package -->
          <tr>
            <td class="oddrow-l" scope="row">Package</td>
            <td class="oddrowdata-l">%value package encode(html)%</td>
          </tr>

		  
		  <!-- Client ID  
          <tr>
            <td class="oddrow-l" scope="row">Client Prefix</td>
            <td class="oddrowdata-l">%value clientId encode(html)%</td>
          </tr>-->
		  
          <!-- Enabled -->
          <tr>
            <td class="evenrow-l" scope="row">Enabled</td>
            %ifvar enabled equals('true')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
	      </tr>

        <!--                               -->
        <!-- Connection Settings  -->
        <!--                               -->
        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Connection Settings</td>
          </tr>

          <!-- bootstrap.servers -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">URI (bootstrap.servers)</td> 
            <td class="oddrowdata-l">%value host encode(html)%</td>
          </tr>
		  
		  <!-- streaming.consumer.group.id.prefix -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Client Prefix</td> 
            <td class="oddrowdata-l">%value clientId encode(html)%</td>
          </tr>



          <!-- Additional Properties -->
		  <tr>
            <td class="evenrow-l"><label for="other_properties">Additional Configuration Parameters</label></td>
			<td class="oddrowdata-l">
             <!--<textarea readonly wrap="off" rows="5" name="other_properties" id="other_properties" cols="50">%value other_properties encode(htmlattr)%</textarea>--> 
			 <div style="font-weight: bold;">
			   <pre>%value other_properties encode(htmlattr)%</pre>
			 </div>
            </td>
          </tr>
		  
		</table>  

        <!--                        -->
        <!-- Advanced Settings      -->
        <!--                        -->

        <!--
        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Enable CSQ</td>
            %ifvar useCsq equals('true')%
              <td class="evenrowdata-l">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
          </tr>
          <tr>
            <script>writeTD("row-l");</script>Maximum CSQ Size</td>
            %ifvar csqSize -notempty%
              %switch csqSize%
                %case '-1'%
                  <script>writeTD("rowdata-l");</script>[UNLIMITED]</td>
                %case '1'%
                  <script>writeTD("rowdata-l");</script>1 message</td>
                %case%
                  <script>writeTD("rowdata-l");</script>%value csqSize encode(html)% messages</td>
               %end%
            %else%
              <script>writeTD("rowdata-l");</script>[UNLIMITED]</td>
            %endif%
          </tr>
	      </table> -->

        <!--                        -->
        <!-- Security Settings      -->
        <!--                        -->

        <table class="tableView" width="100%">
          <tr>
            <td class="heading" colspan=2>Security Settings</td>
          </tr>
          <!-- User -->
          <tr>
            <td width="40%" class="evenrow-l" scope="row" nowrap="true">User</td>
            <td class="evenrowdata-l">%value user encode(html)%</td>
          </tr>
          <!-- Pass -->
          <tr>
            <td class="oddrow-l" scope="row">Password</td>
            %ifvar password -notempty%
              <td class="oddrowdata-l">*****</td>
            %else%
              <td class="oddrowdata-l"></td>
            %endif%
          </tr>

		  <!-- Use SSL -->
          <tr>
            <td width="40%" class="evenrow-l" scope="row" nowrap="true">Use SSL</td>
            %ifvar useSSL equals('Yes')%
            	<td class="evenrowdata-l">%value useSSL encode(html)%</td>
            %else%
                <td class="evenrowdata-l">No</td>
            %endif%
          </tr>

		  %ifvar useSSL equals('Yes')%
		  <!-- Truststore alias -->
          <tr>
            <td class="oddrow-l" scope="row">Truststore Alias</td>
            <td class="oddrowdata-l">%value truststoreAlias encode(html)%</td>
          </tr>

		   <!-- Keystore alias -->
          <tr>
            <td class="evenrow-l" scope="row">Keystore Alias</td>
            <td class="evenrowdata-l">%value keystoreAlias encode(html)%</td>
          </tr>

		  <!-- Key alias -->
          <tr>
            <td class="oddrow-l" scope="row">Key Alias</td>
            <td class="oddrowdata-l">%value keystoreKeyAlias encode(html)%</td>
          </tr>
		   %endif%

	      </table>
      </td>
    </tr>

    %onerror%
      %value errorService encode(html)%<br>
      %value error encode(html)%<br>
      %value errorMessage encode(html)%<br>
    %endinvoke%

  </table>
</body>
</html>
