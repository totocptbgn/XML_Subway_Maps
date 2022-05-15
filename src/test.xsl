<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes" />
    <xsl:key name="station" match="data/station" use="@id" />
    <xsl:template match="root">
        <xsl:call-template name="test">
            <xsl:with-param name="names" select="descendant::station/id"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="test">
        <xsl:param name="names" />
        <xsl:param name="testing" />
        <xsl:param name="x_coordinate" select="0"/>
        <xsl:param name="y_coordinate" select="100"/>
        <xsl:variable name="middleY" select="100"/>
        <xsl:variable name="data" select="key('station', $names[1])" />
        <xsl:value-of select="$names[1]"/>
        <!--         <xsl:text> -  </xsl:text>
        <xsl:value-of select="$data/name"/>
        <xsl:text> -  </xsl:text>
        <xsl:value-of select="$data/age"/>
        <xsl:text> - [X] </xsl:text>
        <xsl:value-of select="$x_coordinate"/>
        <xsl:text> - [Y] </xsl:text>
        <xsl:value-of select="$y_coordinate"/> -->
        <xsl:text> - [PARENT] </xsl:text>
        <xsl:value-of select="name($names[1])"/>
        <xsl:text> - [GRANDPARENT] </xsl:text>
        <xsl:value-of select="name($names[1]/..)"/>
        <xsl:text> - [STATION COUNT] </xsl:text>
        <xsl:value-of select="count($names[1]/../../station)"/>
        <xsl:text> - [GRANDGRANDPARENT] </xsl:text>
        <xsl:value-of select="name($names[1]/../..)"/>
        <xsl:text> - [SUB INDEX] </xsl:text>
        <xsl:value-of select="count($names[1]/../../preceding-sibling::subpath)+1"/>
        <xsl:text> - [STATION ID REV] </xsl:text>
        <xsl:value-of select="(count($names[1]/../preceding-sibling::station))"/>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="count($names[2]/../../preceding-sibling::subpath)+1"/>
        <xsl:text> - : </xsl:text>
        <xsl:value-of select="(count($names[2]/../preceding-sibling::station))"/>
        <xsl:if test="(count($names[1]/../following-sibling::station) = 0 and (count($names[1]/../../following-sibling::subpath)+1)=2)">
        
    </xsl:if>
        <!-- <xsl:if test="(count($names[2]/../../preceding-sibling::subpath)+1) = 1 
        and name($names[2]/../..)='subpath'
        and (count($names[2]/../preceding-sibling::station)) = 0
        ">hhh
        </xsl:if>
        <xsl:text> - :zz </xsl:text>
        <xsl:value-of select="boolean($names[1]/../../ancestor::bifur)"/>
        <xsl:text> - :zz </xsl:text>
        <xsl:value-of select="name($names[1]/../../..)"/> -->
        <xsl:text> - : </xsl:text>
        <xsl:value-of select="(count($names[1]/../following-sibling::station)+1)"/>
        <xsl:text> - : </xsl:text>
        <xsl:value-of select="(count($names[1]/following::station/following-sibling::station))"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:if test="count($names) > 1">
            <xsl:call-template name="test">
                <xsl:with-param name="names" select="$names[position() > 1]"/>
                <xsl:with-param name="testing" select="(count($names[2]/../following-sibling::station))"/>
                <xsl:with-param name="x_coordinate">
                    <xsl:choose>
                        <xsl:when test="((count($names[2]/../preceding-sibling::station) = 0 and (count($names[2]/../../preceding-sibling::subpath)+1)=2))">
                            <xsl:value-of select="$x_coordinate - (50*(count($names[2]/../following-sibling::station)))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$x_coordinate +50"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="y_coordinate">
                    <xsl:if test="((count($names[2]/../../preceding-sibling::subpath)+1)=1) ">
                        <xsl:value-of select="$y_coordinate - 50"/>
                    </xsl:if>
                    <xsl:if test="(count($names[2]/../../preceding-sibling::subpath)+1)=2">
                        <xsl:value-of select="$y_coordinate + 50"/>
                    </xsl:if>
                    <!--  -->
                    <!-- count($names[1]/../../preceding-sibling::subpath)+1 -->
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>