var rssfeed = new google.feeds.Feed("http://feeds.feedburner.com/getpocket/JxOK"); // URL of your feed, of course!
rssfeed.setNumEntries(3); // how many posts to pull
rssfeed.load(showEntries);
 
function showEntries(result)
{
    if(!result.error)
    {
        var feeds = result.feed.entries;
        var rssoutput = "";
        for(var i=0; i<feeds.length; i++)
        {				
            // REPLACE THIS WITH YOUR OWN HTML
            rssoutput += '<a href="' + feeds[i].link + '">' + feeds[i].title + '</a><br />';								
        }
        document.getElementById("latest-news").innerHTML = rssoutput;
        }
    }
}