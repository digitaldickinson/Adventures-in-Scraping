# Grabbing Parish council meeting minutes in Google sheets
 
We'll be using this webpage. http://www.whittinghamparishcouncil.org.uk/agenda-minutes.php 
 
+ Start a new google sheet
+ In A1 add the text ‘Date’ 
+ In B1 add the text ‘Link’
+ In A2 add the following formula. Note: don’t cut-and-paste this the formatting can cause problems. Type it out!

```
=IMPORTXML("http://www.whittinghamparishcouncil.org.uk/agenda-minutes.php", "//a[@class='pdf']")
```

When you hit enter the table should populate with dates. The key bit here is  

```
//a[@class='pdf']
``` 
This is xpath a way of navigating through the code to find the right part of the page. In this case we are looking for any link (a) with the class pdf. For example…

```
<a href="http://admin.easywebsites.co.uk/inc/whittinghamparishcouncil.org.uk/downloads/Mins Jan 17.pdf" target="_blank" title="Jan 2017" class="pdf">Jan 2017</a>
```
 
The formula pulls out the text of the page element selected. In this case that’s the text ‘Jan 2017’ between the <a..> </a> tags
 
In B2 add the following formula. Note: don’t cut-and-paste this the formatting can cause problems. Type it out!
 
 ```
=IMPORTXML("http://www.whittinghamparishcouncil.org.uk/agenda-minutes.php", "//a[@class='pdf']/@href")
```

This time we’ve added a little more direction for the formula. We’ve said find the links with the class pdf and then give is the contents of the href attribute. That’s the bit that contains the actual URL.
 
That’s it! 
 
(well it isn’t because there is an issue with the dates and all we are going to get a the other end of the link is a pdf but hey, give yourself a pat on the back anyway)
