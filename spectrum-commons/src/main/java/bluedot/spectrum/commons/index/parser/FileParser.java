package bluedot.spectrum.commons.index.parser;



import java.io.File;
import java.util.List;

import bluedot.spectrum.commons.index.database.TableAndColumns;


/**
 * @Author : Harold
 * @Description 公开的文件解析器接口
 * @Date : 2018/1/31 16:29
 */
public interface FileParser {
    /**
     *
     * @param fileName 传入文件名
     * @return 返回需要的表名和列名
     */
    List<TableAndColumns> getTableAndColumDateFromFile(String fileName);
}
