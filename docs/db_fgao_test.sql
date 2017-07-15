/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : db_fgao_test

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-07-15 17:20:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_arrange
-- ----------------------------
DROP TABLE IF EXISTS `t_arrange`;
CREATE TABLE `t_arrange` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '排班表',
  `userId` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `day` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_arrange
-- ----------------------------

-- ----------------------------
-- Table structure for t_bug
-- ----------------------------
DROP TABLE IF EXISTS `t_bug`;
CREATE TABLE `t_bug` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '待办表',
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

-- ----------------------------
-- Table structure for t_bug_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_bug_operation`;
CREATE TABLE `t_bug_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '待办操作记录表',
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

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章的分类',
  `parentId` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_category
-- ----------------------------

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论列表',
  `time` bigint(20) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `goodsId` int(11) NOT NULL,
  `firstComment` text,
  `firstCommentPic` varchar(255) DEFAULT NULL,
  `secondComment` text,
  `secondCommentPic` varchar(255) DEFAULT NULL,
  `timeDes` varchar(255) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------

-- ----------------------------
-- Table structure for t_comment_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_goods`;
CREATE TABLE `t_comment_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论使用的货物列表',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment_goods
-- ----------------------------

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券表',
  `userId` int(11) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `shopName` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `goodsName` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `deadLine` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_coupon
-- ----------------------------
INSERT INTO `t_coupon` VALUES ('7', '1', 'admin', '1500105730168', '告白气球', '店铺优惠券', '', '满400减40', '2017-07-15 16:02:02', '你看', 'http://127.0.0.1:8080/admin/couponList.jsp');
INSERT INTO `t_coupon` VALUES ('8', '1', 'admin', '1500105758270', '告白气球', '商品优惠券', '耳机', '满200减20', '2017-07-15 16:02:31', '你看啊', 'http://127.0.0.1:8080/admin/couponList.jsp');
INSERT INTO `t_coupon` VALUES ('9', '1', 'admin', '1500106576735', '告白气球', '店铺优惠券', '', '满400减40', '2017-07-15 16:02:02', '你看阿斯达嗖嗖嗖', 'http://127.0.0.1:8080/admin/couponList.jsp');

-- ----------------------------
-- Table structure for t_document
-- ----------------------------
DROP TABLE IF EXISTS `t_document`;
CREATE TABLE `t_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章',
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

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '进销存货物',
  `name` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `crisisCount` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods_come
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_come`;
CREATE TABLE `t_goods_come` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '到货记录',
  `inRecordId` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_come
-- ----------------------------

-- ----------------------------
-- Table structure for t_goods_in
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_in`;
CREATE TABLE `t_goods_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '进货记录',
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

-- ----------------------------
-- Table structure for t_goods_out
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_out`;
CREATE TABLE `t_goods_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '出货记录',
  `goodsId` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_goods_out
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '人员表',
  `deptId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `inGoods` int(11) DEFAULT NULL,
  `outGoods` int(11) DEFAULT NULL,
  `coupon` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '1', 'admin', 'admin', 'admin', '15956938336', 'admin', '1', '1', '1', '1');
INSERT INTO `t_user` VALUES ('2', '1', 'zqmao', 'zqmao', 'zqmao', null, null, null, null, '0', '0');

-- ----------------------------
-- Table structure for t_user_category
-- ----------------------------
DROP TABLE IF EXISTS `t_user_category`;
CREATE TABLE `t_user_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '人员权限表',
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_category
-- ----------------------------
