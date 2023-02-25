import streamlit as st

import src.soporte_api as sa
import src.soporte_imagenes as si

st.image("imagenes/portada.png")
st.markdown("# Bienvenidos")

lista = st.text_input("Introduce el link a tu lista de reproducción", "")
numero = st.text_input('¿Cuántas canciones tiene tu lista de reproducción?', "")

if st.button("Clica aqui para empezar"):

    with st.spinner('Espera mientras realizamos la llamada a la API'):
        log = sa.credenciales()

        resultado_api = sa.sacar_canciones(log, lista, numero)

        df_canciones = sa.limpiar_canciones(resultado_api)
        st.success('Listo! Ya tenemos todas las canciones de tu lista de reproducción, aquí las tienes')

        num_usuarios, num_canciones, num_artistas = sa.big_numbers(df_canciones)
        
        
        col1, col2, col3 = st.columns(3)
        with col1:
            
            st.markdown('<h1 style="text-align: center; color: #1DB954;">Usuarios</h1>', unsafe_allow_html=True)
            st.markdown(f'<h3 style="text-align: center;">{num_usuarios}</h3>', unsafe_allow_html=True)

        with col2:
            st.markdown('<h1 style="text-align: center; color: #1DB954;">Canciones</h1>', unsafe_allow_html=True)
            st.markdown(f'<h3 style="text-align: center;">{num_canciones}</h3>', unsafe_allow_html=True)
        with col3:
            st.markdown('<h1 style="text-align: center; color: #1DB954;">Artistas</h1>', unsafe_allow_html=True)
            st.markdown(f'<h3 style="text-align: center;">{num_artistas}</h3>', unsafe_allow_html=True)
        
        st.dataframe(df_canciones[["song", "usuario"]], width=700, height=200)
        
        df_popularity = df_canciones.explode("artist")
        df_popularity = df_popularity.groupby("artist")["popularity"].mean().reset_index().sort_values(by= "popularity", ascending = False).head(10)
        #st.plotly_chart(si.crear_barplot(df_popularity, "artist", "popularity"))
        si.crear_barplot(df_popularity, "artist", "popularity")
        st.image("imagenes/barplot.png")
        
else:
    pass