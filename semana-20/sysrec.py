# %% esto hace que tengas celdas
# libreries


import pandas as pd # data processing 


# sklearn libraries for preprocessing and model building 
from sklearn.compose import ColumnTransformer 
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.pipeline import Pipeline # tiene buena sinergia con el preprocessing
# le dices que te estandarice las columnas numéricas y ya te olvidas

# calculo de matriz de similitudes
from sklearn.neighbors import NearestNeighbors

# %%
print('hellowis')

# %%
imdb = pd.read_csv('data/imdb_top_1000.csv')
imdb.head()
# %%
## genero, director y estrellas
keeps_cols = ['Genre', 'Director', 'Star1', 'Star2', 'Star4']
# %%
imdb_keeps = imdb[keeps_cols]
imdb_keeps.head()
# %%
numeric_pipe = Pipeline([[ 'scaler', StandardScaler() ]])
# %%
categorical_pipe = Pipeline([[ 'onehot', OneHotEncoder() ]])
# %%
col_transformer = ColumnTransformer( [('numeric', numeric_pipe, imdb_keeps._get_numeric_data().columns.tolist()),
( 'categorical', categorical_pipe, imdb_keeps.select_dtypes(include=['object']).columns.tolist())
                                      ])
# %%
col_transformer_fit = col_transformer.fit(imdb_keeps)
# %%
col_transformer_trans = col_transformer_fit.transform(imdb_keeps)
col_transformer_trans

# %%
n_neighbors = 6

# metrica pones coseno -> como haces una matriz de 0 y 1 es más fácil encontrar distancia
nneighbors = NearestNeighbors(n_neighbors=n_neighbors, metric='cosine').fit(col_transformer_trans)
# %%

pelicula = 'The Godfather' #pelicula 1
pelicula = 'The Dark Knight Rises' #pelicula 2
peliculas_index = imdb[imdb['Series_Title'] == pelicula].index
peliculas_index
#peliculas = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# %%
dif, ind = nneighbors.kneighbors(col_transformer_trans[peliculas_index])
# dif es la distancia del padrino a cada uno de los elementos que tengo
# %%
ind # los indices que necesita para hacer el filtro
# %%
imdb.loc[ind[0][1:], :]
# %%
dif
## añadiendo más columnas, hay menos diferencia entre grupos -> disminuye la
# %%
