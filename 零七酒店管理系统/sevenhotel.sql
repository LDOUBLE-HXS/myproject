/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 5.5.62 : Database - sevenhotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sevenhotel` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sevenhotel`;

/*Table structure for table `bank` */

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '银行编号，自增',
  `userId` bigint(20) NOT NULL COMMENT '关联客户id，得到持该卡客户',
  `bankName` varchar(20) NOT NULL COMMENT '银行名',
  `bankCard` bigint(20) NOT NULL COMMENT '银行卡号',
  `bankPassword` varchar(6) NOT NULL COMMENT '支付密码(6位)',
  `balance` decimal(20,2) NOT NULL COMMENT '余额',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `bank` */

insert  into `bank`(`id`,`userId`,`bankName`,`bankCard`,`bankPassword`,`balance`) values 
(1,1,'工商银行',6222081901003332835,'123456',700.00),
(2,2,'农业银行',6228480030820693718,'123456',1446.96),
(3,3,'长沙银行',6223687310877573070,'123456',5230.40),
(4,4,'建设银行',6217002920117016965,'123456',6000.00),
(10,7,'工商银行',6228480030820691234,'123456',2000.00);

/*Table structure for table `checkin` */

DROP TABLE IF EXISTS `checkin`;

CREATE TABLE `checkin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '入住记录编号，自增',
  `orderId` bigint(20) NOT NULL COMMENT '关联订单id',
  `managerId` bigint(20) NOT NULL COMMENT '关联管理员id，办理入住的职工工号',
  `roomId` bigint(20) NOT NULL COMMENT '入住关联房间',
  `checkState` int(2) NOT NULL COMMENT '入住状态(1.入住。2.离店)',
  `editOrderTime` datetime NOT NULL COMMENT '处理入住的时间',
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `managerId` (`managerId`),
  KEY `roomId` (`roomId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `checkin` */

insert  into `checkin`(`id`,`orderId`,`managerId`,`roomId`,`checkState`,`editOrderTime`) values 
(1,25,1,1,2,'2019-06-05 11:09:09'),
(2,27,1,2,2,'2019-06-05 11:09:09'),
(3,28,1,3,2,'2019-06-05 11:09:09'),
(4,37,1,1,2,'2019-06-14 09:55:46'),
(5,56,1,1,2,'2019-06-17 09:33:20'),
(6,57,1,2,2,'2019-06-17 11:12:04'),
(7,61,1,1,2,'2019-06-20 00:32:29'),
(8,62,1,5,1,'2019-06-23 13:34:28'),
(9,63,1,23,1,'2019-06-23 13:34:59');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论编号，自增',
  `orderId` bigint(20) NOT NULL COMMENT '评论的订单',
  `comStar` int(2) NOT NULL COMMENT '评星',
  `comContext` varchar(200) NOT NULL COMMENT '评论内容',
  `comImg` varchar(200) DEFAULT NULL COMMENT '评论图片',
  `comDate` datetime NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `comment` */

insert  into `comment`(`id`,`orderId`,`comStar`,`comContext`,`comImg`,`comDate`) values 
(1,61,4,'dsa','static/customer/images/commentImg/1561260060491_COMM.png','2019-06-23 11:08:41'),
(3,63,5,'asd','static/customer/images/commentImg/1561269204118_COMM.jpg','2019-06-23 13:39:28');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户主键id,自增',
  `userCode` varchar(12) NOT NULL COMMENT '用户登陆使用的账号，设置唯一性，不可重复',
  `userName` varchar(10) NOT NULL COMMENT '用户真实姓名',
  `userPassword` varchar(18) NOT NULL COMMENT '登陆密码(6-18位)',
  `userPhone` varchar(11) NOT NULL COMMENT '用户电话(11位)，便于酒店联系',
  `userCard` varchar(18) NOT NULL COMMENT '身份证号码(15或18位)，用于实名制',
  `creationDate` datetime NOT NULL COMMENT '创建时间(截取用户提交注册成功后时间)',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '更新者(管理员更新id)',
  `modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
  `userMemberId` bigint(20) NOT NULL COMMENT '用户等级(取自用户类型表-类型id)，默认普通用户',
  `integral` bigint(20) DEFAULT NULL COMMENT '会员所有积分，默认为0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userCode` (`userCode`) COMMENT '登陆账号唯一性',
  KEY `userMemberId` (`userMemberId`),
  KEY `modifyBy` (`modifyBy`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`id`,`userCode`,`userName`,`userPassword`,`userPhone`,`userCard`,`creationDate`,`modifyBy`,`modifyDate`,`userMemberId`,`integral`) values 
(1,'yangguo','杨过','000000','13388886623','430482199802110111','2019-01-02 10:43:57',1,'2019-05-30 19:11:12',2,2950),
(2,'dengchao','邓超','0000000','13689674534','430482199802110222','2019-03-01 10:44:58',NULL,NULL,2,1902),
(3,'zhangchen','张晨','0000000','18098765434','430482199802110333','2019-03-01 10:45:46',NULL,NULL,3,1244),
(4,'sunlei','孙磊','0000000','13387676765','430482199802110999','2019-03-01 10:46:26',NULL,NULL,4,2000),
(5,'xiaoming','小明','1324567','13574799981','430482199902180121','2019-05-16 16:56:06',NULL,NULL,1,0),
(7,'xiaohong','小红','000000','13574799988','430482199902181234','2019-05-17 12:41:51',NULL,NULL,1,0),
(8,'xiaozi','小资','123456','13388886611','430482199902181233','2019-05-25 22:47:11',NULL,NULL,1,0),
(9,'zhaoziyi','赵子乙','000000','13388886624','430482199802110112','2019-06-06 20:56:29',NULL,NULL,1,0),
(10,'zhaoxinshan','赵蕊珊','000000','13388886625','430482199802110113','2019-06-06 20:56:53',NULL,NULL,1,0),
(11,'zhaoyiwen','赵溢纹','000000','13388886626','430482199802110116','2019-06-06 20:57:22',NULL,NULL,1,0),
(12,'zhaojiyun','赵纪钧','000000','13388886627','430482199802110117','2019-06-06 20:57:51',NULL,NULL,1,0),
(13,'zhaoyining','赵怡凝','000000','13388886628','430482199802110118','2019-06-06 20:58:13',NULL,NULL,1,0),
(14,'zzy','赵钊泳','000000','13388886620','430482199802110120','2019-06-06 20:58:51',NULL,NULL,1,0),
(15,'qy','钱扬','000000','13388886644','430482199802110144','2019-06-06 21:00:54',NULL,NULL,1,0),
(16,'qyx','钱元祥','000000','13388886645','430482199802110145','2019-06-06 21:01:10',NULL,NULL,1,0),
(17,'qrf','钱瑞芬','000000','13388886646','430482199802110146','2019-06-06 21:01:26',NULL,NULL,1,0),
(18,'qaj','钱爱军','000000','13388886647','430482199802110147','2019-06-06 21:01:40',NULL,NULL,1,0);

/*Table structure for table `manager` */

DROP TABLE IF EXISTS `manager`;

CREATE TABLE `manager` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '人员主键id,自增',
  `manCode` varchar(12) NOT NULL COMMENT '管理员登陆使用的工号，设置唯一性，不可重复',
  `manName` varchar(5) NOT NULL COMMENT '管理员真实姓名',
  `manPassword` varchar(12) NOT NULL COMMENT '登陆密码(6-12位)',
  `manPhone` varchar(11) NOT NULL COMMENT '管理员电话(11位)',
  `manSex` int(2) NOT NULL COMMENT '职工性别（1:女、 2:男）',
  `workPicPath` varchar(200) NOT NULL COMMENT '上传个人工作证件照存储路径',
  `creationDate` datetime NOT NULL COMMENT '创建时间(截取上岗成功入职后时间)',
  `positionId` bigint(20) NOT NULL COMMENT '职位(取自职位表-类型id)',
  `manState` int(2) NOT NULL COMMENT '上岗状态(1.在职2.离职)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `manCode` (`manCode`) COMMENT '唯一性',
  KEY `positionId` (`positionId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `manager` */

insert  into `manager`(`id`,`manCode`,`manName`,`manPassword`,`manPhone`,`manSex`,`workPicPath`,`creationDate`,`positionId`,`manState`) values 
(1,'admin','系统管理员','1234567','13511111111',2,'static/admin/images/workPic/1560821432987_WORK.jpg','2017-10-01 10:25:08',1,1),
(2,'liming','李明','0000000','13688889999',2,'static/admin/images/workPic/1560821432988_WORK.jpg','2018-12-08 10:27:51',2,1),
(3,'hanlubiao','韩路彪','0000000','18567542321',2,'static/admin/images/workPic/1560821432989_WORK.jpg','2018-12-28 10:33:42',3,1),
(4,'zhanghua','张华','0000000','13544561111',2,'static/admin/images/workPic/1560821432990_WORK.jpg','2018-12-29 10:34:22',4,1),
(5,'zhaoyan','赵燕','0000000','18098764545',1,'static/admin/images/workPic/1560821432991_WORK.jpg','2019-01-01 10:35:17',5,1),
(6,'zhaomin','赵敏','0000000','18099897657',1,'static/admin/images/workPic/1560821432992_WORK.jpg','2019-02-01 10:36:07',6,1),
(7,'zhaohua','兆华','0000000','18099897665',2,'static/admin/images/workPic/1560821432993_WORK.jpg','2018-12-01 15:08:42',5,2);

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类型主键id,自增',
  `memberType` varchar(15) NOT NULL COMMENT '用户类型，设置唯一性(会员优惠制)',
  `discount` decimal(20,2) DEFAULT NULL COMMENT '优惠折扣',
  `memberPrice` decimal(20,2) DEFAULT NULL COMMENT '会员卡价格',
  `createdBy` bigint(20) NOT NULL COMMENT '创建者(由管理者设立优惠)',
  `creationDate` datetime NOT NULL COMMENT '创建时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '修改者',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `memberType` (`memberType`) COMMENT '设置唯一性',
  KEY `createdBy` (`createdBy`),
  KEY `modifyBy` (`modifyBy`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `member` */

insert  into `member`(`id`,`memberType`,`discount`,`memberPrice`,`createdBy`,`creationDate`,`modifyBy`,`modifyDate`) values 
(1,'普通用户',1.00,0.00,2,'2019-02-01 10:38:15',1,'2019-06-10 17:09:41'),
(2,'白银会员',0.90,300.00,2,'2019-02-01 10:38:54',NULL,NULL),
(3,'黄金会员',0.85,500.00,2,'2019-02-01 10:40:27',NULL,NULL),
(4,'铂金会员',0.80,800.00,2,'2019-02-01 10:41:21',NULL,NULL),
(6,'钻石会员',0.75,1000.00,1,'2019-06-10 17:12:21',NULL,NULL);

/*Table structure for table `memberorder` */

DROP TABLE IF EXISTS `memberorder`;

CREATE TABLE `memberorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '会员卡订单id',
  `memberId` bigint(20) NOT NULL COMMENT '会员卡id',
  `customerId` bigint(20) NOT NULL COMMENT '订购会员卡的酒店用户',
  `orderTime` datetime NOT NULL COMMENT '订购下单的时间',
  `orderPrice` decimal(20,2) NOT NULL COMMENT '下单价格',
  PRIMARY KEY (`id`),
  KEY `memberId` (`memberId`),
  KEY `customerId` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `memberorder` */

insert  into `memberorder`(`id`,`memberId`,`customerId`,`orderTime`,`orderPrice`) values 
(1,3,1,'2019-06-19 11:18:36',500.00),
(2,2,1,'2019-06-19 11:18:36',300.00),
(3,2,1,'2019-06-19 11:18:36',300.00),
(4,3,1,'2019-06-19 11:21:42',500.00),
(5,2,1,'2019-06-19 11:25:27',300.00);

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单编号，自增',
  `roomTypeId` bigint(20) NOT NULL COMMENT '关联房间类型',
  `userId` bigint(20) NOT NULL COMMENT '关联客户id，得到客户信息、订房折扣',
  `checkInTime` datetime NOT NULL COMMENT '订房时间',
  `checkOutTime` datetime NOT NULL COMMENT '退房时间',
  `orderTime` datetime NOT NULL COMMENT '下单时间',
  `orderRoomNum` int(2) NOT NULL COMMENT '订单下单的房间数',
  `orderState` int(2) NOT NULL COMMENT '订单状态(1:已付款。2：未付款。3：订单过期。4：退单)',
  `settlement` decimal(20,2) NOT NULL COMMENT '结算金额',
  `orderDesc` varchar(200) DEFAULT NULL COMMENT '顾客留言备注',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `roomTypeId` (`roomTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

/*Data for the table `order` */

insert  into `order`(`id`,`roomTypeId`,`userId`,`checkInTime`,`checkOutTime`,`orderTime`,`orderRoomNum`,`orderState`,`settlement`,`orderDesc`) values 
(26,1,1,'2019-06-05 14:00:00','2019-06-06 12:00:00','2019-06-05 16:16:15',2,4,128.00,'dsasdas'),
(27,1,1,'2019-06-05 14:00:00','2019-06-06 12:00:00','2019-06-05 16:16:26',2,1,128.00,''),
(28,2,1,'2019-06-05 14:00:00','2019-06-06 12:00:00','2019-06-05 16:18:01',2,1,128.00,''),
(29,1,1,'2019-06-08 14:00:00','2019-06-09 12:00:00','2019-06-08 12:56:33',2,3,128.00,''),
(30,7,3,'2019-04-01 11:36:26','2019-04-02 11:36:30','2019-03-31 11:36:36',2,3,388.00,''),
(31,1,1,'2019-06-12 14:00:00','2019-06-13 12:00:00','2019-06-12 19:49:35',1,3,128.00,'给我一个靠南的房间'),
(32,1,2,'2019-06-11 14:00:00','2019-06-12 12:00:00','2019-06-11 20:16:41',1,3,128.00,'晚点来'),
(33,1,3,'2019-06-12 14:00:00','2019-06-14 12:00:00','2019-06-12 20:18:50',1,4,256.00,''),
(34,1,1,'2019-06-13 14:00:00','2019-06-15 12:00:00','2019-06-13 19:22:45',1,4,512.00,'靠窗，谢谢'),
(35,1,1,'2019-06-13 14:00:00','2019-06-14 12:00:00','2019-06-13 19:25:23',1,4,256.00,''),
(36,1,1,'2019-06-13 14:00:00','2019-06-14 12:00:00','2019-06-13 19:26:43',1,4,256.00,''),
(37,1,1,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 09:41:51',1,1,128.00,'asdasd'),
(38,1,2,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 10:55:58',1,4,345.60,''),
(40,1,2,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 11:07:18',2,4,230.40,''),
(41,3,2,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 11:09:48',2,3,572.40,''),
(42,1,2,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 11:22:33',2,3,230.40,''),
(43,1,2,'2019-06-14 14:00:00','2019-06-15 12:00:00','2019-06-14 11:28:01',1,3,115.20,''),
(44,6,2,'2019-06-15 14:00:00','2019-06-16 12:00:00','2019-06-15 10:54:54',1,3,370.80,''),
(47,1,2,'2019-06-15 14:00:00','2019-06-16 12:00:00','2019-06-15 17:11:48',1,2,115.20,''),
(53,1,2,'2019-06-16 14:00:00','2019-06-17 12:00:00','2019-06-16 22:21:23',1,1,115.20,''),
(54,1,2,'2019-06-16 14:00:00','2019-06-17 12:00:00','2019-06-16 22:22:14',1,1,115.20,''),
(55,1,1,'2019-06-17 14:00:00','2019-06-18 12:00:00','2019-06-17 09:29:00',1,4,128.00,''),
(57,1,1,'2019-06-17 14:00:00','2019-06-18 12:00:00','2019-06-17 11:06:42',1,1,128.00,''),
(59,1,1,'2019-06-19 14:00:00','2019-06-20 12:00:00','2019-06-19 23:48:06',1,1,128.00,''),
(61,1,1,'2019-06-20 14:00:00','2019-06-21 12:00:00','2019-06-20 00:32:29',1,1,115.20,'');

/*Table structure for table `position` */

DROP TABLE IF EXISTS `position`;

CREATE TABLE `position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色主键id,自增',
  `positionType` varchar(15) NOT NULL COMMENT '职位类型，设置唯一性',
  `salary` decimal(20,2) NOT NULL COMMENT '每月薪水',
  `positionDesc` varchar(200) DEFAULT NULL COMMENT '职位描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `positionType` (`positionType`) COMMENT '唯一性'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `position` */

insert  into `position`(`id`,`positionType`,`salary`,`positionDesc`) values 
(1,'系统管理员',0.00,'项目维修'),
(2,'总经理',5000.00,'最高级管理员'),
(3,'副总经理',3500.00,'分管大部分工作'),
(4,'部门经理',3000.00,'掌管人事，财务，可裁员和查看酒店财务报表'),
(5,'前台',2500.00,'服务客户，管理客户需求'),
(6,'保洁',2000.00,'负责酒店房间清理');

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '房间主键id,自增',
  `roomCode` varchar(20) NOT NULL COMMENT '客房编号',
  `roomFloor` varchar(4) NOT NULL COMMENT '客房楼层',
  `roomState` int(2) NOT NULL COMMENT '客房状态(1:可用。2:维修。)',
  `roomTypeId` bigint(20) DEFAULT NULL COMMENT '关联客房种类id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roomCode` (`roomCode`) COMMENT '唯一性',
  KEY `roomTypeId` (`roomTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `room` */

insert  into `room`(`id`,`roomCode`,`roomFloor`,`roomState`,`roomTypeId`) values 
(1,'501','五楼',1,1),
(2,'502','五楼',1,1),
(3,'503','五楼',1,2),
(4,'504','五楼',1,2),
(5,'505','五楼',1,3),
(6,'506','五楼',1,4),
(7,'507','五楼',1,5),
(8,'508','五楼',1,5),
(9,'509','五楼',1,6),
(10,'510','五楼',1,7),
(11,'601','六楼',1,1),
(12,'602','六楼',1,1),
(13,'603','六楼',1,2),
(14,'604','六楼',1,2),
(15,'605','六楼',1,3),
(16,'606','六楼',1,4),
(17,'607','六楼',1,5),
(18,'608','六楼',1,5),
(19,'609','六楼',1,6),
(20,'610','六楼',1,7),
(21,'703','七楼',1,2),
(22,'704','七楼',1,2),
(23,'705','七楼',1,3),
(24,'706','七楼',1,4),
(25,'707','七楼',1,5),
(26,'708','七楼',1,5),
(27,'709','七楼',1,6),
(28,'710','七楼',1,7),
(29,'701','七楼',1,1),
(30,'702','七楼',1,1),
(31,'801','八楼',1,1),
(32,'802','八楼',1,1),
(33,'803','八楼',1,2),
(34,'804','八楼',1,2),
(35,'805','八楼',1,3),
(36,'806','八楼',1,4),
(37,'807','八楼',1,5),
(38,'808','八楼',1,5),
(39,'809','八楼',1,6),
(40,'810','八楼',1,7);

/*Table structure for table `roomtype` */

DROP TABLE IF EXISTS `roomtype`;

CREATE TABLE `roomtype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '房间类型主键id,自增',
  `roomTypeName` varchar(20) NOT NULL COMMENT '房间类型名',
  `roomImg` varchar(200) DEFAULT NULL COMMENT '房间类型的图片路径',
  `sketch` varchar(50) DEFAULT NULL COMMENT '简述房间类型',
  `describe` varchar(1000) NOT NULL COMMENT '房间类型详情描述，如可住人数，房间特点',
  `typePrice` decimal(20,2) DEFAULT NULL COMMENT '房价',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roomTypeName` (`roomTypeName`) COMMENT '唯一性'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `roomtype` */

insert  into `roomtype`(`id`,`roomTypeName`,`roomImg`,`sketch`,`describe`,`typePrice`) values 
(1,'标准单人间','static/admin/images/room/1560821432987_ROOM.jpg','一个人的旅行','1.9米大床，名牌床垫，让您得到更舒适的睡眠；独立冷暖空调，制冷制热、想多少度，都是您说了算；床头电话带多功能手机充电线，适配：苹果5--8、安卓小口、安卓宽口，特种充电头请自带充电器，我们配备了220市电插座；超大屏液晶电视，可看各卫视、中央体育、中央新闻、电影频道、多达几十个直播频道，更有网络在线，各种大片、新片、经典老片随心所欲；单人懒人沙发，避免了卧床看电视的疲劳感；简洁的写作办公台，配备免费高速有线网络，让您的旅途更安心；衣柜里配有浴袍、一次性拖鞋、亮鞋搽都是免费使用的。',128.00),
(2,'标准双人间','static/admin/images/room/1560821432911_ROOM.jpg','两个人的旅行','1.8米双人床，名牌床垫，让您得到更舒适的睡眠；独立冷暖空调，制冷制热、想多少度，都是您说了算；床头电话带多功能手机充电线，适配：苹果5--8、安卓小口、安卓宽口，特种充电头请自带充电器，我们配备了220市电插座；超大屏液晶电视，可看各卫视、中央体育、中央新闻、电影频道、多达几十个直播频道，更有网络在线，各种大片、新片、经典老片随心所欲；单人懒人沙发，避免了卧床看电视的疲劳感；简洁的写作办公台，配备免费高速有线网络，让您的旅途更安心；衣柜里配有浴袍、一次性拖鞋、亮鞋搽都是免费使用的。',218.00),
(3,'豪华单人间','static/admin/images/room/1560821432922_ROOM.jpg','舒适的单人世界','豪华单人间采用明清建筑的豪宅风格，配置1.8米豪华大床，选用顶级舒适的床上用品、拥有最豪华的布艺、家具和设施，以浓重而不失活泼的色调、奔放且大气的布局、近似自然优美的线条，营造豪华舒适、至尊至贵的假日体验。每一间单人间均搭配深色木质家具，配备高级独立卫生间、24小时热水，干净舒适，一台42寸的液晶电视，隔音防噪，冷暖空调，清爽宜人。',318.00),
(4,'豪华双人间','static/admin/images/room/1560821432933_ROOM.jpg','舒适的双人世界','豪华单人间采用明清建筑的豪宅风格，配置1.8米双人豪华大床，选用顶级舒适的床上用品、拥有最豪华的布艺、家具和设施，以浓重而不失活泼的色调、奔放且大气的布局、近似自然优美的线条，营造豪华舒适、至尊至贵的假日体验。每一间单人间均搭配深色木质家具，配备高级独立卫生间、24小时热水，干净舒适，一台42寸的液晶电视，隔音防噪，冷暖空调，清爽宜人。',458.00),
(5,'豪华商务间','static/admin/images/room/1560821432944_ROOM.jpg','外出工作的优选','每一间大约60到70平米，整间套房分为主卧和客厅两大空间，均配置独立高级卫生间。豪华套房设有超宽敞开放式私人阳台，让整个空间始终能够得到充足的自然光线。整个套房空间均保持着明清建筑的豪宅风格，搭配深色木质家具，既奢华却不庸俗，雅致却不失高贵。客厅背景墙面采用高档定制壁纸独一无二，工艺玻璃的修饰更增加了整个空间的格调，墙上挂着一台50寸的液晶电视，木质沙发，柔软舒适，客厅的一角更是独树一帜的设计为泡茶功能区，集商务休闲等功能于一体。',1012.00),
(6,'情侣套房','static/admin/images/room/1560821432955_ROOM.jpg','你和我的世界','便宜的价格，每一间大约60到70平米，整间套房分为主卧和客厅两大空间，均配置独立高级卫生间。豪华套房设有超宽敞开放式私人阳台，让整个空间始终能够得到充足的自然光线。整个套房空间均保持着明清建筑的豪宅风格，搭配深色木质家具，既奢华却不庸俗，雅致却不失高贵。客厅背景墙面采用高档定制壁纸独一无二，工艺玻璃的修饰更增加了整个空间的格调，墙上挂着一台50寸的液晶电视，木质沙发，柔软舒适，客厅的一角更是独树一帜的设计为泡茶功能区，集商务休闲等功能于一体。',412.00),
(7,'家庭套房','static/admin/images/room/1560821432966_ROOM.jpg','温馨的旅行之家','经典两居室设计，巧妙实用，功能齐全，主卧大凸窗，窗外美景尽收眼底，明厨明卫设计，自然通风采光，开启健康生活。',508.00);

/*Table structure for table `storehouse` */

DROP TABLE IF EXISTS `storehouse`;

CREATE TABLE `storehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物品编号，自增',
  `storeName` varchar(20) NOT NULL COMMENT '物品名称',
  `storeTypeId` bigint(20) NOT NULL COMMENT '物品类别，关联仓库类型别',
  `storePriceIn` decimal(20,2) NOT NULL COMMENT '购入价',
  `storePriceOut` decimal(20,2) NOT NULL COMMENT '出售价',
  `stock` bigint(20) DEFAULT NULL COMMENT '库存',
  `createBy` bigint(20) NOT NULL COMMENT '入库人',
  `creationDate` datetime NOT NULL COMMENT '入库时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `storeTypeId` (`storeTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `storehouse` */

insert  into `storehouse`(`id`,`storeName`,`storeTypeId`,`storePriceIn`,`storePriceOut`,`stock`,`createBy`,`creationDate`,`modifyBy`,`modifyDate`) values 
(1,'怡宝',1,1.50,2.00,50,1,'2019-03-01 19:52:35',NULL,NULL),
(2,'可乐',1,2.50,3.00,50,1,'2019-03-01 19:53:03',NULL,NULL),
(3,'三明治',2,4.00,5.00,50,1,'2019-03-15 19:53:57',NULL,NULL),
(4,'方便面',2,4.00,5.00,50,1,'2019-03-01 19:54:43',NULL,NULL),
(5,'一次性牙刷+牙膏',3,6.00,7.00,50,1,'2019-03-01 19:55:25',NULL,NULL),
(6,'一次性毛巾',3,3.00,4.00,50,1,'2019-03-01 19:56:01',NULL,NULL);

/*Table structure for table `storeorder` */

DROP TABLE IF EXISTS `storeorder`;

CREATE TABLE `storeorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品下单编号',
  `customerId` bigint(20) NOT NULL COMMENT '下单人',
  `storeId` bigint(20) NOT NULL COMMENT '商品id',
  `storeNum` int(20) DEFAULT NULL COMMENT '下单商品数量',
  `orderTime` datetime DEFAULT NULL COMMENT '下单时间',
  `totalPrice` decimal(20,2) DEFAULT NULL COMMENT '结算金额',
  PRIMARY KEY (`id`),
  KEY `customerId` (`customerId`),
  KEY `storeId` (`storeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `storeorder` */

/*Table structure for table `storetype` */

DROP TABLE IF EXISTS `storetype`;

CREATE TABLE `storetype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类型编号，自增',
  `typeName` varchar(20) NOT NULL COMMENT '类别名',
  `createBy` bigint(20) NOT NULL COMMENT '创建者',
  `creationDate` datetime NOT NULL COMMENT '创建时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '修改者',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `typeName` (`typeName`) COMMENT '唯一'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `storetype` */

insert  into `storetype`(`id`,`typeName`,`createBy`,`creationDate`,`modifyBy`,`modifyDate`) values 
(1,'饮品',1,'2019-02-01 19:51:18',NULL,NULL),
(2,'食品',1,'2019-02-01 19:51:35',NULL,NULL),
(3,'生活用品',1,'2019-02-01 19:51:43',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
