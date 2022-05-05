# XML_Subway_Maps

> Repo pour le projet de XML en M1.

Sujet disponible [ici](docs/maps.pdf).


### Execution :
- Pour générer une ligne particulière :
```sh
java -jar ./saxon-he-10.3.jar -s:test.xml -xsl:svg.xsl line=[code de la ligne] -o:out.svg
```
- Pour générer toute les lignes :
```sh
bash ./generate_all.sh
```
