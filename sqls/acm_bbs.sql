/*
 Navicat Premium Data Transfer

 Source Server         : company_localhsot_root
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : acm_bbs

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 15/01/2019 09:41:14
*/
CREATE DATABASE /*!32312 IF NOT EXISTS*/`acm_bbs` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `acm_bbs`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(8) NOT NULL,
  `account` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `topic_id` int(8) NOT NULL COMMENT '主题帖的id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复的内容',
  `reply_time` datetime(0) NOT NULL COMMENT '回复的时间',
  `user_id` int(8) NOT NULL COMMENT 'userid为该帖子是谁发的',
  `puser_id` int(8) NULL DEFAULT NULL COMMENT '被回复的人的id， 只有当该帖子是引用别人的才有',
  `arefid` int(8) NULL DEFAULT NULL COMMENT '如果该条帖子为引用别人的话，则不为空，并且显示被引用的回复的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, 1, '<p>test</p>', '2017-06-10 10:59:54', 2, 1, NULL);
INSERT INTO `article` VALUES (2, 1, '<p>test</p>', '2017-06-10 11:00:55', 1, 2, 1);
INSERT INTO `article` VALUES (3, 2, '<p>test</p>', '2017-06-28 11:02:24', 3, 2, NULL);
INSERT INTO `article` VALUES (4, 1, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0002.gif\"/></p>', '2017-06-13 14:36:22', 1, 1, NULL);
INSERT INTO `article` VALUES (5, 1, '<p>在此写上您的回帖</p>', '2017-06-13 14:38:01', 1, 1, NULL);
INSERT INTO `article` VALUES (6, 1, '<p>在此写上您的回帖</p>', '2017-06-13 14:49:32', 1, 1, NULL);
INSERT INTO `article` VALUES (7, 1, '<p>在此写上您的回帖sfgsd</p>', '2017-06-13 14:50:57', 1, 1, NULL);
INSERT INTO `article` VALUES (8, 1, '<p>在此写上您的回帖hhh</p>', '2017-06-13 14:54:55', 1, 1, NULL);
INSERT INTO `article` VALUES (9, 1, '<p>在此写上您的回帖</p>', '2017-06-13 14:58:54', 5, 1, 8);
INSERT INTO `article` VALUES (10, 1, '<p>这是我的回帖<img src=\"http://localhost:8080/umeditor/jsp/upload/20170613/64251497359650753.png\" style=\"width: 652.4px; height: 164.4px;\"/><img src=\"http://img.baidu.com/hi/tsj/t_0003.gif\"/></p>', '2017-06-13 21:14:55', 1, 1, NULL);
INSERT INTO `article` VALUES (11, 2, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/face/i_f18.gif\"/></p>', '2017-06-15 10:27:50', 1, 1, NULL);
INSERT INTO `article` VALUES (12, 6, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/face/i_f14.gif\"/></p>', '2017-06-15 10:45:26', 1, 1, NULL);
INSERT INTO `article` VALUES (13, 6, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0026.gif\"/></p>', '2017-06-15 10:45:58', 1, 1, NULL);
INSERT INTO `article` VALUES (14, 5, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0014.gif\"/></p>', '2017-06-15 10:48:36', 1, 1, NULL);
INSERT INTO `article` VALUES (15, 1, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/bobo/B_0015.gif\"/><img src=\"http://localhost:8080/umeditor/jsp/upload/20170615/85481497500764167.png\"/></p>', '2017-06-15 12:26:06', 1, 1, NULL);
INSERT INTO `article` VALUES (16, 5, '<p style=\"text-align: left;\">在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0002.gif\"/><img src=\"http://localhost:8080/umeditor/jsp/upload/20170616/26781497600431431.png\"/><span class=\"mathquill-embedded-latex\" style=\"width: 24px; height: 33px;\">x^{ }</span></p>', '2017-06-16 16:08:38', 1, 1, NULL);
INSERT INTO `article` VALUES (17, 1, '<p>大家早上好，明天就考试了呢！<img src=\"http://img.baidu.com/hi/bobo/B_0006.gif\"/></p>', '2017-06-18 09:40:12', 5, 1, 15);
INSERT INTO `article` VALUES (18, 6, '<p>test</p>', '2017-06-18 10:15:23', 1, 1, 13);
INSERT INTO `article` VALUES (19, 6, '<p>&nbsp; Hello</p>', '2017-06-18 10:19:54', 1, 1, NULL);
INSERT INTO `article` VALUES (20, 6, '<p>你好啊，一楼</p>', '2017-06-18 11:00:49', 1, 1, 12);
INSERT INTO `article` VALUES (21, 6, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/face/i_f29.gif\"/></p>', '2017-06-18 11:08:59', 1, 1, 20);
INSERT INTO `article` VALUES (22, 3, '<p>在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0069.gif\"/></p>', '2017-06-18 12:08:38', 3, 3, NULL);
INSERT INTO `article` VALUES (23, 1, '&nbsp; &nbsp; &nbsp; &nbsp; Hello<img src=\"http://img.baidu.com/hi/jx2/j_0013.gif\"/><p><br/></p>', '2017-06-18 17:04:22', 1, 2, 1);
INSERT INTO `article` VALUES (24, 1, '<p><img src=\"http://localhost:8080/umeditor/jsp/upload/20170618/21841497776701354.png\" style=\"width: 448.4px; height: 213.4px;\"/></p><p>这个不错</p>', '2017-06-18 17:05:42', 1, 1, NULL);
INSERT INTO `article` VALUES (25, 5, '。。。。<img src=\"http://localhost:8080/umeditor/jsp/upload/20170618/98751497778168424.jpg\" width=\"886\" height=\"435\"/><p><br/></p>', '2017-06-18 17:29:36', 1, 1, NULL);
INSERT INTO `article` VALUES (26, 5, '<img src=\"http://localhost:8080/umeditor/jsp/upload/20170618/40371497778647806.png\"/><p><br/></p>', '2017-06-18 17:37:29', 1, 1, NULL);
INSERT INTO `article` VALUES (27, 5, '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br/></p><p></p>', '2017-06-18 17:44:06', 1, 1, NULL);
INSERT INTO `article` VALUES (28, 10, '<img src=\"http://img.baidu.com/hi/jx2/j_0067.gif\"/><p>你们好</p><p><img src=\"http://localhost:8080/umeditor/jsp/upload/20170620/81441497953824484.png\"/></p><p></p>', '2017-06-20 18:17:08', 9, 9, NULL);
INSERT INTO `article` VALUES (29, 10, '<p>sssssss<br/></p>', '2017-06-20 18:17:50', 9, 9, 28);
INSERT INTO `article` VALUES (30, 10, 'hhhh<img src=\"http://img.baidu.com/hi/jx2/j_0058.gif\"/><p><img src=\"http://localhost:8080/umeditor/jsp/upload/20170621/75931498030185101.png\"/></p>', '2017-06-21 15:29:48', 10, 9, NULL);
INSERT INTO `article` VALUES (31, 6, 'sfsfds<img src=\"http://img.baidu.com/hi/jx2/j_0025.gif\"/><p><br/></p>', '2017-06-21 15:30:19', 10, 1, 19);
INSERT INTO `article` VALUES (32, 12, '<img src=\"http://www.yc5301.cn:8888/umeditor/jsp/upload/20170806/12401501981604981.jpg\"/><p><br/></p>', '2017-08-06 09:06:51', 11, 11, NULL);
INSERT INTO `article` VALUES (33, 12, '<p>test</p>', '2017-08-06 09:07:11', 11, 11, NULL);
INSERT INTO `article` VALUES (34, 12, '<p>test</p>', '2017-08-06 09:07:28', 11, 11, 33);
INSERT INTO `article` VALUES (35, 12, '<img src=\"http://img.baidu.com/hi/jx2/j_0069.gif\"/><p><br/></p>', '2017-08-06 09:37:27', 1, 11, NULL);
INSERT INTO `article` VALUES (36, 12, '<p>test</p>', '2017-08-06 10:05:57', 13, 11, NULL);
INSERT INTO `article` VALUES (37, 12, '<p>test</p>', '2017-08-06 10:06:56', 13, 11, NULL);
INSERT INTO `article` VALUES (38, 12, '<p>test</p>', '2017-08-06 10:07:19', 13, 11, NULL);
INSERT INTO `article` VALUES (39, 12, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0002.gif\"/></p><p><img src=\"http://www.yc5301.cn:8888/umeditor/jsp/upload/20170823/14321503478764152.png\"/></p><p>gsdgsdg</p><p>sdgksdmg</p><p>fdhdf</p>', '2017-08-23 17:00:14', 1, 11, NULL);
INSERT INTO `article` VALUES (40, 12, 'sdfsdf<img src=\"http://img.baidu.com/hi/jx2/j_0037.gif\"/><p><br/></p>', '2017-10-17 19:17:25', 1, 11, NULL);
INSERT INTO `article` VALUES (41, 10, 'sfads<img src=\"http://img.baidu.com/hi/ldw/w_0015.gif\"/><p><img src=\"http://www.yc5301.cn:8888/umeditor/jsp/upload/20171018/56581508337015800.jpg\"/></p>', '2017-10-18 22:30:19', 1, 10, 30);
INSERT INTO `article` VALUES (42, 1, '<img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/><p><br/></p>', '2017-10-30 08:36:53', 1, 1, NULL);
INSERT INTO `article` VALUES (43, 12, 'dsv<img src=\"http://img.baidu.com/hi/bobo/B_0026.gif\"/><p><br/></p>', '2017-12-03 15:41:18', 1, 11, NULL);

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention`  (
  `user_id` int(8) NOT NULL COMMENT '关注的用户的id',
  `puser_id` int(8) NOT NULL COMMENT '被关注的用户的id',
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `puser_id`) USING BTREE,
  INDEX `attention_id_pid`(`user_id`, `puser_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attention
-- ----------------------------
INSERT INTO `attention` VALUES (1, 3, '2017-06-21 12:05:50');
INSERT INTO `attention` VALUES (1, 9, '2017-06-21 15:33:55');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `user_id` int(8) NOT NULL COMMENT '用户id',
  `topic_id` int(8) NOT NULL COMMENT '帖子id',
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `topic_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (1, 1, '2017-06-30 17:00:21');
INSERT INTO `collect` VALUES (1, 3, '2017-06-23 17:00:30');
INSERT INTO `collect` VALUES (1, 9, '2017-06-18 17:06:04');
INSERT INTO `collect` VALUES (4, 2, '2017-06-01 17:00:49');
INSERT INTO `collect` VALUES (8, 1, '2017-06-01 17:00:39');

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic`  (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '帖子id',
  `user_id` int(8) NOT NULL COMMENT '发帖人的id',
  `reply_number` int(5) NULL DEFAULT 0 COMMENT '回复的数量',
  `topic` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帖子主题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '帖子的内容',
  `create_time` datetime(0) NOT NULL COMMENT '发帖的时间',
  `flag` int(1) NOT NULL DEFAULT 1 COMMENT '帖子的状态，1表示正常，0表示已被删除',
  `isindex` int(1) NULL DEFAULT 0 COMMENT '精品帖子，1表示精品，0表示默认',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (1, 1, 14, '骑士获得总冠军', '2017骑士逆转勇士获得总冠军', '2017-06-10 10:57:49', 1, 1);
INSERT INTO `topic` VALUES (2, 1, 1, 'Spring最新源码解析', '深入解析Spring源码及原理', '2017-06-01 10:58:58', 1, 1);
INSERT INTO `topic` VALUES (3, 3, 1, '无话可说', '哈哈', '2017-06-01 12:07:06', 1, 0);
INSERT INTO `topic` VALUES (4, 1, 0, 'saf', '<p>在此写上您的回帖<img src=\"http://localhost:8080/umeditor/jsp/upload/20170612/39591497268654983.png\"/><img src=\"http://img.baidu.com/hi/jx2/j_0002.gif\"/></p>', '2017-06-12 19:57:39', 1, 0);
INSERT INTO `topic` VALUES (5, 1, 5, 'Spring完全源码解析之AOP', '<p style=\"text-align: left;\">详情请参考我的博客！<img src=\"http://img.baidu.com/hi/bobo/B_0003.gif\"/></p><p style=\"text-align: left;\"><img src=\"http://localhost:8080/umeditor/jsp/upload/20170613/1301497339765182.png\"/></p>', '2017-06-13 15:42:48', 1, 1);
INSERT INTO `topic` VALUES (6, 1, 7, '这是一条测试帖子', '<p style=\"text-align: center;\">Hello from jsbintask@gmail.com。<img src=\"http://img.baidu.com/hi/babycat/C_0016.gif\"/></p>', '2017-06-13 21:16:07', 1, 1);
INSERT INTO `topic` VALUES (7, 1, 0, 'safds', '<p style=\"text-align: center;\">在此写上您的回帖<img src=\"http://img.baidu.com/hi/jx2/j_0058.gif\"/></p>', '2017-06-15 12:26:59', 1, 0);
INSERT INTO `topic` VALUES (8, 5, 0, 'Mybatis3.0后的一个小Bug', '<p>加入po中有一个名字是属于符合属性的，mybatis会按照反射机制，先把属性都转化为小写，然后找到对应的get和set方法，因此打字方法找不到！<img src=\"http://img.baidu.com/hi/jx2/j_0070.gif\"/></p>', '2017-06-18 09:42:18', 1, 0);
INSERT INTO `topic` VALUES (9, 8, 0, 'Hello,欢迎你们', '<p>在此写上您的内容<img src=\"http://img.baidu.com/hi/jx2/j_0068.gif\"/></p>', '2017-06-18 14:08:31', 1, 0);
INSERT INTO `topic` VALUES (10, 9, 4, 'Hello，jsbintask', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0060.gif\"/>, <img src=\"http://localhost:8080/umeditor/jsp/upload/20170620/71161497953710481.jpg\" width=\"405\" height=\"391\"/></p>', '2017-06-20 18:15:24', 1, 0);
INSERT INTO `topic` VALUES (11, 1, 0, 'safsf', '<p>在此写上您的内容<img src=\"http://img.baidu.com/hi/jx2/j_0047.gif\"/></p>', '2017-06-21 15:31:07', 0, 0);
INSERT INTO `topic` VALUES (12, 11, 10, '《鬼谷子-捭阖策》', '<p>《鬼谷子</p><p>捭阖第一</p><p>【题解：《易·系辞上》：“是故阖户谓之坤，辟户谓之乾”。捭：开。阖，闭。通过对本文的理解发现，捭阖不仅仅是游说的一种方法，更重要是捭阖已经是一种世界观、哲学观（捭阖者，天地之道。捭阖者，以变动阴阳，四时开闭，以化万物，纵横反出、反复反忤，必由此矣。）。】</p><p>粤若稽古，圣人之在天地间也，为众生之先。观阴阳之开阖以名命物，知存亡之门户，筹策万类之终始，达人心之理，见变化之朕焉，而守司其门户。故圣人之在天下也，自古及今，其道一也。【第一句以圣人立论，古人写作惯用手法，如《黄帝内经》、《太公阴符》等中的黄帝、太公。第二句回答了圣人为何为众人之先；故：是一因果关系词，强调了圣人持道为众生之先的方法更古至今都是一致的。】</p><p>变化无穷，各有所归。或阴或阳，或柔或刚；或开或闭，或弛或张。是故圣人一守司其门户，审察其所先后，度权量能，校其伎巧短长。【“变化无穷，各有所归”强调“各”和“归”，各，有多种多样之意，强调世界的千变万化，归：归宿，结果，强调千变万化的世界终究是有其归宿点；第二句是对第一句的举例；第三句说明现实情况千变万化，圣人是如何做的。】</p><p>夫贤不肖、智愚、勇怯有差，乃可捭，乃可阖；乃可进，乃可退；乃可贱，乃可贵，无为以牧之。审定有无与其实虚，随其嗜欲以见其志意。微排其所言而捭反之，以求其实，贵得其指；阖而捭之，以求其利。【第一句指出人的秉性各有不同，正是这种差别才可以捭阖，也指出了有差、无为是捭阖的关键，无为以牧之是指顺事物秉性来驾驭事物；第二、三句从整体上提出了如何求其实、求其利，实虚：有无，也可指真假；排：1、排斥， &nbsp;2、排查；反：反诘、反问、反驳；指：同旨，主旨，目的。无为作为道家的一种哲学观，可以有两种理解：1、顺应客观世界的规律；2、有所作为和有所不作为，但是有所不作为并不是消极的完全的不作为，而是主动的积极的根据具体情况的不作为，总结起来：顺天之时，随地之性，因人之心。】</p><p>或开而示之，或阖而闭之。开而示之者，同其情也；阖而闭之者，异其诚也。可与不可，审明其计谋，以原其同异。离合有守，先从其志。即欲捭之贵周，即欲阖之贵密。周密之贵微，而与道相追。【第一二句指出了示之、闭之的两种情况，结合下一句的“可与不可”来理解，第二句应该理解为对方与己情同则开而示之，对方不以实相告则阖而闭之。第三句的“可与不可”指是否采取示之、闭之取决于后半句，“原”：察。第四句的守指等待，指是离是合需要等待时机。第五句强调捭阖需要做到周详、隐秘。】</p><p>捭之者，料其情也；阖之者，结其诚也。皆见其权衡轻重，乃为之度数。圣人因而为之虑。其不中权衡度数，圣人因而自为之虑。【第一句中的“料”：忖（cun）度，估量；结：系，固结；诚：实。第二句、第三句强调圣人进则为他人谋，退则为己谋；自为之虑：为之自虑。】</p><p>故捭者，或捭而出之，或捭而内之。阖者，或阖而取之，或阖而去之。捭阖者，天地之道。捭阖者，以变动阴阳，四时开闭，以化万物，纵横反出、反复反忤，必由此矣。【第一二句应该是相对的，第一句中的出应该理解为使对方说出，内理解为使对方采纳。第二句取指使自己获取，去指使自己躲过（祸患），因为前面说过自为之虑。第三句作者将捭阖之道是天地之道，把捭阖的重要性体现出来了。第四句以阴阳立论，指出捭阖这种方法，能够变动阴阳，顺应季节变化，化育各种事物，而人世中的或合纵或连横，或返或出，或反或覆，或反或忤，也都是由捭阖产生的。】</p><p>捭阖者，道之大化，说之变也，必豫审其变化。吉凶大命系焉。口者，心之门户也；心者，神之主也。志意、喜欲、思虑、智谋，此皆由门户出入。故关之以捭阖，制之以出入。【第一句中的“道之大化，说之变也”指的是捭阖这种方法是阴阳规律的无限变化，游说应变的关键，所以作者提出需要事先对各种变化有所准备，因为这关系到吉凶大命。豫：事先有所准备。第三、四句指出了口的重要性。所以，作者在第五句提出以捭阖关之，以出入制之（关之以捭阖，制之以出入：用捭阖之法驾驭说话、实情出入）。当然这“口”是否是作者之前提到的“存亡之门户”还有待考量。】</p><p>捭之者，开也，言也，阳也；阖之者，闭也，默也，阴也。阴阳其和，终始其义。故言长生、安乐、富贵、尊荣、显名、爱好、财利、得意、喜欲，为阳，曰“始”。故言死亡、忧患、贫贱、苦辱、弃损、亡利、失意、有害、刑戮、诛罚，为阴，曰“终”。诸言法阳之类者，皆曰“始”，言善以始其事。诸言法阴之类者，皆曰“终”，言恶以终其谋。【第一句是对游说中的捭阖（作者前面提到捭阖是天地之道，自然不仅仅包含游说之道，故此处指游说中的捭阖之道）下定义，进行解释。第二句需要结合上下句来理解，阴阳相互调和，从开始到结束的整个过程都要符合捭阖的规律、要理。故，因果关系词，第三、四句中的故是承接第二句而言，说明为何要将法阳之类为始，法阴之类为终。第五、六句是承接在第四句的基础上论述的，所以在理解第五、六句时，需要在每一句中体现因果关系。第五六句理解为：凡是游说中说到 &nbsp;“阳”一类的，我们都称其为“始”，因为从事物好的一面游说，诱导对方行动，促进游说成功；反之，游说中说到 &nbsp;“阴”一类的，我们都称之为“终”，因为从事物有害的一面游说，劝阻对方行动，终止对方谋略实施。】</p><p>捭阖之道，以阴阳试之。故与阳言者，依崇高；与阴言者，依卑小。以下求小，以高求大。由此言之，无所不出，无所不入，无所不言可。可以说人，可以说家，可以说国，可以说天下。为小无内，为大无外。益损、去就、倍反，皆以阴阳御其事。【第一句回到了捭阖之道乃天地之道，阴阳之道的根本性世界观上，理解：捭阖的方法就是用阴阳的规律反复地进行试探。试，用。第二句，以“故”这一因果关系词进行举例说明对待阳言者、阴言者的不同方法。第三句是在第二句的基础上进行类比性的演绎，进而得出了第四、五、六、七句的总结性论点。第六句：泛指捭阖的方法无所不包，也可以说捭阖的方法具有普遍适用性。“由此言之中”的“此”就是指第二、三句中所采用的方法。御：治理、统治，引申为用阴阳的规律驾驭游说中的益损、去就、倍反。为小无内，为大无外：小到事物内部再无东西，大到事物外部再无东西，泛指包含一切事物，无所不包。】</p><p>阳动而行，阴止而藏，阳动而出，阴隐而入。阳还终始，阴极反阳。以阳动者，德相生也；以阴静者，形相成也。以阳求阴，苞以德也；以阴结阳，施以力也。阴阳相求，由捭阖也。此天地阴阳之道，而说人之法也。为万事之先，是谓“圆方”之门户。【第一二句是阐述阴阳理论的，后面几句都是以该理论展开论述。第三四句应当结合起来理解，德与形相对，德与力相对，故此处德应该指德行、品德，形指刑罚，方与“力”相关，此两句说的是以阴阳御刑德，故整句理解：阳动则德行产生了，阴静则刑戮形成了，用阳求阴需要用德行包容对方，用阴固结阳则需要向对方施加力量。第五句指阴阳相互依赖都是由捭阖之道决定的。第六句中的此指第五句，指的是捭阖之道系天地、阴阳之道，游说的法则，是万事的根本，天地的门户。不知此处之门户是否就是存亡之门户？存亡之门户还有待考量。】</p>', '2017-08-06 09:00:33', 1, 0);
INSERT INTO `topic` VALUES (13, 13, 0, 'test', '<p>在此写上您的内容</p>', '2017-08-06 09:45:31', 0, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `sno` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别，只有男和女',
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `register_date` date NULL DEFAULT NULL,
  `password` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sign` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人格言，签名之类的',
  `imgUrl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片上传地址',
  `email` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sdept` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `clazz` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `article_num` int(8) NOT NULL DEFAULT 0 COMMENT '该用户发帖数',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1为可发言, 0表示被禁言',
  `islock` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0表示未锁定，可以被其他用户查看',
  `reply_num` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uemail`(`email`) USING BTREE,
  UNIQUE INDEX `sno`(`sno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '14144501413', '男', 'jsbintask', '2017-06-06', '123456', '微信公众号：jsbintask', '6.jpg', 'jsbintask@gmail.com', '15576030460', '计算机', '1406', 7, 1, 1, 28);
INSERT INTO `user` VALUES (2, '14144501415', '女', 'test1', '2017-06-02', '123456', '。。。', '1.jpg', '123@qq.com', '110', '计算机', '1405', 0, 1, 1, 1);
INSERT INTO `user` VALUES (3, '14144501417', '男', 'test2', '2017-06-01', '123456', '嗨。', '2.jpg', '110@qq.com', '15576030460', '物电', '1406', 1, 1, 0, 2);
INSERT INTO `user` VALUES (4, '14144501419', '男', 'test3', '2017-06-12', '123456', 'Hello', 'defaultHead.png', '124@qq.com', NULL, NULL, NULL, 0, 1, 0, 0);
INSERT INTO `user` VALUES (5, '14144501421', '男', 'test4', '2017-05-16', '123456', 'hi.', 'defaultHead.png', '112@qq.com', NULL, NULL, NULL, 1, 1, 0, 2);
INSERT INTO `user` VALUES (7, '14144501425', '男', 'test5', NULL, '123456', NULL, 'defaultHead.png', '1111@qq.com', NULL, NULL, NULL, 0, 1, 0, 0);
INSERT INTO `user` VALUES (8, '14144501377', '男', 'test11', NULL, '123456', 'test', '3.jpg', '1362761867@qq.com', '15576030460', '计算机学院', '网络二班', 1, 1, 0, 0);
INSERT INTO `user` VALUES (9, '14144501379', '男', 'test6', NULL, '123456', '。。。', '4.jpg', '727971401@qq.com', '15173007554', '计算机学院', '1406', 1, 1, 0, 2);
INSERT INTO `user` VALUES (10, '14144501489', '男', 'test7', NULL, '123456', '。。。', '5.jpg', '1484432123@qq.com', '15576030460', '计算机学院', '1406', 0, 1, 0, 2);
INSERT INTO `user` VALUES (11, '14144501381', '男', 'test8', NULL, '123456', 'null', 'defaultHead.png', '1397744240@qq.com', NULL, '计算机学院', '网络14-2BF', 1, 1, 0, 3);
INSERT INTO `user` VALUES (12, '14144501356', '男', 'test9', NULL, 'a2145265', NULL, 'defaultHead.png', '791392383@qq.com', NULL, NULL, NULL, 0, 1, 0, 0);
INSERT INTO `user` VALUES (13, '14141501381', '男', 'test10', NULL, '123456', NULL, 'defaultHead.png', 'ss@a.com', NULL, NULL, NULL, 1, 1, 0, 3);

SET FOREIGN_KEY_CHECKS = 1;
