/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50041
Source Host           : localhost:3306
Source Database       : db_fgao

Target Server Type    : MYSQL
Target Server Version : 50041
File Encoding         : 65001

Date: 2017-02-05 20:41:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_bug
-- ----------------------------
DROP TABLE IF EXISTS `t_bug`;
CREATE TABLE `t_bug` (
  `id` int(11) NOT NULL auto_increment,
  `category` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `createRemark` varchar(255) default NULL,
  `createTime` bigint(20) default NULL,
  `createrId` int(11) default NULL,
  `createrName` varchar(255) default NULL,
  `finishRemark` varchar(255) default NULL,
  `finishTime` bigint(20) default NULL,
  `finisherId` int(11) default NULL,
  `finisherName` varchar(255) default NULL,
  `state` int(11) default NULL,
  `currentName` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for t_bug_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_bug_operation`;
CREATE TABLE `t_bug_operation` (
  `id` int(11) NOT NULL auto_increment,
  `bugId` int(11) default NULL,
  `remark` varchar(255) default NULL,
  `time` bigint(20) default NULL,
  `operaterId` int(11) default NULL,
  `targetId` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL auto_increment,
  `parentId` int(11) default NULL,
  `text` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `id` int(11) NOT NULL auto_increment,
  `categoryId` int(11) default NULL,
  `userId` int(11) default NULL,
  `title` varchar(255) default NULL,
  `content` varchar(255) default NULL,
  `time` bigint(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_document
-- ----------------------------
INSERT INTO `t_document` VALUES ('1', '1', '3', 'asd', 'asd', '111111');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL auto_increment,
  `deptId` int(11) default NULL,
  `name` varchar(255) default NULL,
  `loginName` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `info` varchar(255) default NULL,
  `admin` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '1', 'admin', 'admin', 'admin', '15956938334', 'admin', '1');
INSERT INTO `t_user` VALUES ('2', '1', 'zqmao2', 'zqmao2', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('3', '1', 'zqmao3', 'zqmao3', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('4', '1', 'zqmao4', 'zqmao4', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('5', '1', 'zqmao5', 'zqmao5', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('6', '1', 'zqmao6', 'zqmao6', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('7', '1', 'zqmao7', 'zqmao7', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('9', '1', 'zqmao9', 'zqmao9', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('10', '1', 'zqmao10', 'zqmao10', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('11', '1', 'zqmao11', 'zqmao11', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('12', '1', 'zqmao12', 'zqmao12', '123456', null, null, '0');
INSERT INTO `t_user` VALUES ('15', '0', '周慧琴', 'hqzhou', '123456', '18297980795', '我老婆灰常', '0');

-- ----------------------------
-- Table structure for t_user_category
-- ----------------------------
DROP TABLE IF EXISTS `t_user_category`;
CREATE TABLE `t_user_category` (
  `id` int(11) NOT NULL auto_increment,
  `categoryId` int(11) default NULL,
  `userId` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_category
-- ----------------------------
INSERT INTO `t_user_category` VALUES ('2', '1', '2');
INSERT INTO `t_user_category` VALUES ('3', '1', '3');
INSERT INTO `t_user_category` VALUES ('5', '1', '1');
