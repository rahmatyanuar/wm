package WxPreUpgradeAnalyzer.excel.pub;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellReference;
// --- <<IS-END-IMPORTS>> ---

public final class data

{
	// ---( internal utility methods )---

	final static data _instance = new data();

	static data _newInstance() { return new data(); }

	static data _cast(Object o) { return (data)o; }

	// ---( server methods )---




	public static final void dataCellToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataCellToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required col
		// [i] field:0:required row
		// [i] field:0:optional datePattern {"yyyyDDdd","yyyyMMddHHmmss","dd.MM.yyyy","dd.MM.yyyy HH:mm:ss","dd.MM.yyyy HH:mm:ss.sss"}
		// [o] object:0:required MSSheet
		// [o] field:0:required Value
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	col = Integer.parseInt(IDataUtil.getString( pipelineCursor, "col" ));
		int	row = Integer.parseInt(IDataUtil.getString( pipelineCursor, "row" ));
		String datePattern = IDataUtil.getString(pipelineCursor, "datePattern" );
		pipelineCursor.destroy();
		// pipeline
		
		if(datePattern==null) datePattern = "dd.MM.yyyy HH:mm:ss";
		Sheet sheet = (Sheet) MSSheet; 
		String value = getCellValueAsString(sheet.getRow(row).getCell(col),datePattern);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "Value", value );
		pipelineCursor_1.destroy();
		// pipeline
			
		// --- <<IS-END>> ---

                
	}



	public static final void dataCellsToDocumentList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataCellsToDocumentList)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:optional firstRowAsHeader {"true","false"}
		// [i] field:0:optional colStart
		// [i] field:0:optional rowStart
		// [i] field:0:optional colEnd
		// [i] field:0:optional rowEnd
		// [i] field:0:optional datePattern {"yyyyDDdd","yyyyMMddHHmmss","dd.MM.yyyy","dd.MM.yyyy HH:mm:ss","dd.MM.yyyy HH:mm:ss.sss"}
		// [o] object:0:required MSSheet
		// [o] record:1:required DocumentList
		// [o] field:0:required colStart
		// [o] field:0:required rowStart
		// [o] field:0:required colEnd
		// [o] field:0:required rowEnd
		//pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	colStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colStart" ),-1);
		int	rowStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowStart"),-1 );
		int	colEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colEnd"),-1 );
		int	rowEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowEnd"),-1 );
		Boolean	firstRowAsHeader = IDataUtil.getBoolean( pipelineCursor, "firstRowAsHeader" , true);
		String datePattern = IDataUtil.getString(pipelineCursor, "datePattern" );
		pipelineCursor.destroy();
		// pipeline 
		
		Sheet sheet = (Sheet) MSSheet; 
		
		if(rowStart == -1) rowStart = sheet.getFirstRowNum(); 
		if(rowEnd == -1) rowEnd = sheet.getLastRowNum(); 
		if(colStart == -1) colStart = sheet.getRow(rowStart).getFirstCellNum(); 
		if(colEnd == -1) colEnd = sheet.getRow(rowEnd).getLastCellNum()-1; 
		if(datePattern==null) datePattern = "dd.MM.yyyy HH:mm:ss";
		int row = rowStart;
		int col = colStart;
		int s = 0;
		int z = 0;
		
		String tmp = "";
		Cell cell = null;
		IData[] DocumentList = null;
		IDataCursor cursor = null;
		String[] header = new String[colEnd-colStart+1];
		
		//Header erzeugen
		col = colStart;
		z = 0;
		if(firstRowAsHeader){
			//Header aus der ersten Zeile auslesen
			
			for (;col <= colEnd;col++) {
				//Header auslesen
				cell = sheet.getRow(rowStart).getCell(col);
				
				if (cell == null){
					header[z]="Field".concat(Integer.toString(z));
				} else {
					//Dublettencheck bei den Spaltennamen
					tmp = getCellValueAsString(cell,datePattern);
					Boolean vCheck = true;
					int mSuffix = 0;
					
					while (vCheck == true){
						mSuffix++;
						vCheck = false;
						for (int i=0;i<z;i++){
							if (header[i].equals(tmp)){
								tmp = tmp.concat("_"+Integer.toString(mSuffix));
								vCheck = true;
							}  
						}
					}
					
					header[z] = tmp;
				}
				z++;
			}
			
			//Datenbereich bestimmen
			DocumentList = new IData[rowEnd-rowStart];
			row = rowStart + 1;
		} else {
			//Header selbst definieren
			for (;col <= colEnd;col++) {
				header[z]="Field".concat(Integer.toString(z));
				z++;
			}
			
			//Datenbereich bestimmen
			DocumentList = new IData[rowEnd-rowStart+1];
			row = rowStart;
		}
			
		
		//Daten einlesen
		z=0;
		for (;row <= rowEnd;row++) {
			col = colStart;
			DocumentList[z] = IDataFactory.create();
			cursor = DocumentList[z].getCursor();
			s=0;
			
		    for (;col <= colEnd;col++) { 
		        //Werte lesen (Wenn Zeile und Zelle nicht leer, dann f\u00FCge den Wert hinzu... 
				if (sheet.getRow(row) != null && sheet.getRow(row).getCell(col) != null){ 
					IDataUtil.put(cursor, header[s].toString(), getCellValueAsString(sheet.getRow(row).getCell(col),datePattern));
				} else {
					// ... oder lasse die Zelle leer. 
					IDataUtil.put(cursor, header[s].toString(), "");
				}
		        s++;
		    }
		    z++;
		    if(cursor != null) cursor.destroy();
		}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "DocumentList", DocumentList );
		IDataUtil.put( pipelineCursor_1, "colStart", Integer.toString(colStart ));
		IDataUtil.put( pipelineCursor_1, "rowStart", Integer.toString(rowStart ));
		IDataUtil.put( pipelineCursor_1, "colEnd", Integer.toString(colEnd ));
		IDataUtil.put( pipelineCursor_1, "rowEnd", Integer.toString(rowEnd ));
		pipelineCursor_1.destroy();
		// pipeline
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		// --- <<IS-END>> ---

                
	}



	public static final void dataDocumentListToCells (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataDocumentListToCells)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] record:1:required DocumentList
		// [i] field:0:optional writeHeader {"true","false"}
		// [i] field:0:optional colStart
		// [i] field:0:optional rowStart
		// [i] object:0:optional MSStyle_Header
		// [i] object:0:optional MSStyle_Data
		// [i] object:0:optional MSStyle_Data_Alternate
		// [o] object:0:required MSSheet
		// [o] record:1:required DocumentList
		// [o] field:0:required colStart
		// [o] field:0:required rowStart
		// [o] field:0:required colEnd
		// [o] field:0:required rowEnd
		 
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		IData[]	DocumentList = IDataUtil.getIDataArray( pipelineCursor, "DocumentList" );
		int	colStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colStart" ),0);
		int	rowStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowStart" ),0);
		Boolean	writeHeader = IDataUtil.getBoolean( pipelineCursor, "writeHeader", true);
		Object	MSStyle_Header = IDataUtil.get( pipelineCursor, "MSStyle_Header" );
		Object	MSStyle_Data = IDataUtil.get( pipelineCursor, "MSStyle_Data" );
		Object	MSStyle_Data_Alternate = IDataUtil.get( pipelineCursor, "MSStyle_Data_Alternate" );
		pipelineCursor.destroy();
		// pipeline		
				
		Sheet sheet = (Sheet) MSSheet;
		
		CellStyle localStyle_Header = null;
		CellStyle localStyle_Data = null;
		CellStyle localStyle_Data_Alternate = null;
		
		
		if(MSStyle_Header != null){
			CellStyle style_Header = (CellStyle)MSStyle_Header;
			localStyle_Header = sheet.getWorkbook().createCellStyle();
			localStyle_Header.cloneStyleFrom(style_Header);
			}
		if(MSStyle_Data != null) {
			CellStyle style_Data = (CellStyle)MSStyle_Data;
			localStyle_Data = sheet.getWorkbook().createCellStyle();
			localStyle_Data.cloneStyleFrom(style_Data);
		}
		if(MSStyle_Data_Alternate != null) {
			CellStyle style_Data_Alternate = (CellStyle)MSStyle_Data_Alternate;
			localStyle_Data_Alternate = sheet.getWorkbook().createCellStyle();
			localStyle_Data_Alternate.cloneStyleFrom(style_Data_Alternate);
		}
		
		Cell cell;
		Row Zeile;
		
		int i = 0;
		int row = rowStart;
		int col = colStart;
		
		String	tmp = "";
		
		if ( DocumentList != null)
		{
			for (i = 0; i < DocumentList.length; i++ )
			{
				IDataCursor docCursor = DocumentList[i].getCursor();
				Zeile = getValidRow(sheet,row);
				col = colStart;				
				
				//Header schreiben?
				if(writeHeader && (row == rowStart))
				{
					while (docCursor.next())
					{
						tmp = docCursor.getKey();
						cell = Zeile.createCell(col);
						cell.setCellValue(tmp);
						if(localStyle_Header != null) cell.setCellStyle(localStyle_Header);
						col++;
					}
					row++;
					col = colStart;
					Zeile = getValidRow(sheet,row);
					docCursor = DocumentList[i].getCursor();
				}
		
				
						//Daten schreiben
						while (docCursor.next())
						{					
							tmp = docCursor.getValue().toString();
							cell = Zeile.createCell(col);
							cell.setCellValue(tmp);
							if(localStyle_Data!=null){
								if (i%2 == 0 || localStyle_Data_Alternate == null) 
							    { // gerade
									cell.setCellStyle(localStyle_Data);
							    } else 
							    { // ungerade
							    	cell.setCellStyle(localStyle_Data_Alternate);
							    }
							}
							col++;
						} 
						docCursor.destroy();
						row++;
					}
				}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "colStart", Integer.toString(colStart));
		IDataUtil.put( pipelineCursor_1, "rowStart", Integer.toString(rowStart));
		IDataUtil.put( pipelineCursor_1, "colEnd", Integer.toString(col ));
		IDataUtil.put( pipelineCursor_1, "rowEnd", Integer.toString(row ));
		IDataUtil.put( pipelineCursor_1, "DocumentList", DocumentList );
		pipelineCursor_1.destroy();
		// pipeline
		// --- <<IS-END>> ---

                
	}



	public static final void dataFormulaBuilder (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataFormulaBuilder)>> ---
		// @sigtype java 3.5
		// [i] field:0:required Operation {"SUM","AVERAGE","MIN","MAX","ABS"}
		// [i] field:0:required colStart
		// [i] field:0:required rowStart
		// [i] field:0:optional colEnd
		// [i] field:0:optional rowEnd
		// [o] field:0:required Formula
		// [o] field:0:required refStart
		// [o] field:0:required refEnd
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String operation = IDataUtil.getString( pipelineCursor, "Operation" );
		int	colStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colStart" ),0);
		int	rowStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowStart" ),0);
		int	colEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colEnd" ),colStart);
		int	rowEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowEnd" ),rowStart);
		pipelineCursor.destroy();
		// pipeline
		
		String formulaOut = operation+"(";
		
		CellReference cellRefStart = new CellReference(rowStart, colStart);
		CellReference cellRefEnd = new CellReference(rowEnd, colEnd);
		
		formulaOut=formulaOut+cellRefStart.formatAsString()+":"+cellRefEnd.formatAsString()+")";
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "refStart", cellRefStart.formatAsString() );
		IDataUtil.put( pipelineCursor_1, "refEnd", cellRefEnd.formatAsString() );
		IDataUtil.put( pipelineCursor_1, "Formula", formulaOut);
		pipelineCursor_1.destroy();
		// pipeline			
		// --- <<IS-END>> ---

                
	}



	public static final void dataFormulaToCell (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataFormulaToCell)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required col
		// [i] field:0:required row
		// [i] field:0:required Formula
		// [i] object:0:optional MSStyle
		// [o] object:0:required MSSheet
		// [o] field:0:required col
		// [o] field:0:required row
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	col = getIntegerFromString(IDataUtil.getString( pipelineCursor, "col" ),0);
		int row = getIntegerFromString(IDataUtil.getString( pipelineCursor, "row" ),0);
		String	Formula = IDataUtil.getString( pipelineCursor, "Formula" );
		Object	MSStyle = IDataUtil.get( pipelineCursor, "MSStyle" );
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;	
		CellStyle style = (CellStyle) MSStyle;
		Row MSrow = getValidRow(sheet,row);
		
		Cell cell = MSrow.createCell(col);
		cell.setCellFormula(Formula);
		
		//Style der Cell zuweisen
		if(style != null)cell.setCellStyle(style);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "col", Integer.toString(col) );
		IDataUtil.put( pipelineCursor_1, "row", Integer.toString(row) );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void dataStringToCell (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dataStringToCell)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required col
		// [i] field:0:required row
		// [i] field:0:required Value
		// [i] object:0:optional MSStyle
		// [o] object:0:required MSSheet
		// [o] field:0:required col
		// [o] field:0:required row
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	col = getIntegerFromString(IDataUtil.getString( pipelineCursor, "col" ),0);
		int	row = getIntegerFromString(IDataUtil.getString( pipelineCursor, "row" ),0);
		String	Value = IDataUtil.getString( pipelineCursor, "Value" );
		Object	MSStyle = IDataUtil.get( pipelineCursor, "MSStyle" );
		pipelineCursor.destroy();
		// pipeline	
			
		Sheet sheet = (Sheet) MSSheet;	
		CellStyle style = (CellStyle) MSStyle;
		Row MSrow = getValidRow(sheet,row);
		Cell cell = MSrow.createCell(col);
		cell.setCellValue(Value);
		
		//Style der Cell zuweisen
		if(style != null){
			CellStyle tmpStyle = sheet.getWorkbook().createCellStyle();
			tmpStyle.cloneStyleFrom(style);
			
			cell.setCellStyle(tmpStyle);
		}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "col", col );
		IDataUtil.put( pipelineCursor_1, "row", row );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static int getIntegerFromString(String value, int defaultValue){
		int i = defaultValue;
		
		try {
			i = Integer.parseInt(value);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			
		}
		
		return i;
	}
	public static String getCellValueAsString (Cell cell, String pattern)
	{
		String value = "";
		Date date = null;
		
	
	
		switch (cell.getCellType()) {
	        case Cell.CELL_TYPE_STRING:
	        	value = cell.getRichStringCellValue().getString();
	            break;
	        case Cell.CELL_TYPE_NUMERIC:
	            if (DateUtil.isCellDateFormatted(cell)) {
	            	date = cell.getDateCellValue();
					DateFormat formatter = new SimpleDateFormat(pattern);
					value = formatter.format(date);
	            } else {
	            	DataFormatter df = new DataFormatter();
	            	df.getDefaultFormat(cell);
	            	value = df.formatCellValue(cell).toString();
	            	
	            	//value = Double.toString(cell.getNumericCellValue());
	            }
	            break;
	        case Cell.CELL_TYPE_BOOLEAN:
	        	value = Boolean.toString(cell.getBooleanCellValue());
	            break;
		    case Cell.CELL_TYPE_FORMULA:
		    	
		    try {
				FormulaEvaluator evaluator = cell.getSheet().getWorkbook().getCreationHelper().createFormulaEvaluator();
				DataFormatter df = new DataFormatter();
				value = df.formatCellValue(cell, evaluator).toString();
			} catch (Exception e) {
				try {
					if (DateUtil.isCellDateFormatted(cell)) {
							date = cell.getDateCellValue();
							DateFormat formatter = new SimpleDateFormat(pattern);
							value = formatter.format(date);
					}
				} catch (Exception e1) {
	
				} 
			
			}
	
			    break;
	        
	        default:
	        	value = "";
		}
		
		return value;
	}
	
	public static org.apache.poi.ss.usermodel.Row getValidRow(Sheet mSheet, int mRow){
		Row mZeile;		
		mZeile = mSheet.getRow(mRow);
		
		try {
			Cell cell = mZeile.getCell(0);
		} catch (Exception e) {
			mZeile = mSheet.createRow(mRow);
		}
	
		return mZeile;
	}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	// --- <<IS-END-SHARED>> ---
}

