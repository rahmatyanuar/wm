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
    <TITLE>Integration Server -- IP Access Management</TITLE>
  </HEAD>

   <BODY onLoad="setNavigation('server-ipaccess-add.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_AddHoststoListScrn');">

    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          IP Access &gt;
          Add Hosts
          %ifvar listenerKey%
            %ifvar listenerKey equals('global')%
                &gt; global
            %else%
				&gt; %value listenerKey encode(html)%
            %endif%
          %endif%
      </TD>
      </TR>

      <TR>
        <TD colspan="2">
          <ul class="listitems">
			<script>
			createForm("htmlform_server_ipaccess", "server-ipaccess.dsp", "POST", "BODY");
			setFormProperty("htmlform_server_ipaccess", "listenerKey", "%value listenerKey encode(url)%");
			setFormProperty("htmlform_server_ipaccess", "pkg", "%value pkg encode(url)%");
			</script>
            <li>
			<script>getURL("server-ipaccess.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%", "javascript:document.htmlform_server_ipaccess.submit();", "Return to IP Access");</script>
			</li>
          </UL>
        </TD>
      </TR>
      <SCRIPT>

        function convertToSeconds(allow){
            interval='0';
            if(allow){
                unit = document.hostAllowListService.allowListServiceIntervalUnits.value;
                interval = document.hostAllowListService.allowListServiceInterval.value;
            } else{
                unit = document.hostDenyListService.denyListServiceIntervalUnits.value;
                interval = document.hostDenyListService.denyListServiceInterval.value;
            }

            if(unit == 'minutes'){
                interval = interval * 60;
            } else if(unit == 'hours'){
                interval = interval * 3600;
            } else if(unit == 'days'){
                interval = interval * 86400;
            } else{
                interval = 0;
            }

            if(allow){
                document.hostAllowListService.allowListServiceInterval.value = interval.toString();
            } else{
                document.hostDenyListService.denyListServiceInterval.value = interval.toString();
            }
        }
        function pollingIntervalUnitsOnchange(allow){
            if(allow){
                unit = document.getElementById("allowListServiceIntervalUnits").value;
                if(unit == '0'){
                    document.getElementById("allowListServiceInterval").disabled = true;
                    document.getElementById("allowListServiceInterval").value = "";
                } else{
                    document.getElementById("allowListServiceInterval").disabled = false;
                }
            } else{
                unit = document.getElementById("denyListServiceIntervalUnits").value;
                if(unit == '0'){
                    document.getElementById("denyListServiceInterval").disabled = true;
                    document.getElementById("denyListServiceInterval").value = "";
                } else{
                    document.getElementById("denyListServiceInterval").disabled = false;
                }
            }
        }
        function validatePollingInterval(allow){
            if(allow){
                unit = document.hostAllowListService.allowListServiceIntervalUnits.value;
                interval = document.hostAllowListService.allowListServiceInterval.value;
            } else{
                unit = document.hostDenyListService.denyListServiceIntervalUnits.value;
                interval = document.hostDenyListService.denyListServiceInterval.value;
            }

            if(unit != '0'){
                interval = interval.toString();
                interval = interval.trim();
                if(interval == "")
                    return false;
                if(isNaN(interval)){
                    alert('PollingInterval must be greater than 0');
                    return false;
                }
                interval = Number(interval);
                if(interval <= 0){
                    alert('PollingInterval must be greater than 0');
                    return false;
                }
            }
            return true;
        }
        function allowListMethod(val){
            serviceTable = document.getElementById("allowListService");
            manualTable = document.getElementById("allowListManual");
            if(val=='service'){
                serviceTable.style.display="block";
                serviceTable.style.display="table-row";
                manualTable.style.display="none";
            } else{
                manualTable.style.display="block";
                manualTable.style.display="table-row";
                serviceTable.style.display="none";
            }
        }
        function denyListMethod(val){
            serviceTable = document.getElementById("denyListService");
            manualTable = document.getElementById("denyListManual");
            if(val=='service'){
                serviceTable.style.display="block";
                serviceTable.style.display="table-row";
                manualTable.style.display="none";
            } else{
                manualTable.style.display="block";
                manualTable.style.display="table-row";
                serviceTable.style.display="none";
            }
        }
        function doAddAllow(){
            if (document.allowadd.allow.value==""){
                return false;
            }
            if (!validateHostPattern(document.allowadd.allow.value))
                return false;
            if(confirm('The manually added host list replaces the host list added using the service.')){
                var form = document.allowadd;
                form.submit();
                return true;
            }
        }
        function doAddDeny(){
            if (document.denyadd.deny.value==""){
                return false;
            }
            if (!validateHostPattern(document.denyadd.deny.value))
                return false;
            if(confirm('The manually added host list replaces the host list added using the service.')){
                var form = document.denyadd;
                form.submit();
                return true;
            }
        }
        function validateHostPattern(hostPatterns)
        {
            var regex = new RegExp("^ *[a-zA-Z0-9\-.\*\?]+ *$");
            var hostPattersnList = hostPatterns.split(",");
            for ( i = 0; i < hostPattersnList.length ; i++)
            {
                var hostPattern = hostPattersnList[i];
                //var hostPattern = hostPattern.trim();
                var match = regex.exec(hostPattern);
                if (!match && !(isIPv6Address(hostPattern)))
                {
                    alert("Invalid host pattern: " + hostPattern);
                    return false; 
                }
            }
            return true;
        }
        function doAddAllowListService()
        {
            // validate service name
            var svc = document.hostAllowListService.allowListService.value;
            if (!validateService(svc))
            {
                document.hostAllowListService.allowListService.focus();
                return false;
            }
            if(validatePollingInterval(true) && confirm('The service overwrites the current host list.')){
                document.getElementById("allowListServiceInterval").disabled = false;
                var form = document.hostAllowListService;
                convertToSeconds(true);
                form.submit();
                return true;
            }
        }
        function doAddDenyListService()
        {
            // validate service name
            var svc = document.hostDenyListService.denyListService.value;
            if (!validateService(svc))
            {
                document.hostDenyListService.denyListService.focus();
                return false;
            }
            if(validatePollingInterval(false) && confirm('The service overwrites the current host list.')){
                document.getElementById("denyListServiceInterval").disabled = false;
                var form = document.hostDenyListService;
                convertToSeconds(false);
                form.submit();
                return true;
            }
        }
        function validateService(svc)
        {
        	var idx = svc.lastIndexOf(":");
        	if (svc == "" || idx < 0 || idx > svc.length-1) {
        		alert (
        				"Specify service name in the form:\n\n"+
        				"          folder.subfolder:service\n"
        		);
        		return false;
        	}
        	return true;
        }
         </SCRIPT>
      <TR>
        <TD>
      %switch type%
        %case 'exclude'%
        <table class="tableView">
            <TR>
              <TD class="heading" colspan="2">Add Host</TD>
            </TR>
            <td class="oddrow-l">
              <input type="radio" name="method" id="manual" value="manual" checked onclick="allowListMethod('manual')">
                <label for="manual">Manually</label>
              </input>
              <input type="radio" name="method" id="service" value="service" onclick="allowListMethod('service')">
                <label for="service">Using a service</label>
              </input>
            </td>
        </table>
        <br>
      <table class="tableView" id="allowListManual">
            <TR>
              <TD class="heading" colspan="2">Allow Host</TD>
            </TR>
            <TR>
              <TD class="subheading" colspan="2">Separate hosts with commas</TD>
            </TR>
            <TR>
              <TD class="oddrow" valign="top"><label for="allow">Hosts</label></TD>
              <TD class="oddrow-l">
                <FORM NAME="allowadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                  <INPUT id="allow" NAME="allow" size="40" VALUE=""></INPUT>
                  Example: *.allowme.com, *.allowme2.com
              </TD>
            </TR>
            <tr>
              <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddAllow();"></td>
            </tr>
                </FORM>
          </table>
          <TABLE class="tableView" id="allowListService">
            <FORM NAME="hostAllowListService" ACTION="server-ipaccess.dsp" METHOD="POST">
             <TR>
                <TD class="heading" colspan="2">Service to Allow Host</TD>
             </TR>
             <TR>
                <TD class="oddrow" valign="top"><label for="hostAllowListService">Service</label></TD>
                <TD class="oddrow-l">
                    %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                    <INPUT TYPE="hidden" NAME="action" VALUE="addAllowListService">
          	        <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                    <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                    <INPUT id="allowListService" NAME="allowListService" size="40" VALUE=""></INPUT>
                    <br>
                    <div style="margin-top: 8px">
                        Service that follows the pub.security.ports:hostListProviderSpec specification
                    </div>
                </TD>
             </TR>
          	 <TR>
          		<TD class="oddrow" valign="top"><label for="hostAllowListServiceInterval">Polling Interval</label></TD>
          		<TD>
          			<INPUT type="number" min="1" id="allowListServiceInterval" NAME="allowListServiceInterval" size="40" VALUE=""></INPUT>
                    &emsp;
                    <select id="allowListServiceIntervalUnits" name="allowListServiceIntervalUnits" onchange="pollingIntervalUnitsOnchange(true)">
                        <option value="0" selected="selected">On demand</option>
                        <option value="minutes">Minutes</option>
                        <option value="hours">Hours</option>
                        <option value="days">Days</option>
          			</select>
          		</TD>
          	 </TR>
             <TR>
                <TD colspan="2" class="action"><input type="button" value="Save" onClick="doAddAllowListService();"></TD>
             </TR>
                </FORM>
          </TABLE>
      <SCRIPT>allowListMethod('manual');pollingIntervalUnitsOnchange(true);</SCRIPT>
    %case 'include'%
        <table class="tableView">
            <TR>
              <TD class="heading" colspan="2">Add Host</TD>
            </TR>
            <td class="oddrow-l">
              <input type="radio" name="method" id="manual" value="manual" checked onclick="denyListMethod('manual')">
                <label for="manual">Manually</label>
              </input>
              <input type="radio" name="method" id="service" value="service" onclick="denyListMethod('service')">
                <label for="service">Using a service</label>
              </input>
            </td>
        </table>
        <br>
          <TABLE class="tableView" id="denyListManual">
            <TR>
              <TD class="heading" colspan="2">Deny Host</TD>
            </TR>
            <TR>
              <TH class="subheading" scope="col" colspan="2">Separate hosts with commas</TH>
            </TR>
            <TR>
              <TD class="oddrow" valign="top"><label for="deny">Hosts</label></TD>
              <TD class="oddrow-l">
                <FORM NAME="denyadd" ACTION="server-ipaccess.dsp" METHOD="POST">
                  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                  <INPUT TYPE="hidden" NAME="action" VALUE="add">
                  <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                  <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                  <INPUT id="deny" NAME="deny" size="40" VALUE=""></INPUT>
                  Example: *.denyme.com, *.denyme2.com
               </TD>
            </TR>
            <tr>
               <td colspan="2" class="action"><input type="button" value="Add Hosts" onClick="doAddDeny();"></td>
            </tr>
                </FORM>
          </table>
          <TABLE class="tableView" id="denyListService">
            <FORM NAME="hostDenyListService" ACTION="server-ipaccess.dsp" METHOD="POST">
             <TR>
                <TD class="heading" colspan="2">Service to Deny Host</TD>
             </TR>
             <TR>
                <TD class="oddrow" valign="top"><label for="hostDenyListService">Service</label></TD>
                <TD class="oddrow-l">
                   %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                   <INPUT TYPE="hidden" NAME="action" VALUE="addDenyListService">
                   <INPUT TYPE="hidden" NAME="listenerKey" VALUE="%value listenerKey encode(htmlattr)%">
                   <INPUT TYPE="hidden" NAME="pkg" VALUE="%value pkg encode(htmlattr)%">
                   <INPUT id="denyListService" NAME="denyListService" size="40" VALUE=""></INPUT>
                   <br>
                   <div style="margin-top: 8px">
                       Service that follows the pub.security.ports:hostListProviderSpec specification
                   </div>
                </TD>
             </TR>
          	 <TR>
          		<TD class="oddrow" valign="top"><label for="hostDenyListServiceInterval">Polling Interval</label></TD>
          		<TD>
          		    <INPUT type="number" min="1" id="denyListServiceInterval" NAME="denyListServiceInterval" size="40" VALUE=""></INPUT>
          			&emsp;
          			<select id="denyListServiceIntervalUnits" name="denyListServiceIntervalUnits" onchange="pollingIntervalUnitsOnchange(false)">
                        <option value="0" selected="selected">On demand</option>
                        <option value="minutes">Minutes</option>
                        <option value="hours">Hours</option>
                        <option value="days">Days</option>
          			</select>
          		</TD>
          	 </TR>
             <TR>
                <TD colspan="2" class="action"><input type="button" value="Save" onClick="doAddDenyListService();"></TD>
             </TR>
                </FORM>
          </TABLE>
       <SCRIPT>denyListMethod('manual');pollingIntervalUnitsOnchange(false);</SCRIPT>
    %endswitch%
        </td>
      </tr>

    </table>
  </body>
  </html>
