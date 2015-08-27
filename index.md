---
title: New Releases
layout: page
permalink: /
---

{% assign new_releases = site.books | where: 'availability', 'new' | sort: 'date' | reverse %}
{% for book in new_releases %}
{{ book.title }}
{% endfor %}
