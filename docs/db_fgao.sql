/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : db_fgao

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-05-03 17:27:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_arrange
-- ----------------------------
DROP TABLE IF EXISTS `t_arrange`;
CREATE TABLE `t_arrange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `day` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_arrange
-- ----------------------------
INSERT INTO `t_arrange` VALUES ('1', '1', '早', '1493654400000');
INSERT INTO `t_arrange` VALUES ('2', '1', '夜', '1493740800000');
INSERT INTO `t_arrange` VALUES ('6', '1', '正', '1493913600000');
INSERT INTO `t_arrange` VALUES ('7', '1', '休', '1493827200000');
INSERT INTO `t_arrange` VALUES ('8', '3', '早', '1493654400000');
INSERT INTO `t_arrange` VALUES ('9', '3', '夜', '1493740800000');
INSERT INTO `t_arrange` VALUES ('10', '3', '休', '1493827200000');
INSERT INTO `t_arrange` VALUES ('11', '3', '正', '1493913600000');
INSERT INTO `t_arrange` VALUES ('12', '2', '早', '1493654400000');
INSERT INTO `t_arrange` VALUES ('13', '2', '夜', '1493740800000');
INSERT INTO `t_arrange` VALUES ('14', '2', '休', '1493827200000');
INSERT INTO `t_arrange` VALUES ('15', '2', '正', '1493913600000');
INSERT INTO `t_arrange` VALUES ('16', '15', '早', '1493654400000');
INSERT INTO `t_arrange` VALUES ('17', '15', '夜', '1493740800000');
INSERT INTO `t_arrange` VALUES ('18', '15', '休', '1493827200000');
INSERT INTO `t_arrange` VALUES ('19', '15', '正', '1493913600000');

-- ----------------------------
-- Table structure for t_bug
-- ----------------------------
DROP TABLE IF EXISTS `t_bug`;
CREATE TABLE `t_bug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `createRemark` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `createrId` int(11) DEFAULT NULL,
  `createrName` varchar(255) DEFAULT NULL,
  `finishRemark` varchar(255) DEFAULT NULL,
  `finishTime` bigint(20) DEFAULT NULL,
  `finisherId` int(11) DEFAULT NULL,
  `finisherName` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `currentName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_bug
-- ----------------------------
INSERT INTO `t_bug` VALUES ('1', '售后', '要培训了', '2.19开始培训少加了一个 1。会使： 2016-05-07变成2016-04-07.\r\n以下是我粗暴方法，实在是粗暴注册用户登录后才能发表评论，请 登录 或 注册，访问网站首页。', '1486126082987', '1', 'admin', '好了，大家没事了', '1486126485262', '1', 'admin', '1', null);
INSERT INTO `t_bug` VALUES ('6', '售后', '路由器售后技术员', '撒打算打算', '1486114830757', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('7', '返现', '路由器售后技术员', '撒打算打算', '1486116071431', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('8', '售后', '阿萨德', '具体内容看通知1', '1486126545845', '2', 'admin2', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('17', '返现', '速度asdasd', '的撒爱的', '1486197165020', '1', 'admin', null, '1486183497917', '1', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('20', '售后', 'asda', 'asdasda', '1486197628011', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('22', '售后', '阿斯达', '阿达撒', '1486197842123', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('24', '售后', '顶顶顶顶顶', '阿斯达', '1486198305176', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('25', '售后', '爱上大声地', '爱上大声地', '1486198747629', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('26', '售后', 'vvv事实上', 'vvvv', '1486198860761', '1', 'admin', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('32', '刷单', 'rrr', 'rrrr', '1486214272826', '2', 'zqmao2', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('33', '售后', '1212饿', '122额2', '1486214281875', '2', 'zqmao2', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('34', '售后', '爱上大声地', '爱上大声地', '1486214413769', '2', 'zqmao2', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('35', '售后', '44', '444', '1486215473025', '2', 'zqmao2', null, '0', '0', '未完成', '0', null);
INSERT INTO `t_bug` VALUES ('36', '售后', '爱上大声地', '啊实打实', '1486215538405', '2', 'zqmao2', null, '0', '8', 'zqmao8', '1', null);
INSERT INTO `t_bug` VALUES ('37', '售后', '你好啊', '你好啊', '1493694474482', '1', 'admin', null, '1493694632668', '1', 'admin', '0', null);
INSERT INTO `t_bug` VALUES ('38', '售后', 'dl耳机', '3想，asdasdad', '1493695937922', '1', 'admin', null, '1493781836766', '1', 'admin', '0', null);

-- ----------------------------
-- Table structure for t_bug_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_bug_operation`;
CREATE TABLE `t_bug_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bugId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `operaterId` int(11) DEFAULT NULL,
  `targetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_bug_operation
-- ----------------------------
INSERT INTO `t_bug_operation` VALUES ('1', '1', 'zsdasda', '11111111111111', '2', '4');
INSERT INTO `t_bug_operation` VALUES ('2', '1', '', '1486126310625', '1', '3');
INSERT INTO `t_bug_operation` VALUES ('3', '1', '阿斯达岁的', '1486126432246', '1', '5');
INSERT INTO `t_bug_operation` VALUES ('4', '9', '', '1486126728604', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('8', '10', '', '1486181205507', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('9', '11', '', '1486181225251', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('10', '12', '', '1486181231062', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('11', '13', '', '1486181236583', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('12', '14', '', '1486181241575', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('13', '15', '', '1486181247838', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('14', '16', '', '1486181254097', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('15', '17', '', '1486181260017', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('16', '17', '', '1486183518274', '1', '5');
INSERT INTO `t_bug_operation` VALUES ('17', '17', '6去完成下', '1486183536581', '1', '6');
INSERT INTO `t_bug_operation` VALUES ('18', '17', '你自己去做', '1486194401126', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('19', '17', '', '1486197172391', '1', '6');
INSERT INTO `t_bug_operation` VALUES ('20', '18', '', '1486197552457', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('21', '19', '', '1486197581308', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('22', '20', '', '1486197628021', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('23', '21', '', '1486197681869', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('24', '22', '', '1486197842134', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('25', '23', '', '1486198295972', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('26', '24', '', '1486198305186', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('27', '25', '', '1486198747641', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('28', '26', '', '1486198772884', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('29', '27', '', '1486198782540', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('30', '24', '撒大声地', '1486199148298', '1', '4');
INSERT INTO `t_bug_operation` VALUES ('31', '25', '阿达', '1486199290325', '1', '3');
INSERT INTO `t_bug_operation` VALUES ('32', '20', '啊大大', '1486199389639', '1', '8');
INSERT INTO `t_bug_operation` VALUES ('33', '22', '阿斯达', '1486199398674', '1', '6');
INSERT INTO `t_bug_operation` VALUES ('34', '28', '', '1486199776721', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('35', '26', '阿达', '1486199793068', '1', '3');
INSERT INTO `t_bug_operation` VALUES ('36', '29', '', '1486199911717', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('37', '30', '', '1486199947020', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('38', '31', '', '1486214109536', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('39', '32', '', '1486214272835', '2', '2');
INSERT INTO `t_bug_operation` VALUES ('40', '33', '', '1486214281897', '2', '2');
INSERT INTO `t_bug_operation` VALUES ('41', '34', '', '1486214413779', '2', '2');
INSERT INTO `t_bug_operation` VALUES ('42', '35', '', '1486215473036', '2', '2');
INSERT INTO `t_bug_operation` VALUES ('43', '36', '', '1486215538422', '2', '2');
INSERT INTO `t_bug_operation` VALUES ('44', '37', '', '1493694474499', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('45', '37', '紧急处理', '1493694612498', '1', '3');
INSERT INTO `t_bug_operation` VALUES ('46', '38', '', '1493695937925', '1', '1');
INSERT INTO `t_bug_operation` VALUES ('47', '38', '', '1493695950672', '1', '3');

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES ('1', '0', 'A');
INSERT INTO `t_category` VALUES ('2', '0', 'B');
INSERT INTO `t_category` VALUES ('3', '0', 'C');
INSERT INTO `t_category` VALUES ('4', '1', 'A1.1');
INSERT INTO `t_category` VALUES ('5', '1', 'A1.2');
INSERT INTO `t_category` VALUES ('6', '4', 'A1.1.1');
INSERT INTO `t_category` VALUES ('7', '4', 'A1.1.2');
INSERT INTO `t_category` VALUES ('8', '2', 'B1.1');
INSERT INTO `t_category` VALUES ('9', '0', 'D');
INSERT INTO `t_category` VALUES ('10', '0', 'EE');
INSERT INTO `t_category` VALUES ('12', '10', 'EE1.1');
INSERT INTO `t_category` VALUES ('13', '10', 'EE1.2');

-- ----------------------------
-- Table structure for t_document
-- ----------------------------
DROP TABLE IF EXISTS `t_document`;
CREATE TABLE `t_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_document
-- ----------------------------
INSERT INTO `t_document` VALUES ('2', '1', '1', '百度百科-爱情', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\n	爱情是人与人之间的<a target=\"_blank\" href=\"http://baike.baidu.com/view/1366814.htm\">强烈</a>的<a target=\"_blank\" href=\"http://baike.baidu.com/subview/101438/5070905.htm\">依恋</a>、亲近、向往，以及无私并且无所不尽其心的情感。它通常是<a target=\"_blank\" href=\"http://baike.baidu.com/subview/54543/8135332.htm\">情</a>与欲的对照，爱情[3]由情爱和性爱两个部分组成，情爱是爱情的灵魂，性爱是爱情的能量，情爱是性爱的先决条件，性爱是情爱的动力，只有如此才能达到至高无上的爱情境界。\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\n	在<a target=\"_blank\" href=\"http://baike.baidu.com/view/681638.htm\">汉文化</a>里，爱就是网住对方的心，具有亲密、<a target=\"_blank\" href=\"http://baike.baidu.com/view/572959.htm\">情欲</a>和承诺、依恋、情感的属性，并且对这种关系的长久性持有信心，也能够与对方分享私生活。在爱的情感基础上，除了爱的<a target=\"_blank\" href=\"http://baike.baidu.com/view/1470740.htm\">跨文化</a>差异，随着时间的推移，关于爱情的观念也发生了很大的变化（在不同的民族文化也发展出不同的特征）。1\n</div>', '1486449278393');
INSERT INTO `t_document` VALUES ('3', '4', '1', '你好', '你好', '1486434901146');
INSERT INTO `t_document` VALUES ('4', '6', '1', '图片链接', '你好啊', '1486434921948');
INSERT INTO `t_document` VALUES ('5', '7', '1', '安卓分享本应用不附带应用信息，显示为空', '<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\n	安卓分享本应用不附带应用信息，显示为空\n</div>\n<div class=\"para\" style=\"font-size:14px;color:#333333;font-family:arial, 宋体, sans-serif;background-color:#FFFFFF;\">\n	<a target=\"_blank\" href=\"http://baike.baidu.com/view/681638.htm\"></a><a target=\"_blank\" href=\"http://baike.baidu.com/view/572959.htm\"></a><a target=\"_blank\" href=\"http://baike.baidu.com/view/1470740.htm\"></a>\n</div>', '1486434973222');
INSERT INTO `t_document` VALUES ('6', '5', '1', '安卓首页无上次登录时间，ios有', '安卓首页无上次登录时间，ios有', '1486434990158');
INSERT INTO `t_document` VALUES ('7', '1', '3', '苏大', '你看到的是美好，还是什么，对于别人来说，也许就是幸福<img src=\"http://127.0.0.1:8080/upload/1486453002748.png\" /><br />', '1486453004473');

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES ('1', 'Dr-20 黑', '300');
INSERT INTO `t_goods` VALUES ('2', 'Dr-20 白', '0');
INSERT INTO `t_goods` VALUES ('3', '索爱-麦-黑', '80');
INSERT INTO `t_goods` VALUES ('5', '索爱-麦-白', '90');
INSERT INTO `t_goods` VALUES ('6', '索爱-麦-蓝', '50');
INSERT INTO `t_goods` VALUES ('7', 'Dr-20 蓝', '0');

-- ----------------------------
-- Table structure for t_goods_come
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_come`;
CREATE TABLE `t_goods_come` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inRecordId` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_come
-- ----------------------------
INSERT INTO `t_goods_come` VALUES ('8', '3', '100', '$(\"#goodsComeGrid\").datagrid(\"reload\");', '1493798124669');
INSERT INTO `t_goods_come` VALUES ('9', '6', '300', '后期了', '1493801930140');
INSERT INTO `t_goods_come` VALUES ('10', '5', '50', '等会的', '1493802075315');
INSERT INTO `t_goods_come` VALUES ('11', '4', '50', '', '1493802416112');
INSERT INTO `t_goods_come` VALUES ('12', '4', '30', '', '1493802474890');

-- ----------------------------
-- Table structure for t_goods_in
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_in`;
CREATE TABLE `t_goods_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsId` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_in
-- ----------------------------
INSERT INTO `t_goods_in` VALUES ('3', '5', '100', '1', '1493795898698', '100');
INSERT INTO `t_goods_in` VALUES ('4', '3', '100', '0', '1493795969813', '100进货索爱-麦-黑');
INSERT INTO `t_goods_in` VALUES ('5', '6', '200', '0', '1493801872555', '索爱-麦-蓝,单号还没下来');
INSERT INTO `t_goods_in` VALUES ('6', '1', '300', '1', '1493801907979', '你好啊');

-- ----------------------------
-- Table structure for t_goods_out
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_out`;
CREATE TABLE `t_goods_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsId` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_out
-- ----------------------------
INSERT INTO `t_goods_out` VALUES ('4', '5', '10', '1493795883875', '10');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `inGoods` int(11) DEFAULT NULL,
  `outGoods` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '1', 'admin', 'admin', 'admin', '15956938334', 'admin', '1', '0', '0');
INSERT INTO `t_user` VALUES ('2', '1', 'zqmao2', 'zqmao2', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('3', '1', 'zqmao3', 'zqmao3', '123456', null, null, '1', '0', '1');
INSERT INTO `t_user` VALUES ('4', '1', 'zqmao4', 'zqmao4', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('5', '1', 'zqmao5', 'zqmao5', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('6', '1', 'zqmao6', 'zqmao6', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('7', '1', 'zqmao7', 'zqmao7', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('9', '1', 'zqmao9', 'zqmao9', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('10', '1', 'zqmao10', 'zqmao10', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('11', '1', 'zqmao11', 'zqmao11', '123456', null, null, '0', '0', '0');
INSERT INTO `t_user` VALUES ('12', '1', 'zqmao12', 'zqmao12', '123456', null, '1', '1', '0', '0');
INSERT INTO `t_user` VALUES ('15', '0', '周慧琴', 'hqzhou', '123456', '18297980795', 'tech', '1', '1', '0');

-- ----------------------------
-- Table structure for t_user_category
-- ----------------------------
DROP TABLE IF EXISTS `t_user_category`;
CREATE TABLE `t_user_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_category
-- ----------------------------
INSERT INTO `t_user_category` VALUES ('2', '1', '2');
INSERT INTO `t_user_category` VALUES ('3', '1', '3');
INSERT INTO `t_user_category` VALUES ('5', '1', '1');
INSERT INTO `t_user_category` VALUES ('6', '4', '4');
INSERT INTO `t_user_category` VALUES ('7', '4', '3');
INSERT INTO `t_user_category` VALUES ('8', '10', '1');
INSERT INTO `t_user_category` VALUES ('9', '9', '1');
