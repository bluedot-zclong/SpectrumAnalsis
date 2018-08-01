/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : spectrumanalysis

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2018-04-21 10:10:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for algorithm
-- ----------------------------
DROP TABLE IF EXISTS `algorithm`;
CREATE TABLE `algorithm` (
  `algorithm_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增，算法的主键',
  `algorithm_version` int(16) NOT NULL COMMENT '算法编号16位 （20170101XXXXXXXX）后面为uuid,防止重复',
  `algorithm_name` varchar(10) NOT NULL COMMENT '用户上传时所命名（可修改）',
  `algorithm_sort` tinyint(1) NOT NULL COMMENT '算法类别,0代表预处理算法、1代表分析算法',
  `algorithm_uploadtime` datetime NOT NULL COMMENT '算法上传时间',
  `algorithm_dscription` varchar(512) DEFAULT NULL COMMENT '上传时对算法的描述（可修改)',
  `algorithm_language` varchar(8) NOT NULL COMMENT '算法语言类型',
  `algorithm_real_path` varchar(225) NOT NULL COMMENT '算法本地文件路径',
  `dir_file_id` bigint(20) unsigned NOT NULL COMMENT '文件夹id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态，0代表未删除，1代表在回收站，2代表彻底删除',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`algorithm_id`),
  KEY `fk_algorithm_dir_file` (`dir_file_id`),
  CONSTRAINT `fk_algorithm_dir_file` FOREIGN KEY (`dir_file_id`) REFERENCES `dir` (`dir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='算法信息表';

-- ----------------------------
-- Records of algorithm
-- ----------------------------
INSERT INTO `algorithm` VALUES ('1', '101', '预处理算法测试一号', '0', '2018-04-17 09:19:39', 'Test', 'java', '、sdfsdf', '3', '0', '2018-04-17 09:21:27', '2018-04-17 09:21:27');
INSERT INTO `algorithm` VALUES ('2', '212', '分析算法测试一号', '1', '2018-04-18 09:20:26', 'teste', 'java', 'dfsdfsd', '3', '0', '2018-04-17 09:20:42', '2018-04-17 09:20:49');

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `apply_id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '申请编号',
  `apply_object_id` int(10) DEFAULT NULL COMMENT '对应的申请对象的id',
  `apply_type` tinyint(1) DEFAULT NULL COMMENT '申请类型,0代表角色申请,1代表解冻申请,2代表光谱申请,3代表检验线申请，4代表操作人员的光谱申请',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '申请人',
  `apply_file_url` varchar(255) DEFAULT NULL COMMENT '申请文件',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  `apply_status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '审核状态,0代表拒绝，1代表通过，2代表待审核，3代表操作人员申请光谱的待审核状态',
  `check_time` timestamp DEFAULT '1970-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '审核时间',
  `apply_content` varchar(255) DEFAULT NULL COMMENT '申请账号解封理由',
  `apply_reason` varchar(255) DEFAULT NULL COMMENT '审核批注',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`apply_id`),
  KEY `fk_apply_user_id` (`user_id`),
  CONSTRAINT `fk_apply_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请表(所有申请表)';

-- ----------------------------
-- Records of apply
-- ----------------------------

-- ----------------------------
-- Table structure for connection_algorithm
-- ----------------------------
DROP TABLE IF EXISTS `connection_algorithm`;
CREATE TABLE `connection_algorithm` (
  `connection_algorithm_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '组合线id，主键',
  `connection_algorithm_version` int(16) unsigned NOT NULL COMMENT '检验线组合编号（20170101XXXXXXXX）后面为uuid,防止重复',
  `hardware_id` bigint(20) unsigned NOT NULL COMMENT '硬件ID(在硬件类型表和光谱类型表合并后放光谱类型名字)',
  `connection_algorithm_name` varchar(16) NOT NULL COMMENT '检验线名称',
  `analysis_algorithm_id` bigint(20) unsigned NOT NULL COMMENT '分析算法ID(算法id外键)',
  `pretreatment_algorithm_id` bigint(20) unsigned NOT NULL COMMENT '预处理算法ID(算法id外键)',
  `standard_name` varchar(8) NOT NULL COMMENT '国际标准，如国标',
  `connection_algorithm_state` tinyint(1) NOT NULL COMMENT '检验线组合状态，0代表未开、1代表公开、2代表审核中、3代表已删除',
  `connection_algorithm_describe` varchar(512) DEFAULT NULL COMMENT '组合线描述',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户id',
  `connection_algorithm_save_time` datetime NOT NULL,
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`connection_algorithm_id`),
  KEY `fk_connection_algorithm_hardware_id` (`hardware_id`),
  KEY `fk_connection_algorithm_analysis_algorithm_id` (`analysis_algorithm_id`),
  KEY `fk_connection_algorithm_pretreatment_algorithm_id` (`pretreatment_algorithm_id`),
  KEY `fk_connection_algorithm_pretreatment_algorithm_user_id` (`user_id`),
  CONSTRAINT `fk_connection_algorithm_analysis_algorithm_id` FOREIGN KEY (`analysis_algorithm_id`) REFERENCES `algorithm` (`algorithm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_connection_algorithm_hardware_id` FOREIGN KEY (`hardware_id`) REFERENCES `hardware` (`hardware_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_connection_algorithm_pretreatment_algorithm_id` FOREIGN KEY (`pretreatment_algorithm_id`) REFERENCES `algorithm` (`algorithm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_connection_algorithm_pretreatment_algorithm_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测线表';

-- ----------------------------
-- Records of connection_algorithm
-- ----------------------------

-- ----------------------------
-- Table structure for connection_algorithm_detected_object
-- ----------------------------
DROP TABLE IF EXISTS `connection_algorithm_detected_object`;
CREATE TABLE `connection_algorithm_detected_object` (
  `cado_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection_algorithm_id` bigint(20) unsigned NOT NULL COMMENT '检验线组合id,做外键',
  `detected_objects_id` bigint(20) unsigned NOT NULL COMMENT '被检测物id',
  PRIMARY KEY (`cado_id`),
  KEY `fk_connection_algorithm_id` (`connection_algorithm_id`),
  KEY `fk_detected_objects_id` (`detected_objects_id`),
  CONSTRAINT `fk_connection_algorithm_id` FOREIGN KEY (`connection_algorithm_id`) REFERENCES `connection_algorithm` (`connection_algorithm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detected_objects_id` FOREIGN KEY (`detected_objects_id`) REFERENCES `detected_object` (`detected_objects_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测线-被检测物表';

-- ----------------------------
-- Records of connection_algorithm_detected_object
-- ----------------------------

-- ----------------------------
-- Table structure for connection_algorithm_detection_material
-- ----------------------------
DROP TABLE IF EXISTS `connection_algorithm_detection_material`;
CREATE TABLE `connection_algorithm_detection_material` (
  `cadm_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cado_id` bigint(20) unsigned NOT NULL COMMENT '检验线-被检测物id做外键',
  `detection_material_name` varchar(50) NOT NULL COMMENT '检测内容名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`cadm_id`),
  KEY `fk_cado_id` (`cado_id`),
  CONSTRAINT `fk_cado_id` FOREIGN KEY (`cado_id`) REFERENCES `connection_algorithm_detected_object` (`cado_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检验线-检测内容表';

-- ----------------------------
-- Records of connection_algorithm_detection_material
-- ----------------------------

-- ----------------------------
-- Table structure for detected_category
-- ----------------------------
DROP TABLE IF EXISTS `detected_category`;
CREATE TABLE `detected_category` (
  `detected_type_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '被检测物分类编号',
  `first_classification` varchar(32) DEFAULT NULL COMMENT '被检测物的一级分类',
  `secondary_classification_id` int(8) DEFAULT NULL COMMENT '二级分类的类别编号',
  `secondary_classification` varchar(32) DEFAULT NULL COMMENT '二级分类名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`detected_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3204 DEFAULT CHARSET=utf8 COMMENT='被检测物分类表';

-- ----------------------------
-- Records of detected_category
-- ----------------------------
INSERT INTO `detected_category` VALUES ('101', '小麦粉', '1', '粮食加工品', '2018-04-15 19:21:49', '2018-04-15 19:21:49');
INSERT INTO `detected_category` VALUES ('102', '大米', '1', '粮食加工品', '2018-04-15 19:32:07', '2018-04-15 19:32:07');
INSERT INTO `detected_category` VALUES ('103', '挂面', '1', '粮食加工品', '2018-04-15 19:32:08', '2018-04-15 19:32:08');
INSERT INTO `detected_category` VALUES ('104', '其他粮食加工品', '1', '粮食加工品', '2018-04-15 19:32:11', '2018-04-15 19:32:11');
INSERT INTO `detected_category` VALUES ('201', '食用植物油', '2', '食用油,油脂及其制品', '2018-04-15 19:32:03', '2018-04-15 19:32:03');
INSERT INTO `detected_category` VALUES ('202', '食用油脂制品', '2', '食用油,油脂及其制品', '2018-04-15 19:32:01', '2018-04-15 19:32:01');
INSERT INTO `detected_category` VALUES ('203', '食用动物油脂', '2', '食用油,油脂及其制品', '2018-04-15 19:31:59', '2018-04-15 19:31:59');
INSERT INTO `detected_category` VALUES ('301', '酱油', '3', '调味品', '2018-04-15 19:31:55', '2018-04-15 19:31:55');
INSERT INTO `detected_category` VALUES ('302', '食醋', '3', '调味品', '2018-04-15 19:31:50', '2018-04-15 19:31:50');
INSERT INTO `detected_category` VALUES ('303', '味精', '3', '调味品', '2018-04-15 19:31:48', '2018-04-15 19:31:48');
INSERT INTO `detected_category` VALUES ('304', '酱类', '3', '调味品', '2018-04-15 19:31:46', '2018-04-15 19:31:46');
INSERT INTO `detected_category` VALUES ('305', '调味料', '3', '调味品', '2018-04-15 19:31:45', '2018-04-15 19:31:45');
INSERT INTO `detected_category` VALUES ('401', '热加工熟肉制品', '4', '肉制品', '2018-04-15 19:31:42', '2018-04-15 19:31:42');
INSERT INTO `detected_category` VALUES ('402', '发酵肉制品', '4', '肉制品', '2018-04-15 19:31:35', '2018-04-15 19:31:35');
INSERT INTO `detected_category` VALUES ('403', '预制调理肉制品', '4', '肉制品', '2018-04-15 19:31:32', '2018-04-15 19:31:32');
INSERT INTO `detected_category` VALUES ('404', '腌腊肉制品', '4', '肉制品', '2018-04-15 19:31:30', '2018-04-15 19:31:30');
INSERT INTO `detected_category` VALUES ('501', '液体乳', '5', '乳制品', '2018-04-15 19:31:14', '2018-04-15 19:31:14');
INSERT INTO `detected_category` VALUES ('502', '乳粉', '5', '乳制品', '2018-04-15 19:31:12', '2018-04-15 19:31:12');
INSERT INTO `detected_category` VALUES ('503', '其他乳制品', '5', '乳制品', '2018-04-15 19:31:09', '2018-04-15 19:31:09');
INSERT INTO `detected_category` VALUES ('601', '瓶(桶)装饮用水', '6', '饮料', '2018-04-15 19:31:06', '2018-04-15 19:31:06');
INSERT INTO `detected_category` VALUES ('602', '碳酸饮料(汽水)', '6', '饮料', '2018-04-15 19:30:59', '2018-04-15 19:30:59');
INSERT INTO `detected_category` VALUES ('603', '茶(类)饮料', '6', '饮料', '2018-04-15 19:30:54', '2018-04-15 19:30:54');
INSERT INTO `detected_category` VALUES ('604', '果蔬汁类及其饮料', '6', '饮料', '2018-04-15 19:30:51', '2018-04-15 19:30:51');
INSERT INTO `detected_category` VALUES ('605', '蛋白饮料', '6', '饮料', '2018-04-15 19:30:39', '2018-04-15 19:30:39');
INSERT INTO `detected_category` VALUES ('606', '固体饮料', '6', '饮料', '2018-04-15 19:30:37', '2018-04-15 19:30:37');
INSERT INTO `detected_category` VALUES ('607', '其他饮料', '6', '饮料', '2018-04-15 19:30:35', '2018-04-15 19:30:35');
INSERT INTO `detected_category` VALUES ('701', '方便面', '7', '方便食品', '2018-04-15 19:30:24', '2018-04-15 19:30:24');
INSERT INTO `detected_category` VALUES ('702', '其他方便食品', '7', '方便食品', '2018-04-15 19:30:22', '2018-04-15 19:30:22');
INSERT INTO `detected_category` VALUES ('703', '调味面制品', '7', '方便食品', '2018-04-15 19:30:20', '2018-04-15 19:30:20');
INSERT INTO `detected_category` VALUES ('801', '饼干', '8', '饼干类', '2018-04-15 19:30:04', '2018-04-15 19:30:04');
INSERT INTO `detected_category` VALUES ('901', '畜禽水产罐头', '9', '罐头', '2018-04-15 19:29:57', '2018-04-15 19:29:57');
INSERT INTO `detected_category` VALUES ('902', '果蔬罐头', '9', '罐头', '2018-04-15 19:29:48', '2018-04-15 19:29:48');
INSERT INTO `detected_category` VALUES ('903', '其他罐头', '9', '罐头', '2018-04-15 19:29:15', '2018-04-15 19:29:15');
INSERT INTO `detected_category` VALUES ('1001', '冷冻饮品', '10', '冷冻饮品类', '2018-04-15 19:29:20', '2018-04-15 19:29:20');
INSERT INTO `detected_category` VALUES ('1101', '速冻面米食品', '11', '速冻食品', '2018-04-15 19:29:08', '2018-04-15 19:29:08');
INSERT INTO `detected_category` VALUES ('1102', '速冻调制食品', '11', '速冻食品', '2018-04-15 19:28:58', '2018-04-15 19:28:58');
INSERT INTO `detected_category` VALUES ('1103', '速冻肉制品', '11', '速冻食品', '2018-04-15 19:28:57', '2018-04-15 19:28:57');
INSERT INTO `detected_category` VALUES ('1104', '速冻果蔬制品', '11', '速冻食品', '2018-04-15 19:28:56', '2018-04-15 19:28:56');
INSERT INTO `detected_category` VALUES ('1105', '速冻水产品', '11', '速冻食品', '2018-04-15 19:28:55', '2018-04-15 19:28:55');
INSERT INTO `detected_category` VALUES ('1106', '速冻其他食品', '11', '速冻食品', '2018-04-15 19:28:54', '2018-04-15 19:28:54');
INSERT INTO `detected_category` VALUES ('1201', '膨化食品', '12', '薯类和膨化食品', '2018-04-15 19:28:47', '2018-04-15 19:28:47');
INSERT INTO `detected_category` VALUES ('1202', '薯类食品', '12', '薯类和膨化食品', '2018-04-15 19:28:45', '2018-04-15 19:28:45');
INSERT INTO `detected_category` VALUES ('1301', '糖果', '13', '糖果制品(含巧克力及制品)', '2018-04-15 19:28:40', '2018-04-15 19:28:40');
INSERT INTO `detected_category` VALUES ('1302', '巧克力及巧克力制品', '13', '糖果制品(含巧克力及制品)', '2018-04-15 19:28:39', '2018-04-15 19:28:39');
INSERT INTO `detected_category` VALUES ('1303', '代可可脂巧克力及代可可脂巧克力制品', '13', '糖果制品(含巧克力及制品)', '2018-04-15 19:28:38', '2018-04-15 19:28:38');
INSERT INTO `detected_category` VALUES ('1304', '果冻', '13', '糖果制品(含巧克力及制品)', '2018-04-15 19:28:37', '2018-04-15 19:28:37');
INSERT INTO `detected_category` VALUES ('1401', '茶叶', '14', '茶叶及相关制品', '2018-04-15 19:28:29', '2018-04-15 19:28:29');
INSERT INTO `detected_category` VALUES ('1402', '边销茶', '14', '茶叶及相关制品', '2018-04-15 19:28:27', '2018-04-15 19:28:27');
INSERT INTO `detected_category` VALUES ('1403', '茶制品', '14', '茶叶及相关制品', '2018-04-15 19:28:26', '2018-04-15 19:28:26');
INSERT INTO `detected_category` VALUES ('1404', '调味茶', '14', '茶叶及相关制品', '2018-04-15 19:28:25', '2018-04-15 19:28:25');
INSERT INTO `detected_category` VALUES ('1405', '代用茶', '14', '茶叶及相关制品', '2018-04-15 19:28:24', '2018-04-15 19:28:24');
INSERT INTO `detected_category` VALUES ('1501', '白酒', '15', '酒类', '2018-04-15 19:28:21', '2018-04-15 19:28:21');
INSERT INTO `detected_category` VALUES ('1502', '葡萄酒及果酒', '15', '酒类', '2018-04-15 19:28:14', '2018-04-15 19:28:14');
INSERT INTO `detected_category` VALUES ('1503', '啤酒', '15', '酒类', '2018-04-15 19:28:13', '2018-04-15 19:28:13');
INSERT INTO `detected_category` VALUES ('1504', '黄酒', '15', '酒类', '2018-04-15 19:28:12', '2018-04-15 19:28:12');
INSERT INTO `detected_category` VALUES ('1505', '其他酒', '15', '酒类', '2018-04-15 19:28:12', '2018-04-15 19:28:12');
INSERT INTO `detected_category` VALUES ('1506', '食用酒精', '15', '酒类', '2018-04-15 19:28:11', '2018-04-15 19:28:11');
INSERT INTO `detected_category` VALUES ('1601', '酱腌菜', '16', '蔬菜制品', '2018-04-15 19:28:10', '2018-04-15 19:28:10');
INSERT INTO `detected_category` VALUES ('1602', '蔬菜干制品', '16', '蔬菜制品', '2018-04-15 19:28:02', '2018-04-15 19:28:02');
INSERT INTO `detected_category` VALUES ('1603', '食用菌制品', '16', '蔬菜制品', '2018-04-15 19:28:01', '2018-04-15 19:28:01');
INSERT INTO `detected_category` VALUES ('1604', '其他蔬菜制品', '16', '蔬菜制品', '2018-04-15 19:28:00', '2018-04-15 19:28:00');
INSERT INTO `detected_category` VALUES ('1701', '蜜饯', '17', '水果制品类', '2018-04-15 19:28:00', '2018-04-15 19:28:00');
INSERT INTO `detected_category` VALUES ('1702', '水果制品', '17', '水果制品类', '2018-04-15 19:27:55', '2018-04-15 19:27:55');
INSERT INTO `detected_category` VALUES ('1801', '炒货食品及坚果制品', '18', '炒货食品及坚果制品类', '2018-04-15 19:27:54', '2018-04-15 19:27:54');
INSERT INTO `detected_category` VALUES ('1901', '蛋制品', '19', '蛋制品类', '2018-04-15 19:27:48', '2018-04-15 19:27:48');
INSERT INTO `detected_category` VALUES ('2001', '可可制品', '20', '可可及焙烤咖啡产品', '2018-04-15 19:27:44', '2018-04-15 19:27:44');
INSERT INTO `detected_category` VALUES ('2002', '焙炒咖啡', '20', '可可及焙烤咖啡产品', '2018-04-15 19:27:37', '2018-04-15 19:27:37');
INSERT INTO `detected_category` VALUES ('2101', '糖', '21', '食糖', '2018-04-15 19:27:34', '2018-04-15 19:27:34');
INSERT INTO `detected_category` VALUES ('2201', '非即食水产品', '22', '水产制品', '2018-04-15 19:27:30', '2018-04-15 19:27:30');
INSERT INTO `detected_category` VALUES ('2202', '即食水产品', '22', '水产制品', '2018-04-15 19:27:25', '2018-04-15 19:27:25');
INSERT INTO `detected_category` VALUES ('2301', '淀粉及淀粉制品', '23', '淀粉及淀粉制品类', '2018-04-15 19:27:23', '2018-04-15 19:27:23');
INSERT INTO `detected_category` VALUES ('2302', '淀粉糖', '23', '淀粉及淀粉制品类', '2018-04-15 19:27:20', '2018-04-15 19:27:20');
INSERT INTO `detected_category` VALUES ('2401', '热加工糕点', '24', '糕点', '2018-04-15 19:27:18', '2018-04-15 19:27:18');
INSERT INTO `detected_category` VALUES ('2402', '冷加工糕点', '24', '糕点', '2018-04-15 19:27:12', '2018-04-15 19:27:12');
INSERT INTO `detected_category` VALUES ('2403', '食品馅料', '24', '糕点', '2018-04-15 19:27:11', '2018-04-15 19:27:11');
INSERT INTO `detected_category` VALUES ('2501', '豆制品', '25', '豆制品类', '2018-04-15 19:27:09', '2018-04-15 19:27:09');
INSERT INTO `detected_category` VALUES ('2601', '蜂蜜', '26', '蜂产品', '2018-04-15 19:27:04', '2018-04-15 19:27:04');
INSERT INTO `detected_category` VALUES ('2602', '蜂王浆(含蜂王浆冻干品)', '26', '蜂产品', '2018-04-15 19:26:59', '2018-04-15 19:26:59');
INSERT INTO `detected_category` VALUES ('2603', '蜂花粉', '26', '蜂产品', '2018-04-15 19:26:58', '2018-04-15 19:26:58');
INSERT INTO `detected_category` VALUES ('2604', '蜂产品制品', '26', '蜂产品', '2018-04-15 19:26:57', '2018-04-15 19:26:57');
INSERT INTO `detected_category` VALUES ('2901', '婴幼儿配方乳粉', '29', '婴幼儿配方食品', '2018-04-15 19:26:56', '2018-04-15 19:26:56');
INSERT INTO `detected_category` VALUES ('3001', '婴幼儿谷类辅助食品', '30', '特殊膳食食品', '2018-04-15 19:26:45', '2018-04-15 19:26:45');
INSERT INTO `detected_category` VALUES ('3002', '婴幼儿罐装辅助食品', '30', '特殊膳食食品', '2018-04-15 19:26:37', '2018-04-15 19:26:37');
INSERT INTO `detected_category` VALUES ('3003', '其他特殊膳食食品', '30', '特殊膳食食品', '2018-04-15 19:26:36', '2018-04-15 19:26:36');
INSERT INTO `detected_category` VALUES ('3101', '其他食品', '31', '其他食品类', '2018-04-15 19:25:44', '2018-04-15 19:25:44');
INSERT INTO `detected_category` VALUES ('3201', '食品添加剂', '32', '食品添加剂类', '2018-04-15 19:25:33', '2018-04-15 19:25:33');
INSERT INTO `detected_category` VALUES ('3202', '食品用香精', '32', '食品添加剂类', '2018-04-15 19:25:29', '2018-04-15 19:25:29');
INSERT INTO `detected_category` VALUES ('3203', '复配食品添加剂', '32', '食品添加剂类', '2018-04-15 19:25:28', '2018-04-15 19:25:28');

-- ----------------------------
-- Table structure for detected_object
-- ----------------------------
DROP TABLE IF EXISTS `detected_object`;
CREATE TABLE `detected_object` (
  `detected_objects_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '被检测物编号',
  `detected_type_id` bigint(20) NOT NULL COMMENT '被检测物分类编号',
  `detected_objects_name` varchar(32) NOT NULL DEFAULT '' COMMENT '被检测物名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`detected_objects_id`),
  KEY `fk_detected_type_id` (`detected_type_id`),
  CONSTRAINT `fk_detected_type_id` FOREIGN KEY (`detected_type_id`) REFERENCES `detected_category` (`detected_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=320302 DEFAULT CHARSET=utf8 COMMENT='被检测物表';

-- ----------------------------
-- Records of detected_object
-- ----------------------------
INSERT INTO `detected_object` VALUES ('7301', '703', '辣条', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10101', '101', '特制一等小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10102', '101', '特制二等小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10103', '101', '标准粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10104', '101', '普通粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10105', '101', '高筋小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10106', '101', '低筋小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10107', '101', '营养强化小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10108', '101', '全麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10109', '101', '面包用小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10110', '101', '面条用小麦粉', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10111', '101', '饺子用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10112', '101', '馒头用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10113', '101', '发酵饼干用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10114', '101', '酥性饼干用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10115', '101', '蛋糕用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10116', '101', '糕点用小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10117', '101', '自发小麦粉', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10118', '101', '小麦胚(胚片,胚粉)', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10201', '102', '大米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10202', '102', '糙米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10301', '103', '普通挂面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10302', '103', '蔬菜面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10303', '103', '鸡蛋面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10304', '103', '营养强化面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10305', '103', '杂粮面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10306', '103', '手工面', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10401', '104', '高粱米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10402', '104', '黍米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10403', '104', '稷米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10404', '104', '小米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10405', '104', '黑米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10406', '104', '紫米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10407', '104', '红线米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10408', '104', '小麦米', '2018-04-15 19:40:18', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10409', '104', '大麦米', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10410', '104', '裸大麦米', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10411', '104', '莜麦米(燕麦米)', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10412', '104', '荞麦米', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10413', '104', '薏仁米', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10414', '104', '蒸谷米', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10415', '104', '八宝米类', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10416', '104', '混合杂粮类', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10417', '104', '玉米碜', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10418', '104', '玉米粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10419', '104', '燕麦片', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10420', '104', '汤圆粉(糯米粉)', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10421', '104', '莜麦粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10422', '104', '玉米自发粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10423', '104', '小米粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10424', '104', '高粱粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10425', '104', '荞麦粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10426', '104', '大麦粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10427', '104', '青稞粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10428', '104', '杂面粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10429', '104', '大米粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10430', '104', '绿豆粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10431', '104', '黄豆粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10432', '104', '红豆粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10433', '104', '黑豆粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10434', '104', '豌豆粉', '2018-04-15 19:40:19', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10435', '104', '芸豆粉', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10436', '104', '蚕豆粉', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10437', '104', '黍米粉(大黄米粉)', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10438', '104', '稷米粉(糜子面)', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10439', '104', '混合杂粮粉', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10440', '104', '生湿面制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10441', '104', '生干面制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10442', '104', '米粉制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('10443', '104', '其他谷物粉类制成品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20101', '201', '菜籽油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20102', '201', '大豆油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20103', '201', '花生油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20104', '201', '葵花籽油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20105', '201', '棉籽油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20106', '201', '亚麻籽油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20107', '201', '油茶籽油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20108', '201', '玉米油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20109', '201', '米糠油', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20110', '201', '芝麻油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20111', '201', '棕榈油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20112', '201', '橄榄油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20113', '201', '食用调和油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20114', '201', '食用氢化油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20201', '202', '人造奶油(人造黄油)', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20202', '202', '起酥油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20203', '202', '代可可脂', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20204', '202', '植脂奶油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20205', '202', '粉末油脂', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20206', '202', '植脂末', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20301', '203', '猪油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20302', '203', '牛油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20303', '203', '羊油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20304', '203', '鸡油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20305', '203', '鸭油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20306', '203', '鹅油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20307', '203', '骨髓油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('20308', '203', '鱼油', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30101', '301', '酿造酱油', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30102', '301', '配制酱油', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30201', '302', '酿造食醋', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30202', '302', '配制食醋', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30301', '303', '谷氨酸钠(味精)', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30302', '303', '加盐味精', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30303', '303', '增鲜味精', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30401', '304', '稀甜面酱', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30402', '304', '甜面酱', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30403', '304', '大豆酱(黄酱)', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30404', '304', '蚕豆酱', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30405', '304', '豆瓣酱', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30406', '304', '大酱', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30501', '305', '鸡汁调味料', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30502', '305', '牛肉汁调味料', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30503', '305', '烧烤汁', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30504', '305', '鲍鱼汁', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30505', '305', '香辛料调味汁', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30506', '305', '糟卤', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30507', '305', '调味料酒', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30508', '305', '液态复合调味料', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30509', '305', '酸水解植物蛋白调味液', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30510', '305', '花生酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30511', '305', '芝麻酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30512', '305', '辣椒酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30513', '305', '番茄酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30514', '305', '风味酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30515', '305', '蛋黄酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30516', '305', '沙拉酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30517', '305', '芥末酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30518', '305', '咖喱卤', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30519', '305', '油辣椒', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30520', '305', '火锅蘸料', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30521', '305', '火锅底料', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30522', '305', '排骨酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30523', '305', '叉烧酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30524', '305', '香辛料酱(泥)', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30525', '305', '复合调味酱', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30526', '305', '鸡精调味料', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30527', '305', '鸡粉调味料', '2018-04-15 19:40:42', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30528', '305', '畜(禽)粉调味料', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30529', '305', '风味汤料', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30530', '305', '酱油粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30531', '305', '食醋粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30532', '305', '酱粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30533', '305', '咖喱粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30534', '305', '香辛料粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30535', '305', '酸水解植物蛋白调味料', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30536', '305', '复合调味粉', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30537', '305', '香辛料调味油', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30538', '305', '复合调味油', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30539', '305', '蚝油', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30540', '305', '鱼露', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30541', '305', '虾酱', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30542', '305', '鱼子酱', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('30543', '305', '虾油', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40101', '401', '酱卤肉类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40102', '401', '糟肉类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40103', '401', '白煮肉类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40104', '401', '熏肉', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40105', '401', '烤肉', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40106', '401', '烤鸡腿', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40107', '401', '烤鸭', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40108', '401', '烤鸡', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40109', '401', '叉烧肉', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40110', '401', '灌肠类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40111', '401', '西式火腿', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40112', '401', '炸猪皮', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40113', '401', '炸鸡翅', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40114', '401', '炸肉丸', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40115', '401', '肉松类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40116', '401', '肉干类', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40117', '401', '肉脯', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40118', '401', '熟培根', '2018-04-15 19:40:46', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40119', '401', '熟腊肉', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40120', '401', '肉糕类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40121', '401', '肉冻类(肉皮冻水晶肉)', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40122', '401', '血豆腐', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40201', '402', '发酵灌肠制品', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40202', '402', '发酵火腿制品', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40301', '403', '冷藏预制调理肉类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40302', '403', '冷冻预制调理肉类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40401', '404', '咸肉类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40402', '404', '腊肉类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40403', '404', '风干肠类', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40404', '404', '风干鹅', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40405', '404', '腌制猪肘', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40406', '404', '中国火腿', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40407', '404', '生培根', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40408', '404', '生香肠', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40409', '404', '生发酵香肠', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('40410', '404', '巴氏杀菌乳', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50101', '501', '调制乳', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50102', '501', '灭菌乳', '2018-04-15 19:40:47', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50103', '501', '发酵乳', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50201', '502', '全脂乳粉', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50202', '502', '脱脂乳粉', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50203', '502', '部分脱脂乳粉', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50204', '502', '调制乳粉', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50205', '502', '牛初乳粉', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50301', '503', '炼乳', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50302', '503', '奶油', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50303', '503', '稀奶油', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50304', '503', '无水奶油', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50305', '503', '干酪', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50306', '503', '再制干酪', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('50307', '503', '特色乳制品', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60101', '601', '饮用天然矿泉水', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60102', '601', '饮用纯净水', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60103', '601', '饮用天然泉水', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60104', '601', '饮用天然水', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60105', '601', '其他饮用水', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60201', '602', '果汁型碳酸饮料', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60202', '602', '果味型碳酸饮料', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60203', '602', '可乐型碳酸饮料', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60204', '602', '其他型碳酸饮料', '2018-04-15 19:40:48', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60301', '603', '原茶汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60302', '603', '茶浓缩液', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60303', '603', '茶饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60304', '603', '果汁茶饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60305', '603', '奶茶饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60306', '603', '复合茶饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60307', '603', '混合茶饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60401', '604', '原榨果汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60402', '604', '果汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60403', '604', '蔬菜汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60404', '604', '果浆', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60405', '604', '蔬菜浆', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60406', '604', '复合果蔬汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60407', '604', '复合果蔬浆', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60408', '604', '浓缩果蔬汁', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60409', '604', '果蔬汁饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60410', '604', '果肉饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60411', '604', '果浆饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60412', '604', '复合果蔬汁饮料', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60413', '604', '果蔬汁饮料浓浆', '2018-04-15 19:40:49', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60414', '604', '发酵果蔬汁饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60415', '604', '水果饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60501', '605', '含乳饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60502', '605', '植物蛋白饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60503', '605', '复合蛋白饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60601', '606', '风味固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60602', '606', '蛋白固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60603', '606', '果蔬固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60604', '606', '茶固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60605', '606', '咖啡固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60606', '606', '可可粉固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60607', '606', '植物固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60608', '606', '谷物固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60609', '606', '营养素固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60610', '606', '食用菌固体饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60701', '607', '咖啡饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60702', '607', '植物饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60703', '607', '风味饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60704', '607', '运动饮料', '2018-04-15 19:40:50', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60705', '607', '营养素饮料', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60706', '607', '能量饮料', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60707', '607', '电解质饮料', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60708', '607', '饮料浓浆', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('60709', '607', '其他类饮料', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70101', '701', '方便面', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70201', '702', '方便米饭', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70202', '702', '方便粥', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70203', '702', '方便米粉', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70204', '702', '方便米线', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70205', '702', '方便粉丝', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70206', '702', '方便湿米粉', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70207', '702', '方便豆花', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70208', '702', '方便湿面', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70209', '702', '凉粉', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70210', '702', '麦片', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70211', '702', '黑芝麻糊', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70212', '702', '红枣羹', '2018-04-15 19:40:51', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70213', '702', '油茶', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('70214', '702', '即食谷物粉', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80101', '801', '酥性饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80102', '801', '韧性饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80103', '801', '发酵饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80104', '801', '压缩饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80105', '801', '曲奇饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80106', '801', '夹心饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80107', '801', '威化饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80108', '801', '蛋圆饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80109', '801', '蛋卷', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80110', '801', '煎饼', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80111', '801', '装饰饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80112', '801', '水泡饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('80113', '801', '其他饼干', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90101', '901', '火腿猪肉罐头', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90102', '901', '火腿罐头', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90103', '901', '肉类罐头', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90104', '901', '鱼罐头', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90105', '901', '回锅肉罐头', '2018-04-15 19:40:52', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90106', '901', '红烧扣肉罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90107', '901', '五香肉丁罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90108', '901', '凤尾鱼罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90109', '901', '红烧排骨罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90110', '901', '豆豉鲮鱼罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90111', '901', '香菇肉酱罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90112', '901', '榨菜肉丝罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90113', '901', '其它畜禽水产罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90201', '902', '菠萝罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90202', '902', '蚕豆罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90203', '902', '蘑菇罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90204', '902', '什锦水果罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90205', '902', '竹笋罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90206', '902', '莲藕罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90207', '902', '糖水枇杷罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90208', '902', '盐水红豆罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90209', '902', '其它果蔬罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90301', '903', '花生米罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90302', '903', '琥珀核桃仁罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90303', '903', '咸核桃仁罐头', '2018-04-15 19:40:53', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('90304', '903', '八宝粥罐头', '2018-04-15 19:40:54', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100101', '1001', '冰淇淋', '2018-04-15 19:40:15', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100102', '1001', '雪糕', '2018-04-15 19:40:15', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100103', '1001', '雪泥', '2018-04-15 19:40:15', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100104', '1001', '冰棍', '2018-04-15 19:40:15', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100105', '1001', '食用冰', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100106', '1001', '甜味冰', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100107', '1101', '生制速冻饺子', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100108', '1101', '生制速冻汤圆', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100109', '1101', '生制速冻粽子', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100110', '1101', '生制速冻面点', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100111', '1101', '生制速冻其他面米制品', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100112', '1101', '熟制速冻饺子', '2018-04-15 19:40:16', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100113', '1101', '熟制速冻汤圆', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100114', '1101', '熟制速冻粽子', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100115', '1101', '熟制速冻面点', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('100116', '1101', '熟制速冻其他面米制品', '2018-04-15 19:40:17', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110201', '1102', '生制速冻糜类制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110202', '1102', '生制速冻其他调制制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110203', '1102', '熟制速冻糜类制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110204', '1102', '熟制速冻其他调制制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110301', '1103', '生制速冻分割肉', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110302', '1103', '生制速冻肉片', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110303', '1103', '生制速冻肉卷', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110304', '1103', '生制速冻内脏', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110305', '1103', '生制速冻其他肉制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110306', '1103', '熟制速冻分割肉', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110307', '1103', '熟制速冻肉片', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110308', '1103', '熟制速冻肉卷', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110309', '1103', '熟制速冻内脏', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110310', '1103', '熟制速冻其他肉制品', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110401', '1104', '生制速冻蔬菜', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110402', '1104', '生制速冻水果', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110403', '1104', '生制速冻坚果', '2018-04-15 19:40:20', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110404', '1104', '生制速冻其他果蔬制品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110405', '1104', '熟制速冻蔬菜', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110406', '1104', '熟制速冻水果', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110407', '1104', '熟制速冻坚果', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110408', '1104', '熟制速冻其他果蔬制品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110501', '1105', '生制速冻鱼类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110502', '1105', '生制速冻虾类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110503', '1105', '生制速冻蟹类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110504', '1105', '生制速冻贝类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110505', '1105', '生制速冻其他水产品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110506', '1105', '熟制速冻鱼类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110507', '1105', '熟制速冻虾类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110508', '1105', '熟制速冻蟹类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110509', '1105', '熟制速冻贝类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110510', '1105', '熟制速冻其他水产品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110601', '1106', '生制其他速冻品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('110602', '1106', '熟制其他速冻品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120101', '1201', '焙烤型薯类膨化食品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120102', '1201', '油炸型薯类膨化食品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120103', '1201', '直接挤压型薯类膨化食品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120104', '1201', '花色型薯类膨化食品', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120201', '1202', '干制薯类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120202', '1202', '冷冻薯类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120203', '1202', '薯泥类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120204', '1202', '薯粉类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('120205', '1202', '其他薯类', '2018-04-15 19:40:21', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130101', '1301', '硬质糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130102', '1301', '奶糖糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130103', '1301', '夹心糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130104', '1301', '酥质糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130105', '1301', '焦香糖果(太妃糖果)', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130106', '1301', '充气糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130107', '1301', '凝胶糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130108', '1301', '胶基糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130109', '1301', '压片糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130110', '1301', '流质糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130111', '1301', '膜片糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130112', '1301', '花式糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130113', '1301', '其他糖果', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130201', '1302', '黑巧克力', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130202', '1302', '牛奶巧克力', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130203', '1302', '白巧克力', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130204', '1302', '巧克力制品', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130301', '1303', '代可可脂巧克力', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130302', '1303', '代可可脂巧克力制品', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130401', '1304', '果汁型果冻', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130402', '1304', '果肉型果冻', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130403', '1304', '果味型果冻', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130404', '1304', '含乳型果冻', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('130405', '1304', '其他型果冻', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140101', '1401', '绿茶(龙井茶)', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140102', '1401', '绿茶(珠茶)', '2018-04-15 19:40:22', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140103', '1401', '绿茶(黄山毛峰)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140104', '1401', '绿茶(都匀毛尖)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140105', '1401', '红茶(祁门工夫红茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140106', '1401', '红茶(小种红茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140107', '1401', '红茶(红碎茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140108', '1401', '乌龙茶(铁观音茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140109', '1401', '乌龙茶(武夷岩茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140110', '1401', '乌龙茶(凤凰单枞茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140111', '1401', '白茶(白毫银针茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140112', '1401', '白茶(白牡丹茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140113', '1401', '白茶(贡眉茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140114', '1401', '黄茶(蒙顶黄芽茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140115', '1401', '黄茶(霍山黄芽茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140116', '1401', '黄茶(君山银针茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140117', '1401', '黑茶(普洱茶(熟茶)散茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140118', '1401', '黑茶(六堡茶散茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140119', '1401', '花茶(茉莉花茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140120', '1401', '花茶(珠兰花茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140121', '1401', '花茶(桂花茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140122', '1401', '袋泡茶(绿茶袋泡茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140123', '1401', '袋泡茶(红茶袋泡茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140124', '1401', '袋泡茶(花茶袋泡茶)', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140125', '1401', '普洱茶(生茶)紧压茶', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140126', '1401', '普洱茶(熟茶)紧压茶', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140127', '1401', '六堡茶紧压茶', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140128', '1401', '白茶紧压茶', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140129', '1401', '工艺茉莉花茶', '2018-04-15 19:40:23', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140130', '1401', '蒸团茶', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140131', '1401', '其他茶叶', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140201', '1402', '边销茶(花砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140202', '1402', '边销茶(黑砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140203', '1402', '边销茶(茯砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140204', '1402', '边销茶(康砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140205', '1402', '边销茶(沱茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140206', '1402', '边销茶(紧茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140207', '1402', '边销茶(金尖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140208', '1402', '边销茶(米砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140209', '1402', '边销茶(青砖茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140210', '1402', '边销茶(方包茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140301', '1403', '绿茶粉', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140302', '1403', '红茶粉', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140303', '1403', '固态速溶茶(速溶红茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140304', '1403', '固态速溶茶(速溶绿茶)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140305', '1403', '茶浓缩液(红茶浓缩液)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140306', '1403', '茶浓缩液(绿茶浓缩液)', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140307', '1403', '普洱茶膏', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140308', '1403', '黑茶膏', '2018-04-15 19:40:24', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140309', '1403', '调味茶制品(调味茶粉)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140310', '1403', '调味茶制品(调味速溶茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140311', '1403', '调味茶制品(调味茶浓缩液)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140312', '1403', '调味茶制品(调味茶膏)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140313', '1403', '表没食子儿茶素没食子酸酯', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140314', '1403', '绿茶茶氨酸', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140401', '1404', '加料调味茶(八宝茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140402', '1404', '加料调味茶(三泡台)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140403', '1404', '加料调味茶(枸杞绿茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140404', '1404', '加料调味茶(玄米绿茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140405', '1404', '加香调味茶(柠檬红茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140406', '1404', '加香调味茶(草莓绿茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140407', '1404', '混合调味茶(柠檬枸杞茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140408', '1404', '袋泡调味茶(玫瑰袋泡红茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140409', '1404', '紧压调味茶(荷叶茯砖茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140501', '1405', '叶类代用茶(荷叶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140502', '1405', '叶类代用茶(桑叶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140503', '1405', '叶类代用茶(薄荷叶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140504', '1405', '叶类代用茶(苦丁茶)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140505', '1405', '花类代用茶(杭白菊)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140506', '1405', '花类代用茶(金银花)', '2018-04-15 19:40:25', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140507', '1405', '花类代用茶(重瓣红玫瑰)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140508', '1405', '果实类代用茶(大麦茶)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140509', '1405', '果实类代用茶(枸杞子)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140510', '1405', '果实类代用茶(决明子)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140511', '1405', '果实类代用茶(苦瓜片)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140512', '1405', '果实类代用茶(罗汉果)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140513', '1405', '果实类代用茶(柠檬片)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140514', '1405', '根茎类代用茶(甘草)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140515', '1405', '根茎类代用茶(牛蒡根)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140516', '1405', '根茎类代用茶(人参(人工种植))', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140517', '1405', '混合类代用茶(荷叶玫瑰茶)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140518', '1405', '混合类代用茶(枸杞菊花茶)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140519', '1405', '袋泡代用茶(荷叶袋泡茶)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140520', '1405', '袋泡代用茶(桑叶袋泡茶)', '2018-04-15 19:40:26', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('140521', '1405', '紧压代用茶(紧压菊花茶)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150101', '1501', '浓香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150102', '1501', '清香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150103', '1501', '酱香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150104', '1501', '米香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150105', '1501', '凤香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150106', '1501', '兼香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150107', '1501', '芝麻香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150108', '1501', '特香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150109', '1501', '豉香星白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150110', '1501', '老白干香型白酒', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150111', '1501', '浓香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150112', '1501', '清香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150113', '1501', '酱香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150114', '1501', '米香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150115', '1501', '凤香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150116', '1501', '兼香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150117', '1501', '芝麻香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150118', '1501', '特香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150119', '1501', '豉香星白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150120', '1501', '老白干香型白酒(原酒)', '2018-04-15 19:40:27', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150201', '1502', '葡萄酒(原酒)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150202', '1502', '葡萄酒(加工灌装)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150203', '1502', '冰葡萄酒(原酒)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150204', '1502', '冰葡萄酒(加工灌装)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150205', '1502', '其他特种葡萄酒(原酒)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150206', '1502', '其他特种葡萄酒(加工灌装)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150207', '1502', '发酵型果酒(原酒)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150208', '1502', '发酵型果酒(加工灌装)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150301', '1503', '熟啤酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150302', '1503', '生啤酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150303', '1503', '鲜啤酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150304', '1503', '特种啤酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150401', '1504', '黄酒(原酒)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150402', '1504', '黄酒(加工灌装)', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150501', '1505', '露酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150502', '1505', '枸杞酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150503', '1505', '枇杷酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150504', '1505', '白兰地', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150505', '1505', '威士忌', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150506', '1505', '俄得克', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150507', '1505', '朗姆酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150508', '1505', '水果白兰地', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150509', '1505', '水果蒸馏酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150510', '1505', '清酒', '2018-04-15 19:40:28', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150511', '1505', '米酒(醪糟)', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150512', '1505', '奶酒', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150513', '1505', '其它酒', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150601', '1506', '食用酒精', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150602', '1601', '调味榨菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150603', '1601', '腌萝卜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150604', '1601', '腌豇豆', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150605', '1601', '酱渍菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150606', '1601', '虾油渍菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('150607', '1601', '盐水渍菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160201', '1602', '自然干制蔬菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160202', '1602', '热风干燥蔬菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160203', '1602', '冷冻干燥蔬菜', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160204', '1602', '蔬菜脆片', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160205', '1602', '蔬菜粉及制品', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160301', '1603', '干制食用菌', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160302', '1603', '腌渍食用菌', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('160401', '1604', '其他蔬菜制品', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170101', '1701', '蜜饯类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170102', '1701', '凉果类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170103', '1701', '果脯类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170104', '1701', '话化类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170105', '1701', '果丹(饼)类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170106', '1701', '果糕类', '2018-04-15 19:40:29', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170201', '1702', '葡萄干', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170202', '1702', '水果脆片', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170203', '1702', '荔枝干', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170204', '1702', '桂圆', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170205', '1702', '椰干', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170206', '1702', '大枣干制品', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170207', '1702', '苹果酱', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170208', '1702', '草莓酱', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170209', '1702', '蓝莓酱', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('170210', '1702', '其它水果制品', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180101', '1801', '炒瓜子', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180102', '1801', '炒花生', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180103', '1801', '炒豌豆', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180104', '1801', '油炸青豆', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180105', '1801', '油炸琥珀桃仁', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180106', '1801', '水煮花生', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180107', '1801', '糖炒花生', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180108', '1801', '糖炒瓜子仁', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180109', '1801', '裹衣花生', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('180110', '1801', '咸干花生', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190101', '1901', '皮蛋', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190102', '1901', '咸蛋', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190103', '1901', '糟蛋', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190104', '1901', '卤蛋', '2018-04-15 19:40:30', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190105', '1901', '咸蛋黄', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190106', '1901', '巴氏杀菌鸡全蛋粉', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190107', '1901', '鸡蛋黄粉', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190108', '1901', '鸡蛋白片', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190109', '1901', '巴氏杀菌冻鸡全蛋', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190110', '1901', '冻鸡蛋黄', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190111', '1901', '冰鸡蛋白', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190112', '1901', '鸡蛋豆腐', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('190113', '1901', '鸡蛋豆腐干', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200101', '2001', '可可粉', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200102', '2001', '可可脂', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200103', '2001', '可可液块', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200104', '2001', '可可饼块', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200201', '2002', '焙炒咖啡豆', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('200202', '2002', '咖啡粉', '2018-04-15 19:40:31', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210101', '2101', '白砂糖', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210102', '2101', '绵白糖', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210103', '2101', '赤砂糖', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210104', '2101', '冰糖(单晶体冰糖)', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210105', '2101', '冰糖(多晶体冰糖)', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210106', '2101', '方糖', '2018-04-15 19:40:32', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210107', '2101', '冰片糖', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210108', '2101', '红糖', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210109', '2101', '复配糖', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('210110', '2101', '其他糖', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220101', '2201', '干制虾米', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220102', '2201', '干制虾皮', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220103', '2201', '干制干贝', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220104', '2201', '干制鱼干', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220105', '2201', '干制鱿鱼干', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220106', '2201', '干燥裙带菜', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220107', '2201', '干海带', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220108', '2201', '紫菜', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220109', '2201', '干海参', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220110', '2201', '干鲍鱼', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220111', '2201', '盐渍海带', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220112', '2201', '盐渍裙带菜', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220113', '2201', '盐渍海蜇皮', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220114', '2201', '盐渍海蜇头', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220115', '2201', '盐渍鱼', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220116', '2201', '鱼糜制品(鱼丸)', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220117', '2201', '鱼糜制品(虾丸)', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220118', '2201', '鱼糜制品(墨鱼丸)', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220201', '2202', '烤鱼片', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220202', '2202', '鱿鱼丝', '2018-04-15 19:40:33', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220203', '2202', '烤虾', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220204', '2202', '熏鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220205', '2202', '熏鱿鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220206', '2202', '鱼松', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220207', '2202', '炸鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220208', '2202', '五香鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220209', '2202', '糟鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220210', '2202', '即食海参', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220211', '2202', '即食鲍鱼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220212', '2202', '鱼饼', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220213', '2202', '鱼肠', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220214', '2202', '烤海苔', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220215', '2202', '醉虾', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220216', '2202', '醉泥螺', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220217', '2202', '醉蚶', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220218', '2202', '蟹酱(糊)', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220219', '2202', '生鱼片', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220220', '2202', '生螺片', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('220221', '2202', '海蜇丝', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230101', '2301', '谷类淀粉(大米)', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230102', '2301', '谷类淀粉(玉米)', '2018-04-15 19:40:34', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230103', '2301', '谷类淀粉(高粱)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230104', '2301', '谷类淀粉(麦)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230105', '2301', '薯类淀粉(木薯)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230106', '2301', '薯类淀粉(马铃薯)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230107', '2301', '薯类淀粉(甘薯)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230108', '2301', '薯类淀粉(芋头)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230109', '2301', '豆类淀粉(绿豆)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230110', '2301', '豆类淀粉(蚕豆)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230111', '2301', '豆类淀粉(豇豆)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230112', '2301', '豆类淀粉(豌豆)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230113', '2301', '其他淀粉(藕)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230114', '2301', '其他淀粉(荸荠)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230115', '2301', '其他淀粉(百合)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230116', '2301', '其他淀粉(蕨根)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230117', '2301', '淀粉制品(粉丝)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230118', '2301', '淀粉制品(粉条)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230119', '2301', '淀粉制品(粉皮)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230120', '2301', '淀粉制品(虾片)', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230201', '2302', '葡萄糖', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230202', '2302', '饴糖', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230203', '2302', '麦芽糖', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230204', '2302', '异构化糖', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230205', '2302', '低聚异麦芽糖', '2018-04-15 19:40:35', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230206', '2302', '果葡糖浆', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230207', '2302', '麦芽糊精', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('230208', '2302', '葡萄糖浆', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240101', '2401', '烘烤类糕点(酥类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240102', '2401', '烘烤类糕点(松酥类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240103', '2401', '烘烤类糕点(松脆类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240104', '2401', '烘烤类糕点(酥层类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240105', '2401', '烘烤类糕点(酥皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240106', '2401', '烘烤类糕点(松酥皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240107', '2401', '烘烤类糕点(糖浆皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240108', '2401', '烘烤类糕点(硬皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240109', '2401', '烘烤类糕点(水油皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240110', '2401', '烘烤类糕点(发酵类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240111', '2401', '烘烤类糕点(烤蛋糕类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240112', '2401', '烘烤类糕点(烘糕类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240113', '2401', '烘烤类糕点(烫面类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240114', '2401', '烘烤类糕点(其他类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240115', '2401', '油炸类糕点(酥皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240116', '2401', '油炸类糕点(水油皮类)', '2018-04-15 19:40:36', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240117', '2401', '油炸类糕点(松酥类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240118', '2401', '油炸类糕点(酥层类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240119', '2401', '油炸类糕点(水调类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240120', '2401', '油炸类糕点(发酵类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240121', '2401', '油炸类糕点(其他类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240122', '2401', '蒸煮类糕点(蒸蛋糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240123', '2401', '蒸煮类糕点(印模糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240124', '2401', '蒸煮类糕点(韧糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240125', '2401', '蒸煮类糕点(发糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240126', '2401', '蒸煮类糕点(松糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240127', '2401', '蒸煮类糕点(粽子类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240128', '2401', '蒸煮类糕点(水油皮类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240129', '2401', '蒸煮类糕点(片糕类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240130', '2401', '蒸煮类糕点(其他类)', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240131', '2401', '炒制类糕点', '2018-04-15 19:40:37', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240132', '2401', '其馒头', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240133', '2401', '花卷', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240134', '2401', '包子', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240135', '2401', '豆包', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240136', '2401', '饺子', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240137', '2401', '发糕', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240138', '2401', '馅饼', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240139', '2401', '油条', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240140', '2401', '油饼', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240141', '2401', '炸糕', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240142', '2401', '窝头', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240143', '2401', '烙饼', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240201', '2402', '热调软糕类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240202', '2402', '冷调韧糕类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240203', '2402', '冷调松糕类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240204', '2402', '印模糕类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240205', '2402', '挤压糕点类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240206', '2402', '其他类糕点', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240207', '2402', '西式装饰蛋糕类', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240208', '2402', '上糖浆类', '2018-04-15 19:40:38', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240209', '2402', '夹心(注心)类', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240210', '2402', '糕团类', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240211', '2402', '其他冷加工糕点', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240301', '2403', '月饼馅料', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('240302', '2403', '其它食品馅料', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250101', '2501', '红腐乳', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250102', '2501', '酱腐乳', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250103', '2501', '白腐乳', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250104', '2501', '青腐乳', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250105', '2501', '豆豉', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250106', '2501', '纳豆', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250107', '2501', '豆汁', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250108', '2501', '豆浆', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250109', '2501', '豆腐', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250110', '2501', '豆腐泡', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250111', '2501', '熏干', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250112', '2501', '豆腐脑', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250113', '2501', '豆腐干', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250114', '2501', '腐竹', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250115', '2501', '豆腐皮', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250116', '2501', '素肉', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250117', '2501', '大豆组织蛋白', '2018-04-15 19:40:39', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('250118', '2501', '膨化豆制品', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('260101', '2601', '蜂蜜', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('260201', '2602', '蜂王浆', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('260202', '2602', '蜂王浆冻干品', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('260301', '2603', '蜂花粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('260401', '2604', '蜂产品制品', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('290101', '2901', '湿法工艺乳粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('290102', '2901', '干法工艺乳粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('290103', '2901', '干湿法复合工艺乳粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300101', '3001', '婴幼儿米粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300102', '3001', '婴幼儿小米米粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300103', '3001', '高蛋白婴幼儿米粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300104', '3001', '高蛋白婴幼儿小米米粉', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300105', '3001', '婴幼儿面条', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300106', '3001', '婴幼儿颗粒面', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300107', '3001', '婴幼儿饼干', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300108', '3001', '婴幼儿米饼', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300109', '3001', '婴幼儿磨牙棒', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300201', '3002', '婴幼儿果蔬泥', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300202', '3002', '婴幼儿肉泥', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300203', '3002', '婴幼儿鱼泥', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300204', '3002', '婴幼儿颗粒果蔬泥', '2018-04-15 19:40:40', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300205', '3002', '婴幼儿颗粒肉泥', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300206', '3002', '婴幼儿颗粒鱼泥', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300207', '3002', '婴幼儿水果汁', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300208', '3002', '婴幼儿蔬菜汁', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('300301', '3003', '其他特殊膳食食品', '2018-04-15 19:40:41', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310101', '3101', 'DHA藻油', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310102', '3101', '花生四烯酸油脂', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310103', '3101', 'L-阿拉伯糖', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310104', '3101', '木糖', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310105', '3101', '大豆低聚糖', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310106', '3101', '低聚木糖', '2018-04-15 19:40:43', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310107', '3101', '低聚果糖', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310108', '3101', '低聚半乳糖', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310109', '3101', '低聚半乳糖制品', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310110', '3101', '菊粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310111', '3101', '棉子低聚糖', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310112', '3101', '壳寡糖', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310113', '3101', '蚌肉多糖', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310114', '3101', '白砂糖浆', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310115', '3101', '面包专用糖浆', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310116', '3101', '烘焙糖浆', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310117', '3101', '阿胶膏', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310118', '3101', '清膏', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310119', '3101', '蜜膏', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310120', '3101', '阿胶固元糕', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310121', '3101', '冰淇淋粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310122', '3101', '饼干预拌粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310123', '3101', '面包预拌粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310124', '3101', '蛋糕预拌粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310125', '3101', '大豆蛋白粉', '2018-04-15 19:40:44', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310126', '3101', '大豆肽粉', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310127', '3101', '花生蛋白粉', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310128', '3101', '复合氨基酸粉', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310129', '3101', '复合益生菌豆', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310130', '3101', '螺旋藻制品', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310131', '3101', '即食鲜切蔬果', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310132', '3101', '凉拌菜', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310133', '3101', '方便菜肴', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310134', '3101', '食用槟榔', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310135', '3101', '干酵母', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310136', '3101', '酵母抽提物', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310137', '3101', '酵母浸出物', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310138', '3101', '酵母制品', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310139', '3101', 'γ-氨基丁酸', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('310140', '3101', '乳酸菌粉', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320101', '3201', '食品添加剂产品名称', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320102', '3202', '液体香精', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320103', '3202', '乳化香精', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320104', '3202', '浆(膏)状香精', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320105', '3202', '粉末)香精', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320106', '3202', '香精(拌和,胶囊)', '2018-04-15 19:40:45', '2018-04-15 20:01:29');
INSERT INTO `detected_object` VALUES ('320301', '3203', '复配食品添加剂明细', '2018-04-15 19:40:46', '2018-04-15 20:01:29');

-- ----------------------------
-- Table structure for detection_material
-- ----------------------------
DROP TABLE IF EXISTS `detection_material`;
CREATE TABLE `detection_material` (
  `detection_material_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '检测内容编号',
  `category_id` bigint(20) NOT NULL COMMENT '内容类别编号',
  `detection_material_name` varchar(32) NOT NULL COMMENT '检测内容名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`detection_material_id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `detection_material_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测的内容表';

-- ----------------------------
-- Records of detection_material
-- ----------------------------

-- ----------------------------
-- Table structure for detection_material_category
-- ----------------------------
DROP TABLE IF EXISTS `detection_material_category`;
CREATE TABLE `detection_material_category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '检测内容类别编号',
  `category__name` varchar(32) NOT NULL COMMENT '类别名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测内容分类表';

-- ----------------------------
-- Records of detection_material_category
-- ----------------------------

-- ----------------------------
-- Table structure for detection_material_detail
-- ----------------------------
DROP TABLE IF EXISTS `detection_material_detail`;
CREATE TABLE `detection_material_detail` (
  `material_detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '检测物质细节id',
  `report_id` bigint(20) unsigned NOT NULL COMMENT '报告ID',
  `material_name` varchar(50) NOT NULL COMMENT '检测的内容如：性激素、毒素、重金属等(换成json串)',
  `material_value` varchar(50) NOT NULL COMMENT '数据值',
  `standard_value` varchar(50) NOT NULL COMMENT '标准数据对应值',
  `is_excessive` tinyint(1) NOT NULL COMMENT '该检测内容含量是否超标，0表示未超标，1表示超标',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`material_detail_id`),
  KEY `fk_report_id` (`report_id`),
  CONSTRAINT `fk_report_id` FOREIGN KEY (`report_id`) REFERENCES `report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测物质细节表';

-- ----------------------------
-- Records of detection_material_detail
-- ----------------------------

-- ----------------------------
-- Table structure for dir
-- ----------------------------
DROP TABLE IF EXISTS `dir`;
CREATE TABLE `dir` (
  `dir_id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `dir_name` varchar(20) NOT NULL COMMENT '文件夹名称',
  `dir_type_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT '文件夹所属类型，0表示光谱文件夹，1表示算法文件',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`dir_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='光谱/算法文件夹';

-- ----------------------------
-- Records of dir
-- ----------------------------
INSERT INTO `dir` VALUES ('2', '3', 'adsasdas', '0', '2018-03-17 17:40:27', '2018-04-14 16:13:48');
INSERT INTO `dir` VALUES ('3', '3', '算法测试文件夹', '1', '2018-03-17 17:41:41', '2018-04-17 09:21:48');
INSERT INTO `dir` VALUES ('4', '3', 'qqqq', '0', '2018-03-17 17:41:49', '2018-03-17 17:41:49');
INSERT INTO `dir` VALUES ('5', '3', '1231', '0', '2018-04-14 10:15:06', '2018-04-14 10:15:06');
INSERT INTO `dir` VALUES ('6', '3', 'test', '1', '2018-04-17 09:21:57', '2018-04-17 09:21:57');

-- ----------------------------
-- Table structure for function
-- ----------------------------
DROP TABLE IF EXISTS `function`;
CREATE TABLE `function` (
  `function_id` bigint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '功能编号',
  `function_name` varchar(32) DEFAULT NULL COMMENT '功能名称',
  `function_url` varchar(64) DEFAULT NULL COMMENT '功能的地址',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能表';

-- ----------------------------
-- Records of function
-- ----------------------------

-- ----------------------------
-- Table structure for hardware
-- ----------------------------
DROP TABLE IF EXISTS `hardware`;
CREATE TABLE `hardware` (
  `hardware_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '设备编号',
  `hardware_type` varchar(16) DEFAULT NULL COMMENT '硬件类型',
  `hardware_name` varchar(64) NOT NULL COMMENT '设备名称',
  `spectrum_type_id` bigint(20) unsigned NOT NULL COMMENT '硬件支持的光谱编号唯一不能重复',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可用（1：表示可用，0：表示不可用）',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`hardware_id`),
  KEY `fk_spectrum_type_id` (`spectrum_type_id`),
  CONSTRAINT `fk_spectrum_type_id` FOREIGN KEY (`spectrum_type_id`) REFERENCES `spectrum_type` (`spectrumtype_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='硬件信息';

-- ----------------------------
-- Records of hardware
-- ----------------------------
INSERT INTO `hardware` VALUES ('1', null, 'PerkinElmer 红外光谱仪Spectrum Two', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('2', null, 'Q1000手持式油液状态监控仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('3', null, 'WQF-510A傅立叶变换红外光谱仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('4', null, '傅立叶变换红外光谱仪FTIR-650', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('5', null, '安捷伦4500增塑剂检测专用分析仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('6', null, 'Nicolet iS50 傅立叶变换红外光谱仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('7', null, 'WQF-520A傅立叶变换红外光谱仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('8', null, 'Nicolet iS10 傅立叶变换红外光谱仪', '1', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('9', null, '海洋光学IDRaman mini 手持式拉曼系统', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('10', null, '钢研纳克smart便携式的台式拉曼光谱仪', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('11', null, 'DXR 智能拉曼光谱仪', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('12', null, '手持式拉曼光谱仪TruScan RM', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('13', null, 'Cobalt RapID空间位移拉曼光谱仪', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('14', null, 'Kaiser拉曼在线生物工艺分析仪', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('15', null, 'NanoRam手持式拉曼鉴定系统', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('16', null, '全自动拉曼光谱仪-XploRA PLUS', '4', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('17', null, '﻿AFS-9780全自动四灯位注射式氢化物发生原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('18', null, 'DCMA-200型直接进样汞镉测试仪', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('19', null, 'RGF¬8780原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('20', null, 'SK-博析-LC 液相色谱原子荧光联用仪', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('21', null, 'AFS-9700全自动注射泵原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('22', null, 'AFS-9130型全自动内置式顺序注射原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('23', null, 'AF-7500型原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('24', null, 'AFS-9330型全自动六灯位顺序注射原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('25', null, 'DCMA-200型直接进样汞镉测试仪', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('26', null, 'RGF¬8780原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('27', null, 'SK-博析-LC 液相色谱原子荧光联用仪', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('28', null, 'AF-7500型原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('29', null, 'AFS-9780全自动四灯位注射式氢化物发生原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('30', null, 'AF-7550型双道氢化物-原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('31', null, 'AFS-9330型全自动六灯位顺序注射原子荧光光度计', '5', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('32', null, 'AFS-9700全自动注射泵原子荧光光度计', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('33', null, 'PerkinElmer 原子吸收光谱仪', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('34', null, '耶拿ZEEnit®700P火焰石墨炉原子吸收光谱仪', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('35', null, 'AA－7020型原子吸收分光光度计', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('36', null, '原子吸收分光光度计AA-7000', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('37', null, '仪电科仪 4510F原子吸收分光光度计', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('38', null, 'WFX-210原子吸收分光光度计', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('39', null, 'TAS-990原子吸收分光光度计', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('40', null, 'WFX-910便携式原子吸收光谱仪', '6', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('41', null, '聚光ICP-5000电感耦合等离子体发射光谱仪', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('42', null, 'PQ9000 高分辨率ICP-OES', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('43', null, 'PerkinElmer Optima 8000 等离子体发射光谱仪', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('44', null, 'Plasma 2000 全谱电感耦合等离子光谱仪', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('45', null, 'Prodigy7 等离子体发射光谱仪', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('46', null, '赛默飞 iCAP 7000 系列 ICP-OES', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('47', null, 'ICP发射光谱仪ICPS-8100', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('48', null, '5100 ICP-OES', '7', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('49', null, 'F97系列荧光分光光度计', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('50', null, '同步吸收-三维荧光扫描光谱仪Aqualog®', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('51', null, '爱丁堡一体化稳态瞬态荧光光谱仪FS5', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('52', null, '岛津荧光分光光度计 RF-6000', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('53', null, '超快时间分辨荧光光谱仪DeltaFlex', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('54', null, '荧光分光光度计F-380', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('55', null, '高灵敏一体式荧光光谱仪-FluoroMax-4', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('56', null, 'F96S高速荧光分光光度计', '8', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('57', null, 'SparkCCD 6000 火花直读光谱仪', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('58', null, '德国OBLF GS1000-II型直读光谱仪', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('59', null, '台式直读光谱仪FOUNDRY-MASTER Smart', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('60', null, 'ARL easySpark 全谱直读光谱仪', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('61', null, '岛津光电直读光谱仪 PDA-5000', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('62', null, '火花直读光谱仪1000型', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('63', null, 'M5000 CCD全谱直读光谱仪', '9', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('64', null, '岛津光电发射光谱仪PDA-8000', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('65', null, '聚光科技 SupNIR¬2700系列近红外分析仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('66', null, '海能仪器 Spectrastar2500XL系列近红外光谱仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('67', null, '福斯NIRS DS 2500 多功能近红外分析仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('68', null, '[海洋光学]NIRQUEST近红外光谱仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('69', null, 'VIAVI MicroNIR Pro微型近红外光谱仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('70', null, '瑞士万通_DS 2500 近红外光谱分析仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('71', null, '瑞士万通PRO 近红外在线分析仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('72', null, 'XDS SmartProbe 近红外光谱分析仪', '2', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('73', null, '影像校正光谱仪 OmniEvo180“优雅型”', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('74', null, '193mm焦距高光通量影像校正光栅光谱仪-SR193i', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('75', null, '真空紫外光栅光谱仪', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('76', null, 'iHR320/iHR550成像光谱仪', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('77', null, 'FHR640/FHR1000光谱仪', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('78', null, '紫外可见便携式光谱仪OL756', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('79', null, 'Horiba 多功能成像高分辨光谱仪（iHR550）', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');
INSERT INTO `hardware` VALUES ('80', null, '7IGF10定光栅摄谱仪，光谱仪', '10', '0', '2018-04-14 16:03:10', '2018-03-17 17:41:20');

-- ----------------------------
-- Table structure for maintenance
-- ----------------------------
DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance` (
  `maintenance_id` bigint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '维护编号',
  `maintenance_name` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '维护名称',
  `maintenance_type` tinyint(1) DEFAULT NULL COMMENT '0代表备份  1代表恢复',
  `maintenance_content` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '备份/恢复的内容',
  `maintenance_describe` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '维护/备份的描述',
  `maintenance_file_address` varchar(256) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作是备份时,备份文件的路径(恢复没有)',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`maintenance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统维护表。恢复和备份,备份为0，恢复为1';

-- ----------------------------
-- Records of maintenance
-- ----------------------------

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '光谱分析报告编号',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户编号',
  `spectrum_type_name` varchar(16) NOT NULL COMMENT '光谱类型名',
  `check_time` datetime NOT NULL COMMENT '检测时间',
  `standard_content` varchar(16) NOT NULL COMMENT '标准含量',
  `standards` varchar(4) NOT NULL COMMENT '执行标准',
  `unit` varchar(4) NOT NULL COMMENT '单位',
  `regular` int(2) NOT NULL COMMENT '是否合格，0表示合格，1表示不合格',
  `limit` varchar(2) NOT NULL COMMENT '是否超标',
  `spectruminfo_id` bigint(20) unsigned NOT NULL COMMENT '光谱的主键编号',
  `detected_name` varchar(20) NOT NULL COMMENT '被检测物名字',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`report_id`),
  KEY `fk_report_user_id` (`user_id`),
  KEY `fk_spectruminfo_id` (`spectruminfo_id`),
  CONSTRAINT `fk_report_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_spectruminfo_id` FOREIGN KEY (`spectruminfo_id`) REFERENCES `spectruminfo` (`spectruminfo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='光谱分析报告表';

-- ----------------------------
-- Records of report
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` bigint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(12) NOT NULL COMMENT '角色名',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '普通用户', '2018-01-26 15:20:54', '2018-01-26 15:20:57');
INSERT INTO `role` VALUES ('2', '操作人员', '2018-01-26 15:21:02', '2018-01-26 15:21:05');
INSERT INTO `role` VALUES ('3', '实验人员', '2018-01-26 15:21:08', '2018-01-26 15:21:10');
INSERT INTO `role` VALUES ('4', '普通管理员', '2018-01-26 15:21:12', '2018-01-26 15:21:14');
INSERT INTO `role` VALUES ('5', '超级管理员', '2018-01-26 15:21:17', '2018-01-26 15:21:21');

-- ----------------------------
-- Table structure for role_function
-- ----------------------------
DROP TABLE IF EXISTS `role_function`;
CREATE TABLE `role_function` (
  `role_function_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(2) unsigned NOT NULL COMMENT '角色编号',
  `function_id` bigint(5) unsigned NOT NULL COMMENT '功能编号',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`role_function_id`),
  KEY `fk_role_id` (`role_id`),
  KEY `fk_function_id` (`function_id`),
  CONSTRAINT `fk_function_id` FOREIGN KEY (`function_id`) REFERENCES `function` (`function_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-功能联系表';

-- ----------------------------
-- Records of role_function
-- ----------------------------

-- ----------------------------
-- Table structure for spectruminfo
-- ----------------------------
DROP TABLE IF EXISTS `spectruminfo`;
CREATE TABLE `spectruminfo` (
  `spectruminfo_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `spectrum_version` int(16) NOT NULL COMMENT '光谱版本号（20170101XXXXXXXX）后面为uuid,防止重复',
  `is_standard_spectrum` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为标准光谱（0不是，1是）',
  `spectrum_name` varchar(16) NOT NULL COMMENT '光谱名字',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0代表未删除，1代表在回收站，2代表彻底删除，默认为0',
  `save_time` datetime(6) NOT NULL COMMENT '光谱保存时间',
  `spectrum_description` varchar(128) NOT NULL COMMENT '光谱描述',
  `characteristic_peak` text COMMENT '光谱特征峰值',
  `spectrum_file_url` varchar(255) NOT NULL COMMENT '光谱文件保存地址',
  `category_origin` varchar(32) NOT NULL COMMENT '被检测物产地',
  `detected_id` bigint(20) unsigned NOT NULL COMMENT '被检测物编号(外键)',
  `file_id` bigint(20) unsigned NOT NULL COMMENT '文件夹编号(外键)',
  `hardware_name` varchar(64) DEFAULT NULL COMMENT '硬件名称',
  `spectrum_type_name` varchar(20) NOT NULL COMMENT '光谱类型名称',
  `spectrum_picture_url` varchar(255) DEFAULT NULL COMMENT '光谱图片',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`spectruminfo_id`),
  KEY `fk_detected_id` (`detected_id`),
  KEY `fk_file_id` (`file_id`),
  CONSTRAINT `fk_detected_id` FOREIGN KEY (`detected_id`) REFERENCES `detected_object` (`detected_objects_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_file_id` FOREIGN KEY (`file_id`) REFERENCES `dir` (`dir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='光谱信息表';

-- ----------------------------
-- Records of spectruminfo
-- ----------------------------
INSERT INTO `spectruminfo` VALUES ('1', '213', '0', '光谱一号', '0', '2018-04-15 19:54:24.000000', 'sadsadasdas', 'asd', 'dsa', 'dsadasda', '10101', '4', 'sadasd', '红外光谱', 'dasdasd', '2018-04-15 19:54:50', '2018-04-15 21:08:12');

-- ----------------------------
-- Table structure for spectrum_type
-- ----------------------------
DROP TABLE IF EXISTS `spectrum_type`;
CREATE TABLE `spectrum_type` (
  `spectrumtype_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '光谱类型编号',
  `spectrumtype_name` varchar(16) NOT NULL COMMENT '光谱类型',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`spectrumtype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='光谱类型表';

-- ----------------------------
-- Records of spectrum_type
-- ----------------------------
INSERT INTO `spectrum_type` VALUES ('1', '红外光谱', '2018-04-14 15:57:00', '2018-04-03 15:59:38');
INSERT INTO `spectrum_type` VALUES ('2', '近红外光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('3', '远红外光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('4', '激光拉曼光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('5', '原子荧光光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('6', '原子吸光光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('7', 'ICP-AES原子发射光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('8', '分子荧光光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('9', '光电直读关光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('10', '光栅光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('11', '圆二色光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('12', '辉光放电光谱', '2018-04-14 15:57:00', '2018-04-26 15:59:41');
INSERT INTO `spectrum_type` VALUES ('13', '来了', '2018-04-14 15:57:00', '2018-04-26 15:59:41');

-- ----------------------------
-- Table structure for standard
-- ----------------------------
DROP TABLE IF EXISTS `standard`;
CREATE TABLE `standard` (
  `standard_id` bigint(2) unsigned NOT NULL AUTO_INCREMENT,
  `standard_name` varchar(10) NOT NULL COMMENT '标准名称（国标，欧标）',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`standard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='国际标准表';

-- ----------------------------
-- Records of standard
-- ----------------------------

-- ----------------------------
-- Table structure for standard_spectrum
-- ----------------------------
DROP TABLE IF EXISTS `standard_spectrum`;
CREATE TABLE `standard_spectrum` (
  `standard_spectrum_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `standard_spectrum_version` int(16) NOT NULL COMMENT '标准光谱编号',
  `standard_spectrum_name` varchar(16) NOT NULL COMMENT '光谱名字',
  `save_time` datetime(6) NOT NULL COMMENT '光谱保存时间',
  `spectrum_description` varchar(128) NOT NULL COMMENT '光谱描述',
  `characteristic_peak` text NOT NULL COMMENT '光谱特征峰值',
  `spectrum_file_url` varchar(255) NOT NULL COMMENT '光谱文件保存地址',
  `category_origin` varchar(32) NOT NULL COMMENT '被检测物产地',
  `detected_id` bigint(20) unsigned NOT NULL COMMENT '被检测物编号',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户编号',
  `spectrum_picture_url` varchar(255) NOT NULL COMMENT '光谱图片路径',
  `spectrum_type_name` varchar(20) NOT NULL COMMENT '光谱类型名称',
  `hardware_name` varchar(64) NOT NULL COMMENT '硬件名称',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`standard_spectrum_id`),
  KEY `fk_standard_spectrum_user_id` (`user_id`),
  KEY `fk_standard_spectrum_detected_id` (`detected_id`),
  CONSTRAINT `fk_standard_spectrum_detected_id` FOREIGN KEY (`detected_id`) REFERENCES `detected_object` (`detected_objects_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_standard_spectrum_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准光谱信息表';

-- ----------------------------
-- Records of standard_spectrum
-- ----------------------------

-- ----------------------------
-- Table structure for syslog
-- ----------------------------
DROP TABLE IF EXISTS `syslog`;
CREATE TABLE `syslog` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户编号',
  `ip` varchar(16) NOT NULL COMMENT '用户ip地址',
  `opetate_content` varchar(32) NOT NULL COMMENT '操作具体内容',
  `log_lever` varchar(10) NOT NULL COMMENT '操作级别',
  `function_id` bigint(20) NOT NULL COMMENT '功能编号',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`log_id`)
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8 COMMENT='日志管理';

-- ----------------------------
-- Records of syslog
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(16) NOT NULL COMMENT '用户真实姓名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `salt` varchar(64) DEFAULT NULL COMMENT '进行加密的盐值',
  `idcard` char(18) DEFAULT NULL COMMENT '非普通用户必填，以后不可修改(申请角色是必填)',
  `phone_number` char(11) NOT NULL COMMENT '手机号',
  `email` varchar(32) NOT NULL COMMENT '邮箱（根据邮箱登录）',
  `birthday` date DEFAULT NULL COMMENT '生日(选填)',
  `sex` tinyint(1) NOT NULL COMMENT '1:男，0：女',
  `photo_url` varchar(255) NOT NULL COMMENT '用户头像路径',
  `person_address` varchar(128) DEFAULT NULL COMMENT '个人地址（选填，申请完善）',
  `work_address` varchar(64) DEFAULT NULL COMMENT '工作地址（选填，申请完善）',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '账号状态(正常在线对应1,正常离线对应2,冻结对应0)',
  `role_id` bigint(2) unsigned NOT NULL DEFAULT '1' COMMENT '普通用户对应1 操作人员对应2 实验人员对应3 普通管理员对应4超级管理员对应5',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`user_id`),
  KEY `fk_user_roleId` (`role_id`),
  CONSTRAINT `fk_user_roleId` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'user', '7f7cd15807fa0e4b278181e1f99767a1', 'qwer', '362502201701011234', '15797957730', 'user@qq.com', '2018-01-26', '1', '', '', '', '2', '1', '2018-01-26 15:20:24', '2018-01-26 15:20:26');
INSERT INTO `user` VALUES ('2', 'operator', '7f7cd15807fa0e4b278181e1f99767a1', 'qwer', '362502201701011234', '15797957730', 'operator@qq.com', '2018-01-26', '1', '', '', '', '2', '2', '2018-01-26 15:20:24', '2018-01-26 15:20:26');
INSERT INTO `user` VALUES ('3', 'lab', '7f7cd15807fa0e4b278181e1f99767a1', 'qwer', '362502201701011234', '15797957730', 'lab@qq.com', '2018-01-26', '1', '', '', '', '2', '3', '2018-01-26 15:20:24', '2018-01-26 15:20:26');
INSERT INTO `user` VALUES ('4', 'admin', '7f7cd15807fa0e4b278181e1f99767a1', 'qwer', '362502201701011234', '15797957730', 'admin@qq.com', '2018-01-26', '1', '', '', '', '2', '4', '2018-01-26 15:20:24', '2018-01-26 15:20:26');
INSERT INTO `user` VALUES ('5', 'superadmin', '7f7cd15807fa0e4b278181e1f99767a1', 'qwer', '362502201701011234', '15797957730', 'superadmin@qq.com', '2018-01-26', '1', '', '', '', '2', '5', '2018-01-26 15:20:24', '2018-01-26 15:20:26');

-- ----------------------------
-- Table structure for userdir_mv
-- ----------------------------
DROP TABLE IF EXISTS `userdir_mv`;
CREATE TABLE `userdir_mv` (
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(16) DEFAULT NULL,
  `dir_id` bigint(20) DEFAULT NULL,
  `dir_name` varchar(20) DEFAULT NULL,
  `dir_type_id` tinyint(255) DEFAULT NULL,
  `gmt_create` timestamp NULL DEFAULT NULL,
  `gmt_modified` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表和文件夹表的物化视图表';

-- ----------------------------
-- Records of userdir_mv
-- ----------------------------

-- ----------------------------
-- Event structure for addheardware
-- ----------------------------
DROP EVENT IF EXISTS `addheardware`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `addheardware` ON SCHEDULE AT '2018-04-14 15:03:02' ON COMPLETION NOT PRESERVE ENABLE DO INSERT INTO `spectrumanalysis`.`hardware` (`hardware_id`, `hardware_type`, `hardware_name`, `spectrum_type_id`, `gmt_create`) VALUES ('1', '', 'PerkinElmer 红外光谱仪Spectrum Two', '1', '2017-01-20 13:55:14');
;;
DELIMITER ;

-- ----------------------------
-- Event structure for addSpectrum_type
-- ----------------------------
DROP EVENT IF EXISTS `addSpectrum_type`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `addSpectrum_type` ON SCHEDULE AT '2018-04-14 15:51:29' ON COMPLETION NOT PRESERVE ENABLE DO INSERT INTO `spectrumanalysis`.`spectrum_type` (`spectrumtype_name_id`, `spectrumtype_name`) VALUES ('1', '红外光谱');
;;
DELIMITER ;
