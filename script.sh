for file in *.csv;
    do sed '/^$/d' $file > "$(basename "$file" .csv)_1.csv";
done

for file in *_1.csv;
    do  awk '{print FILENAME "," NR, ",",$0 }' $file > "$(basename "$file" .csv)_2.csv";
done

for file in *_2.csv;
    do sed 's/[[:space:]]//g' $file > "$(basename "$file" .csv)_3.csv";
done

for file in *_3.csv;
    do sed 's/\([A-Z]\)/\1,/g' $file > "$(basename "$file" .csv)_4.csv";
done

awk -F',' '{ for(i=4;i<=NF;i++) print $1,$2,$3,$i}' OFS=',' *_4.csv > output.csv

sed -e 's/_1//g' output.csv > output1.csv

rm *_1.csv  *_2.csv *_3.csv *_4.csv output.csv

cat output1.csv
