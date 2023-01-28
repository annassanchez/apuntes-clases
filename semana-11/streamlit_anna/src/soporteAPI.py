import sys
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd
import numpy as np
import os
from dotenv import load_dotenv
import math

##creo una función para meter las credenciales
def credenciales():
    CLIENT_SECRET = os.getenv("secret")
    CLIENT_ID = os.getenv("id")
    credenciales = SpotifyClientCredentials(CLIENT_ID, CLIENT_SECRET)
    sp = spotipy.Spotify(client_credentials_manager = credenciales)
    return sp

def sacar_num_canciones(num_canciones):
    num_canciones_input = int(num_canciones)
    if num_canciones_input < 100:
        return 1
    else: 
        return math.ceil(num_canciones_input / 100) 

def sacar_canciones(url, num_canciones, conexion):
    playlist_URI = url.split("/")[-1].split("?")[0]
    offset = 0
    all_data = []
    for i in range(num_canciones):
        all_data.append(conexion.playlist_tracks(playlist_URI, offset=offset)["items"])
        offset += 100
    return all_data

def limpiar_datos(resultados):
    basic_info = {"song": [], "artist": [], "date": [], "explicit": [], "uri": [], "popularity": [], "ironhacker": [], "links": []}
    for i in range(len(resultados)): 
        for z in range(len(resultados[i])): 
            artista = []

            basic_info["uri"].append(resultados[i][z]["track"]["uri"])
            basic_info["song"].append(resultados[i][z]["track"]["name"])
            basic_info["date"].append(resultados[i][z]["track"]["album"]["release_date"])
            basic_info["explicit"].append(resultados[i][z]["track"]["explicit"])
            basic_info["popularity"].append(resultados[i][z]["track"]["popularity"])
            basic_info["ironhacker"].append(resultados[i][z]["added_by"]["id"])
            basic_info["links"].append(resultados[i][z]["track"]["external_urls"]["spotify"])

            
            if len(resultados[i][z]["track"]["artists"]) == 1:
                basic_info["artist"].append(resultados[i][z]["track"]["artists"][0]["name"])
            else:
                for x in range(len(resultados[i][z]["track"]["artists"])):
                    artista.append(resultados[i][z]["track"]["artists"][x]["name"])
                basic_info["artist"].append(artista)
    df = pd.DataFrame(basic_info)
    mapa = {"1129644679": "Pau", 
    "alvarogcambronero": "Elisa", 
    "1183037273": "Ana", 
    "annxox": "Ana S", 
    "belen.gasset": "Belén", 
    "8epi76oaztyef2ws47q0lwcuz": "Amiga de Pau", 
    "11159625835": "Jorge", 
    "115724470": "Sindri", 
    "miriamplz": "Miriam",
    "4bkhftxifirml76m9kdv5m8tf": "Ana G", 
    "1180927307": "Paula",
    "2177d6zcret6mozpaakgowcna": "Lin", 
    "31usc6kzxaks4tdjv262fanxtxka": "Brandon"}
    
    df["usuario"] = df["ironhacker"].map(mapa)
    return df

def sacar_big_numbers(df):
    df = df.explode('artists')

    num_canciones = len(df['song'].unique())
    num_artistas = len(df['artists'].unique())
    num_ironhackers = len(df['usuario'].unique())

    return num_canciones, num_artistas, num_ironhackers