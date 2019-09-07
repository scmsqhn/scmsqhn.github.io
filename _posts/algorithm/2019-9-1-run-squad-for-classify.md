---
layout: post
title: "使用解决蕴含逻辑判断和阅读理解问题的方案解决带有逻辑的分类问题"
book: true 
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-7-16/91630214.jpg
category: 算法
tags:
- 算法
- algorithm
redirect_from: 
- /2019/09/algorithmindex/
--- 
---

bert 分类任务 优化思路


## bert中英文效果差异
- 相同预料量级，相同应用场景下，英文比中文效果好约10%-20%

## 比较中英文差异并试图合理化这种差异
- 中文为大字符集，字符的数量比英文多
- 英文词汇的数量比较中文多，在自然科学领域，可以明显感觉到，中文的专用名词多为音译或字词拼接，相比较英文，中文的顺序更加重要，相似的字符不同的组合，可以得到完全不同的含义，即完全不同的向量维度
- 因为词的数量少，单词，概念边界就模糊，字与字的顺序就更加重要
- 在预训练不足，或者语料不足的情况下，矩阵对于顺序，组合的表达，对效果的影响较大

## 优化bert思路
- 如何能够更好的表达字与字的顺序，或组合形式,便可提升bert预测的效果
- 更加充分的预训练,确保字符顺序不确定的熵，尽可能少的影响结果
- bert解决位置的方式为增加一个position层，作为对于位置的补充,通过正序倒序进行提升

## 对策实现
- 将sequence_output+textcnn替代pooled_output用于文本分类模型的softmax部分
- 取消textcnn中的embedding直接使用bert的sequence_output
- 原有bert中position为顺序增加倒序 NG
- 更充分的预训练(实测中，预训练对结果特别是主题分类的提升最大))

## 代码
- 新增文件textcnn.py
- 修改文件run_classify.py

```
数据位置
> 60 /data/bert/data/glue_data/ultra_data
代码位置
> 60 /data/BERT-BiLSTM-CRF-NER/bert_base/bert/textcnn.py
> 60 /data/BERT-BiLSTM-CRF-NER/bert_base/bert/run_classify.py
输出位置
> 60 /tmp/mrpc_output/
训练轮数
> 3轮
样本情况
$ wc -l /data/bert/data/glue_data/ultra_data、*.tsv
9184 dev.tsv
9184 test.tsv
40088 train.tsv
58456 total
```

## 主要资料
- BERT 其内部的attention层
[bert encode-decode-att分析](https://www.jianshu.com/p/25fc600de9fb)

## 测试数据记录

function | step | rnd | acc

---|---|---|---

cnn | 25000 step | 10 round | 0.947 
base | 25000 step | 10 round | 0.936 
cnn | 1000 step | 0.3 round | 0.81  
base | 10000 step | 3 round | 0.78 
base | 6000 step | 2 round | 0.64 
base | 1000 step | 1 round | 0.47 
cnn | 1000 step | 0.3 round | 0.52  


```
graph TD
text-->bert
bert-->pooled_output
pooled_output-->outtext
```

```
graph TD
text-->bert
bert-->sequenced_output
sequenced_output-->textcnn
textcnn-->outtext
```
结论，在开始cnn有明显又是，后续不再明显，训练10轮后，只领先1.1%
这又是什么原因?
