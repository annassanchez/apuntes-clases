import streamlit as st
import math
import src.soporteAPI as sa
import src.soporteImagenes as si

st.write('Hola, buenos días')
## tengo que meter un input -- voy a coger un text-input
##una vez ejecutado, mejor no lo cierres -- lo ejecutas desde anaconda prompt
playlist = st.text_input('Introduce el link a tu playlist')
num_canciones = st.text_input('¿Cuántas canciones tiene tu lista?')
##pages es para meter pestañas -- las meto desde la carpeta de pages y me creará un índice

if playlist != '' and num_canciones !='':
    num_canciones2 = sa.sacar_num_canciones(num_canciones)
    print(num_canciones2)

    sp = sa.credenciales

    lista_canciones = sa.sacar_canciones(playlist, num_canciones2, sp)
    df_canciones = sa.limpiar_datos(lista_canciones)
    st.dataframe(df_canciones[['usuario', 'canciones']], width=700, height=200)

    num_can, num_art, num_usu = sa.sacar_big_numbers(df_canciones)

    ##si quiero escribir markdown
    col1, col2, col3 = st.columns(3)
    with col1:
        st.markdown(f'# Número de ironhackers: {num_usu}')
    with col2:
        st.markdown(f'# numero artistas, {num_art}')
    with col3:
        st.markdown(f'# numero canciones, {num_can}')
    si.sacar_populares(df_canciones)
    st.image('imagenes/popularidad.png')

    usuarios = df_canciones['usuario'].unique().tolist()
    st.selectbox('Elige un ironhacker', ["Elige uno" + usuarios])

else:
    st.write('necesito tu data')