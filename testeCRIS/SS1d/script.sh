rm SS1d-Resultado/*.*
rmdir SS1d-Resultado
find | grep txt > indexBasicDataset.dat
aLine -i -l indexBasicDataset.dat -d SS1d-Resultado
aLine --convert -d SS1d-Resultado
aLine --similarity --features SS1d-Resultado/cache.txt -o SS1d-Resultado/similaridadeTextos.txt
