---
title: Available Now
---

{% assign books = site.books | sort: 'title' %}
{% for book in books %}
{% unless book.availability == 'soon' %}
{{ book.title }}
{% endunless %}
{% endfor %}
