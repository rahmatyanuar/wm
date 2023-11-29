package WxPreUpgradeAnalyzer.excel.pub;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
// --- <<IS-END-IMPORTS>> ---

public final class styles

{
	// ---( internal utility methods )---

	final static styles _instance = new styles();

	static styles _newInstance() { return new styles(); }

	static styles _cast(Object o) { return (styles)o; }

	// ---( server methods )---




	public static final void styleApplyToCells (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(styleApplyToCells)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] object:0:required MSStyle
		// [i] field:0:required colStart
		// [i] field:0:required rowStart
		// [i] field:0:optional colEnd
		// [i] field:0:optional rowEnd
		// [o] object:0:required MSSheet
		// [o] object:0:required MSStyle
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		Object	MSStyle = IDataUtil.get( pipelineCursor, "MSStyle" );
		int	colStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colStart" ),0);
		int	rowStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowStart" ),0);
		int	colEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colEnd" ),colStart);
		int	rowEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "rowEnd" ),rowStart);
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;
		CellStyle style = (CellStyle)MSStyle;
		CellStyle tmpStyle = sheet.getWorkbook().createCellStyle();
		tmpStyle.cloneStyleFrom(style);
		
		Cell cell = null;
		
		for (int r = rowStart;r <= rowEnd; r++ ){
			for (int c = colStart; c <= colEnd; c++){
				cell = getValidRow(sheet, r).getCell(c);
				cell.setCellStyle(tmpStyle);
			}
		}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.put( pipelineCursor_1, "MSStyle", style );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void styleFromCell (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(styleFromCell)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required col
		// [i] field:0:required row
		// [o] object:0:required MSStyle
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	col = getIntegerFromString(IDataUtil.getString( pipelineCursor, "col" ),0);
		int	row = getIntegerFromString(IDataUtil.getString( pipelineCursor, "row" ),0);
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;
		Cell cell = sheet.getRow(row).getCell(col);
		CellStyle style = sheet.getWorkbook().createCellStyle();
		style.cloneStyleFrom(cell.getCellStyle());
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSStyle", style );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void styleFromSetting (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(styleFromSetting)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSWorkbook
		// [i] record:0:optional border
		// [i] - field:0:optional top {"none","thin","medium","thick"}
		// [i] - field:0:optional bottom {"none","thin","medium","thick"}
		// [i] - field:0:optional left {"none","thin","medium","thick"}
		// [i] - field:0:optional right {"none","thin","medium","thick"}
		// [i] record:0:optional font
		// [i] - field:0:optional bold {"true","false"}
		// [i] - field:0:optional underlined {"none","single","double"}
		// [i] - field:0:optional italic {"true","false"}
		// [i] - field:0:optional align {"left","right","center"}
		// [i] - field:0:optional size {"8","10","12","14","16"}
		// [i] record:0:optional color
		// [i] - field:0:optional foreground {"WHITE","BLACK","GREY_25_PERCENT","GREY_40_PERCENT","GREY_50_PERCENT","GREY_80_PERCENT","LIGHT_BLUE","LIGHT_CORNFLOWER_BLUE","LIGHT_GREEN","LIGHT_ORANGE","LIGHT_TURQUOISE","LIGHT_YELLOW"}
		// [o] object:0:required MSWorkbook
		// [o] object:0:required MSStyle
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSWorkbook = IDataUtil.get( pipelineCursor, "MSWorkbook" );
		// pipeline
		
		Workbook wb = (Workbook)MSWorkbook;
		CellStyle style = wb.createCellStyle();
		org.apache.poi.ss.usermodel.Font font = wb.createFont();
		
		// font begin
		IData	fontDoc = IDataUtil.getIData( pipelineCursor, "font" );
		if ( fontDoc != null)
		{
			IDataCursor fontCursor = fontDoc.getCursor();
			Boolean	bold = IDataUtil.getBoolean( fontCursor, "bold" ,false);
			String	underlined = IDataUtil.getString( fontCursor, "underlined" );
			Boolean	italic = IDataUtil.getBoolean( fontCursor, "italic",false );
			String	align = IDataUtil.getString( fontCursor, "align" );
			String	size = IDataUtil.getString( fontCursor, "size" );
			
			
			if (bold) font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			if (underlined.equals("single")) font.setUnderline(HSSFFont.U_SINGLE);
			if (underlined.equals("double")) font.setUnderline(HSSFFont.U_DOUBLE);
			if (italic) font.setItalic(true);
			if (align.equals("left"))style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			if (align.equals("right"))style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			if (align.equals("center"))style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			if (size!=null)font.setFontHeightInPoints(Short.parseShort(size));
			
			fontCursor.destroy();
			style.setFont(font);
		}
		// font end
		
		
		// border begin
		IData	border = IDataUtil.getIData( pipelineCursor, "border" );
		if ( border != null)
		{
			IDataCursor borderCursor = border.getCursor();
			String	top = IDataUtil.getString( borderCursor, "top" );
			String	bottom = IDataUtil.getString( borderCursor, "bottom" );
			String	left = IDataUtil.getString( borderCursor, "left" );
			String	right = IDataUtil.getString( borderCursor, "right" );
			borderCursor.destroy();
			
			if (top!=null){
				if (top.equals("thin")) {
					style.setBorderTop(CellStyle.BORDER_THIN);
				    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
				} else if (top.equals("medium")){
					style.setBorderTop(CellStyle.BORDER_MEDIUM);
				    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
				} else if (top.equals("thick")){
					style.setBorderTop(CellStyle.BORDER_THICK);
				    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
				}
			}
			
			if (bottom!=null){
				if (bottom.equals("thin")) {
					style.setBorderBottom(CellStyle.BORDER_THIN);
				    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				} else if (bottom.equals("medium")){
					style.setBorderBottom(CellStyle.BORDER_MEDIUM);
				    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				} else if (bottom.equals("thick")){
					style.setBorderBottom(CellStyle.BORDER_THICK);
				    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				}
			}
			
			if (left!=null){
				if (left.equals("thin")) {
					style.setBorderLeft(CellStyle.BORDER_THIN);
				    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				} else if (left.equals("medium")){
					style.setBorderLeft(CellStyle.BORDER_MEDIUM);
				    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				} else if (left.equals("thick")){
					style.setBorderLeft(CellStyle.BORDER_THICK);
				    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				}
			}
			
			if (right!=null){
				if (right.equals("thin")) {
					style.setBorderRight(CellStyle.BORDER_THIN);
				    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
				} else if (right.equals("medium")){
					style.setBorderRight(CellStyle.BORDER_MEDIUM);
				    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
				} else if (right.equals("thick")){
					style.setBorderRight(CellStyle.BORDER_THICK);
				    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
				}
			}
		}
		// border end
		
		// color begin
		IData	color = IDataUtil.getIData( pipelineCursor, "color" );
		if ( color != null)
		{
			IDataCursor colorCursor = color.getCursor();
				String	foreground = IDataUtil.getString( colorCursor, "foreground" );
			colorCursor.destroy();
			
			if(foreground!=null){
				if(foreground.equals("WHITE")){
					style.setFillForegroundColor(HSSFColor.WHITE.index);
				} else if (foreground.equals("BLACK")){
					style.setFillForegroundColor(HSSFColor.BLACK.index);
				} else if (foreground.equals("GREY_25_PERCENT")){
					style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
				} else if (foreground.equals("GREY_40_PERCENT")){
					style.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
				} else if (foreground.equals("GREY_50_PERCENT")){
					style.setFillForegroundColor(HSSFColor.GREY_50_PERCENT.index);
				} else if (foreground.equals("GREY_80_PERCENT")){
					style.setFillForegroundColor(HSSFColor.GREY_80_PERCENT.index);
				} else if (foreground.equals("LIGHT_BLUE")){
					style.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
				}  else if (foreground.equals("LIGHT_CORNFLOWER_BLUE")){
					style.setFillForegroundColor(HSSFColor.LIGHT_CORNFLOWER_BLUE.index);
				} else if (foreground.equals("LIGHT_GREEN")){
					style.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
				} else if (foreground.equals("LIGHT_ORANGE")){
					style.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
				} else if (foreground.equals("LIGHT_TURQUOISE")){
					style.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
				} else if (foreground.equals("LIGHT_YELLOW")){
					style.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
				} 
				
			    style.setFillPattern(style.SOLID_FOREGROUND);
			}
		}
		// color end
		pipelineCursor.destroy();
		
		//to be continued...
		
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSWorkbook", wb );
		IDataUtil.put( pipelineCursor_1, "MSStyle", style );
		pipelineCursor.destroy();
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
	
	public static org.apache.poi.ss.usermodel.Row getValidRow(Sheet mSheet, int mRow){
		Row mZeile;		
		
		//System.out.println("req:"+mRow+" last:"+mSheet.getLastRowNum());
		
		if( mRow <= mSheet.getLastRowNum() )
		{
			mZeile = mSheet.getRow(mRow);
		}
		else	
		{
			mZeile = mSheet.createRow(mRow);	
		}
	
		return mZeile;
	}
	// --- <<IS-END-SHARED>> ---
}

