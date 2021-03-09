# -*- coding: utf-8 -*-
"""
Created on Thu Aug 22 16:15:42 2019

@author: tmaguire
"""

from newspaper import Article
from bs4 import BeautifulSoup
import requests
import dask.dataframe as dd
import dataset

filename = 'masterempty.csv'
df = dd.read_csv(filename)
links = df['DocumentIdentifier']
db = dataset.connect('sqlite:///scrapnoticias.db')
table = db['noticias']

########################################################################################

def scraper(lista):

    for i in lista:
    

        if 'infobae' in i.lower():
            try:
                tituloinfobae = scraperinfobae(i)
                table.insert(dict(titulo = tituloinfobae[0],
                                  texto = tituloinfobae[1]))

            except Exception as x:
                xstr = str(x)
                table.insert(dict(titulo = xstr,
                                  texto = xstr))

        else:
            try:
                article = Article(url=i,language='es',request_timeout=20)
                article.download()
                article.parse()
                table.insert(dict(titulo = article.title,
                                  texto = article.text))
                
                
            except Exception as x:
                xstr = str(x)
                table.insert(dict(titulo = xstr,
                                  texto = xstr))
   
    
######################################################################################
    
def scraperinfobae(link):
        res = requests.get(link)
        soup = BeautifulSoup(res.text, 'lxml')
        articulo = soup.find('div', {'id': 'article-content'})
        texto = articulo.find_all('p')
        main =""
        pretitulo = str(soup.title.string)
        titulolimpio = pretitulo.replace('Infobae','')
        for i in texto :
            if 'seguí leyendo' in i.text.lower():
                break
            else:
                linea = i.text
                main += linea
        return titulolimpio, main

########################################################################################

scraper(links.compute())
    
    