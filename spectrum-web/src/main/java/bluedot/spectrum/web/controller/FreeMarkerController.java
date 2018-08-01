package bluedot.spectrum.web.controller;



import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;


/**
 * @Author: WFP
 * @Time: 2018/1/15
 * @decription:
 */
@Controller
@RequestMapping("/freemarker")
public class FreeMarkerController {
    @RequestMapping("/test")
    public ModelAndView testFreeMarrker(HttpServletRequest req, HttpServletResponse resp){
        //传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        //传给模板的list数据
        List<String> authors = Arrays.asList(new String[]{"James","Killer","King"});
        //传给模板的map数据
        Map<String, Object> viewLogs = new HashMap<String, Object>();
        viewLogs.put("ROOT", "2012-12-31 23:43:11");
        viewLogs.put("LOG_VIEWER", "2012-12-31 23:43:11");
        viewLogs.put("DATA_MANAGER", "2012-12-31 23:43:11");

        //添加到model中
        model.put("viewLogs", viewLogs);
        model.put("authors", authors);
        model.put("user", "wfp");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addAllObjects(model);
        modelAndView.setViewName("/freemarkerTest");
        return modelAndView;
    }
}
