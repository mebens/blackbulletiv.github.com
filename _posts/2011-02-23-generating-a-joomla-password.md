---
layout: post
title: Generating a Joomla Password (for reseting)
date: 2011-02-23 12:34:00
category: Tutorials
tags:
  - cryptography
  - Joomla
  - PHP
  - web development
---



I recently found myself in the awkward situation of having only a Super Admin user in the Joomla installation, and neither I nor my client knew the password. I had to the fix the problem, and I decided to do so by generating a Joomla user password (which required a lot of searching through code, mind you). Here's the PHP code I used:

{% highlight php %}
<?php
// JUserHelper class from libraries/joomla/user/helper.php
$pwd = 'my_new_password';
$instance = new JUserHelper();
$salt = $instance->genRandomPassword(32);
$final_pwd = $instance->getCryptedPassword($pwd, $salt) . ':' . $salt;
?>
{% endhighlight %}

(Note that I have to use the &lt;?php tags to get syntax highlighting to work properly.)

This is the technique Joomla uses to generate a password when a password reset is requested. The JUserHelper class provides the hashing functions we need. A Joomla password is made up of two sections separated by a colon; the first is the hashed password, and the second is the salt used to hash it.

However, for a simple technique, that will work just fine, you can use the md5 function:

{% highlight php %}
<?php
$pwd = md5('my_new_password');
?>
{% endhighlight %}

Or even an SQL query:

{% highlight sql %}
UPDATE jos_users SET password = MD5('password') WHERE id = <user_id_here>;
{% endhighlight %}

But that's not the standard Joomla way of doing it. If you used the PHP code, you can update the user with this query:

{% highlight sql %}
UPDATE jos_users SET password = <password_here> WHERE id = <user_id_here>;
{% endhighlight %}

Hope that helps.
