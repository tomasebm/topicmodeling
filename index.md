# ¡Hola!

En este repositorio se encuentra todo lo necesario para replicar [ésta tesis de grado.](https://github.com/tomasebm/topicmodeling/edit/gh-pages/index.md) Me podés contactar [acá](https://github.com/tomasebm/topicmodeling/edit/gh-pages/index.md) si encontrás algún problema al querer replicarla.


### Paso 1 - Consulta a la base de datos GDELT

Lo primero que vamos a hacer es traer los links de la base de datos [GDELT](https://www.gdeltproject.org/). Para ello, debemos ingresar con nuestro usuario al servicio de Google Cloud, [Google Big Query](https://cloud.google.com/bigquery). La consulta se puede hacer tanto desde la consola de Google Cloud como usando algún paquete que interactúe desde el propio código. Te sugiero que uses [éste script](https://github.com/tomasebm/topicmodeling/blob/main/consultabigquery.py) hecho en Python. De todas maneras, si querés hacerlo por consola, dentro del mismo está la consulta SQL.

### Paso 2 - Preprocesamiento y modelización

Podés encontrar en [éste notebook de Jupyter](https://github.com/tomasebm/topicmodeling/edit/gh-pages/index.md) el preprocesamiento
