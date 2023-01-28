import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

def sacar_populares(df):
    df = df.explode('artists')

    populares = df.groupby(['artist'])['popularity'].mean().reset_index().sort_values(by='popularity', ascending=False).head(10)
    sns.barplot(data = populares, y = 'artist', x = 'popularity', color = '#1DB654')

    plt.xlabel('')

    plt.tight_layout()
    ##guardo el chart
    ##como me lo ejecuta desde el main, puedo poner la ruta de imágenes para que me lo guarde de forma directa
    plt.savefig('imagenes/popularidad.png')
