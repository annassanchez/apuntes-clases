import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import os
from dotenv import load_dotenv
load_dotenv()
import pandas as pd

def credenciales():
    CLIENT_SECRET = os.getenv("secret")
    CLIENT_ID = os.getenv("id")
    print(CLIENT_ID)
    print(CLIENT_SECRET)
    credenciales = SpotifyClientCredentials(CLIENT_SECRET, CLIENT_ID)
    sp = spotipy.Spotify(client_credentials_manager = credenciales)
    return sp

def sacar_canciones(conexion, url, numero_canciones):
    playlist_URI = url.split("/")[-1].split("?")[0]
    numero_canciones = int(numero_canciones[0]) +1

    offset = 0
    todas_canciones = []
    for i in range(numero_canciones):
        todas_canciones.append(conexion.playlist_tracks(playlist_URI, offset=offset)["items"])
        offset += 100
    return todas_canciones

def limpiar_canciones(lista_canciones):
    basic_info = {"song": [], "artist": [], "date": [], "explicit": [], "uri": [], "popularity": [], "usuario": [], "links": [], 'uri_artista': []}
    for i in range(len(lista_canciones)): 
        for z in range(len(lista_canciones[i])): 
            artista = []
            uris = []

            basic_info["uri"].append(lista_canciones[i][z]["track"]["uri"])
            basic_info["song"].append(lista_canciones[i][z]["track"]["name"])
            basic_info["date"].append(lista_canciones[i][z]["track"]["album"]["release_date"])
            basic_info["explicit"].append(lista_canciones[i][z]["track"]["explicit"])
            basic_info["popularity"].append(lista_canciones[i][z]["track"]["popularity"])
            basic_info["usuario"].append(lista_canciones[i][z]["added_by"]["id"])
            basic_info["links"].append(lista_canciones[i][z]["track"]["external_urls"]["spotify"])

            
            if len(lista_canciones[i][z]["track"]["artists"]) == 1:
                basic_info["artist"].append(lista_canciones[i][z]["track"]["artists"][0]["name"])
                basic_info["uri_artista"].append(lista_canciones[i][z]["track"]["artists"][0]["id"])

            else:
                for x in range(len(lista_canciones[i][z]["track"]["artists"])):
                    artista.append(lista_canciones[i][z]["track"]["artists"][x]["name"])
                    uris.append(lista_canciones[i][z]["track"]["artists"][x]["id"])
                basic_info["artist"].append(artista)
                basic_info["uri_artista"].append(uris)
                
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
        
        df["usuario"] = df["usuario"].map(mapa)
        df.to_csv("datos/musica_part.csv")
    return df
                

def big_numbers(df):
    
    df = df.explode("artist")
    numero_usuarios = len(df["usuario"].unique())
    numero_canciones = len(df["song"].unique())
    numero_artistas = len(df["artist"].unique())
    
    return numero_usuarios, numero_canciones, numero_artistas

def sacar_features(df, conexion):
    uris_canciones = df["uri"].unique().tolist()
    features = []

    for i in uris_canciones:
        features.append(conexion.audio_features(i))
    df_features = pd.DataFrame(features)
    df_features = df_features[0].apply(pd.Series)
    df_final = df.merge(df_features, on="uri", how = "inner")

        
    return df_final
    
