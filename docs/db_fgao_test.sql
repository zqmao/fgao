/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.169
Source Server Version : 50636
Source Host           : 192.168.1.169:3306
Source Database       : db_fgao_test

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-11-18 20:23:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_after_sale_come_record
-- ----------------------------
DROP TABLE IF EXISTS `t_after_sale_come_record`;
CREATE TABLE `t_after_sale_come_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courierNum` varchar(255) NOT NULL,
  `expressName` varchar(255) DEFAULT NULL,
  `shopName` varchar(255) DEFAULT NULL,
  `goodsName` varchar(255) DEFAULT NULL,
  `checkResult` varchar(255) DEFAULT NULL,
  `wangwang` varchar(255) DEFAULT NULL,
  `phoneNum` varchar(255) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `unpackId` int(11) DEFAULT NULL,
  `afterSaTor` varchar(255) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `bounceType` varchar(255) DEFAULT NULL,
  `entryTime` bigint(20) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_after_sale_entry
-- ----------------------------
DROP TABLE IF EXISTS `t_after_sale_entry`;
CREATE TABLE `t_after_sale_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryTime` bigint(20) DEFAULT NULL,
  `entryMan` varchar(255) DEFAULT NULL,
  `expressName` varchar(255) DEFAULT NULL,
  `courierNum` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_bug
-- ----------------------------
DROP TABLE IF EXISTS `t_bug`;
CREATE TABLE `t_bug` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '待办表',
  `category` varchar(255) DEFAULT NULL,
  `title` text,
  `createRemark` text,
  `createTime` bigint(20) DEFAULT NULL,
  `createrId` int(11) DEFAULT NULL,
  `createrName` varchar(255) DEFAULT NULL,
  `finishRemark` varchar(255) DEFAULT NULL,
  `finishTime` bigint(20) DEFAULT NULL,
  `finisherId` int(11) DEFAULT NULL,
  `finisherName` varchar(255) DEFAULT NULL,
  `wangwang` varchar(255) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `currentName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章的分类',
  `parentId` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论列表',
  `time` bigint(20) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `goodsName` varchar(255) NOT NULL,
  `firstComment` text,
  `firstCommentPic` varchar(255) DEFAULT NULL,
  `secondComment` text,
  `secondCommentPic` varchar(255) DEFAULT NULL,
  `timeDes` varchar(255) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `isVerify` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_comment_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_goods`;
CREATE TABLE `t_comment_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论使用的货物列表',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_draw_bill
-- ----------------------------
DROP TABLE IF EXISTS `t_draw_bill`;
CREATE TABLE `t_draw_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creatorId` int(11) DEFAULT NULL,
  `entryTime` bigint(20) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `sum` varchar(255) DEFAULT NULL,
  `shopName` varchar(255) DEFAULT NULL,
  `goodsName` varchar(255) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `billHead` varchar(255) DEFAULT NULL,
  `tfn` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `billRemark` varchar(255) DEFAULT NULL,
  `emailOrPhone` varchar(255) DEFAULT NULL,
  `drawingor` int(11) DEFAULT NULL,
  `billTime` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_export_order_list
-- ----------------------------
DROP TABLE IF EXISTS `t_export_order_list`;
CREATE TABLE `t_export_order_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNum` varchar(255) DEFAULT NULL,
  `wangwang` varchar(255) DEFAULT NULL,
  `alipayNum` varchar(255) DEFAULT NULL,
  `actualMoney` varchar(255) DEFAULT NULL,
  `consigneeName` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phoneNum` varchar(255) DEFAULT NULL,
  `orderCreateTime` varchar(255) DEFAULT NULL,
  `orderTime` varchar(255) DEFAULT NULL,
  `goodsHeadline` varchar(255) DEFAULT NULL,
  `shopName` varchar(255) DEFAULT NULL,
  `exportTime` varchar(255) DEFAULT NULL,
  `exportor` int(11) DEFAULT NULL,
  `courierNum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `INDEX_ORDER_NUM` (`orderNum`) USING HASH,
  KEY `INDEX_COURIER_NUM` (`courierNum`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70979 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_express
-- ----------------------------
DROP TABLE IF EXISTS `t_express`;
CREATE TABLE `t_express` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expressName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_express_reissue
-- ----------------------------
DROP TABLE IF EXISTS `t_express_reissue`;
CREATE TABLE `t_express_reissue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creatorId` int(11) DEFAULT NULL,
  `entryTime` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `shopName` varchar(255) DEFAULT NULL,
  `goodsName` varchar(255) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `wangwang` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `issueDocumentor` int(11) DEFAULT NULL,
  `expressName` varchar(255) DEFAULT NULL,
  `afterSaTor` varchar(255) DEFAULT NULL,
  `courierNum` varchar(255) DEFAULT NULL,
  `issuTime` bigint(20) DEFAULT NULL,
  `issuRemark` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `customer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pre_sale_record
-- ----------------------------
DROP TABLE IF EXISTS `t_pre_sale_record`;
CREATE TABLE `t_pre_sale_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNum` varchar(255) DEFAULT NULL,
  `doneOrderUserId` int(11) DEFAULT NULL,
  `donePayUserId` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `couponQuota` varchar(255) DEFAULT NULL,
  `praiseMoney` varchar(255) DEFAULT NULL,
  `differenceMoney` varchar(255) DEFAULT NULL,
  `importUserId` int(11) DEFAULT NULL,
  `importTime` bigint(20) DEFAULT NULL,
  `returnMoney` varchar(255) DEFAULT NULL,
  `specialExpress` varchar(255) DEFAULT NULL,
  `specialGift` varchar(255) DEFAULT NULL,
  `selfCheckRemark` varchar(255) DEFAULT NULL,
  `selfCheck` int(11) DEFAULT NULL,
  `financeCheckRemark` varchar(255) DEFAULT NULL,
  `financeCheck` int(11) DEFAULT NULL,
  `isVirtual` int(11) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sign_record
-- ----------------------------
DROP TABLE IF EXISTS `t_sign_record`;
CREATE TABLE `t_sign_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `dayTime` varchar(50) DEFAULT NULL COMMENT 'yyyy年MM月dd日',
  `signInTime` bigint(20) DEFAULT NULL,
  `signOutTime` bigint(20) DEFAULT NULL,
  `adminHandle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '人员表',
  `deptId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `incumbency` int(11) DEFAULT NULL COMMENT '1为在职',
  `loginName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `inGoods` int(11) DEFAULT NULL,
  `outGoods` int(11) DEFAULT NULL,
  `coupon` int(11) DEFAULT '0',
  `after` int(11) DEFAULT '0' COMMENT '售后记录表',
  `export` int(11) DEFAULT '0',
  `editor` int(11) DEFAULT NULL,
  `drawBill` int(11) DEFAULT '0' COMMENT '是否有开发票的权限 1有，0无',
  `importPreSale` int(10) unsigned zerofill DEFAULT NULL,
  `finance` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user_category
-- ----------------------------
DROP TABLE IF EXISTS `t_user_category`;
CREATE TABLE `t_user_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '人员权限表',
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
