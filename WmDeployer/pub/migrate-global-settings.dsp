<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<SCRIPT src="js/webMethods.js"></SCRIPT>
<LINK href="css/webMethods.css" type="text/css" rel="stylesheet">
<BODY>
<TABLE width="100%">
%invoke wm.deployer.gui.UIUpgrade:migrateDeployerGlobalSettings%
		%include error-handler.dsp%
	%onerror%
		%loop -struct%
			<tr><td>%value $key%=%value%</td></tr>
		%endloop%
%end invoke%
</TABLE>
</BODY>
</HTML>