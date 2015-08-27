---
title: Coming Soon
layout: page
permalink: /:path/:basename/
---

{% assign upcoming_books = site.books | where: 'availability', 'soon' | sort: 'date' %}
{% if upcoming_books.size > 0 %}
{% for book in upcoming_books %}
{{ book.title }}
{% endfor %}
{% else %}
We are working on our next release.

In the meantime,
here are some things you can do:

Check out [our new releases](/).

Browse [our whole catalog](/books/).

Follow us [on Facebook](https://www.facebook.com/DriscollBrookPress).
{% endif %}
