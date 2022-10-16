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
mywebpage_text = getpagetext(webpage_parsed_html)
print(mywebpage_text)