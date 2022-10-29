import requests
import bs4
import urllib.request


webpage_url = "https://www.gutenberg.org/browse/scores/top#books-last30"
webpage_html = requests.get(webpage_url)
webpage_parsed_html = bs4.BeautifulSoup(webpage_html.content, 'html.parser')

pageList = webpage_parsed_html.find("h2", {"id": "books-last30"})
ol = pageList.find_next_sibling("ol")
download_link_list = []

book_list = {}


def collect_all_download_link(count):
	for x in ol.findAll('li'):
		# print(x.a.text, '19')
		url = x.a['href']
		link = 'https://www.gutenberg.org/files/' + url.split('/')[2] + '/' + url.split('/')[2] + '.txt'
		if(len(book_list) < count):
			book_list[x.a.text] = {
				"book_name": x.a.text,
				"download_link": link,
			}

collect_all_download_link(2)
for key in book_list:
	print("Book Name", key)