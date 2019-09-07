---
layout: default
title: My Blog
---
 
<div id="post-pagination" class="pagination">
{% if paginator.previous_page %}
<p class="previous">
{% if paginator.previous_page == 1 %}
<a href="/">Previous</a>
{% else %}
<a href="{{ paginator.previous_page_path }}">Previous</a>
{% endif %}
</p>
{% else %}
<p class="previous disabled">
<span>Previous</span>
</p>
{% endif %}
 
<ul class="pages">
<li class="page">
{% if paginator.page == 1 %}
<span class="current-page">1</span>
{% else %}
<a href="/">1</a>
{% endif %}
</li>
 
{% for count in (2..paginator.total_pages) %}
<li class="page">
{% if count == paginator.page %}
<span class="current-page">{{ count }}</span>
{% else %}
<a href="/page{{ count }}">{{ count }}</a>
{% endif %}
</li>
{% endfor %}
</ul>
 
{% if paginator.next_page %}
<p class="next">
<a href="{{ paginator.next_page_path }}">Next</a>
</p>
{% else %}
<p class="next disabled">
<span>Next</span>
</p>
{% endif %}
 
</div>


您好，泰岳成都算法团队的用户们,您可以在这获得您需要的部署，选型信息
让算法越来越好用的唯一途径就是,一直使用它 ---弗兰克西斯.培根
- 如何安装标准版
- 如何安装地址归一化服务
- 当前算法问题及对策解析
- 算法研发进度
