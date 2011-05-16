---
layout: post
title: Lua Performance Tests
category: General
tags:
  - Lua
  - programming
---

Just for some experimentation, I did some performance tests on a few operations in Lua. To time them I used the command, `time lua test.lua`, and took the "real" time. The test file was just a loop, which looped _20 million_ times:

{% highlight lua %}
for i = 1, 20000000 do --[[ code here ]] end
{% endhighlight %}

Alright, here's the results.

<table>
  <tr>
    <th>Description</th>
    <th>Seconds</td>
    <th>Loop Code</th>
    <th>Variable/Function Definition</th>
  </tr>

  <tr>
    <td>Empty function call</td>
    <td>1.249</td>
    <td>f()</td>
    <td>function f() end</td>
  </tr>

  <tr>
    <td>Return function call</td>
    <td>1.688</td>
    <td>f()</td>
    <td>x = 0<br />
        function f() return x end</td>
  </tr>

  <tr>
    <td>Assignment</td>
    <td>0.76</td>
    <td>x = 0</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td>Table property assignment</td>
    <td>1.097</td>
    <td>x.y = 'f'</td>
    <td>x = { y = 'f' }</td>
  </tr>

  <tr>
    <td>Table creation</td>
    <td>10.495</td>
    <td>x = { y = 'f' }</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td>Table sorting</td>
    <td>19.742</td>
    <td>table.sort(x)</td>
    <td>x = {'f', 'k', 'a', 'b', 'e'}</td>
  </tr>

  <tr>
    <td>Simple addition</td>
    <td>1.295</td>
    <td>x = x + 1</td>
    <td>x = 0</td>
  </tr>

  <tr>
    <td>Nothing</td>
    <td>0.144</td>
    <td>do end</td>
    <td>&nbsp;</td>
  </tr>
</table>

I think we can conclude that Lua is pretty fast.
