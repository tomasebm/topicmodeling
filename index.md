[![Twitter Follow](https://img.shields.io/twitter/follow/tomasebm?style=social)](https://twitter.com/tomasebm)
[![GitHub repo size](https://img.shields.io/github/repo-size/tomasebm/topicmodeling)](https://github.com/tomasebm/topicmodeling/)

# ¡Hola!

En este repositorio se encuentra todo lo necesario para replicar [esta tesis de grado.](https://drive.google.com/file/d/1WCtX9UaLi21UN-yqkNNtShOcmj_tqdNm/view?usp=sharing) Me podés contactar en **[@tomasebm](https://twitter.com/tomasebm)** por cualquier consulta.


### Paso 1 - Consulta a la base de datos GDELT

Lo primero que vamos a hacer es traer los links de la base de datos [GDELT](https://www.gdeltproject.org/). Para ello, debemos ingresar con nuestro usuario al servicio de Google Cloud, [Google Big Query](https://cloud.google.com/bigquery). La consulta se puede hacer tanto desde la consola de Google Cloud como usando algún paquete que interactúe desde el propio código. Te sugiero que uses [este script](https://github.com/tomasebm/topicmodeling/blob/main/consultabigquery.py) hecho en Python. De todas maneras, si querés hacerlo por consola, dentro del mismo está la consulta SQL.

### Paso 2 - Scrap

[Acá te dejo el script](https://github.com/tomasebm/topicmodeling/blob/main/scraper.py) que usé para scrapear todos los diarios. Lo monté en un servidor Lightsail de AWS (Amazon Web Services). El script trabaja con una base Sqlite, por lo que luego quedaría el paso de exportar esa base como un archivo .csv y continuar el proceso.

### Paso 3 - Preprocesamiento y modelización

Podés encontrar en [este notebook de Jupyter](https://github.com/tomasebm/topicmodeling/blob/main/notebook.ipynb) el preprocesamiento y la modelización. Las stopwords [están acá](https://github.com/tomasebm/topicmodeling/blob/main/stopwords.txt).

### Paso 4 - Visualizaciones

Finalmente, las visualizaciones las podés hacer con este [este código en R](https://github.com/tomasebm/topicmodeling/blob/main/VizTopic_TOM.R).


