import requests
import bs4
from urllib import request

webpage_url = "http://www.gutenberg.org/files/2554/2554-0.txt"
webpage_html = requests.get(webpage_url)
webpage_parsed_html = bs4.BeautifulSoup(webpage_html.content, 'html.parser')


response = request.urlopen(url)
raw = response.read()
text = raw.decode("utf-8-sig")