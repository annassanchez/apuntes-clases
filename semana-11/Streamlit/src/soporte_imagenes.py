import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt

def crear_barplot(df, ejex, ejey):
    
    plt.figure(figsize = (100, 40))
    # para definir el color que quiero
    fig = sns.barplot(data = df, x = ejex, y = ejey, color = "#1DB954")
    plt.xticks(rotation = 45, fontsize = 100 )
    plt.yticks(fontsize = 100 )

    plt.xlabel("", fontsize=100)
    plt.ylabel(ejey, fontsize=100)
    plt.tight_layout()
    plt.savefig("imagenes/barplot.png")
    
    
def crear_radar(df):
    
    df_numeric = df.select_dtypes(include = np.number).drop(["duration_ms", "tempo","popularity"], axis = 1)

    
    labels = df_numeric.columns.tolist()
    
    
    # create a list with the average of all features
    value=df_numeric.mean().tolist()
    fig = plt.figure(figsize = (18,18))
    # repeat first value to close the circle
    # the plot is a circle, so we need to "complete the loop"
    # and append the start value to the end.
    value.append(value[0])
    
    N=len(labels)
    # calculate angle for each category
    angles=[n/float(N)*2*np.pi for n in range(N)]
    angles.append(angles[0])


    # plot
    plt.polar(angles, value, color = "black")
    plt.fill(angles,value,alpha=0.5, facecolor='#1DB954')

    # plt.title('Discovery Weekly Songs Audio Features', size=35)

    plt.xticks(angles[:-1],labels, size=15)
    plt.yticks(size = 0)
    plt.savefig("imagenes/radar.jpg")

    
    
    
    