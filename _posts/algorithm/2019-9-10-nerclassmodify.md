---
layout: blog
title: 分类抽取提升方法合肥合成作战项目验证
---

实体抽取提升验证记录


# 工作顺序

- 问题定位
- 问题建模
- 问题对策
- 对策验证
- 对策实施

# 问题定位
- 项目经理，引用用户标准，对于测试结果进行手动标注，评估随机50条结果，作为优化baseline



地址部分实测 50错36条对14条
主要为
对于电信诈骗业务理解不同所导致
嫌疑人居住地提取错误



- 算法与项目共同阅读文本，记录错误抽取样本共性问题

# 问题建模
- 用序列标注方法解决命名实体抽取问题,如果要达到较好的效果，需要,命名实体，在文法上具有稳定的上下文关系
- 案发地，居住地，户籍地，在文法上具有一定的逻辑性，推断性，序列标注方法解决蕴含逻辑推断的问题，效果有所下降


 分析部分参考 算法状态描述 https://scmsqhn.github.io/algorithm


# 问题对策

使用两个模型提升
1. 一个用来表达稳定文法关系中的人事地物
2. 另一个增加label，用来发现逻辑
3. 均使用BERT+GRU+CRF结构


# 对策验证


**思路**:
使用第一个发现命名实体的归属逻辑，属于报案人 嫌疑人 或者被害人
使用第二个模型发现命名实体的边界，属于人事地物
在第二个模型中发现的准确实体，在第一个模型中，进行查找归属逻辑

**此思路同分类**
在分类模型输出后
同时训练两样本是否属于同类的句子对二分类模型
用来提升模型输出

第一个模型输出
accuracy:98.71%; precision:83.45%; recall:87.53%; FB1:85.44
嫌疑人: precision:42.86%; recall:42.86%; FB1:42.867
嫌疑人QQ: precision:71.43%; recall:71.43%; FB1:71.4314
嫌疑人微信: precision: 100.00%; recall: 100.00%; FB1: 100.008
嫌疑人支付宝: precision: 0.00%; recall: 0.00%; FB1: 0.007
嫌疑人电话: precision: 100.00%; recall: 100.00%; FB1: 100.008
报案人: precision:94.59%; recall:92.11%; FB1:93.3337
报案人QQ: precision: 100.00%; recall: 100.00%; FB1: 100.0012
报案人学历: precision: 100.00%; recall: 100.00%; FB1: 100.004
报案人居住地: precision:88.46%; recall:88.46%; FB1:88.4626
报案人年龄: precision:72.73%; recall:66.67%; FB1:69.5711
报案人微信: precision: 100.00%; recall: 100.00%; FB1: 100.0010
报案人性别: precision:66.67%; recall:86.96%; FB1:75.4730
报案人户籍地: precision:88.00%; recall:88.00%; FB1:88.0025
报案人支付宝: precision: 0.00%; recall: 0.00%; FB1: 0.005
报案人电话: precision:82.76%; recall:85.71%; FB1:84.2129
报案人身份证: precision:87.10%; recall:90.00%; FB1:88.5231
报案人银行账户: precision: 100.00%; recall: 100.00%; FB1: 100.004
报案时间: precision: 100.00%; recall: 100.00%; FB1: 100.0019
案发地: precision:90.32%; recall:93.33%; FB1:91.8031
案发时间: precision:83.93%; recall:87.04%; FB1:85.4556
涉案总额: precision:88.37%; recall:90.48%; FB1:89.4143
涉案金额: precision:66.67%; recall:66.67%; FB1:66.6712

第二个模型输出
processed 9901 tokens with 409 phrases; found: 412 phrases; correct: 403.
accuracy:99.82%; precision:97.82%; recall:98.53%; FB1:98.17
QQ: precision: 100.00%; recall: 100.00%; FB1: 100.0026
人: precision:93.62%; recall:97.78%; FB1:95.6547
地址: precision:96.34%; recall:97.53%; FB1:96.9382
学历: precision: 100.00%; recall: 100.00%; FB1: 100.004
年龄: precision: 100.00%; recall:91.67%; FB1:95.6511
微信: precision: 100.00%; recall: 100.00%; FB1: 100.0018
性别: precision:95.83%; recall: 100.00%; FB1:97.8724
总金额: precision: 100.00%; recall: 100.00%; FB1: 100.0042
支付宝: precision: 100.00%; recall: 100.00%; FB1: 100.003
时间: precision:98.63%; recall:98.63%; FB1:98.6373
电话: precision:97.22%; recall:97.22%; FB1:97.2236
身份证: precision: 100.00%; recall: 100.00%; FB1: 100.0030
金额: precision: 100.00%; recall: 100.00%; FB1: 100.0012
银行账户: precision: 100.00%; recall: 100.00%; FB1: 100.004



