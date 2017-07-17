#!/usr/bin/env python2.7

import re
import requests

PLANET_TITLE        = 'Notre Dame - Computer Science and Engineering'
PLANET_DESCRIPTION  = 'News articles regarding Computer Science and Engineering at Notre Dame'
PLANET_URL          = 'http://www3.nd.edu/~pbui/static/rss/csenews.xml'
PLANET_SOURCE	    = 'http://cse.nd.edu/news'

r = requests.get(PLANET_SOURCE)
t = ''.join(map(unicode.strip, r.text.splitlines()))
x = '<div class="newsListing"><h2><a href="([^"]*)">([^<]*)</a></h2>.*?<a href="http://cse.nd.edu/author/([^"]*)">.*?Date:([^<]+)<.*?<p>(.*?)</p>.*?</div></div>'

articles = [{'author': a, 'title': t, 'link': l, 'published': p, 'summary': s} for l, t, a, p, s in re.findall(x, t)]

print u'''<rss version="2.0">
<channel>
<title>{planet_title}</title>
<link>{planet_url}</link>
<description>
{planet_description}
</description>'''.format(planet_title       = PLANET_TITLE,
                         planet_url         = PLANET_URL,
                         planet_description = PLANET_DESCRIPTION)

for article in articles:
    print u'''<item>
<title>{article_title}</title>
<author>{article_author}</author>
<link>{article_link}</link>
<source>{article_source}</source>
<guid>{article_id}</guid>
<pubDate>{article_published}</pubDate>
<description>{article_summary}</description>
</item>'''.format(article_title     = article['title'],
                  article_author    = article['author'],
                  article_link      = article['link'],
                  article_source    = PLANET_SOURCE,
                  article_id        = article['link'],
                  article_published = article['published'],
                  article_summary   = article['summary'].encode('ascii', 'ignore'))

print '''</channel>
</rss>'''
