## 本项目实现的最终作用是基于SSH实现的一个宠物商城
## 分为2个角色
### 第1个角色为管理员角色，实现了如下功能：
 - 公告管理
 - 商品分类管理
 - 新闻管理
 - 用户管理
 - 留言管理
 - 管理员登录
 - 管理商品
 - 订单管理
### 第2个角色为用户角色，实现了如下功能：
 - 个人信息管理
 - 个人订单管理
 - 加入购物车
 - 用户留言
 - 用户角色登录
 - 用户首页
 - 结算订单
## 数据库设计如下：
# 数据库设计文档

**数据库名：** ssh_cw_shop

**文档版本：** 


| 表名                  | 说明       |
| :---: | :---: |
| [t_bigtype](#t_bigtype) |  |
| [t_comment](#t_comment) |  |
| [t_news](#t_news) |  |
| [t_notice](#t_notice) |  |
| [t_order](#t_order) |  |
| [t_order_product](#t_order_product) |  |
| [t_product](#t_product) |  |
| [t_smalltype](#t_smalltype) |  |
| [t_tag](#t_tag) |  |
| [t_user](#t_user) | 用户表 |

**表名：** <a id="t_bigtype">t_bigtype</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | name |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 名字  |
|  3   | remarks |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |

**表名：** <a id="t_comment">t_comment</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | content |   varchar   | 1000 |   0    |    Y     |  N   |   NULL    | 内容  |
|  3   | createTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    | 创建时间  |
|  4   | nickName |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  5   | replyContent |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  6   | replyTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    |   |

**表名：** <a id="t_news">t_news</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | content |   text   | 65535 |   0    |    Y     |  N   |   NULL    | 内容  |
|  3   | createTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    | 创建时间  |
|  4   | title |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 标题  |

**表名：** <a id="t_notice">t_notice</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | content |   text   | 65535 |   0    |    Y     |  N   |   NULL    | 内容  |
|  3   | createTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    | 创建时间  |
|  4   | title |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 标题  |

**表名：** <a id="t_order">t_order</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | cost |   float   | 13 |   0    |    N     |  N   |       |   |
|  3   | createTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    | 创建时间  |
|  4   | orderNo |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  5   | status |   int   | 10 |   0    |    N     |  N   |       | 状态  |
|  6   | userid |   int   | 10 |   0    |    Y     |  N   |   NULL    | 用户ID  |

**表名：** <a id="t_order_product">t_order_product</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | num |   int   | 10 |   0    |    N     |  N   |       | 数量  |
|  3   | orderid |   int   | 10 |   0    |    Y     |  N   |   NULL    | 订单ID  |
|  4   | productid |   int   | 10 |   0    |    Y     |  N   |   NULL    | 商品ID  |

**表名：** <a id="t_product">t_product</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | description |   varchar   | 2000 |   0    |    Y     |  N   |   NULL    |   |
|  3   | hot |   int   | 10 |   0    |    N     |  N   |       |   |
|  4   | hotTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    |   |
|  5   | name |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 名字  |
|  6   | price |   int   | 10 |   0    |    N     |  N   |       | 价格  |
|  7   | proPic |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  8   | specialPrice |   int   | 10 |   0    |    N     |  N   |       |   |
|  9   | specialPriceTime |   datetime   | 19 |   0    |    Y     |  N   |   NULL    |   |
|  10   | stock |   int   | 10 |   0    |    N     |  N   |       |   |
|  11   | bigTypeId |   int   | 10 |   0    |    Y     |  N   |   NULL    |   |
|  12   | smallTypeId |   int   | 10 |   0    |    Y     |  N   |   NULL    |   |

**表名：** <a id="t_smalltype">t_smalltype</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | name |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 名字  |
|  3   | remarks |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  4   | bigTypeId |   int   | 10 |   0    |    Y     |  N   |   NULL    |   |

**表名：** <a id="t_tag">t_tag</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | name |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 名字  |
|  3   | url |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 网络地址  |

**表名：** <a id="t_user">t_user</a>

**说明：** 用户表

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  1   | id |   int   | 10 |   0    |    N     |  Y   |       | 自增主键  |
|  2   | ADDRESS |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 地址  |
|  3   | birthday |   datetime   | 19 |   0    |    Y     |  N   |   NULL    |   |
|  4   | dentityCode |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  5   | email |   varchar   | 45 |   0    |    Y     |  N   |   NULL    | 邮箱  |
|  6   | mobile |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 联系方式  |
|  7   | password |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 密码  |
|  8   | sex |   varchar   | 5 |   0    |    Y     |  N   |   NULL    | 性别  |
|  9   | status |   int   | 10 |   0    |    N     |  N   |       | 状态  |
|  10   | trueName |   varchar   | 255 |   0    |    Y     |  N   |   NULL    |   |
|  11   | userName |   varchar   | 255 |   0    |    Y     |  N   |   NULL    | 用户名  |

