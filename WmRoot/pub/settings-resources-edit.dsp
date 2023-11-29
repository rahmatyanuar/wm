<html>
    <script Language="JavaScript">
    	var authCodeValue;
    	var windowOpened = false;
    	var windowObjectReference = null;
    	var containsCode = null;
    	var getNewAuthorizationCode = false;

    	function oAuthParamsChangeEvent(){
    	    getNewAuthorizationCode = true;
    	}

    	function authorizationCodeChangedEvent(){
            getNewAuthorizationCode = false;
        }

        function verifyPositiveIntegerField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) <= 0) {
                alert("Value must be a positive integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyPositiveIntegerField_NotRequired(value, name)
        {
            if (isblank(value)) {
                return true;
            }
            else if (!isNum(value) || parseInt(value) <= 0) {
                alert("Value must be a positive integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function verifyNonnegativeIntegerField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) < 0) {
                alert("Value must be a nonnegative integer: "+name);
                return false;
            }
            else {
                return true;
            }
        }


        function verifyPercentageField_NotRequired(value, name)
        {
            if (isblank(value)) {
                return true;
            } 
            else if (!isNum(value) || parseInt(value) < 0 || parseInt(value) > 100) {
                    alert("Value must be an integer between 0 and 100: "+name);
                    return false;
            }
            else {
                return true;
            }
        }

        function verifyPercentageField(value, name)
        {
            if (isblank(value)) {
                alert(name + " is required.");
                return false;
            }
            else if (!isNum(value) || parseInt(value) < 0 || parseInt(value) > 100) {
                alert("Value must be an integer between 0 and 100: "+name);
                return false;
            }
            else {
                return true;
            }
        }

        function validateSettingValues()
        {
            var maxServerThreads = document.settings["watt.server.threadPool"].value;
            var minServerThreads = document.settings["watt.server.threadPoolMin"].value;
            var sessionTimeout   = document.settings["watt.server.clientTimeout"].value;
            var maxSchedThreads  = document.settings["watt.server.scheduler.threadThrottle"].value;
            var maxRedirects     = document.settings["watt.net.maxRedirects"].value;
            var outboundTimeout  = document.settings["watt.net.timeout"].value;
            var outboundRetries  = document.settings["watt.net.retries"].value;
            var svrThrdThreshold = document.settings["watt.server.control.serverThreadThreshold"].value;
            var schdThreadThrottle = document.settings["watt.server.scheduler.threadThrottle"].value;
            var sessionWarning   = document.settings["watt.server.session.stateful.warning"].value;
            var maxStatefulSessions = document.settings["watt.server.session.stateful.max"].value;
        
            if (validateOAuthSettings() &&
                verifyPositiveIntegerField(maxServerThreads,   "Maximum Server Threads")      &&
                verifyPositiveIntegerField(minServerThreads,   "Minimum Server Threads")      &&
                verifyPositiveIntegerField(sessionTimeout,     "Session Timeout")             &&
                verifyPositiveIntegerField(maxSchedThreads,    "Scheduler Maximum Threads")   &&
                verifyPositiveIntegerField_NotRequired(maxStatefulSessions,"Maximum Stateful Sessions")   &&
                verifyNonnegativeIntegerField(maxRedirects,    "Outbound Maximum Redirects")  &&
                verifyNonnegativeIntegerField(outboundTimeout, "Outbound Timeout")            &&
                verifyNonnegativeIntegerField(outboundRetries, "Outbound Retries")            &&
                verifyPercentageField_NotRequired(sessionWarning,  "Available Stateful Sessions Warning Threshold")   &&
                verifyPercentageField(svrThrdThreshold,        "Available Threads Warning Threshold") && 
                verifyPercentageField(schdThreadThrottle,      "Scheduler Thread Throttle")) {

                if (parseInt(maxServerThreads) < parseInt(minServerThreads)) {
                    alert("The Minimum number of server threads (" + minServerThreads + ")\n" +
                          "cannot exceed the Maximum number of server threads (" + maxServerThreads + ").");
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                return false;
            }
        }
        function setAuth(value) {
            if (value == "Basic") {
                enableBasic();
            } else {
              enableOAuth();
            }
            return true;
         }

        function respondToClientAuthChange(cAuth) {
            if (cAuth == 'Basic') {
                setAuth("Basic");
            }
            else {
                setAuth("OAuth");
            }
         }

        function enableOAuth(){
           document.settings["watt.server.smtp.authentication.type"].value="OAuth";
           auth = "OAuth";
           obj = document.getElementById("Password");
           obj.style.display = 'inline';
           document.settings.Password.disabled=true;
           document.settings["watt.server.smtp.oauth.authURL"].disabled=false;
           document.settings["watt.server.smtp.oauth.clientID"].disabled=false;
           document.settings["watt.server.smtp.oauth.clientSecret"].disabled=false;
           document.settings["watt.server.smtp.oauth.scope"].disabled=false;
           document.settings["watt.server.smtp.oauth.redirectURL"].disabled=false;
           document.settings["watt.server.smtp.oauth.accessTokenURL"].disabled=false;
           document.settings["watt.server.smtp.oauth.authorizationCode"].disabled=false;
           document.settings["watt.server.smtp.oauth.token.refreshInterval"].disabled=false;
           document.getElementById("testlink_OAuth").removeAttribute("style");
        }

        function enableBasic(){
           document.settings["watt.server.smtp.authentication.type"].value="Basic";
           auth = "Basic";
           obj = document.getElementById("Password");
           obj.style.display = 'inline';
           document.settings.Password.disabled=false;
           document.settings["watt.server.smtp.oauth.authURL"].disabled=true;
           document.settings["watt.server.smtp.oauth.clientID"].disabled=true;
           document.settings["watt.server.smtp.oauth.clientSecret"].disabled=true;
           document.settings["watt.server.smtp.oauth.scope"].disabled=true;
           document.settings["watt.server.smtp.oauth.redirectURL"].disabled=true;
           document.settings["watt.server.smtp.oauth.accessTokenURL"].disabled=true;
           document.settings["watt.server.smtp.oauth.authorizationCode"].disabled=true;
           document.settings["watt.server.smtp.oauth.token.refreshInterval"].disabled=true;
           document.getElementById("testlink_OAuth").style='pointer-events:none; color: #08080;';
        }

        function validateOAuthSettings(){
            var auth = document.settings["watt.server.smtp.authentication.type"].value;
            if((auth=="Basic") ){
                return true;
            }
            var authURL = document.settings["watt.server.smtp.oauth.authURL"].value;
            if (( authURL == null ) || ( authURL == "" ) || isblank(authURL)) {
              alert("Auth URL required");
              return false;
            }
            if(!isValidURL(authURL)){
              alert("Auth URL is invalid : " + authURL);
              return false;
            }
            var clientID = document.settings["watt.server.smtp.oauth.clientID"].value;
            if (( clientID == null ) || ( clientID == "" ) || isblank(clientID)) {
              alert("Client ID required");
              return false;
            }
            var clientSecret = document.settings["watt.server.smtp.oauth.clientSecret"].value;
            if (( clientSecret == null ) || ( clientSecret == "" ) || isblank(clientSecret)) {
              alert("Client Secret required");
              return false;
            }
            var scope = document.settings["watt.server.smtp.oauth.scope"].value;
            if (( scope == null ) || ( scope == "" ) || isblank(scope)) {
              alert("OAuth Scope required");
              return false;
            }
            var accessTokenURL = document.settings["watt.server.smtp.oauth.accessTokenURL"].value;
            if (( accessTokenURL == null ) || ( accessTokenURL == "" ) || isblank(accessTokenURL)) {
              alert("Access Token URL required");
              return false;
            }
            if(!isValidURL(accessTokenURL)){
              alert("Access Token URL is invalid : " + accessTokenURL);
              return false;
            }
            var redirectURL = document.settings["watt.server.smtp.oauth.redirectURL"].value;
            if (( redirectURL == null ) || ( redirectURL == "" ) || isblank(redirectURL)) {
              alert("Redirect URL required");
              return false;
             }
            if(!isValidRedirectURL(redirectURL)){
              alert("Redirect URL is invalid " + "If you are accessing Integration Server locally, redirect URLs must be http://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp or https://localhost:{port}/WmRoot/security-oauth-get-authcode.dsp • If you are accessing Integration Server remotely, use https://{ISHostName}:{port}/WmRoot/security-oauth-get-authcode.dsp");
              return false;
            }
             if(getNewAuthorizationCode){
                 var authcode = document.settings["watt.server.smtp.oauth.authorizationCode"].value;
                 if (authcode){
                    alert("Get a new authorization code as authURL/clientId/clientSecret/scope/redirectURL is updated.");
                 }
                 else {
                    alert("Enter authorization code.");
                 }
                 return false;
            }
            return true;
        }

        function isValidRedirectURL(url){
            return url.match(/^((https|http):\/\/)+([0-9A-Fa-f]{2}|[-()_.!~*';?:@&=+$,A-Za-z0-9])+\/WmRoot\/security-oauth-get-authcode.dsp$/);
        }

        function isValidURL(url){
            return url.match(/^(ht)tps?:\/\/[a-zA-Z0-9]/);
        }

        function windowOpen(windowOpenValue){
            getNewAuthorizationCode = false;
        	if((windowObjectReference == null || windowObjectReference.closed) && windowOpenValue=="true"){
                windowOpened = document.createElement("input");
                windowOpened.setAttribute("type", "hidden");
                windowOpened.setAttribute("name", "windowOpened");
                windowOpened.setAttribute("value", "true");
                document.settings.appendChild(windowOpened);
                var auth = document.settings["watt.server.smtp.authentication.type"].value;
                if((auth=="Basic") ){
                    alert("Get Authorization Code is applicable only for OAuth");
                    return;
                }
                if (!validateOAuthSettings()){
                    return;
                }
                var authURL = document.settings["watt.server.smtp.oauth.authURL"].value;
                var clientID = document.settings["watt.server.smtp.oauth.clientID"].value;
                var scope = document.settings["watt.server.smtp.oauth.scope"].value;
                var redirectURL = document.settings["watt.server.smtp.oauth.redirectURL"].value;
                var url = authURL.concat("?response_type=code&client_id=").concat(clientID).concat("&scope=").concat(scope).concat("&redirect_uri=").concat(redirectURL);
                windowObjectReference = window.open(url, "DescriptiveWindowName", "resizable, scrollbars, status");
            }
            setTimeout(function() {
                //Sends request to Redirect URL's Web Page receiveMessage
                windowObjectReference.postMessage("Get the Auth Code", "*");
                if(( authCodeValue == null ) || ( authCodeValue == "" ) || isblank(authCodeValue)){
                    windowOpen('false');
                }
            }, 2000);
        }
        	  //Listens to Request coming in from Redirect URL Web Page
        function receiveMessage(event){
        	var span = document.getElementById("mySpan");
            span.onclick = function() {
                modal.style.display = "none";
            }
        	var modal = document.getElementById("myModal");
        	modal.style.display = "none";
        	var redirectURL = document.settings["watt.server.smtp.oauth.redirectURL"].value;
        	if (event.origin !== redirectURL){
        		var currentURL = event.data;
        		containsCode = currentURL.includes("code=");
        		if(containsCode){
        			authCodeValue = document.createElement("input");
        			authCodeValue.setAttribute("type", "hidden");
        			authCodeValue.setAttribute("name", "authCodeValue");
        			authCodeValue.setAttribute("value", currentURL);
        			document.settings.appendChild(authCodeValue);

                    var authCodeParamURL = new URL(currentURL);
                    var authorizationCode = authCodeParamURL.searchParams.get("code");
                    document.settings["watt.server.smtp.oauth.authorizationCode"].value = authorizationCode;

        			modal.style.display = "block";
        			windowObjectReference.close();
        			return true;
                } else {
        	        return false;
                }
            }
        }
        //Event Listener
        window.addEventListener("message", receiveMessage, true);
        document.addEventListener("DOMContentLoaded", function() {
           var auth = document.settings["watt.server.smtp.authentication.type"].value;
           document.settings["watt.server.smtp.oauth.accessToken.expiryTime"].disabled = "disabled";
           respondToClientAuthChange(auth);
           document.settings["watt.server.smtp.oauth.authURL"].size=50;
           document.settings["watt.server.smtp.oauth.clientID"].size=40;
           document.settings["watt.server.smtp.oauth.clientSecret"].size=40;
           document.settings["watt.server.smtp.oauth.scope"].size=50;
           document.settings["watt.server.smtp.oauth.redirectURL"].size=50;
           document.settings["watt.server.smtp.oauth.accessTokenURL"].size=50;
           document.settings["watt.server.smtp.oauth.authorizationCode"].size=50;

           document.settings["watt.server.smtp.oauth.authURL"].addEventListener("change", oAuthParamsChangeEvent);
           document.settings["watt.server.smtp.oauth.clientID"].addEventListener("change", oAuthParamsChangeEvent);
           document.settings["watt.server.smtp.oauth.clientSecret"].addEventListener("change", oAuthParamsChangeEvent);
           document.settings["watt.server.smtp.oauth.scope"].addEventListener("change", oAuthParamsChangeEvent);
           document.settings["watt.server.smtp.oauth.redirectURL"].addEventListener("change", oAuthParamsChangeEvent);
           document.settings["watt.server.smtp.oauth.authorizationCode"].addEventListener("change", authorizationCodeChangedEvent);
        });
    </script>

    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">

        <title>Integration Server Settings</title>
        <STYLE>
        .modal {
          display: none;
          position: fixed;
          z-index: 1;
          left: 0;
          top: 0;
          width: 100%;
          height: 100%;
          overflow: auto;
          background-color: rgb(0,0,0);
          background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
          background-color: #fefefe;
          margin: 15% auto;
          padding: 20px;
          border: 1px solid #888;
          width: 80%;
        }

        .close {
          color: #aaa;
          float: right;
          font-size: 28px;
          font-weight: bold;
        }

        .close:hover,
        .close:focus {
          color: black;
          text-decoration: none;
          cursor: pointer;
        }
        </STYLE>
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <SCRIPT SRC="webMethods.js"></SCRIPT>
    </head>
    <body onLoad="setNavigation('settings-resources-edit.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditResourceSetScrn');">

        <table width="100%">

            <tr>
                <td class="breadcrumb" colspan="3">
                    Settings &gt; Resources &gt; Edit
                </td>
            </tr>

            <tr>
                <td colspan="3">
                    <ul class="listitems">
                        <li class="listitem">
						<script>
                            createForm("htmlform_settings_resources", "settings-resources.dsp", "POST", "BODY");
						</script>
						<script>getURL("settings-resources.dsp", "javascript:document.htmlform_settings_resources.submit();", "Return to Resource Settings");</script>
						</li>
                    </ul>
                </td>
            </tr>
         </table>

            %invoke wm.server.query:getResourceSettings%

                     <form name="settings" action="settings-resources.dsp" onsubmit="return validateSettingValues()" method="post">
                                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
                                <input type="hidden" name="action" value="change" />
						<input type="hidden" name="passwordChanged" value="false">
                                %loop -struct Resources%
                        <table class="tableView" width="50%">
                                    %comment% <!-- key == name of section --> %endcomment%
                                    %scope #$key%
                                        %ifvar $key equals('ServerMemory')%
                                        %else%
                                        <tr>
                                            <td class="heading" colspan="2">%value name encode(html)%</td>
                                        </tr>
                                        %endif%
                                        %comment%
                                            <!--                                              -->
                                            <!-- section is array of fields, of the structure -->
                                            <!--     key:   name                              -->
                                            <!--     value: record                            -->
                                            <!--         value                                -->
                                            <!--         resource                             -->
                                            <!--         description                          -->
                                            <!--         isrequired                           -->
                                            <!--         isodd                                -->
                                            <!--         calcvalue (calculated value)         -->
                                            <!--         calcdesc (calculated description)    -->
                                            <!--                                              -->
                                        %endcomment%

                                        %loop -struct fields%
                                            %scope #$key%
                                                %ifvar iseditable equals('true')%
                                                    <tr>
                                                        <td
                                                            %comment%

                                                                An embarrassing hack -- the first value in the Server Thread Pool is skipped, so
                                                                we start with even, not odd.

                                                             %endcomment%

                                                            %ifvar $key equals('ServerThreadPool')%
                                                                class="%ifvar isodd equals('true')%even%else%odd%endif%row"
                                                            %else%
                                                                class="%ifvar isodd equals('true')%odd%else%even%endif%row"
                                                            %endif%
                                                                nowrap width="50%" >
                                                            <label for="%value title encode(htmlattr)%">%value title encode(html)%</label>
                                                        </td>

                                                        <td class="%ifvar isodd equals('true')%odd%else%even%endif%row-l"
                                                                width="50%">
                                %ifvar $key equals('SamlUrl')%
								    <input type="text" id="%value title encode(htmlattr)%" name="%value resource encode(htmlattr)%" value="%value value encode(htmlattr)%" size=40>						    
                                %else%
							%ifvar $key equals('password')%
								    <input type="text" id="%value title encode(htmlattr)%" name="%value resource encode(htmlattr)%" value="*****" onChange="document.settings.passwordChanged.value=true;">						    
                                %else%
                                      %ifvar $key equals('UserAgent')%
									<input type="text" id="%value title encode(htmlattr)%" name="%value resource encode(htmlattr)%" value="%value value encode(htmlattr)%" size=40>
                                  %else%
                                     %ifvar $key equals('tlsSettings')%
                                        <select id="%value title encode(htmlattr)%" name="tlsSettings">
                                       <option %ifvar value equals('None')%selected %endif%value="None">None</option>
                                       <option %ifvar value equals('Explicit')%selected %endif%value="Explicit">Explicit</option>
                                       <option %ifvar value equals('Implicit')%selected %endif%value="Implicit">Implicit</option>
                                    </select>
                                    
                                     %else%
                                        %ifvar $key equals('trustStoreAlias')%
                                           <select id="%value title encode(htmlattr)%" name="trustStoreAlias" class="listbox">
                                          %invoke wm.server.security.keystore:listTrustStores%
                                             <option name="" value=""></option>
                                             %loop trustStores%
                                                %ifvar isLoaded equals('true')%
									   	       <option name="%value keyStoreName encode(htmlattr)%" value="%value keyStoreName encode(htmlattr)%" %ifvar ../value vequals(keyStoreName)%selected%endif%>%value keyStoreName encode(html)%</option>
                                                %endif%
                                             %endloop%
                                          %endinvoke%
                                       </select>
                                        %else%
                                            %ifvar value equals('true')%
											  <input type="radio" name="%value resource encode(htmlattr)%" id="%value resource encode(htmlattr)%1" value="true" checked><label for="%value resource encode(htmlattr)%1">Yes</label></input>
											  <input type="radio" name="%value resource encode(htmlattr)%" id="%value resource encode(htmlattr)%2" value="false"><label for="%value resource encode(htmlattr)%2">No</label></input>
                                            %else%
                                              %ifvar value equals('false')%
												<input type="radio" name="%value resource encode(htmlattr)%" id="%value resource encode(htmlattr)%1" value="true"><label for="%value resource encode(htmlattr)%1">Yes</label></input>
												<input type="radio" name="%value resource encode(htmlattr)%" id="%value resource encode(htmlattr)%2" value="false" checked><label for="%value resource encode(htmlattr)%2">No</label></input>
                                              %else%
                                                %ifvar $key equals('authType')%
                                                  <select id="%value resource encode(htmlattr)%" name="%value resource encode(htmlattr)%" onchange="respondToClientAuthChange(this.value);">
                                                    <option %ifvar value equals('Basic')%selected %endif%value="Basic">Basic Authentication</option>
                                                    <option %ifvar value equals('OAuth')%selected %endif%value="OAuth">OAuth</option>
                                                  </select>
                                                %else%
                                                    %ifvar $key equals('authorizationCode')%
                                                     <script>
                                                        writeEditPass("edit", "%value resource encode(html_javascript)%", "%value value encode(html_javascript)%");
                                                     </script>
                                                     <tr>
                                                       <td>
                                                        <div id="myModal" class="modal" style="display:none">
                                                       			<div class="modal-content">
                                                       			<span id="mySpan" class="close">&times;</span>
                                                       			<p>Received Auth Code</p>
                                                       			</div>
                                                       	   </div>
                                                       </td>
                                                       <td><a id="testlink_OAuth" href="javascript:windowOpen('true')">Get Authorization Code</a></td>
                                                     </tr>
                                                     %else%
                                                       %ifvar $key equals('clientSecret')%
                                                       <script>
                                                         writeEditPass("edit",
                                                            "%value resource encode(html_javascript)%",
                                                            "%value value encode(html_javascript)%");
                                                       </script>
                                                          %else%
                                                            <script>
                                                              writeEdit("edit",
                                                                  "%value resource encode(html_javascript)%",
                                                                  "%value value encode(html_javascript)%");
                                                            </script>
                                                          %endif%
                                                      %endif%
                                                  %endif%
                                                %endif%
                                            %endif%
                                        %endif%
                                      %endif%
                                   %endif%
                                %endif%
								%endif%
							    %value description encode(html)%

                                                        </td>
                            
                            
                            %ifvar requiresRestart equals('true')%
                                <td class="%ifvar isodd equals('true')%odd%else%even%endif%row-l" width="50%">*</td>
                            %endif%

                                                    %else%
                                                        %comment% edit mode and NOT editable  %endcomment%
                                                    %endif%
                                                </tr>
                                            %endscope%
                                        %endloop%     <!-- end of field -->
                                    %endscope%
                                %endloop%             <!-- end of section -->

                                <!-- Comment out this portion from the UI. May want to add it later. -->

                                <tr>
                                    <td class="space" colspan="2">* Server restart is required for settings to take effect.</td>
                                </tr>

                                <tr>
                                    <td colspan="2" class="action">
                                        <input type="submit"
                                               name="submit"
                                               value="Save Changes"/>
                                    </td>
                                </tr>
        </table>
                            </form>
            %endinvoke%
    </body>
</html>
