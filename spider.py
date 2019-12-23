from grab import Grab

spider = Grab()
main_domain = 'https://news.ycombinator.com/'
spider.go(main_domain)
items = spider.doc('//td[@class="title"]/a[@class="storylink"]')

links = items.attr_list('href')
links = list(map(lambda url: url if 'https://' in url or 'http://' in url else "{}{}".format(main_domain, url), links))
title = items.text_list()

result = list(zip(links, title))