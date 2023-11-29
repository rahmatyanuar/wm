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

<body onLoad="setNavigation('streaming-detail.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_StreamingTriggerDetailsScrn');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Event Processing Trigger Management &gt; Details</TD>
    </tr>
    %ifvar action equals('edit')%  
    
      %invoke wm.server.streaming:updateTrigger% 
        <tr>
          <td colspan="2">&nbsp;</td>
          </tr>
        <tr>
          <td class="message" colspan=2>%value message encode(html)%</TD>
        </tr>
      %endinvoke%
    %endif%

    %invoke wm.server.streaming:getTriggerReport%

    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_streaming", "streaming.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("streaming-trigger-management.dsp","javascript:document.htmlform_settings_streaming.submit();","Return to Event Processing Trigger Management")</script>
		  </li>

          %ifvar enabled equals('false')%
		    <script>
		    createForm("htmlform_settings_streaming_edit", "streaming-edit.dsp", "POST", "BODY");
			setFormProperty("htmlform_settings_streaming_edit", "name", "%value name encode(url)%");
		    </script>
            <li class="listitem">
			<script>getURL("streaming-edit-trigger.dsp?name=%value name encode(url)%","javascript:document.htmlform_settings_streaming_edit.submit();","Edit Streaming Trigger")</script>
			</li>
          %else%
            <li class="listitem"><div class="disabledLink">Edit Event Processing Trigger</div></li>
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
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Trigger Name</td>
            <td class="oddrowdata-l">%value triggerName encode(html)%</td>
          </tr>
          </tr>
          <!-- Package -->
          <tr>
            <td class="oddrow-l" scope="row">Package</td>
            <td class="oddrowdata-l">%value triggerData/node_pkg encode(html)%</td>
          </tr>
          <!-- Connection Alias -->
          <tr>
            <td class="oddrow-l" scope="row">Connection Alias</td>
            <td class="oddrowdata-l">%value triggerData/trigger/aliasName encode(html)%</td>
          </tr>
		  
		  <!-- Client ID -->
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Client ID</td>
            <td class="oddrowdata-l">%value triggerData/trigger/clientIdDisplay encode(html)%</td>
          </tr>
		  
		  
          <!-- Enabled -->
          <tr>
            <td class="evenrow-l" scope="row">Enabled</td>
            %ifvar triggerData/trigger/enabled equals('true')%
              <td class="evenrowdata-l"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="images/green_check.png">Yes</td>
            %else%
              <td class="evenrowdata-l">No</td>
            %endif%
	      </tr>

        <!--                               -->
        <!-- Stream Builder  -->
        <!--                               -->
        
          <tr>
            <td class="heading" colspan=2>Receive and Decode</td>
          </tr>
		  
		  <!-- Source ID -->
		  <tr>
            <td class="subheading" colspan=2>
			  %loop triggerData/trigger/source%
                %value sourceId encode(html)%&nbsp;
		      %end%
			</td>
          </tr>

          <!-- Topic -->
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Subject</td>
            <td class="oddrowdata-l">
			  %loop triggerData/trigger/source%
                Topic: %value source-schema/sourceName encode(html)%&nbsp;
		      %end%
			</td> 
          </tr>
		  
		  <!-- Key -->
          <tr>
		    <td width="40%" class="oddrow-l" scope="row" nowrap="true">Key Deserializer</td>
            <td width="40%" class="oddrow-l">
              %loop triggerData/trigger/source%
                %value source-schema/keyCoder/type encode(html)%&nbsp;
		      %end%
		    </td>
          </tr>
		  
		  <!-- Value -->
          <tr>
		    <td width="40%" class="oddrow-l" scope="row" nowrap="true">Value Deserializer</td>
            <td width="40%" class="oddrow-l">
              %loop triggerData/trigger/source%
                %value source-schema/valueCoder/type encode(html)%&nbsp;
		      %end%
		    </td>
          </tr>
		  
		  <!-- Process -->
		  <tr>
            <td class="heading" colspan=2>Process</td>
          </tr>
		  
		  <!-- Window Type -->
		  <tr>
            <td class="subheading" colspan=2>Window</td>
          </tr>
          <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Window Type</td>
            <td class="oddrowdata-l">%value triggerData/trigger/window/type encode(html)%</td>
          </tr>
		  %loop triggerData/trigger/window/parameters/nameValue%
		    <!-- Name/Value -->
            <tr>
              <td width="40%" class="oddrow-l" scope="row" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value name encode(html)%</td>
              <td class="oddrowdata-l">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value value encode(html)%</td>
            </tr>
		  %end%
		  
		  %loop triggerData/trigger/process%
		    <tr>
              <td class="subheading" colspan=2>Process %value processId encode(html)%</td>
            </tr>
		    
			%loop intermediate%
		      <tr>
                <td width="40%" class="oddrow-l" scope="row" nowrap="true">Intermediate Operation</td>
                <td class="oddrowdata-l">%value type encode(html)%</td>
              </tr>
			  %loop parameters/nameValue%
		        <!-- Name/Value -->
                <tr>
                  <td width="40%" class="oddrow-l" scope="row" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value name encode(html)%</td>
                  <td class="oddrowdata-l">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value value encode(html)%</td>
                </tr>
		      %endloop%
			%endloop%

			%loop terminal%
		      <tr>
                <td width="40%" class="oddrow-l" scope="row" nowrap="true">Terminal Operation</td>
                <td class="oddrowdata-l">%value type encode(html)%</td>
              </tr>
			  %loop parameters/nameValue%
		        <!-- Name/Value -->
                <tr>
                  <td width="40%" class="oddrow-l" scope="row" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value name encode(html)%</td>
                  <td class="oddrowdata-l">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value value encode(html)%</td>
                </tr>
		      %endloop%
			%endloop%			
			
		  %endloop%
		  
		  <tr>
            <td class="subheading" colspan=2>Process Results</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Target Operation</td>
            <td class="oddrowdata-l">%value triggerData/trigger/target/type encode(html)%</td>
          </tr>
		  %loop triggerData/trigger/target/parameters/nameValue%
		    <!-- Name/Value -->
            <tr>
              <td width="40%" class="oddrow-l" scope="row" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value name encode(html)%</td>
              <td class="oddrowdata-l">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value value encode(html)%</td>
            </tr>
		  %endloop%
		  
		 
		  
		  <!-- Properties -->
		  <tr>
            <td class="heading" colspan=2>Properties</td>
          </tr>
		  
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Commit Mode</td>
            <td class="oddrowdata-l">%value triggerData/trigger/commitMode encode(html)%</td>
          </tr>		  

		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Polling Request Size</td>
            <td class="oddrowdata-l">%value triggerData/trigger/pollingRequestSize encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Polling Interval</td>
            <td class="oddrowdata-l">%value triggerData/trigger/pollingInterval encode(html)%&nbsp;%value triggerData/trigger/pollingIntervalUnit encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Max Buffer</td>
            <td class="oddrowdata-l">%value triggerData/trigger/maxBuffer encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Consumer Count Minimum</td>
            <td class="oddrowdata-l">%value triggerData/trigger/minConsumers encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Consumer Count Maximum</td>
            <td class="oddrowdata-l">%value triggerData/trigger/maxConsumers encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Add Consumers After</td>
            <td class="oddrowdata-l">%value triggerData/trigger/consumerExpansionDelay encode(html)%&nbsp;%value triggerData/trigger/consumerExpansionDelayUnit encode(html)%</td>
          </tr>
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Remove Inactive Consumers After</td>
            <td class="oddrowdata-l">%value triggerData/trigger/consumerCleanupDelay encode(html)%&nbsp;%value triggerData/trigger/consumerCleanupDelayUnit encode(html)%</td>
          </tr>
		  
		  <tr>
            <td width="40%" class="oddrow-l" scope="row" nowrap="true">Use Parallel Streams</td>
            <td class="oddrowdata-l">%value value triggerData/trigger/useParallelStreams(html)%</td>
          </tr>
		  
		  

		  <!-- Configuration Parameters -->
		  <tr>
            <td class="heading" colspan=2>Configuration Parameters</td>
          </tr>
		  
		  %loop triggerData/trigger/configurationParameters%		  
		    <tr>
              %loop -struct%
                <TD>%value $key%</TD>
                <TD>%value%</TD>
              %end%
            </tr>
		  %end%
		  
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
