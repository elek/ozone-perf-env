echo "" > results
for i in `ls -1`; do
   rm tmp
   for j in `seq 1 6`; do
   echo "$i" >> tmp
   done

    cat $i/result | grep -oP '(?<=mean_rate=)([0-9.]+)' | paste tmp - > tmp2
    mv tmp2 tmp

    cat $i/result | grep -oP '(?<=Successful executions: )([0-9.]+)' | paste tmp - > tmp2
    mv tmp2 tmp

    cat $i/result | grep -oP '(?<=Total execution time \(sec\): )([0-9.]+)' | paste tmp - > tmp2
    mv tmp2 tmp

    cat $i/result | grep -oP '(?<=real)(.*)' | paste tmp - > tmp2
    mv tmp2 tmp
    cat tmp >> results
done
cat results
