import requests
import bs4

webpage_url = "https://www.sis.uta.fi/~tojape/"
webpage_html = requests.get(webpage_url)
webpage_parsed_html = bs4.BeautifulSoup(webpage_html.content, 'html.parser')



def getpagetext(parsedpage):
	scriptelements = parsedpage.find_all('script')
	for scriptelement in scriptelements:
		scriptelement.extract()
	pagetext = parsedpage.get_text()
	return(pagetext)

def getpageurls(webpage_parsed):
	pagelinkelements = webpage_parsed.find_all('a')
	pageurls = [];
	for pagelink in pagelinkelements:
		pageurl_isok=1
		try:
			pageurl = pagelink['href']
		except:
			pageurl_isok=0
		if pageurl_isok == 1:
			if (pageurl.find('.pdf') !=-1)|(pageurl.find('.ps')!=-1):
				pageurl_isok = 0
			if (pageurl.find('http') ==-1 )|(pageurl.find('.fi')==-1):
				pageurl_isok = 0
		if pageurl_isok == 1 and pageurl not in pageurls:
			pageurls.append(pageurl)
	return(pageurls)
mywebpage_urls = getpageurls(webpage_parsed_html)
# print(mywebpage_urls)






def basicwebcrawler(seedpage_url,maxpages):
	num_pages_crawled = 0
	crawled_urls = []
	crawled_texts = []
	pagestocrawl=[seedpage_url]
	while (num_pages_crawled<maxpages)&(len(pagestocrawl)>0):
		pagetocrawl_url = pagestocrawl[0]
		print('Getting page:')
		print(pagetocrawl_url)
		pagetocrawl_html = requests.get(pagetocrawl_url)
		pagetocrawl_parsed = bs4.BeautifulSoup(pagetocrawl_html.content,'html.parser')
		pagetocrawl_text = getpagetext(pagetocrawl_parsed)
		pagetocrawl_urls = getpageurls(pagetocrawl_parsed)
		num_pages_crawled = num_pages_crawled + 1
		crawled_urls.append(pagetocrawl_url)
		crawled_texts.append(pagetocrawl_text)
		pagestocrawl = pagestocrawl[1:len(pagestocrawl)]
		pagestocrawl.extend(pagetocrawl_urls)
	return(crawled_urls, crawled_texts)
mycrawled_urls_and_texts = basicwebcrawler('https://www.sis.uta.fi/~tojape/',10)
mycrawled_urls = mycrawled_urls_and_texts[0]
mycrawled_texts = mycrawled_urls_and_texts[1]