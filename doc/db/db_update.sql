-- 2023/2/23 增加oauth2_authorization索引 老寇
alter table oauth2_authorization add index idx_token_expires_issued_principal_name(access_token_value(700),access_token_expires_at,access_token_issued_at,principal_name) comment 'token_过期时间_开始时间_登录人_索引';

-- 2023/2/24 增加boot_sys_audit_log索引 老寇
alter table boot_sys_audit_log add index idx_business_id_type(business_id,`type`) comment '业务编号_索引';

-- 2023/2/24 增加boot_sys_menu索引 老寇
ALTER TABLE boot_sys_menu ADD index idx_type_visible(`type`,`visible`) COMMENT '类型_可见_索引';

-- 2023/2/24 增加boot_sys_message_detail索引 老寇
ALTER table boot_sys_message_detail add INDEX idx_read_flag_user_id(read_flag,user_id) COMMENT '已读_用户编号_索引';

-- 2023/2/24 删除索引boot_sys_operate_log索引 老寇
alter alter boot_sys_operate_log drop idx_module;

-- 2023/2/24 增加boot_sys_resource索引 老寇
ALTER table boot_sys_resource ADD INDEX idx_code(`code`) comment '编码_索引';

-- 2023/2/24 增加boot_sys_resource_audit索引 老寇
ALTER table boot_sys_resource_audit add index idx_resource_id(`resource_id`) comment '资源编号_索引';

-- 2023/2/26 增加boot_sys_menu数据 老寇
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES ('1564996817056710700', '1537444981390794754', 'monitor:flow:view', '0', '流量监控', 'http://127.0.0.1:8081', 'dashboard', '1341620898007281665', NULL, '2023-02-26 21:05:30', '2023-02-26 21:05:30', '0', '4000', '0', '0');
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES ('1564996817056710701', '1535878154046939137', 'sys:config:view', '0', '配置中心', 'http://127.0.0.1:8848/nacos', 'appstore', '1341620898007281665', '1341620898007281665', '2023-02-26 21:09:04', '2023-02-26 21:32:40', '0', '404', '1', '0');

-- 2023/3/2 增加boot_sys_menu数据 老寇
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES ('1564996817056710705', '1545036486288732162', 'workflow:definition:template', '1', '流程模板', '/workflow/definition/api/template', 'documentation', '1341620898007281665', '1341620898007281665', '2023-03-02 07:52:36', '2023-03-02 07:53:10', '0', '10', '2', '0');

-- 2023/3/9 增加boot_sys_menu数据 老寇
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES (1564996817056710706, 1545037580289044482, 'workflow:task:resource:resolve', 1, '任务处理', '/workflow/task/api/resource/resolve', 'like', 1341623527018004481, NULL, '2023-03-08 07:45:38', '2023-03-08 07:45:38', 0, 10, 0, 0);
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES (1564996817056710707, 1545037580289044482, 'workflow:task:resource:transfer', 1, '任务转办', '/workflow/task/api/resource/transfer', 'solution', 1341623527018004481, 1537114827246292994, '2023-03-08 07:46:11', '2023-03-08 08:05:01', 0, 10, 6, 0);
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES (1564996817056710708, 1545037580289044482, 'workflow:task:resource:delegate', 1, '任务委派', '/workflow/task/api/resource/delegate', 'user-add', 1341623527018004481, NULL, '2023-03-08 07:51:53', '2023-03-08 07:51:53', 0, 10, 0, 0);

-- 2023/3/10 移除boot_sys_dept字段 老寇
alter table boot_sys_dept drop `path`;

-- 2023/3/10 增加boot_sys_dept索引 老寇
ALTER table boot_sys_dept ADD INDEX idx_tenant_id(`tenant_id`) comment '租户编号_索引';

-- 2023/3/11 为oauth2_authorization增加事件 老寇
-- 每天零点清理过期token
drop event if exists delete_oauth2_authorization_expire_token_every_day;
create event delete_oauth2_authorization_expire_token_every_day
on schedule every 1 day starts '2023-03-11 00:00:00'
on completion preserve
do delete from oauth2_authorization where access_token_expires_at <= now();

-- 2023/3/12 增加boot_sys_menu数据 老寇
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES ('1564996817056710709', '1535878154046939137', 'sys:db:view', '0', '数据库文档', '/sys/db/view', 'book', '1341620898007281665', '1341620898007281665', '2023-03-12 13:05:20', '2023-03-12 13:06:54', '0', '401', '2', '0');

-- 2023/3/15 增加boot_sys_menu数据 老寇
INSERT INTO `boot_sys_menu` (`id`, `pid`, `permission`, `type`, `name`, `url`, `icon`, `creator`, `editor`, `create_date`, `update_date`, `del_flag`, `sort`, `version`, `visible`) VALUES ('1564996817056710710', '1535878154046939137', 'sys:tx:view', '0', '事务管理', 'http://127.0.0.1:7091', 'cascader', '1341620898007281665', '1341620898007281665', '2023-03-15 22:11:04', '2023-03-15 22:13:06', '0', '403', '2', '0');

-- 2023/4/20 分表boot_sys_login_log数据 老寇
CREATE TABLE `boot_sys_login_log_0` (
                                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                        `creator` bigint DEFAULT NULL COMMENT '创建者',
                                        `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                        `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1已删除 0未删除',
                                        `editor` bigint DEFAULT NULL COMMENT '编辑人',
                                        `login_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录用户',
                                        `request_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'IP地址',
                                        `request_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归属地',
                                        `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器版本',
                                        `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
                                        `request_status` tinyint unsigned NOT NULL COMMENT '状态  0：成功   1：失败',
                                        `msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '提示信息',
                                        `login_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录类型',
                                        `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
                                        `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户id',
                                        PRIMARY KEY (`id`),
                                        KEY `idx_tenant_id_request_status` (`tenant_id`,`request_status`) USING BTREE COMMENT '租户编号_请求状态_索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='登录日志';

CREATE TABLE `boot_sys_login_log_1` (
                                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                        `creator` bigint DEFAULT NULL COMMENT '创建者',
                                        `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                        `del_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1已删除 0未删除',
                                        `editor` bigint DEFAULT NULL COMMENT '编辑人',
                                        `login_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录用户',
                                        `request_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'IP地址',
                                        `request_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归属地',
                                        `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器版本',
                                        `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
                                        `request_status` tinyint unsigned NOT NULL COMMENT '状态  0：成功   1：失败',
                                        `msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '提示信息',
                                        `login_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录类型',
                                        `version` int NOT NULL DEFAULT '0' COMMENT '版本号',
                                        `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户id',
                                        PRIMARY KEY (`id`),
                                        KEY `idx_tenant_id_request_status` (`tenant_id`,`request_status`) USING BTREE COMMENT '租户编号_请求状态_索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='登录日志';

-- 2023/5/3 修改boot_sys_resource数据 老寇
UPDATE `boot_sys_resource` SET `title` = '大籽 - 白月光与朱砂痣.mp3', `url` = 'http://127.0.0.1/upload/node4/f906b6a282564c559632a1beeb449f5f.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:43:30', `remark` = '《白月光与朱砂痣》是由大籽、嘿人李逵演唱的歌曲，收录于2021年1月1日发行的《白月光与朱砂痣》专辑。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429355654328815617;
UPDATE `boot_sys_resource` SET `title` = '王胜男_花粥 - 出山.mp3', `url` = 'http://127.0.0.1/upload/node1/ebd577c32a8d448c8349af779d36110a.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:43', `remark` = '《出山》是由花粥作词、作曲，王胜男和花粥演唱的歌曲，正式发行于2018年9月28日。背景伴奏原曲是Bachbeats创作的《Super Love》。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429355954762616834;
UPDATE `boot_sys_resource` SET `title` = '艾辰 - 错位时空.mp3', `url` = 'http://127.0.0.1/upload/node2/a673b6697e4142e5b24e5347b2b32fe8.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:50', `remark` = '《错位时空》是周仁作词，张博文作曲，艾辰演唱的歌曲，由网易云音乐飓风工作室出品，于2021年1月1日发行。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429355987293638657;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 告白气球.mp3', `url` = 'http://127.0.0.1/upload/node4/33e764e16a3f43dfa720967f8a95b9d8.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:40:04', `remark` = '《告白气球》是周杰伦演唱的一首歌曲，由方文山作词，周杰伦作曲，林迈可编曲，收录于周杰伦2016年6月24日发行的录音室专辑《周杰伦的床边故事》中。\n2017年1月，这首歌曲获得Billboard Radio China 2016年度十大金曲奖；同年，该歌曲入围了第28届金曲奖最佳年度歌曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356225781764097;
UPDATE `boot_sys_resource` SET `title` = '丸子呦 - 广寒宫.mp3', `url` = 'http://127.0.0.1/upload/node4/c62266fb46004a96954f1c88e57999ea.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:56', `remark` = '《广寒宫》是2019年4月30日丸子哟发布演唱的古风歌曲。作曲 : 刘凤瑶作词 : 蒋柽，编曲：侯贻强 / EZ-Mitchell。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356501397868545;
UPDATE `boot_sys_resource` SET `title` = '胡歌 - 逍遥叹.mp3', `url` = 'http://127.0.0.1/upload/node4/9e18868a6555416aa6b8c50eb24f25d4.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:43:24', `remark` = '《逍遥叹》是电视剧《仙剑奇侠传》的插曲，由陈宇任（Funck）作词、作曲，屠颖编曲，郭文宗制作，胡歌演唱，收录在华研国际音乐2005年1月25日发行的电视剧《仙剑奇侠传》原声带中 。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356560529166337;
UPDATE `boot_sys_resource` SET `title` = '要不要买菜 - 下山.mp3', `url` = 'http://127.0.0.1/upload/node3/b66ce02154434655b43cd82eb20354f5.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:38:08', `remark` = '《下山》是由朱斌语作词作曲，要不要买菜演唱的歌曲，发行于2019年11月22日。\n2021年1月23日，该曲获得第二届腾讯音乐娱乐盛典年度十大热歌奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356593961963521;
UPDATE `boot_sys_resource` SET `title` = '陈一发儿 - 童话镇.mp3', `url` = 'http://127.0.0.1/upload/node5/99e4a13f475144c7b0a984dc50f67a84.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:36:01', `remark` = '《童话镇》是由竹君作词，暗杠作曲，陈一发儿翻唱的流行歌曲。该曲女声版本在云音乐热歌榜连续两周榜首，并最终入选2016年度云音乐最热歌曲第五名，成为陈一发儿的代表作之一。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356687457193986;
UPDATE `boot_sys_resource` SET `title` = '汪睿 - 桃花笑.mp3', `url` = 'http://127.0.0.1/upload/node4/424ca662e7d84e8486eb5bac29f858f0.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:36:08', `remark` = '《桃花笑》为林依晨、张彬彬领衔主演的电视剧《小女花不弃》中的插曲，由汪睿演唱，由青萝子作词，西门振作曲。该歌曲温馨喜庆，旋律轻快欢乐，歌词郎朗上口，配上汪睿独特可爱的嗓音，好听又为剧情发展烘托气氛。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356715475144706;
UPDATE `boot_sys_resource` SET `title` = '银临 - 棠梨煎雪.mp3', `url` = 'http://127.0.0.1/upload/node5/3db5f8ab95cc45debbac3238b2178336.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:12', `remark` = '《棠梨煎雪》是一首银临演唱的古风歌曲，收录于2013年12月15日发行的专辑《腐草为萤》', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429356956618264577;
UPDATE `boot_sys_resource` SET `title` = '蔡依林 - 日不落.mp3', `url` = 'http://127.0.0.1/upload/node3/bea227b2276e4ff08ba80c78bb135c28.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:38:17', `remark` = '《日不落》是中国台湾流行音乐女歌手蔡依林演唱的一首歌曲，翻唱自BWO的《Sunshine in the Rain》，由崔惟楷重新填词，Bodies Without Organs作曲，收录于蔡依林2007年09月21日发行的专辑《特务J》中，亦是音乐电影《记忆的裂痕》中的背景音乐。\n该歌曲发行后获得第六届HITO流行音乐奖年度听众最爱歌曲、第十五届北京流行音乐典礼年度金曲和第八届全球华语歌曲排行榜最受欢迎二十大金曲等奖项。2008年1月《日不落》获得中国台湾Hit Fm百首单曲冠军。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429358833586081793;
UPDATE `boot_sys_resource` SET `title` = '深海鱼子酱 - 千千万万.mp3', `url` = 'http://127.0.0.1/upload/node1/e74d47b36a3b47f99da3bc1ca23320ff.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:05', `remark` = '《千千万万》是深海鱼子酱演唱的歌曲，发行于2022年1月13日，收录于专辑《千千万万(粤语版)》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429358893971476482;
UPDATE `boot_sys_resource` SET `title` = '流芒菌 - 红昭愿.mp3', `url` = 'http://127.0.0.1/upload/node4/fa9aa526d024481b9c1c5cbdc5ae2ab0.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-12-10 13:44:20', `remark` = '《红昭愿》是来自音阙诗听音乐社的一首原创作品，由荒唐客作词，殇小瑾作曲，流茫菌演唱的一首歌。正式发行于2017年1月11日。大量的不重复处理让歌曲呈现更高的耐听感，时时刻刻都是新鲜的元素！据社长也亦是《红昭愿》这首歌的制作人殇小谨介绍：“魔性的开场loop人声采样，是我们的第七版创意。和声的配唱模式，是我们的第三版创意。编曲的整体搭配，包括中国风古筝元素的加入，是我们的第三版创意。”', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429358962762256386;
UPDATE `boot_sys_resource` SET `title` = '张韶涵 - 淋雨一直走.mp3', `url` = 'http://127.0.0.1/upload/node2/fc4f4b3713174e57a9e88cc55e9d009f.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:42:56', `remark` = '《淋雨一直走》是张韶涵演唱的一首歌曲，收录在张韶涵发行的专辑《有形的翅膀》中。\n2012年12月这首歌曲获得第20届中国歌曲排行榜年度金曲奖和最佳编曲奖，2013年4月获得Music Radio中国TOP排行榜年度金曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429359285337788418;
UPDATE `boot_sys_resource` SET `title` = '花僮 - 笑纳.mp3', `url` = 'http://127.0.0.1/upload/node4/1ea804cfdda948ae8901b7d7cd670cb8.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:39:35', `remark` = '《笑纳》是周仁作词，古月作曲，韩珂编曲，花僮演唱的歌曲，发行于2020年8月26日。收录于同名专辑《笑纳》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1429360419737636866;
UPDATE `boot_sys_resource` SET `title` = '许嵩 - 如果当时.mp3', `url` = 'http://127.0.0.1/upload/node5/40ca5064ce1e4df594ab7bbfe53b7b8d.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:40:11', `remark` = '《如果当时》是许嵩首张个人专辑《自定义》的一首主打歌曲，创作工作均由许嵩独自完成。发行于2009年1月10日。\n这首歌是一首构思独特的养耳之作，具有浓厚的中国风味道。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1431054811305213953;
UPDATE `boot_sys_resource` SET `title` = '黎林添娇 - 星月糖.mp3', `url` = 'http://127.0.0.1/upload/node4/bed7739d71414a95a43694a20ec69e9a.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:43:57', `remark` = '《星月糖》是漠飞作词，王鹏作曲，黎林添娇演唱的一首歌。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610165923516417;
UPDATE `boot_sys_resource` SET `title` = 'yihuik苡慧 - 银河与星斗.mp3', `url` = 'http://127.0.0.1/upload/node5/f96ff9b14ce94f8e8746ef8738614fcd.mp3', `code` = 'audio', `create_date` = '2021-10-21 13:05:09', `update_date` = '2022-08-26 10:37:41', `remark` = '《银河与星斗》是由李昀格和刘思情作词，轮子作曲，yihuik苡慧演唱的歌曲，发行于2021年5月30日。收录于同名专辑《银河与星斗》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848513;
UPDATE `boot_sys_resource` SET `title` = '黄霑_罗大佑_徐克 - 沧海一声笑.mp4', `url` = 'http://127.0.0.1/upload/node4/108f3fe556a54faea00c0af69ff7a832.mp4', `code` = 'video', `create_date` = '2021-10-24 14:55:43', `update_date` = '2023-01-01 16:30:53', `remark` = '《沧海一声笑》是1990年上映的电影《笑傲江湖》的主题曲，由黄霑作词、作曲，顾嘉辉编曲。\n歌曲分粤语、普通话两个版本，但歌词几乎相同；粤语版由许冠杰演唱，收录于许冠杰1990年4月1日由宝丽金唱片发行的专辑《90电影金曲精选》中；普通话版由罗大佑、黄霑、徐克共同演唱，收录于黄沾1990年由滚石唱片发行的专辑《笑傲江湖-百无禁忌黄沾作品集》中。\n1991年，该曲获第10届香港电影金像奖最佳原创电影歌曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848514;
UPDATE `boot_sys_resource` SET `title` = '令狐冲 - 一曲肝肠断.jpg', `url` = 'http://127.0.0.1/upload/node3/bacb44ff9a5f4ba9bb7eefd7adc45a47.jpg', `code` = 'image', `create_date` = '2021-10-24 15:07:54', `update_date` = '2023-01-19 19:01:19', `remark` = '老寇的QQ个人头像', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848515;
UPDATE `boot_sys_resource` SET `title` = '郑中基 - 无赖.mp3', `url` = 'http://127.0.0.1/upload/node2/0cacaed1d0e24dd8bf783d6126981cd3.mp3', `code` = 'audio', `create_date` = '2021-10-24 15:33:48', `update_date` = '2022-08-26 10:43:50', `remark` = '《无赖》是郑中基演唱的一首粤语歌曲，由李峻一填词、作曲，收录在郑中基2005年6月由金牌大风唱片发行的粤语专辑《Before After》中。该歌曲是电影《龙咁威2之皇母娘娘呢》的主题曲。\n2005年12月该歌曲获得新城劲爆歌曲、劲爆卡拉OK歌曲两个奖项；2006年获得第28届香港十大中文金曲、2005年度十大劲歌金曲金曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848516;
UPDATE `boot_sys_resource` SET `title` = '李昕融_樊桐舟_李凯稠 - 你笑起来真好看.mp3', `url` = 'http://127.0.0.1/upload/node1/6f159e4ade6340cfa877508f28457289.mp3', `code` = 'audio', `create_date` = '2021-10-26 08:39:20', `update_date` = '2022-08-26 10:43:17', `remark` = '《你笑起来真好看》是由周兵作词，李凯稠作曲，李昕融、樊桐舟、李凯稠共同演唱的歌曲，于2020年10月26日以单曲形式发行。\n2020年，该曲获得中国当代歌曲创作精品工程“听见中国听见你”年度优秀歌曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848520;
UPDATE `boot_sys_resource` SET `title` = '胡歌 - 指纹.mp4', `url` = 'http://127.0.0.1/upload/node5/69142f1e30d04175bbe2825688efbe25.mp4', `code` = 'video', `create_date` = '2021-11-04 20:45:23', `update_date` = '2022-10-22 16:09:57', `remark` = '《指纹》是电视剧《轩辕剑之天之痕》的插曲，由周剑光作词，郑宇界作曲，胡歌演唱，谢嘉荣制作MV。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848524;
UPDATE `boot_sys_resource` SET `title` = '刘德华 - 17岁.mp4', `url` = 'http://127.0.0.1/upload/node3/fecc0b2a83dd4c94b0398f6187ebc04c.mp4', `code` = 'video', `create_date` = '2021-11-07 09:53:00', `update_date` = '2022-08-26 10:38:49', `remark` = '《17岁》是刘德华演唱的一首歌曲，由刘德华和徐继宗作词，徐继宗作曲的一首歌，编曲为Billy Chan，收录在专辑《如果有一天》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848525;
UPDATE `boot_sys_resource` SET `title` = '黄安 - 新鸳鸯蝴蝶梦.mp3', `url` = 'http://127.0.0.1/upload/node3/73c11e1aac3c4b3db893ca711bb78ab5.mp3', `code` = 'audio', `create_date` = '2021-11-28 17:43:38', `update_date` = '2022-08-26 10:36:15', `remark` = '《新鸳鸯蝴蝶梦》是1993年台湾电视剧《包青天》的主题曲，由黄安演唱、填词并作曲，詹宏达编曲，最早收录于1993年2月1日发行的同名专辑《新鸳鸯蝴蝶梦》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848527;
UPDATE `boot_sys_resource` SET `title` = '蔡依林_周杰伦 - 布拉格广场.flac', `url` = 'http://127.0.0.1/upload/node5/a607608ec20b46e2abbeaf3e704db6d6.flac', `code` = 'audio', `create_date` = '2022-03-14 11:07:44', `update_date` = '2022-08-26 10:37:49', `remark` = '《布拉格广场》是蔡依林、周杰伦演唱的歌曲，由方文山作词、周杰伦作曲、钟兴民编曲，收录于蔡依林2003年3月7日发行的专辑《看我72变》中。\n2004年5月，钟兴民在第15届台湾金曲奖颁奖典礼上凭借该曲获得“最佳编曲人奖” 。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848530;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 本草纲目.flac', `url` = 'http://127.0.0.1/upload/node5/1cabe4eabef547688090a4c58ad2c82e.flac', `code` = 'audio', `create_date` = '2022-03-01 11:17:50', `update_date` = '2022-08-26 10:36:57', `remark` = '《本草纲目》是周杰伦演唱的一首歌曲，由方文山作词，周杰伦作曲，林迈可编曲，收录在周杰伦2006年9月5日发行的专辑《依然范特西》中。 \n周杰伦在2009年春节联欢晚会上与宋祖英以“英伦组合”合唱该歌曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848531;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 超人不会飞.flac', `url` = 'http://127.0.0.1/upload/node3/98f52b4365df44efb76e4c8e046f006d.flac', `code` = 'audio', `create_date` = '2022-03-07 11:19:14', `update_date` = '2022-08-26 10:37:24', `remark` = '《超人不会飞》是周杰伦演唱的一首歌曲，由周杰伦填词、谱曲，林迈可编曲，收录在周杰伦2010年5月18日发行的专辑《跨时代》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848532;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 稻香.flac', `url` = 'http://127.0.0.1/upload/node4/76340fdb43be499ea3a540ea6f934267.flac', `code` = 'audio', `create_date` = '2022-03-16 11:20:50', `update_date` = '2022-10-22 15:58:08', `remark` = '《稻香》是周杰伦演唱的一首歌曲，由周杰伦作词、作曲，黄雨勋编曲，收录在周杰伦2008年10月15日发行的专辑《魔杰座》中；周杰伦在接受媒体采访时表示，《稻香》是因5·12汶川地震创作的。\n2009年这首歌曲获得第20届台湾金曲奖最佳年度歌曲奖、雪碧榜中国原创音乐流行榜港台地区歌曲奖等奖项。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848533;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 东风破.flac', `url` = 'http://127.0.0.1/upload/node3/a56c134452cc466e8596c39d9c4fb0bc.flac', `code` = 'audio', `create_date` = '2022-03-14 11:22:10', `update_date` = '2022-08-26 10:33:54', `remark` = '《东风破》是周杰伦演唱的一首歌曲，由周杰伦谱曲，方文山填词，林迈可编曲，收录在周杰伦2003年7月31日发行的个人第四张专辑《叶惠美》中。\n2004年，该歌曲获得第四届华语流行乐传媒大奖十大单曲奖、第11届中国歌曲排行榜港台地区最受欢迎歌曲奖、MusicRadio中国TOP排行榜台港地区年度歌曲和第七届中央电视台音乐电视大赛港台及海外华语最佳MV作品奖等奖项，方文山凭借该歌曲获得第四届百事音乐风云榜年度港台及海外华人最佳作词奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848534;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 断了的弦.flac', `url` = 'http://127.0.0.1/upload/node5/b5c8a23a9aeb4fb7963a93b5a46d034c.flac', `code` = 'audio', `create_date` = '2022-03-14 11:23:59', `update_date` = '2022-08-27 11:05:23', `remark` = '《断了的弦》是周杰伦演唱的一首歌曲，由方文山作词，周杰伦作曲，钟兴民编曲，收录于周杰伦于2003年11月13日发行的EP《寻找周杰伦》中 。该曲是电影《寻找周杰伦》的插曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848535;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 发如雪.flac', `url` = 'http://127.0.0.1/upload/node1/b83abed50bf64d5490afed2762ccea05.flac', `code` = 'audio', `create_date` = '2022-03-27 11:25:11', `update_date` = '2022-10-22 15:58:08', `remark` = '《发如雪》是由周杰伦作曲，方文山填词，周杰伦演唱。《发如雪》是首古筝伴奏的中国古典风格的作品，相比《夜曲》的欧洲古典风格，这首《十一月的萧邦》专辑中的第二主打歌曲毫不逊色。另外歌词“本来无一物，何处惹尘埃”道出了这生生世世，缘起缘落，一切只因心尘未脱的世间痴男怨女的心境。《发如雪》是一首在唱腔上颇具难度技巧的歌曲，周杰伦飙到高音的地方令人印象深刻。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848536;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 霍元甲.flac', `url` = 'http://127.0.0.1/upload/node3/e632ad8073b24f76a8ca17e6d9a812ae.flac', `code` = 'audio', `create_date` = '2022-03-14 11:26:15', `update_date` = '2022-08-26 10:40:18', `remark` = '《霍元甲》是周杰伦演唱的一首歌曲，由方文山作词，周杰伦作曲，洪敬尧编曲，收录于2006年1月20日发行的同名EP《霍元甲》中。该曲是电影《霍元甲》的同名主题曲。\n2007年，该曲获得第26届香港电影金像奖最佳原创电影歌曲提名，周杰伦凭借该曲获得第18届台湾金曲奖最佳单曲制作人奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848537;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 兰亭序.mp3', `url` = 'http://127.0.0.1/upload/node1/d8ed3d9659b843ceb776d603cc068bef.mp3', `code` = 'audio', `create_date` = '2022-02-24 11:29:06', `update_date` = '2022-08-26 10:36:48', `remark` = '《兰亭序》是周杰伦演唱的一首歌曲，由周杰伦作曲，方文山填词，钟兴民编曲，收录在周杰伦2008年10月15日发行的专辑《魔杰座》中。\n2011年，周杰伦在央视春晚上演唱了这首歌曲，并获得了2011年CCTV春晚我最喜爱的春节联欢晚会评选歌舞类节目三等奖。\n', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848538;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 龙卷风.flac', `url` = 'http://127.0.0.1/upload/node4/f74da90133ed48638193cc072773a217.flac', `code` = 'audio', `create_date` = '2022-03-14 11:31:07', `update_date` = '2022-08-26 10:42:43', `remark` = '《龙卷风》是周杰伦演唱的一首歌曲，由徐若瑄作词，周杰伦作曲，钟兴民编曲，收录于周杰伦2000年11月7日发行的首张个人专辑《Jay》中。\n2001年，该歌曲获得新城劲爆卡拉OK歌曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848539;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 牛仔很忙.flac', `url` = 'http://127.0.0.1/upload/node1/d97ae6efe4a841f3a119d96e32f3994b.flac', `code` = 'audio', `create_date` = '2022-03-29 11:33:34', `update_date` = '2022-10-22 15:58:08', `remark` = '《牛仔很忙》是周杰伦演唱的一首歌曲，由周杰伦作曲，黄俊郎填词，钟兴民编曲，收录在周杰伦2007年11月2日发行的专辑《我很忙》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848540;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 七里香.flac', `url` = 'http://127.0.0.1/upload/node1/31dbe74b6a184f94b3e690ddb23b173d.flac', `code` = 'audio', `create_date` = '2022-03-29 11:35:07', `update_date` = '2022-10-22 22:30:34', `remark` = '七里香歌曲《七里香》，由周杰伦演唱，方文山作词，周杰伦谱曲，钟兴民编曲，收录在周杰伦2004年8月3日发行的同名专辑《七里香》中。\n2004年，该曲获得香港TVB8十大金曲最佳作曲、监制、编曲3项大奖。2005年，该曲获得第27届十大中文金曲十大金曲奖、优秀流行华语歌曲奖以及第11届全球华语音乐榜中榜年度最佳歌曲等多个奖项。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848541;
UPDATE `boot_sys_resource` SET `title` = '周杰伦_费玉清 - 千里之外.flac', `url` = 'http://127.0.0.1/upload/node4/7c51289e75fd427484871b63aeee0545.flac', `code` = 'audio', `create_date` = '2022-03-07 11:36:12', `update_date` = '2022-08-26 10:38:42', `remark` = '《千里之外》是周杰伦、费玉清演唱的一首歌曲，由方文山作词，周杰伦作曲，林迈可编曲，收录在周杰伦2006年9月5日发行的专辑《依然范特西》中，是周杰伦的代表作品之一。该歌曲另有费玉清的独唱版本，收录于费玉清2007年4月20日发行的专辑《回想曲青青校树》中。\n2007年，该歌曲获得了第十三届全球华语音乐榜中榜年度最佳歌曲奖、第29届十大中文金曲全国最受欢迎中文歌曲奖、第7届蒙牛酸酸乳音乐风云榜年度最佳歌曲奖。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848542;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 烟花易冷.flac', `url` = 'http://127.0.0.1/upload/node4/4c6655d7d5dc42b1a491f8a0c4138413.flac', `code` = 'audio', `create_date` = '2022-03-15 11:37:57', `update_date` = '2022-08-26 10:43:03', `remark` = '《烟花易冷》是方文山作词，黄雨勋编曲，周杰伦作曲并演唱的一首歌曲，收录在周杰伦2010年5月18日发行的专辑《跨时代》中。\n2011年，该曲获得2010年度北京流行音乐典礼“年度金曲奖”。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848543;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 夜的第七章.mp3', `url` = 'http://127.0.0.1/upload/node2/23d90162fde44dd58b7e7147e196adb9.mp3', `code` = 'audio', `create_date` = '2022-03-16 11:39:14', `update_date` = '2022-10-22 15:58:08', `remark` = '《夜的第七章》讲的是伦敦近郊的公园里的发生了一起凶杀案，现场唯一留下的线索是死者口里的一朵蓝色玫瑰的故事。\n《夜的第七章》是周杰伦、潘儿演唱的一首歌曲，由黄俊郎作词，周杰伦作曲，钟兴民、林迈可编曲。收录在周杰伦于2006年9月5日发行的专辑《依然范特西》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848544;
UPDATE `boot_sys_resource` SET `title` = '周杰伦 - 夜曲.flac', `url` = 'http://127.0.0.1/upload/node1/eefa051169454bf9ab1ccaa313febf8e.flac', `code` = 'audio', `create_date` = '2022-03-14 11:40:57', `update_date` = '2022-08-26 10:42:36', `remark` = '《夜曲》是周杰伦演唱的一首歌曲，由方文山作词，周杰伦作曲，林迈可编曲，收录在周杰伦2005年11月1日发行的专辑《11月的萧邦》中。\n2005年，该曲获得雪碧榜港台金曲、9+2音乐先锋榜年度先锋金曲。2006年，该曲获得全球华语音乐榜中榜年度最佳歌曲等多个奖项。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1441610450502848545;
UPDATE `boot_sys_resource` SET `title` = 'k↑.jpg', `url` = 'http://127.0.0.1/upload/node3/1d73029a377241e1903cba6c45060bf1.jpg', `code` = 'image', `create_date` = '2022-08-31 10:45:39', `update_date` = '2023-02-07 13:52:40', `remark` = '老寇的CSDN个人头像', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 20 WHERE `id` = 1564806594321100801;
UPDATE `boot_sys_resource` SET `title` = 'Yanni - With An Orchid (心兰相随).mp4', `url` = 'http://127.0.0.1/upload/node5/02a6554e954142c09c77702e5197762a.mp4', `code` = 'video', `create_date` = '2022-10-26 11:55:18', `update_date` = '2022-10-26 12:01:47', `remark` = 'With An Orchid 《心兰相随》是一首非常有名的New Age(新世纪)曲子。由希腊演奏家、作曲家Yanni创作，收录于其专辑 If I Could Tell You 。香港凤凰卫视的凤凰气象站，大连电视台晚间气象预报和福州电视台的福州三天未来天气采用它为背景音乐，受到许多人的喜爱。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585117840203255810;
UPDATE `boot_sys_resource` SET `title` = '李宇春 - 和你一样.flac', `url` = 'http://127.0.0.1/upload/node5/66c17e7ceae341309d82e63735219d8f.flac', `code` = 'audio', `create_date` = '2022-10-26 12:04:17', `update_date` = '2022-11-01 20:28:30', `remark` = '《和你一样》是李宇春演唱的歌曲，由任淼作词，上海玉米与任淼共同谱曲，发行于2008年4月29日 ，收录于2008年12月16日李宇春发行的专辑《N+1 Evolution》中。\n2008年12月，该曲获得无线音乐最具爱心金曲提名。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585120102459838465;
UPDATE `boot_sys_resource` SET `title` = '房东的猫 - New Boy.flac', `url` = 'http://127.0.0.1/upload/node5/36438ade79584b2f9e472d3657e0f64c.flac', `code` = 'audio', `create_date` = '2022-10-26 12:06:44', `update_date` = '2022-11-01 20:28:31', `remark` = 'NEW BOY是房东的猫、陈婧霏演唱的歌曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585120717546131457;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 沧海一声笑(现场版).mp4', `url` = 'http://127.0.0.1/upload/node1/c928e1fcc55f4b65a848a6ce44240029.mp4', `code` = 'video', `create_date` = '2022-10-26 12:09:38', `update_date` = '2022-11-01 20:28:31', `remark` = '《沧海一声笑》是任贤齐演唱的一首歌曲，由黄沾作词、作曲，梁伯君编曲，收录在任贤齐2000年1月27日发行的专辑《为爱走天涯》中。该曲是2000年中视版电视剧《笑傲江湖》的插曲', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 1 WHERE `id` = 1585121449896775681;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 还有我.mp4', `url` = 'http://127.0.0.1/upload/node5/49eb851e06af49939ae5b93287ea22dc.mp4', `code` = 'video', `create_date` = '2022-10-26 12:30:26', `update_date` = '2022-11-01 20:28:32', `remark` = '《还有我》是任贤齐演唱的一首歌曲，由任贤齐作词、作曲，葛子毅编曲，收录在任贤齐2007年4月26日发行的专辑《如果没有你》中 。\n该歌曲是电影《合约情人》的插曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585126683264094209;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 任逍遥.mp4', `url` = 'http://127.0.0.1/upload/node5/9ea81ace95d84d6d8fc505d165e47515.mp4', `code` = 'video', `create_date` = '2022-10-26 12:32:36', `update_date` = '2022-11-01 20:28:33', `remark` = '《任逍遥 》是任贤齐演唱的一首歌曲，由小虫作词、作曲，梁伯君编曲，收录于任贤齐1998年8月28日由滚石唱片发行的录音室专辑《爱像太平洋》中。该歌曲是1998年台视电视剧《神雕侠侣》片头曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585127225684070402;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 天涯.mp4', `url` = 'http://127.0.0.1/upload/node1/bfeb8d47dc754fa884e1678bc3a980f9.mp4', `code` = 'video', `create_date` = '2022-10-26 12:35:22', `update_date` = '2022-11-01 20:28:34', `remark` = '《天涯》是任贤齐翻唱中岛美雪竹の歌，由陈没填词，蔡朝华编曲，收录在任贤齐2000年1月27日由滚石唱片发行的专辑《为爱走天涯》中。该歌曲是2000年台湾中视电视剧《笑傲江湖》的片尾曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585127922618011650;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 死不了.mp4', `url` = 'http://127.0.0.1/upload/node5/3195026cd259454e90bd88b2ab9038b3.mp4', `code` = 'video', `create_date` = '2022-10-26 12:37:10', `update_date` = '2022-11-01 20:28:35', `remark` = '《死不了》是任贤齐演唱的一首歌曲，由刘思铭作词，刘志宏作曲，洪敬尧编曲，收录在任贤齐2000年1月27日由滚石唱片发行的专辑《为爱走天涯》中。该曲是2000年中视版电视剧《笑傲江湖》的主题曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585128375955165186;
UPDATE `boot_sys_resource` SET `title` = '任贤齐 - 心太软.mp4', `url` = 'http://127.0.0.1/upload/node1/44fba7e03c9c4f6da79a7152e56f5e64.mp4', `code` = 'video', `create_date` = '2022-10-26 12:38:55', `update_date` = '2022-11-01 20:28:35', `remark` = '《心太软》是任贤齐1996年12月24日发行的一张专辑，由小虫担任制作人，滚石唱片发行，共收录10首歌曲。\n该专辑的同名主打歌《心太软》荣获香港电台十大劲爆国语金曲铜奖、香港新城精选104电台国语金奖、1997ChannelV华语榜中榜TOP20第二名。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585128815811825666;
UPDATE `boot_sys_resource` SET `title` = '杨千嬅_任贤齐 - 花好月圆夜 (国语版).mp4', `url` = 'http://127.0.0.1/upload/node1/d41be2c462a84cbdb6bb40182c4e7196.mp4', `code` = 'video', `create_date` = '2022-10-26 12:42:11', `update_date` = '2022-11-01 20:28:36', `remark` = '《花好月圆夜》是由任贤齐、杨千嬅演唱的一首歌曲，由任贤齐作曲，伍乐城编曲，分普通话、粤语两个版本，普通话版由任贤齐作词，粤语版由林夕作词，两版皆收录在杨千嬅2004年1月21日发行的EP《2004开大》中 [2-3]  。该曲是电影《花好月圆》的插曲。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585129637417259009;
UPDATE `boot_sys_resource` SET `title` = '范倪Liu - 南半球与北海道.mp3', `url` = 'http://127.0.0.1/upload/node5/7931e662df164b0281752a26be9a74e3.mp3', `code` = 'audio', `create_date` = '2022-10-26 12:44:49', `update_date` = '2022-11-01 20:28:37', `remark` = '“我告别南半球奔向北海道，愿化作那昼夜的飞鸟将你拥抱”\n    尘埃力量携手旗下女歌手范倪Liu带来全新单曲《南半球与北海道》。范倪Liu治愈演绎，你的笑盛放于花海，那是我见过最美的画面。我告别南半球与北海道，与零度经线的距离只差分毫，只能目送你随日落消失于眼角。我多想能穿梭到平行时空，乘着风，奔向你...', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585130300620607489;
UPDATE `boot_sys_resource` SET `title` = '凤凰传奇 - 海底.mp3', `url` = 'http://127.0.0.1/upload/node1/f98cb30cf0944015b082cc640f4a8a68.mp3', `code` = 'audio', `create_date` = '2022-10-26 12:45:53', `update_date` = '2022-11-01 20:28:38', `remark` = '《海底》，由一支榴莲作词，一支榴莲/寿延作曲，凤凰传奇在《为歌而赞》第七期演唱的歌曲，发行于2021年4月24日。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 0 WHERE `id` = 1585130571937550338;
UPDATE `boot_sys_resource` SET `title` = '千百顺 - 很任性.flac', `url` = 'http://127.0.0.1/upload/node1/d218ea8dc46e437a884778f53e27a590.flac', `code` = 'audio', `create_date` = '2022-11-02 17:24:09', `update_date` = '2023-02-07 14:00:44', `remark` = '《很任性》是由高进作词、作曲，千百顺演唱的歌曲，发行于2014年12月24日。收录于同名专辑《很任性》中。', `creator` = 1341620898007281665, `editor` = 1341620898007281665, `del_flag` = 0, `version` = 2 WHERE `id` = 1587737315629010946;

-- 2023/5/11 修改oauth2_registered_client数据 老寇
UPDATE `oauth2_registered_client` SET `client_id` = '95TxSsTPFA3tF12TBSMmUVK0da', `client_id_issued_at` = '2023-05-11 01:17:54', `client_secret` = '{bcrypt}$2a$10$BDcxgmL3WYk7G.QEDTqlBeSudNlV3KUU/V6iC.hKlAbGAC.jbX2fO', `client_secret_expires_at` = NULL, `client_name` = 'OAuth2认证', `client_authentication_methods` = 'client_secret_basic', `authorization_grant_types` = 'refresh_token,password,client_credentials,mail,authorization_code,mobile', `redirect_uris` = 'http://127.0.0.1:8001,http://127.0.0.1:8000', `scopes` = 'password,mail,openid,mobile', `client_settings` = '{\"@class\":\"java.util.Collections$UnmodifiableMap\",\"settings.client.require-proof-key\":false,\"settings.client.require-authorization-consent\":true}', `token_settings` = '{\"@class\":\"java.util.Collections$UnmodifiableMap\",\"settings.token.reuse-refresh-tokens\":true,\"settings.token.id-token-signature-algorithm\":[\"org.springframework.security.oauth2.jose.jws.SignatureAlgorithm\",\"RS256\"],\"settings.token.access-token-time-to-live\":[\"java.time.Duration\",3600.000000000],\"settings.token.access-token-format\":{\"@class\":\"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat\",\"value\":\"self-contained\"},\"settings.token.refresh-token-time-to-live\":[\"java.time.Duration\",21600.000000000],\"settings.token.authorization-code-time-to-live\":[\"java.time.Duration\",3600.000000000]}' WHERE `id` = '95TxSsTPFA3tF12TBSMmUVK0da';
