# SpectrumAnalsis
江西农业大学2015届蓝点工作室光谱分析系统第二版本

第一版本地址：
https://gitee.com/zclong/spectrum3.git


## 项目背景与开发目的
-  现如今，使用光谱分析仪器已慢慢的走进我们的生活，光谱分析给人们的生活、科学的研究带来了很多便利。而随着我们的生活水平质量越来越好，人们对我们身边的饮食健康越来越重视，经过市场调研后，我们发现市场上很少有农药便携快速检测产品，且市场需要该产品为普通用户、实验员、检测局等进行光谱的分析及实验和数据统计。我们通过光谱检测仪器结合我们开发的光谱分析平台来检测水果、蔬菜等物质中农药的各种元素的含量，系统根据仪器检测出的含量进行统计分析并且返回含量及是否超标信息给用户，极大的便利用户的使用，并且可以用于实验室、检测局等进行物质含量的检测，是否合格，统计数据。而市场上有许许多多的光谱扫描仪器，分析这些由不同的仪器扫描所产生的各种类型的光谱文件，又需要有各种各样的分析算法。这就导致了人们分析光谱时，需要找到与光谱相对于的算法。而一旦使用的仪器变多了，为不同的仪器光谱去寻找适合的算法便会变得相当麻烦。而该系统不仅提供一个农药检测光谱分析平台，而且能够对不同的硬件和各类的分析算法等做一个调配，方便人们对光谱分析的操作。


## 项目整体框架

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/173721_9e2f77a3_1222466.png "spectrum.png")


## 项目整体结构

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/173910_a0167490_1222466.png "屏幕截图.png")


## 项目模块划分

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/174026_cfb34237_1222466.png "屏幕截图.png")


## 业务流程

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/174140_004b6c25_1222466.png "屏幕截图.png")


## 技术选型
### 服务端
- 自实现SpringMVC架构，Spring的IOC容器，自动获取封装前台表单数据，自动解析视图，控制层、业务层、持久层通过ioc注入，实现各层之间的解耦
- 采用JDBC自封装ORM框架，实现java对象到数据库表的映射
- 权限过滤器实现细粒度的系统身体认证和权限验证 
- Echarts绘制光谱 
- Lucene全文检索
- 使用freemakeer模板引擎，提高系统响应速度，使视图层和控制层分离，实现动态页面页面静态化，防止sql注入攻击
- 自实现缓存框架，缓存热点数据与常计算数据，缓存采用FIFO、LRU算法进行缓存策略，防止大量数据出现一次刷新掉热点数据，并大大降低数据库的压力 
- 数据库连接池: Druid 1.0.x
- 日志管理: slf4j + log4j12
- 测试框架: junit4 / testng
- 前端框架: Bootstrap + Jquery

--------------------

## 项目导入
> 准备环境
- JDK7+
- Tomcat8+
- Maven3.2+
- Eclipse4.5+ / IntelliJ IDEA / MyEclipse10+
- MySQL5.5+

--------------------

- 导入项目前

1.用SVN/Git客户端检出项目
```
Git: https://github.com/bluedot-zclong/SpectrumAnalsis.git
```

2.导入eclipse/IDEA/myeclipse,选中项目右键选择Maven->Update Project...

- 运行 :     

1.选择 spectrum-web -> Run As -> Run On Server...或

2.开启Tomcat，输入网址 http://localhost:8080/spectrum-web
--------------------

- 项目展示

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/174909_d4adcb37_1222466.png "屏幕截图.png")

![输入图片说明](https://images.gitee.com/uploads/images/2018/0802/175713_2f8f3ae6_1222466.png "spectrum.png")


