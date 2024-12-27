/*
数据库school使用utf8mb4字符集，包含院系表d、学生表s、教师表t、课程表c、开课表o、成绩表e，以及账户表Account。
院系表d包含院系号yxh、院系名称mc、地址dz、联系电话lxdh，院系号yxh为主键。
学生表s包含学号xh、姓名xm、性别xb、出生日期csrq、籍贯jg、手机号码sjhm、院系号yxh，学号xh为主键，院系号yxh为外键。
教师表t包含工号gh、姓名xm、性别xb、出生日期csrq、学历xl、基本工资jbgz、院系号yxh，工号gh为主键，院系号yxh为外键。
课程表c包含课号kh、课名km、学分xf、学时xs、院系号yxh，课号kh为主键，院系号yxh为外键。
开课表o包含学期xq、课号kh、工号gh、上课时间sksj，学期xq、课号kh、工号gh为联合主键，课号kh、工号gh为外键。
成绩表e包含学号xh、学期xq、课号kh、工号gh、平时成绩pscj、考试成绩kscj、总评成绩zpcj，学号xh、学期xq、课号kh、工号gh为联合主键，学号xh、学期xq为外键。
账户表Account包含用户名usr、密码pwd，用户名usr为主键。

每个表的主键索引使用B+树索引，外键约束使用级联操作。
*/

drop database if exists school;
create database school character set utf8mb4 collate utf8mb4_general_ci;
use school;

drop table if exists d;
-- 院系表
create table d(
	 yxh char(2) not null comment '院系号',
	 mc varchar(30) not null comment '院系名称',
	 dz varchar(30) not null comment '地址',
	 lxdh char(8) not null comment '联系电话',
	 primary key (yxh) using btree,
	 check (yxh >= '01' and yxh <= '99')
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '院系表';

insert into d values('01', '信息科学与工程学院', '南校区一号楼', '65347567');
insert into d values('02',	'电气院',	'南校区二号楼',	'65341234');
insert into d values('03',	'材料院',	'南校区四号楼',	'65347890');

use school;
drop table if exists s;
-- 学生表
create table s(
	xh char(4) not null comment '学号',
	xm varchar(12) not null comment '姓名',
	xb char(1) not null comment '性别',
	csrq date not null comment '出生日期',
	jg varchar(12) not null comment '籍贯',
	sjhm char(11) not null comment '手机号码',
	yxh char(2) not null comment '院系号',
	primary key (xh) using btree,
 	constraint fk_yxh_s foreign key (yxh) references d(yxh) on delete cascade on update cascade
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '学生表';

insert into s values(1101,	'叶晨新',	'男',	'2003-03-06',	'上海',	'13613005486',	'02');
insert into s values(1102,	"束建杰",	'男',	'2004-12-08',	'安徽',	'18913457890',	'01'); 
insert into s values(1103,	'彭千容',	'女',	'2005-01-05',	'江苏',	'18826490423',	'01');
insert into s values(1104,	'刘晶晶',	'女',	'2004-11-06',	'上海',	'13331934111',	'01'); 
insert into s values(1105,	'郑昕晨',	'男',	'2004-06-07',	'上海',	'18015872567',	'01'); 
insert into s values(1106,	'李二丽',	'女',	'2004-05-04',	'江苏',	'18107620945',	'01'); 
insert into s values(1107,	'张铭昊',	'男',	'2005-08-16',	'吉林',	'13912341078',	'01'); 


use school;
drop table if exists t;
-- 教师表
create table t(
	 gh char(4) not null comment '工号',
	 xm varchar(15) not null comment '姓名',
	 xb char(1) not null comment '性别',  
	 csrq date not null comment '出生日期',
	 xl varchar(10) not null comment '学历',
	 jbgz double(8, 2) not null comment '基本工资',
	 yxh char(2) not null comment '院系号',
	 primary key (gh) using btree,
	 constraint fk_yxh_t foreign key (yxh) references d(yxh) on delete cascade on update cascade
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '教师表';


insert into t values('0101', '陈迪茂', '男', '1973-03-06',	'副教授', 3567.00, '01');
insert into t values('0102',	'马小红',	'女',	'1972-12-08',	'讲师',	2845.00,	'01');
insert into t values('0201',	'张心颖',	'女',	'1960-01-05',	'教授',	4200.00,	'02');
insert into t values('0103',	'吴宝钢',	'男',	'1980-11-06',	'讲师',	2554.00,	'01');


use school;
drop table if exists c;
-- 课程表
create table c(
	 kh char(8) not null comment '课号',
	 km varchar(20) not null comment '课名',
	 xf int not null default 4 comment '学分',
	 xs int not null default 40 comment '学时',
	 yxh char(2) not null comment '院系号',
	 primary key (kh) using btree,
	 constraint fk_yxh_c foreign key (yxh) references d(yxh) on delete cascade on update cascade
);

insert into c values('08305001',	'离散数学',	4,	40,	'01');
insert into c values('08305002',	'数据库系统',	4,	50,	'01');
insert into c values('08305003',	'数据结构与算法',	    4,	50,	'01');
insert into c values('08305004',	'系统结构',	    6,	60,	'01');
insert into c values('08301001',	'分子物理学',	4,	40,	'03');
insert into c values('08302001',	'通信学',	3,	30,	'02');


use school;
drop table if exists o;
-- 开课表
create table O (
	xq varchar(25) not null comment '学期',
	kh char(8) not null comment '课号',
	gh char(4) not null comment '工号',
	sksj varchar(30) not null comment '上课时间',
	primary key (xq, kh, gh) using btree,
	constraint fk_kh_o foreign key (kh) references c(kh) on delete cascade on update cascade,
	constraint fk_gh_o foreign key (gh) references t(gh) on delete cascade on update cascade
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '开课表';

insert into O values('2022-2023秋季',	'08305001',	 '0103',	'星期三5-8');
insert into O values('2022-2023冬季',	'08305002',	 '0101', 	'星期三1-4');
insert into O values('2022-2023冬季',	'08305002',	 '0102',	'星期三1-4');
insert into O values('2022-2023冬季',	'08305002',	 '0103',	'星期三1-4');
insert into O values('2022-2023冬季',	'08305003',	 '0102',	'星期五5-8');
insert into O values('2023-2024秋季',	'08305004',	 '0101',	'星期二1-4');
insert into O values('2023-2024秋季',	'08305001',	 '0102',	'星期一5-8');
insert into O values('2023-2024冬季',	'08302001',	 '0201',	'星期一5-8');



use school;
drop table if exists e;
-- 成绩表
create table e(
	xh char(4) not null comment '学号',
	xq varchar(25) not null comment '学期',
	kh char(8) not null comment '课号',
	gh char(4) not null comment '工号',
	pscj int comment '平时成绩',
	check(pscj >= 0 and pscj < 101),
	kscj int comment '考试成绩',
	check(kscj >= 0 and kscj < 101),
	zpcj int comment '总评成绩',
	check(zpcj >= 0 and zpcj < 101),
	primary key (xh, xq, kh, gh) using btree,
	constraint fk_xh_e foreign key (xh) references s(xh) on delete cascade on update cascade,
	constraint fk_xq_e foreign key (xq) references o(xq) on delete cascade on update cascade,
	constraint fk_kh_e foreign key (kh) references o(kh) on delete cascade on update cascade,
	constraint fk_gh_e foreign key (gh) references o(gh) on delete cascade on update cascade
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '成绩表';

insert into e values(1101,	'2022-2023秋季',	'08305001',	 '0103',	60,	60,	60);
insert into e values(1102,	'2022-2023秋季',	'08305001',	'0103',	87,	87,	87);
insert into e values(1102,	'2022-2023冬季',	'08305002',	'0101',	82,	82,	82);
insert into e values(1102,	'2023-2024秋季',	'08305004',	'0101',	null,	null,	null);
insert into e values(1103,	'2022-2023秋季',	'08305001',	'0103',	56,	56,	56);
insert into e values(1103,	'2022-2023冬季',	'08305002',	'0102',	75,	75,	75);
insert into e values(1103,	'2022-2023冬季',	'08305003',	'0102',	84,	84,	84);
insert into e values(1103,	'2023-2024秋季',	'08305001',	'0102',	null,	null,	null);
insert into e values(1103,	'2023-2024秋季',	'08305004',	'0101',	null,	null,	null);
insert into e values(1104,	'2022-2023秋季',	'08305001',	'0103',	74,	74,	74);
insert into e values(1104,	'2023-2024冬季',	'08302001',	'0201',	null,	null,	null);
insert into e values(1106,	'2022-2023秋季',	'08305001',	'0103',	85,	85,	85);
insert into e values(1106,	'2022-2023冬季',	'08305002',	'0103',	66,	66,	66);
insert into e values(1107,	'2022-2023秋季',	'08305001',	'0103',	90,	90,	90);
insert into e values(1107,	'2022-2023冬季',	'08305003',	'0102',	79,	79,	79);
insert into e values(1107,	'2023-2024秋季',	'08305004',	'0101',	null,	null,	null);
insert into e values(1107,	'2023-2024冬季',	'08302001',	'0201',	100,	100,	100);

create index idx1 on s(yxh asc, xm desc) using btree; 
show index from s; 
create index idx2 on c(km) using btree;
show index from e; 

drop table if exists Account;
create table Account(
	usr char(33) not null comment '用户名',
	pwd char(33) not null comment '密码',
	primary key (usr) using btree
) engine = InnoDB default charset = utf8mb4 collate utf8mb4_general_ci comment = '账户表';
