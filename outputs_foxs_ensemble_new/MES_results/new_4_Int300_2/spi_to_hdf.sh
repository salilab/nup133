TARGET=Int300_2_B10100001_MSE

for FILE in fine_match-*.spi
do
    echo $FILE
    e2proc2d.py $FILE $TARGET.hdf
done

