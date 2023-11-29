 %invoke wm.server.query:getCurrentSession%
 %invoke wm.server.query:getCurrentUser%
 %invoke apigateway.ui:loadWebAppDetails%
  
  
<html>

<body>
<form id="gateway" method="POST" action="%value protocol%://%value host%:%value port%/%value context%/%value relativePath%">
  <input type="hidden" name="ssnid" value="%value currentSessionID%"><br>
  <input type="hidden" name="username" value="%value username%"><br><br>
</form>

<script>

    document.getElementById("gateway").submit();

</script>
</body>
</html>

