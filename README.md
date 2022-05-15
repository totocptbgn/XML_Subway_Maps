# XML_Subway_Maps

> Projet de Formats de documents & XML de M1.

Sujet disponible [ici](docs/sujet.pdf). Les lignes produites sont dans le répertoire [output/](src/output/).

### Execution :
- Pour générer une ligne particulière :
```sh
java -jar ./src/saxon-he-10.3.jar -s:src/base_ratp.xml -xsl:src/svg.xsl line=[code de la ligne] -o:out.svg
```

- Pour générer toutes les lignes :
```sh
cd src && sh generate_all.sh
```

- Pour vérifier le format :
```sh
xmllint --schema base_ratp.xsd base_ratp.xml > out.txt
```
