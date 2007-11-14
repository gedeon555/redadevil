for %%f in (../data/dev/*.sph) do ..\lib\sox12181\sox ..\data\dev\%%f -s ..\data\dev_wav/%%f.wav
pause