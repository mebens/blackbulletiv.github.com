---
layout: page
title: Games
---

These are the video games I've made and released.

{% for game in site.games %}
  <h2><a href="/{{ site.game_dir }}/{{ game.slug }}" class="dark-link">{{ game.title }}</a></h2>
  {% if game.description %}<p class="low-top">{{ game.description }}</p>{% endif %}
{% endfor %}
