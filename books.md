---
title: Available Now
layout: page
permalink: /:path/:basename/
---

{% assign books = site.books | sort: 'title' %}
{% for book in books %}
{% unless book.availability == 'soon' %}
{{ book.title }}
{% endunless %}
{% endfor %}
