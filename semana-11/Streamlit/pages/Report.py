import streamlit as st
import pandas as pd
import src.soporte_api as sa
import src.soporte_imagenes as si

st.write("En esta página visualizaremos algunos de los principales resultados de la lista de reproducción")

df = pd.read_csv("datos/musica_part.csv", index_col = 0)

log = sa.credenciales()

with st.spinner('Espera mientras realizamos la llamada a la API'):
    df_features = sa.sacar_features(df, log)
    
si.crear_radar(df_features)
st.image("imagenes/radar.jpg")