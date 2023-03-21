#对于数据库的操作
create database `sql`;  创建数据库
drop database `sql`; 删除数据库
show databases; 展示所有的数据库
use `sql`;  在这一数据库中进行操作


#对于表的字段/属性的操作
create table `student`(
  id int
  name varchar(32)
  score decimal(3,1)
  birth_date date
  insert_time timestamp
); 创建表
drop table `student`;
describe/desc `student`;  查看表的字段/属性
alter table `student` add gpa decimal(3,2); 增加表中字段（列）
alter table `student` drop column gpa;  删除表中属性（列）

# 对于表中内容的操作
insert into `student` values(...);  增加
delete from `student` where `score` <= 60;  删除
update `student` set name = '...' where id = ...; 改
select * from `student`;  查看

#对于表中查找的操作
select * from `student`;  查看表中全部内容
select `id`, `name`, `score` from `student`;  查看表中部分内容

排序： select * from `student` order by `score`; 升序
      select * from `student` order by 'score' desc limit 3; 降序+只看前3行数据
      
聚合函数： select count(*) from `employee`;  取得所有员工人数=求得多少条数据
          select count(*) from `employee` where `birth_date` > `1970-10-01` and `sex` = `F`;  符合条件下的多少行数据
          select avg(`salary`) from `employee`; 求得平均值
          select sum(`salary`) from `employee`; 求和
          select max(`salary`) from `employee`; 
          select min(`salary`) from `employee`;
          
模糊搜索： select * from `client` where `phone` like '%335'; 查找尾号为335的数据
          select * from `employee` where `birth_date` like `%12%`;  查找12月的
          
表的上下合并union： select `emp_id`, `name` from `employee` union select `client_id`, `client_name` from `client`;

表的左右链接join： select * from `employee` join `branch` on `emp_id` = `manage_id`; 
           select `employee`.`emp_id`. `employee`.`name`, `branch`.`branch_name` from `employee` left join `branch` on `employee`.`emp_id` = `branch`.`manage_id`;  
           回传的是左表格的全部加上满足条件的右表格，其余补足null；
   
子查询：  select `name` from `employee` where `emp_id` = (select `manage_id` from `branch` where `branch_name` = `研发`); 嵌套查询
         select `name` from `employee` where `emp_id` in (select `emp_id` from `works_with` where `total_sales` > 50000); 当后一个查找有多种情况时
         
  foreign key (`manager_id`) references `employee`(`emp_id`) on delete set null； 当employee表中的emp_id被删除时，相应的manage_id就变为null
  foreign key(`client_id`) references `client`(`client_id`) on delete cascade； 当删除时，相应表中的整行删除
