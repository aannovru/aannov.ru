---
layout: default
title: Анонимные Алкоголики Нижний Новгород
aa_ru: Анонимные Алкоголики
aa_ru_nn: Анонимные Алкоголики Нижний Новгород
phone: "+79601979248"
home_ru: Главная
---

{% for post in site.posts %}
<article class="post">
    <!--<time>{{ post.date | date_to_string }}</time>-->
    <h2><a rel="bookmark" href="{{ post.url }}">{{ post.title }}</a></h2>
</article>
{% endfor %}
