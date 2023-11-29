<HTML>
  <HEAD>

    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <script src="webMethods.js"></script>

    <script language ="javascript">  

      /**
       *
       */
      function loadDocument() {
        setNavigation('settings-streaming.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Messaging_StreamingCreateAliasScrn');
		toggleSSL();
      }

      /**
       * Validation logic
       */
       function validateForm(obj) {

              if (isEmpty(obj.name.value)) {
                alert("Connection Alias Name must be specified.");
                return false;
              }

              if (isEmpty(obj.description.value)) {
                alert("Description must be specified.");
                return false;
              }

              if (isEmpty(obj.package.value)) {
                alert("Package must be specified.");
                return false;
              }

             if (isEmpty(obj.host.value)) {
                alert("Host must be specified.");
                return false;
              }

      		if (!isNum(obj.timeout.value)) {
                alert("Connection Timeout must be a positive integer or 0.");
                return false;
              }

      		if (!isNum(obj.keepAlive.value)) {
                alert("Connection Keep Alive must be a positive integer or 0.");
                return false;
              }

              if (isEmpty(obj.clientId.value)) {
                  alert("Connection Client ID must be specified.");
                  return false;
              }else {
                  var str = obj.clientId.value;
                  var result = /^([A-Za-z][_A-Za-z0-9$]*)$/.test(str);
                  if (!result) {
                      alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
                      return false;
                  }
              }

      		if (((obj.user.value!="")&& (obj.password.value=="")) || ((obj.user.value=="")&& (obj.password.value!="")) ) {

              alert("Both username and password must be specified.");
              return false;
          }


              if (obj.will_enabled.checked) {
                if (obj.will_qos.value == -1) {
                  alert("Last-Will QoS must be specified.");
                  return false;
                }

                if (isEmpty(obj.will_topic.value)) {
                  alert("Last-Will Topic must be specified.");
                  return false;
                }
              }

			var ssl = obj.useSSL.value;
			var host = obj.host.value.toLowerCase();

            if(host.startsWith('ssl://') && ssl == 'No'){
            	alert("Use SSL must be Yes if host uri starts with ssl://.");
            	return false;
            }

			if (ssl == 'Yes') {
				if(!host.startsWith("ssl://")){
					alert("Host URI must start with ssl:// if Use SSL is Yes");
					return false;
				}


				var ks = obj.keystoreAlias.value;
				var ts = obj.truststoreAlias.value;
				if (ts == "") {
					alert(" Truststore alias is mandatory if Use SSL is Yes.");
					return false;
				}
			}

              return true;
            }

			// To show and hide rows depending on useSSL radio button
			function toggleSSL() {
				var ssl = document.getElementsByName('useSSL');
				for(var i=0, length=ssl.length; i<length; i++){
					if(ssl[i].checked){
						if(ssl[i].value == 'No'){
							document.getElementById('sslTSRow').style.display = 'none';
							document.getElementById('sslKSRow').style.display = 'none'
							document.getElementById('sslKeyRow').style.display = 'none';
						}else{
							document.getElementById('sslTSRow').style.display = '';
							document.getElementById('sslKSRow').style.display = ''
							document.getElementById('sslKeyRow').style.display = '';
						}
					}
				}
			}

			//certificate based
			var hiddenOptions = new Array();
			var hiddenOptionsTs = new Array();

			function loadKeyStoresOptions()
			{
			    var ks = document.createform.keystoreAlias.options
				var ts = document.createform.truststoreAlias.options
	      		%invoke wm.server.security.keystore:listKeyStoresAndConfiguredKeyAliases%
	      			   ks[ks.length] = new Option("","");
				       hiddenOptions[ks.length-1] = new Array();

			       	   %loop keyStoresAndConfiguredKeyAliases%
			       			ks.length=ks.length+1;
				       		ks[ks.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
			    	   		%loop keyAliases%
			       				aliases[%value $index%] = new Option("%value%","%value%");
			       			%endloop%
			       			if (aliases.length == 0)
			       			{
								aliases[0] = new Option("","");
							}
				       		hiddenOptions[ks.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%

				//list trust store aliases
				%invoke wm.server.security.keystore:listTrustStores%
	      			   ts[ts.length] = new Option("","");
				       hiddenOptionsTs[ts.length-1] = new Array();
			       	   %loop trustStores%
			       			ts.length=ts.length+1;
				       		ts[ts.length-1] = new Option("%value encode(javascript) keyStoreName%","%value encode(javascript) keyStoreName%");
			           		var aliases = new Array();
				       		hiddenOptionsTs[ts.length-1] = aliases;
		       	   %endloop%
			    %endinvoke%

			    var keyOpts = document.createform.keystoreAlias.options;
    			var key = "%value encode(javascript) keystoreAlias%";
				if ( key != "")
				{
	       			for(var i=0; i<keyOpts.length; i++)
	       			{
				    	if(key == keyOpts[i].value) {
				    		keyOpts[i].selected = true;
		    			}
			      	}
				}

				changeval();

				var aliasOpts = document.createform.keystoreKeyAlias.options;
    			var alias = '%value encode(javascript) keystoreKeyAlias%';
				if ( alias != "")
				{
	       			for(var i=0; i<aliasOpts.length; i++)
	       			{
				    	if(alias == aliasOpts[i].value) {
				    		aliasOpts[i].selected = true;
		    			}
			      	}
				}
	      }

			function changeval() {
				var ks = document.createform.keystoreAlias.options;
				var selectedKS = document.createform.keystoreAlias.value;

				for(var i=0; i<ks.length; i++) {
					if(selectedKS == ks[i].value) {
						var aliases = hiddenOptions[i];
						document.createform.keystoreKeyAlias.options.length = aliases.length;
						for(var j=0;j<aliases.length;j++) {
							var opt = aliases[j];
							document.createform.keystoreKeyAlias.options[j] = new Option(opt.text, opt.value); 
						}
					}
				}
			}
			
			
/**
 * onChange to 'Create Connection Using' was made
 */ 
function displaySettings(object) {
	
	if (object.options[object.selectedIndex].value == "Kafka") {
	  document.getElementById("host").value = "http://localhost:9092";
	}else if (object.options[object.selectedIndex].value == "Mock") {
	  document.getElementById("host").value = "file:///c:/WINDOWS/foo.bar";
	}else {
	  document.getElementById("host").value = "";
	}
}
			

    </script>
  </head>

  <body onLoad="loadDocument(); loadKeyStoresOptions();">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Streaming Settings &gt; Streaming Connection Alias &gt; Create</td>
    </tr>
    <tr>
      <td colspan="2">
        <ul class="listitems">
		      <script>createForm("htmlform_settings_streaming", "streaming.dsp", "POST", "BODY");</script>
          <li class="listitem"><script>getURL("streaming.dsp","javascript:document.htmlform_settings_streaming.submit();","Return to Streaming Settings")</script></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><form name='createform' action="streaming.dsp" method="post" autocomplete="off">
        %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
        <table class="tableView" width="100%">

          <!--                  -->
          <!-- General Settings -->
          <!--                  -->	  
          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr> 

          <!-- Connection Alias Name -->
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="name">Connection Alias Name</label></td>
            <td class="oddrow-l"><INPUT NAME="name" ID="name" size="50"></td>
          </tr>
		  
	      <!-- Description -->
          <tr>
            <script>writeTD("row-l");</script><label for="description">Description</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="description" ID="description"size="50"></td>
          </tr>
		  
		  <!-- Provider Type --> 
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="type">Provider Type</label></td>
            %invoke wm.server.streaming:getAvailableProviders%
            <script>writeTD("row-l");</script>
			  <select name="type" ID="type" onchange="displaySettings(this.form.type)">
			    <option value="empty"></option>
                %loop availableProviders%
                    <option value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                %endloop%
              </select></td>
			%onerror%
			  <td>
			    No provider implementations loaded in the classpath:<br>%value errorMessage encode(html)%
			  </td>
            %endinvoke%
          </tr>

          <!-- Package -->
          <tr>
            <script>writeTD("row-l");</script><label for="package">Package</label></td>
            %invoke wm.server.packages:packageList%
            <script>writeTD("row-l");</script><select name="package" ID="package">
                %loop packages%
                  %ifvar enabled equals('true')%
                    %ifvar ../package -notempty%
                      <option %ifvar ../package vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %else%
                      <option %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                    %endif%
                  %endif%
                %endloop%
                </select></td>
                %endinvoke%
          </tr>

          <!--                              -->
          <!-- Connection Protocol Settings -->
          <!--                              -->
          <tr>
            <td class="heading" colspan=2>Connection Protocol Settings</td>
          </tr>

          <!-- Host -->
          <tr>
            <script>writeTD("row-l");</script><label for="host">URI</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="host" ID="host"size="50" value=""></td>
          </tr>

          <!-- Connection Client ID -->
          <tr>
            <script>writeTD("row-l");</script><label for="clientId">Client Prefix</label></td>
            %invoke wm.server.streaming:generateClientId%
              <script>writeTD("row-l");</script><INPUT NAME="clientId" ID="clientId" size="50" value="%value generatedClientId%"></td>
            %endinvoke%
          </tr>
		  
		  <!-- Other Properties -->
		  <tr>
            <td class="evenrow-l"><label for="other_properties">Additional Configuration Parameters</label></td> 
			<td class="oddrow-l">One (name=value) entry per line<br>
              <textarea wrap="off" rows="5" name="other_properties" id="other_properties" cols="50"></textarea>
            </td>
          </tr>
         
          <!--                        -->
          <!-- Security Settings      -->
          <!--                        -->
          <tr>
            <td class="heading" colspan=2>Security Settings</td>
          </tr>

          <!-- User Name -->
          <tr>
            <script>writeTD("row-l");</script><label for="user">User Name</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="user" ID="user" autocomplete="off" size="50"></td>
          </tr>

          <!-- Password -->
          <tr>
            <td></script><label for="password">Password</label></td>
            <td></script><input    name="password" ID="password" autocomplete="off" size="50"/></td>
          </tr>

		  <!-- useSSL radio button -->
		  <tr>
            <script>writeTD("row-l");</script><label for="useSSL">Use SSL</label></td>
            <script>writeTD("row-l");</script><label><INPUT TYPE="radio" name="useSSL" value="No" onChange="toggleSSL()" checked/>No</label><label><INPUT TYPE="radio" name="useSSL" value="Yes" onChange="toggleSSL()" />Yes</label></td>
          </tr>

		  <!-- Truststore Alias -->
		  <tr id="sslTSRow">
			<script>writeTD("row-l");</script><label for="truststoreAlias" id="truststoreAliasLabel">Truststore Alias</label></td>
			<script>writeTD("row-l");</script><SELECT  name="truststoreAlias" id="truststoreAlias" style="width: 270px;"></SELECT></td>
		  </tr>

		  <!-- Keystore Alias -->
		  <tr id="sslKSRow">
		    <script>writeTD("row-l");</script><label for="keystoreAlias" id="keystoreAliasLabel">Keystore Alias</label></td>
			<script>writeTD("row-l");</script><SELECT name="keystoreAlias" id="keystoreAlias"  onchange="changeval()" style="width: 270px;"></SELECT></td>
		  </tr>

		  <!-- Key Alias : will be populated when Keystore Alias is selected -->
		  <tr id="sslKeyRow">
			<script>writeTD("row-l");</script><label for="keystoreKeyAlias" id="keystoreKeyAliasLabel">Key Alias</label></td>
			<script>writeTD("row-l");</script><select name="keystoreKeyAlias" id="keystoreKeyAlias" style="width: 270px;"></select></td>
		  </tr>

        </table>
               
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="action" type="hidden" value="create">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">
              </td>
            </tr>
        </table>

       </form>

      </td>
    </tr>
  </table>
</body>
</html>
