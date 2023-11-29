/*
 * Mappings.java
 *
 * Copyright 2004 webMethods, Inc.
 * ALL RIGHTS RESERVED
 *
 * UNPUBLISHED -- Rights reserved under the copyright laws of the United States.
 * Use of a copyright notice is precautionary only and does not imply
 * publication or disclosure.
 *
 * THIS SOURCE CODE IS THE CONFIDENTIAL AND PROPRIETARY INFORMATION OF
 * WEBMETHODS, INC.  ANY REPRODUCTION, MODIFICATION, DISTRIBUTION,
 * OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY PROHIBITED
 * WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF WEBMETHODS, INC.
 */
package sample.sap.idoc;

//--- <<IS-START-IMPORTS>> ---
import com.sap.conn.idoc.*;
import com.wm.adapter.sap.SAPAdapter;
import com.wm.adapter.sap.resources.WmSAPExceptionBundle;
import com.wm.adapter.sap.resources.WmSAPResourceBundle;
import com.wm.adapter.sap.util.Error;
import com.wm.adapter.sap.util.LogMsg;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;
//--- <<IS-END-IMPORTS>> ---

public final class Mappings
{
	// ---( internal utility methods )---
	static final Mappings _instance	= new Mappings();
	static Mappings _newInstance()	{ return new Mappings();}
	static Mappings _cast( Object o){ return (Mappings)o;	}
	// ---( server methods )---

	public static final void orders( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(orders)>> ---
		// @sigtype java 3.5
		// @specification pub.sap.transport.ALE:aleRoutingInfo

	   /*
			Mapping algorithm:

			Sender:     If (E1EDKA1/PARVW) == "AG"
						   then sender = E1EDKA1/PARTN

			Receiver:   If (E1EDKA1/PARVW) == "LF"
						   then receiver = E1EDKA1/PARTN

			MsgType:    EDI_DC/MESTYP

			Set fields: EDI_DC/SNDPRN = sender
						EDI_DC/SNDPRT = "KU"
		*/
		IDataCursor idc = pipeline.getCursor();
		String msgType = IDataUtil.getString( idc, "msgType");
		if( msgType == null)
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_ARGUMENT_MISSING, "\"msgType\"");
			throw new ServiceException( exMsg);
		}
		if( !msgType.equals( "ORDERS"))
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_IDOC_NOT_OF_TYPE, "'ORDERS'");
			throw new ServiceException( exMsg);
		}
		IDocDocumentList idocList = (IDocDocumentList)IDataUtil.get( idc, "iDocList");
		int numIDocs = idocList.getNumDocuments();
		if( numIDocs > 0)
		{
			IDocDocument idoc = idocList.first();
			IDocSegment rootSegment = idoc.getRootSegment();
			try
			{
				IDocSegment segment = rootSegment.getFirstChild( "E1EDKA1", "PARVW", "AG");
				if( segment != null)
				{
					String sender = segment.getString( "PARTN");
					if( sender.length() > 0)
					{
						idoc.setSenderPartnerNumber( sender);
						idoc.setSenderPartnerType( "KU");
						IDataUtil.put( idc, "sender", sender);
					}
				}
				segment = rootSegment.getFirstChild( "E1EDKA1", "PARVW", "LF");
				if( segment != null)
				{
					String receiver = segment.getString( "PARTN");
					if( receiver.length() > 0)
						IDataUtil.put( idc, "receiver", receiver);
				}
				idc.destroy();
				for( int i = 1; i < numIDocs; i++)
				{
					idoc = idocList.get( i);
					rootSegment = idoc.getRootSegment();
					segment = rootSegment.getFirstChild( "E1EDKA1", "PARVW", "AG");
					if( segment != null)
					{
						String sender = segment.getString( "PARTN");
						if( sender != null && sender.length() > 0)
						{
							idoc.setSenderPartnerNumber( sender);
							idoc.setSenderPartnerType( "KU");
						}
					}
				}
			}
			catch (IDocFieldNotFoundException e)
			{
				idc.destroy();
				throw Error.createAdapterServiceException( LogMsg.SAP_ADMIN, WmSAPExceptionBundle.IDOCS_FIELD_NOT_FOUND,
															e.getFieldName(), e.getRecord().getRecordMetaData().getName());
			}
			catch (IDocException e)
			{
				idc.destroy();
				throw Error.createAdapterServiceException( LogMsg.SAP_ADMIN, WmSAPExceptionBundle.IDOCS_GENERAL_ERROR,
															e.getMessage());
			}
		}
		// --- <<B2B-END>> ---
	}

	public static final void ordrsp( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(ordrsp)>> ---
		// @sigtype java 3.5
		// @specification pub.sap.transport.ALE:aleMappingInfo

		/*
			Mapping algorithm:

			Sender:    If (E1EDKA1/PARVW) == "AG"
						   then sender = E1EDKA1/LIFNR

			Receiver:  Not modified.
			MsgType:   Not modified.

			Set fields: EDI_DC/SNDPRN = sender
						EDI_DC/SNDPRT = "LI"
		*/
		IDataCursor idc = pipeline.getCursor();
		String msgType = IDataUtil.getString( idc, "msgType");
		if( msgType == null)
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_ARGUMENT_MISSING, "\"msgType\"");
			throw new ServiceException( exMsg);
		}
		if( !msgType.equals( "ORDRSP"))
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_IDOC_NOT_OF_TYPE, "'ORDERSP'");
			throw new ServiceException( exMsg);
		}
		IDocDocumentList idocList = (IDocDocumentList) IDataUtil.get( idc, "iDocList");
		int numIDocs = idocList.getNumDocuments();
		for( int i = 0; i < numIDocs; i++)
		{
			IDocDocument idoc = idocList.get(i);
			IDocSegment rootSegment = idoc.getRootSegment();
			try
			{
				IDocSegment segment = rootSegment.getFirstChild( "E1EDKA1", "PARVW", "AG");
				if( segment != null)
				{
					String sender = segment.getString( "LIFNR");
					if( sender.length() > 0)
					{
						idoc.setSenderPartnerNumber( sender);
						idoc.setSenderPartnerType( "LI");
					}
				}
			}
			catch (IDocFieldNotFoundException e)
			{
				idc.destroy();
				throw Error.createAdapterServiceException( LogMsg.SAP_ADMIN, WmSAPExceptionBundle.IDOCS_FIELD_NOT_FOUND,
														e.getFieldName(), e.getRecord().getRecordMetaData().getName());
			}
			catch (IDocException e)
			{
				idc.destroy();
				throw Error.createAdapterServiceException( LogMsg.SAP_ADMIN, WmSAPExceptionBundle.IDOCS_GENERAL_ERROR,
														e.getMessage());
			}
		}
		// --- <<B2B-END>> ---
	}
}