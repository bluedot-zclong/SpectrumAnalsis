package bluedot.spectrum.commons.index.parser;


import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import bluedot.spectrum.commons.index.database.TableAndColumns;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @Author : Harold
 * @Description 作为文件解析器的实现类之一，主要用于xml文件的解析
 * 	xml文件主要有表名和字段名的信息
 * @Date : 2018/1/31 16:31
 */
public class XmlParser implements FileParser {

	
    public List<TableAndColumns> getTableAndColumDateFromFile(String fileName) {
         
    	
    	List<TableAndColumns> tableAndColumnDates = paxserXmlFile(fileName);

        return tableAndColumnDates;
    }

    /**
     * 解析xml文件
     * @param fileName 传入文件路径
     * @return 返回文件解析结果的封装Bean，List<TableAndColumnDate>
     */
    private List<TableAndColumns> paxserXmlFile(String fileName){
        File directory = new File("");//设定为当前文件夹
        
        //解析结果的封装Bean
        List<TableAndColumns> tableAndColumnDates = new ArrayList<TableAndColumns>();

        SAXReader reader = new SAXReader();
        
        Document document = null;

        try {
        	InputStream ifile = new FileInputStream(fileName);

        	InputStreamReader ir = new InputStreamReader(ifile,"UTF-8");

            document = reader.read(ir);
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        //获取文件的根节点
        Element rootElement = document.getRootElement();
        
        //定义一个Element用于遍历
        Element fooElement;
        
        //创建一个用于保存遍历结结果的对象
        TableAndColumns table = null;
        
        //遍历所有名叫“table”的节点
        for(Iterator i = rootElement.elementIterator("table"); i.hasNext();){
        	//对table进行初始化
        	table = new TableAndColumns();
        	
        	//获取结点
        	fooElement=(Element)i.next();
        	
        	//将表名封装到table中
        	table.setTableName(fooElement.elementText("table-name"));
        	
        	//将表名封装到table中
        	table.setId(fooElement.elementText("id"));
        	
        	//遍历所有名叫“column-name”的节点
            for (Iterator it = fooElement.elements("column-name").iterator(); it.hasNext();) {
                Element elm = (Element) it.next(); 
                table.getColumns().add(elm.getText().toString());
            }
            
            //将table封装到List集合中
            tableAndColumnDates.add(table);
            
            table = null;
        }
        return tableAndColumnDates;
    }

}
