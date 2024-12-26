## 学生课程成绩管理系统


### 项目简介
参考自[StudentSystem](https://github.com/2019ZSS/StudentSystem?utm_source=chatgpt.com)
```
    这是一个基于Python Pyqt5实现的学生课程成绩管理系统。
    C/S 模式
    用户面向：学生和老师

    主要功能模块有课程管理和成绩管理
    课程管理模块：
        学生可以进行本学期的课程查询，选课，退课，课程表查询，查询所修过的所有课程。
        教师可以开设本学期课程或者撤销开设的课程
    成绩管理模块：
        学生查看学期成绩单
        教师评定每门课程学生成绩

    项目意义：学习数据库相关知识并进行实际项目生产。(为了完成俺们的数据库期末大作业的动手实践(逃))
```

### 项目环境
```
    项目实现: python3.7 + mysql
    python相关包: Pyqt5, pymysql, numpy
     
    项目有关的数据库：
    基于(数据库原理)上课所学
    1. 使用的六个基本数据表: 学生表，教师表，院系表，课程表，开课表，选课表.
    2. 新创建的一个用户表。
    数据表具体创建可参见 create.sql
```

### 项目目录
```

    --APP(程序运行主目录)
        main.py(从此文件运行整个项目运行)
        login.py
        register.py
    --BACK(后台数据库接口实现)
        util.py
        course.py
        score.py
    --Course(课程管理模块)
        Student
        Teacher
    --Score(成绩管理模块)
        Student
        Teacher
    --image(程序图标存放)
```

### 仍旧存在的问题
1. 当老师本学期未开任何课时，成绩查询按钮单击会导致程序崩溃

### 如何运行
1. 确保你安装了上“项目环境”中的python包
2. 确保你安装了mysql 8.x 以上版本（可参考此链接教程安装：<a href="https://www.cnblogs.com/canfengfeixue/p/18002244">mysql安装教程</a>）
3. 在mysql中运行文件[create.sql](./create.sql)创建对应数据库和数据表
4. 修改[util.py](./BACK/util.py)中的数据库连接信息为你自己的mysql信息
```python
mysql_info = {
            'host': 'localhost', # 数据库地址
            'user': 'root', # 数据库用户身份
            'password': '123456', # 数据库用户对应的密码密码
            'db': 'school', # 数据库的名字
            'charset': 'utf8', # 数据库编码方式
            'autocommit': True}
db = Database(mysql_info)
```
5. 运行[main.py](./APP/main.py)即可
