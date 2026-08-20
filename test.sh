binary="bench interactive"

make clean; make

score=0

for file in $binary; do
    if [[ ! -f "$file" ]]; then
        echo "FAIL: $file not made"
        echo "SCORE: $score/7"
        break 
    fi
done


for (( i = 0; i < 2; i++ )); do
    echo "TEST: ./test $i"
    ./test $i > /dev/null
    if [ "$?" -eq 1 ]; then
    ((score+=1))
    else
    echo "  --FAIL!"
    fi
done



echo "TEST: plotted images are present"
if [ -f "plot-single.png" ]; then
    ((score+=1))
else
    echo "  --FAIL!"
fi

echo "TEST: plotted images are present"
if [ -f "plot-multi.png" ]; then
    ((score+=1))
else
    echo "  --FAIL!"
fi

echo "TEST: nice benchmarking"
if [ -f "bench-nice.sh" ] && [ -f "plot-nice.png" ]; then
    ((score+=1))
else
    echo "  --FAIL!"
fi

echo "TEST: taskset benchmarking"
if [ -f "bench-taskset.sh" ] && [ -f "plot-taskset.png" ]; then
    ((score+=1))
else
    echo "  --FAIL!"
fi

echo "TEST: questions.txt is non-empty"
if [ -f questions.txt ] && [ "$(wc -c < questions.txt)" -gt 200 ]; then
    ((score+=1))
else
    echo "  --FAIL!"
fi

echo "SCORE: $score/7"
