#!/usr/bin/env python
# coding: utf-8

# In[1]:


#package prince https://github.com/MaxHalford/prince
#MCA multiple correspondance analysis
#three or more categorical features


# In[1]:


#Importing the necessary package
import pandas as pd
import numpy as np
from prince import MCA#Dataset preparation with only numerical features
df = pd.read_csv('AASER_11CDR.csv')
print(len(df))
print(len(df.columns))
df


# In[564]:


df=df.set_index('CDR_name')
df


# In[565]:


#replace all dev with yes
df.replace("dev","yes",inplace=True)
df.replace("none","no",inplace=True)
df.replace("no","n",inplace=True)
df.replace("yes","y",inplace=True)
df.replace("ext","e",inplace=True)
df


# In[566]:


df.drop(['Java','term','archet','temp','extr','gdl','oauth2'],axis=1, inplace = True)
df


# In[568]:


mca = MCA(n_components = 2, n_iter = 3, random_state = 101)
mca.fit(df)
df_mca = mca.transform(df)
df_mca


# In[569]:


mca.explained_inertia_ #variance explained


# In[570]:


round(sum(mca.explained_inertia_)*100,1)


# In[571]:


mca.eigenvalues_


# In[572]:


mca.column_coordinates(df)


# In[573]:


#The result is like the PCA or CA result, two principal components with SVD result as the values. Just like previous techniques, we could plot the coordinates into a two-dimension graph.
mca.column_coordinates(df)
ax=mca.plot_coordinates(X =df,figsize=(8,8),show_row_points=True,show_row_labels=True, 
                     show_column_points=False, show_column_labels=False,
                    row_points_size=30, column_points_size=30)


# In[574]:


ax.set_title('CDR in Principal Coordinates')


# In[575]:


ax.get_figure().savefig('mca_coordinates_11cdr.svg')
ax.get_figure().savefig('mca_coordinates_11cdr.png')


# In[576]:


mca = MCA(n_components = 3, n_iter = 3, random_state = 101)
mca.fit(df)
df_mca = mca.transform(df)
df_mca


# In[577]:


print(df_mca.iloc[0,2])
index=df_mca.index
print(index[0])


# In[578]:


mca.explained_inertia_ #variance explained


# In[579]:


round(sum(mca.explained_inertia_)*100,1)


# In[580]:


mca.eigenvalues_


# In[581]:


mca.column_coordinates(df)


# In[583]:


get_ipython().run_line_magic('matplotlib', 'notebook')
import matplotlib.pyplot as plt

from mpl_toolkits.mplot3d import Axes3D


from matplotlib import interactive,pyplot
from mpl_toolkits.mplot3d import Axes3D
from numpy.random import rand
from pylab import figure

 
m=rand(3,3) # m is an array of (x,y,z) coordinate triplets
 
fig = figure()
ax = fig.add_subplot(projection='3d')
labels=['EHRBase', 'Better', 'Base24', 'Cabo', 'ArenaEHR', 'eWeave', 'EHRCare','Clever', 'EHRDB','RHP','EHRNet']
colors=['black', 'black', 'red','green', 'black','red','red','red','black','red','black']
markers=['o','p','>','*','H','^','<','v','D','1','2']
pippo=['EHRBase', 'Better,ArenaEHR,EHRDB', 'Base24', 'Cabo', 'Better,ArenaEHR,EHRDB', 'eWeave', 'EHRCare','Clever', 'Better,ArenaEHR,EHRDB','RHP','EHRNet']

for i in range(len(df_mca)): #plot each point + its index as text above
    ax.scatter(df_mca.iloc[i,0],df_mca.iloc[i,1],df_mca.iloc[i,2],color=colors[i],marker=markers[i],s=30,label=labels[i])

ax.set_xlabel(f'component 0 {round(mca.explained_inertia_[0]*100,1)}%', fontsize=14)
ax.set_ylabel(f'component 1 {round(mca.explained_inertia_[1]*100,1)}%', fontsize=14)
ax.set_zlabel(f'component 2 {round(mca.explained_inertia_[2]*100,1)}%', fontsize=14)

plt.show()






# In[584]:


ax.get_figure().savefig('3d_mca_coordinates_11cdr_t.svg')
ax.get_figure().savefig('3d_mca_coordinates_11cdr_t.png')


# In[556]:


df_mca.index


# In[557]:


mca.explained_inertia_


# In[558]:


df2_mca=df_mca.reindex(['Base24','eWeave','EHRCare','Clever','RHP','Cabo','EHRBase','ArenaEHR','Better','EHRDB','EHRNet'])
df2_mca


# In[559]:


symbols=['triangle-right','triangle-up','triangle-left','triangle-down','1','star','circle','circle-x','circle-cross','circle-cross-open','circle-dot']
s=dict(zip(df2_mca.index,symbols))
colors=['red', 'red', 'red','red', 'red','green','black','black','black','black','black']
c=dict(zip(df2_mca.index,colors))
for i,ss in enumerate(s):
    print(ss,s[ss],c[ss])


# In[309]:


df_mca


# In[560]:


import plotly.express as px

labels = {
    str(i): f'Comp {str(i+1)} {round(var*100,1)}%'
    for i, var in enumerate(mca.explained_inertia_)
}

fig = px.scatter_matrix(
    df2_mca,
    labels=labels,
    dimensions=range(3),
    color=df2_mca.index,
    color_discrete_map=c,
    symbol=df2_mca.index,
    symbol_map=s,
    height=800, width=800,
    size=[15]*11,size_max=12
)
fig.update_traces(diagonal_visible=True)
fig.show()


# In[561]:


fig.write_image('scatterplot3dcomponents_11CDR.svg')
fig.write_image('scatterplot3dcomponents_11CDR.png')


# In[562]:


df2=df.reindex(['Base24','eWeave','EHRCare','Clever','RHP','Cabo','EHRBase','ArenaEHR','Better','EHRDB','EHRNet'])
df2

