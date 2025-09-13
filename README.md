# binance-QuantitativeTrading
数字货币，币安Binance, 比特币BTC 以太坊ETH 莱特币LTC 量化交易系统 火币  交易策略 量化策略 自动交易

如果国内不能访问币安api，需要科学上网.

## 双均线策略
以 ETH 为例，5分钟K线数据，均线5 和 均线60 为例：

均线5上穿均线60是金叉，执行买入；
均线5下穿均线60是死叉，执行卖出；
![image](https://user-images.githubusercontent.com/18456518/119827775-18c59400-bf2c-11eb-821b-addda37b3b4a.png)
这是一个比较好的情况，可以赚一点钱。

<img width="1643" alt="image" src="https://user-images.githubusercontent.com/18456518/119828150-7b1e9480-bf2c-11eb-9443-d0d6c1f387ab.png">
这是一个比较震荡的情况，会亏损。


使用时，必须根据自身情况，调整 K线 和 均线！！！！


## 运行环境
python3

由于交易所的api在大陆无法访问，需要科学上网。

## 快速使用

1、获取币安API的 api_key 和 api_secret

2、注册钉钉自定义机器人Webhook，用于推送交易信息到指定的钉钉群

3、修改app目录下的authorization文件

```
api_key='Binance-key'
api_secret='Binance-secret'
dingding_token = '申请钉钉群助手的token'  
```


4、交易策略配置信息 strategyConfig.py
设置你的配置信息：

```
# 均线, ma_x 要大于 ma_y
ma_x = 5
ma_y = 60

# 币安
binance_market = "SPOT"#现货市场
kLine_type = '15m' # 15分钟k线类型，你可以设置为5分钟K线：5m;1小时为：1h;1天为：1d
```
当 kline 5 向上穿过 kline 60， 则执行买入。

当 kline 5 向下穿过 kline 60， 则执行卖出。

你可根据自己的喜好，调整 ma_x 和 ma_y 的值。 

你也可以调整 kLine_type ，来选择 5分钟K线、15分钟K线、30分钟K线、1小时K线、1天K线等；

不同的K线，最终效果也是不一样的。


5、同时交易多币种

run.py中

创建多个订单管理对象：
```
# 使用 USDT 购买 DOGE,限定最多100个USDT
orderManager_doge = OrderManager("USDT", 100,"DOGE", binance_market)
# 使用 USDT 购买 ETH,限定最多100个USDT
orderManager_eth = OrderManager("USDT", 100,"ETH", binance_market)
```

将orderManager_doge 和 orderManager_eth 加入定时执行的方法中：
```
def binance_func():
    orderManager_doge.binance_func()
    time.sleep(10)
    orderManager_eth.binance_func()

```

程序可同时监控 DOGE 和 ETH 的均线，并根据策略执行交易。
使用时，可根据自身需要，增加其他币种。



6、运行程序(记得先开科学上网)
```
python run.py
```



## 服务器部署
购买服务器，建议是海外服务器，可以访问币安API

### 我的配置：
Linux, 1核CPU, 2G内存(1G也可)

我是在雨云购买的香港服务器

也可选择 新加坡、other

## 钉钉信息截图
![image](https://user-images.githubusercontent.com/18456518/119217054-3cdb3c80-bb0a-11eb-9f66-60eb974bca46.png)










