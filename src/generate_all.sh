for i in 2 1 3 3B 4 5 6 7 7B 8 9 10 11 12 13 14
do
   java -jar ./saxon-he-10.3.jar -s:base_ratp.xml -xsl:svg.xsl line=$i -o:output/line_$i.svg
done