> install.packages('rvest')
 
 #pull in the rvest lib so we can use the specific commands
> library(rvest)
 
#load the website address into a vector called URL (watch the case)
URL <- "http://www.whittinghamparishcouncil.org.uk/agenda-minutes.php"
 
#Use the read_html() instruction to read the HTML code from the website we set in URL
allMinsHTML <- read_html(URL)
 
#Use the html_nodes() instruction to read the specific bits that we want from the website we set in URL. Identifying the right 'nodes' is the real challenge in scrapping the page and there are several tools that can help you pin things down.  This example takes all the links that are marked with the class pdf from the part of the webpage within the div called #accordion. 
 
minList <- html_nodes(allMinsHTML, "#accordion a.pdf")
 
#When we look at the vector minList we can see there are 50 elements each with all the code for the link to the minutes file. 
 
minList

#The next step is to break that down into useful content.  The most obvious thing we need is the actual URL. We can get that using Rvest's html_attr() function which identifies an attribute and gives us the content. The link is in the href attribute. 
 
minLinks <- html_attr(minList, "href")
 
# Looking at minLinks shows us just the text for each link
 
minLinks

#We can also do something similar to get the date of minutes. This time we'll use the html_text() function. This will extract the text between the <a> </a> tags in minList
 
minDate <- html_text(minList)
 
# A quick look at minDate should give us a nice list of dates. 
 
minDate
 
#At the moment we have a vector with our links and one with our dates. What we really need to pull those together in a structured way.  One way of doing this is to create a data frame.Think of a data.frame like a table (although it isn't) and each of our separate lists of columns that just need to be combined. 
 
minuteData <- data.frame("Date"=minDate,"Link"=minLinks, stringsAsFactors=FALSE)
 
#To see the finsihed data frame  could simply call minuteData like we have with our other vectors but a View() will give a more obvious presentation 
 
View(minuteData)
 
#Feeling brave? You could do it all in one by combining all the elements. The key here is the %>% which steps through each command so html_nodes(allMinsHTML, "#accordion a.pdf") %>% html_text() gets the html for all the links and then extracts the text. 
 
minuteData <- data.frame( "Date"= html_nodes(allMinsHTML, "#accordion a.pdf") %>% html_text(),"Link"=html_nodes(allMinsHTML, "#accordion a.pdf") %>% html_attr("href"), stringsAsFactors=FALSE)

#The last thing to do is to write the data out so we can use it later. Lets send it to a CSV file. If you're not sure where it will be saved use the getwd() command 
 
write.csv(minuteData, "minuteData.csv")
