package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Base64;
import io.fusionauth.jwt.JWTUtils;
import io.fusionauth.jwt.Signer;
import io.fusionauth.jwt.domain.JWT;
import io.fusionauth.jwt.rsa.RSASigner;
// --- <<IS-END-IMPORTS>> ---

public final class jwt

{
	// ---( internal utility methods )---

	final static jwt _instance = new jwt();

	static jwt _newInstance() { return new jwt(); }

	static jwt _cast(Object o) { return (jwt)o; }

	// ---( server methods )---




	public static final void jwtEncode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(jwtEncode)>> ---
		// @sigtype java 3.5
		// [i] record:0:required jwtEncodeInput
		// [i] - field:0:required keyId
		// [i] - field:0:required issuer
		// [i] - field:0:required subject
		// [i] - field:0:required audience
		// [i] - field:0:required durationInSecond
		// [i] - field:0:required privateKey
		// [o] record:0:required jwtEncodeOutput
		// [o] - field:0:required jwtHeader
		// [o] - field:0:required jwtPayload
		// [o] - field:0:required encodedJWT
		IDataCursor pipelineCursor = pipeline.getCursor();
				
		IData input = IDataUtil.getIData(pipelineCursor, "jwtEncodeInput");
		IDataCursor inputCursor = input.getCursor();
		
		String keyId = IDataUtil.getString(inputCursor, "keyId");
		String issuer = IDataUtil.getString(inputCursor, "issuer");
		String subject = IDataUtil.getString(inputCursor, "subject");
		String audience = IDataUtil.getString(inputCursor, "audience");
		String durationInSecond = IDataUtil.getString(inputCursor, "durationInSecond");
		String privateKey = IDataUtil.getString(inputCursor, "privateKey");
		
		// If the input private key is with "\n" then replace with newline
		privateKey = privateKey.replaceAll("\\\\n", "\n");
		
		Signer signer = RSASigner.newSHA256Signer(privateKey);
		
		// Build a new JWT
		JWT jwt = new JWT();
				
		jwt.setIssuer(issuer)
				.setSubject(subject)
				.setAudience(audience)
				.setIssuedAt(ZonedDateTime.now(ZoneOffset.UTC))
				.setExpiration(ZonedDateTime.now(ZoneOffset.UTC).plusSeconds(Long.valueOf(durationInSecond)));
		
		// Sign and encode the JWT to a JSON string representation
		String encodedJWT = JWT.getEncoder().encode(jwt, signer, h -> h.set("kid", keyId));
		String jwtHeader = JWTUtils.decodeHeader(encodedJWT).toString();
		String jwtPayload = JWTUtils.decodePayload(encodedJWT).toString();
		
		IData outputData = IDataFactory.create();
		IDataCursor outputDataCursor = outputData.getCursor();
		IDataUtil.put(outputDataCursor, "jwtHeader", jwtHeader);
		IDataUtil.put(outputDataCursor, "jwtPayload", jwtPayload);
		IDataUtil.put(outputDataCursor, "encodedJWT", encodedJWT);
		
		IDataUtil.put(pipelineCursor,"jwtEncodeOutput",outputData);
		
		pipelineCursor.destroy();
		
				
		// --- <<IS-END>> ---

                
	}
}

