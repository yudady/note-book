# anaconda （python 大補帖 : jupyter ipython ）


## web版的python
```
启动 :
cmd 输入 “ jupyter notebook ” 
```


## [Installing opencv](https://github.com/conda-forge/opencv-feedstock)


```
conda update -n base conda
conda search opencv --channel conda-forge



conda config --add channels conda-forge
conda install opencv
conda install -c anaconda numpy 
conda install matplotlib   // Matplotlib是Python主要的绘图库




检查
>>> import cv2
>>> cv2.__version__



```


## 安装其他套件(pip vs. conda)

1. pip installs python packages in any environment.
2. conda installs any package in conda environments.