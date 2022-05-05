# XML_Subway_Maps

> Repo pour le projet de XML en M1.

Sujet disponible [ici](docs/maps.pdf).


Execution :
-  java -jar ./saxon-he-10.3.jar -s:test.xml -xsl:svg.xsl line=10 -o:out.svg
ou 
- bash ./generate_all.sh