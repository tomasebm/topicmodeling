# -*- coding: utf-8 -*-
"""
Created on Sat Jan  2 06:50:53 2021

@author: Tom
"""

#############################
# importamos los paquetes ##
#############################
import pandas as pd
from google.cloud import bigquery
import os
from datetime import datetime, timedelta
##################################################################
# 'path' reemplazalo con la ruta donde querés guardar el archivo #
##################################################################
path = 'C:/gdelt/'
#############################################
# acá van tus credenciales de Google Cloud #
#############################################
os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="C:/gdelt/Gdelt-df3745683639.json"
client = bigquery.Client()
data = []
################################################
# Reemplazá las variables por la fecha deseada #
################################################
DATEfloor = "20150101"
DATEtop = "20170101"
TIMESTAMPfloor = "2015-01-01"
TIMESTAMPtop = "2017-01-01"
#############################################
#############################################
consulta = """
    SELECT
        DATE,
        DocumentIdentifier,
        V2Themes,
    FROM
        `gdelt-bq.gdeltv2.gkg_partitioned`
    WHERE
        DATE>=""" + str(DATEfloor) + """000000 and _PARTITIONTIME >= TIMESTAMP("""+ '"' + str(TIMESTAMPfloor)+ '"' """) 
    AND DATE<=""" + str(DATEtop) + """999999 and _PARTITIONTIME <= TIMESTAMP("""+ '"' + str(TIMESTAMPtop)+ '"' """) 
    AND (DocumentIdentifier like '%perfil.com%' OR DocumentIdentifier like '%lanacion.com.ar%' OR DocumentIdentifier like '%clarin.com%' OR DocumentIdentifier like '%minutouno.com%' OR DocumentIdentifier like '%pagina12.com.ar%' OR DocumentIdentifier like '%telam.com.ar%')
    AND V2Themes like '%CORONA%'
    ORDER BY DATE DESC"""

query_job = client.query(consulta)

results = query_job.result()  # Waits for job to complete.


for row in results:  # API request
    data.append({"DocumentIdentifier":row.DocumentIdentifier,"DATE":row.DATE,"V2Themes":row.V2Themes})

df = pd.DataFrame(data)
df.loc[df['DocumentIdentifier'].str.contains('pagina12.') == True, 'Medio'] = 'Página 12'
df.loc[df['DocumentIdentifier'].str.contains('clarin.') == True, 'Medio'] = 'Clarín'
df.loc[df['DocumentIdentifier'].str.contains('lanacion.') == True, 'Medio'] = 'La Nación'
df.loc[df['DocumentIdentifier'].str.contains('minutouno.') == True, 'Medio'] = 'MinutoUno'
df.loc[df['DocumentIdentifier'].str.contains('infobae.') == True, 'Medio'] = 'Infobae'
df.loc[df['DocumentIdentifier'].str.contains('perfil.') == True, 'Medio'] = 'Perfil'
df.loc[df['DocumentIdentifier'].str.contains('telam.') == True, 'Medio'] = 'Télam'
df['DATE'] = df['DATE'].astype(str)
df['DATE'] = df['DATE'].str[:-6]
df.reset_index(drop=True)
df.to_csv(path + 'desde' + DATEfloor + 'hasta' + DATEtop + '.csv',index=False)
