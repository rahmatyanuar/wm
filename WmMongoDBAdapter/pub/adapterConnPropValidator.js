function mongoDBAdapterConnPropValidator(theForm)
{
	var databaseField = theForm.elements['.CPROP.mongoDatabaseName'];
	if((databaseField != "undefined") && (databaseField.value.length == 0))
	{
		return "'Database Name' cannot be empty";
	}
	var authScheme = theForm.elements['.CPROP.authScheme'];
	if((authScheme != "undefined") && (authScheme.value != "None"))
	{
		var authDBField = theForm.elements['.CPROP.authenticationDatabase'];
		if((authScheme.value == "Default") && (authDBField != "undefined") && (authDBField.value.length == 0))
		{
			return "'Authentication Database' cannot be empty";
		}
		var userName = theForm.elements['.CPROP.mongoUserName'];
		if((userName != "undefined") && (userName.value.length == 0))
		{
			return "'User' cannot be empty";
		}
	}
	var serverSelectionTimeout = theForm.elements['.CPROP.serverSelectionTimeout'];
	if((serverSelectionTimeout != "undefined") && isNaN(serverSelectionTimeout.value))
	{
		return "'Server Selection Timeout' should be number";
	}
	var timeout = theForm.elements['.CPROP.timeout'];
	if((timeout != "undefined") && isNaN(timeout.value))
	{
		return "'Socket Connection Timeout' should be number";
	}
	var socketReadTimeOut = theForm.elements['.CPROP.socketReadTimeOut'];
	if((socketReadTimeOut != "undefined") && isNaN(socketReadTimeOut.value))
	{
		return "'Socket Read Timeout' should be number";
	}
	
	var compressors = theForm.elements['.CPROP.compressors'];
	if((compressors != "undefined") && (compressors.value.length > 0))
	{
		var compressionSet = ["snappy", "zlib", "zstd"];
		var tokens = compressors.value.split(",");
		for (var i = 0; i < tokens.length; i++)
		{
			var isTokenFound = false;
			var val = tokens[i];
			for (var j = 0; j < compressionSet.length; j++)
			{
				if(val == compressionSet[j])
				{
					isTokenFound = true;
					break;
				}
			}
			if(!isTokenFound)
			{
				return "'Compression Set' value is not valid";
			}
		}
	}
}
adapterConnPropValidator = mongoDBAdapterConnPropValidator;