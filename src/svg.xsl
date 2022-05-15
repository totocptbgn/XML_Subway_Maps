<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/2000/svg"
		>
    <xsl:output
      method="xml"
      indent="yes"
      media-type="image/svg" />
    <xsl:key name="station" match="data/station" use="@id" />
    <xsl:param name="line"/>
    <xsl:template match="root">
        <svg xmlns="http://www.w3.org/2000/svg"    width="7000"
        height="1080">
            <xsl:call-template name="test">
                <xsl:with-param name="names" select="lines/line[@name=$line]/descendant::station"/>
            </xsl:call-template>
        </svg>
    </xsl:template>
    <xsl:template name="test">
        <xsl:param name="names" />
        <xsl:param name="x_coordinate" select="500"/>
        <xsl:param name="y_coordinate" select="500"/>
        <xsl:variable name="data" select="key('station', $names[1]/id)" />
        <!-- SVG -->
        <xsl:variable name="o_coordinate" select="100"/>
        <xsl:variable name="pathWidth" select="100"/>
        <xsl:variable name="circleRadius" select="15"/>
        <xsl:variable name="offset" select="100"/>
        <xsl:variable name="jumpBifur" select="300"/>
        <xsl:variable name="bifurHeigh" select="200"/>
        <xsl:variable name="changeLineOffset" select="40"/>
        <!-- SIMPLE PATH -->
        <xsl:if test="not(name($names[1]/..)='subpath')">
            <g transform="translate({$x_coordinate},{$y_coordinate})">
                <!-- if the next one exists and is not a subpath, draw a line -->
                <!--  <xsl:if test="$names[2] and not(name($names[2]/../..)='subpath')"> -->
                <xsl:value-of select="$names[1]/ancestor::line/@name"/>
                <xsl:value-of select="$names[1]/../../@name"/>
                <xsl:value-of select="$names[1]/preceding::station/../../@name"/>
                <xsl:if test="$names[2]">
                    <path d="M 0 0 H {$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- DRAW TO THE LEFT IF THERE IS A BIFUR BEFORE AND IS THE FIRST STATION -->
                <xsl:if test="boolean(($names[1]/../preceding::bifur)) 
                and (count($names[1]/preceding-sibling::station))=0
                and ($names[1]/ancestor::line/@name) = ($names[1]/preceding::station/ancestor::line/@name)">
                    <path d="M 0 0 H {-$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- station name above circle -->
                <xsl:choose>
                    <xsl:when test ="$names[1]/changes/changeline">
                        <circle  r="{$circleRadius}" fill="white" stroke="black" stroke-width="3" />
                        <xsl:for-each select="$names[1]/changes/changeline">
                            <circle cx="0" cy="{position()* $changeLineOffset}" r="15" fill="none"  stroke="black" stroke-width="3" />
                            <text x="0" y="{position()* $changeLineOffset}" text-anchor="middle" fill="black" font-size="15px" font-family="Arial" font-weight="bold"
                dy=".3em">
                                <xsl:value-of select="."/>
                            </text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <circle  r="{$circleRadius}" fill="#006fb6" stroke="black" stroke-width="3" />
                    </xsl:otherwise>
                </xsl:choose>
                <text transform="rotate(-60)" xml:space=" preserve">
                    <tspan y="0" x="40" style="font-weight:bold;font-size:30px;">
                        <xsl:value-of select ="$data/name"/>
                    </tspan>
                </text>
            </g>
        </xsl:if>
        <!-- BIFUR -->
        <!-- IF SUBPATH IS THE FIRST -->
        <xsl:if test="(count($names[1]/../preceding-sibling::subpath)+1) = 1 
            and name($names[1]/..)='subpath'
            ">
            <g transform="translate({$x_coordinate},{$y_coordinate -$bifurHeigh})">
                <!-- if the next one exists, draw a line -->
                <!-- if next exists and is a child of subpath and is the first subpath -->
                <xsl:if test="$names[2] and (name($names[2]/..)='subpath') and (count($names[2]/../preceding-sibling::subpath)+1) = 1 ">
                    <path d="M 0 0 H {$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- DRAW PATH TO THE LEFT OF FIRST STATION OF SUBPATH IF THERE IS A STATION BEFORE -->
                <xsl:if test="boolean(($names[1]/../../preceding::station)) and (count($names[1]/preceding-sibling::station)+1) = 1
                and (((count($names[1]/../../preceding-sibling::fpath)) != 0) 
                or (((count($names[1]/../../preceding-sibling::lpath)) != 0)))">
                    <path d="M 0 0 H {-$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                    <path d="M {-$pathWidth} 0  L {-$jumpBifur} {$bifurHeigh}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- DRAW PATH TO THE RIGHT OF THE LAST STATION OF SUBPATH IF THERE IS A STATION AFTER -->
                <xsl:if test="boolean(($names[1]/../../following::station)) and
                (count($names[1]/../preceding-sibling::subpath)+1) != (count($names[2]/../preceding-sibling::subpath)+1)
                and ($names[1]/ancestor::line/@name) = ($names[1]/../../following::station/ancestor::line/@name)">
                    <path d="M 0 0 H {$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                    <path d="M {$pathWidth} 0  L {$jumpBifur} {$bifurHeigh}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!--  -->
                <xsl:choose>
                    <xsl:when test ="$names[1]/changes/changeline">
                        <circle  r="{$circleRadius}" fill="white" stroke="black" stroke-width="3" />
                        <xsl:for-each select="$names[1]/changes/changeline">
                            <circle cx="0" cy="{position()* $changeLineOffset}" r="15" fill="none"  stroke="black" stroke-width="3" />
                            <text x="0" y="{position()* $changeLineOffset}" text-anchor="middle" fill="black" font-size="15px" font-family="Arial" font-weight="bold"
                dy=".3em">
                                <xsl:value-of select="."/>
                            </text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <circle  r="{$circleRadius}" fill="#006fb6" stroke="black" stroke-width="3" />
                    </xsl:otherwise>
                </xsl:choose>
                <!-- station name above circle -->
                <text transform="rotate(-60)" xml:space=" preserve">
                    <tspan y="0" x="40" style="font-weight:bold;font-size:30px;">
                        <xsl:value-of select ="$data/name"/>
                    </tspan>
                </text>
            </g>
        </xsl:if>
        <!--  -->
        <!-- IF SUBPATH IS THE SECOND -->
        <xsl:if test="(count($names[1]/../preceding-sibling::subpath)+1) = 2 
            and name($names[1]/..)='subpath'
            ">
            <g transform="translate({$x_coordinate},{$y_coordinate+$bifurHeigh})">
                <xsl:if test="$names[2] and (name($names[2]/..)='subpath') ">
                    <path d="M 0 0 H {$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- DRAW PATH TO THE LEFT OF FIRST STATION OF SUBPATH IF THERE IS A STATION BEFORE -->
                <xsl:if test="boolean(($names[1]/../../preceding::station)) and (count($names[1]/preceding-sibling::station)+1) = 1 
                and (((count($names[1]/../../preceding-sibling::fpath)) != 0) 
                or (((count($names[1]/../../preceding-sibling::lpath)) != 0)))">
                    <path d="M 0 0 H {-$pathWidth}" style="stroke:#006fb6;stroke-width:8" />
                    <path d="M {-$pathWidth} 0  L {-$jumpBifur} {-$bifurHeigh}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <!-- DRAW PATH TO THE RIGHT OF THE LAST STATION OF SUBPATH IF THERE IS A STATION AFTER AND IS THE LAST STATION OF SUBPATH-->
                <xsl:if test="boolean(($names[1]/../../following::station)) and (boolean($names[1]/../ancestor::bifur) != boolean($names[2]/../ancestor::bifur))
                and (($names[1]/following::station/ancestor::line/@name) =($names[1]/ancestor::line/@name))">
                    <path d="M 0 0 H {$pathWidth}" style="stroke:#006fb6;stroke-width:8;fill:none" />
                    <path d="M {$pathWidth} 0  L {$jumpBifur} {-$bifurHeigh}" style="stroke:#006fb6;stroke-width:8" />
                </xsl:if>
                <xsl:choose>
                    <xsl:when test ="$names[1]/changes/changeline">
                        <circle  r="{$circleRadius}" fill="white" stroke="black" stroke-width="3" />
                        <xsl:for-each select="$names[1]/changes/changeline">
                            <circle cx="0" cy="{position()* $changeLineOffset}" r="15" fill="none"  stroke="black" stroke-width="3" />
                            <text x="0" y="{position()* $changeLineOffset}" text-anchor="middle" fill="black" font-size="15px" font-family="Arial" font-weight="bold"
                dy=".3em">
                                <xsl:value-of select="."/>
                            </text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <circle  r="{$circleRadius}" fill="#006fb6" stroke="black" stroke-width="3" />
                    </xsl:otherwise>
                </xsl:choose>
                <!-- station name above circle -->
                <text transform="rotate(-60)" xml:space=" preserve">
                    <tspan y="0" x="40" style="font-weight:bold;font-size:30px;">
                        <xsl:value-of select ="$data/name"/>
                    </tspan>
                </text>
            </g>
        </xsl:if>
        <xsl:if test="count($names) > 1">
            <xsl:call-template name="test">
                <xsl:with-param name="names" select="$names[position() > 1]"/>
                <xsl:with-param name="x_coordinate">
                    <xsl:choose>
                        <xsl:when test="((count($names[2]/preceding-sibling::station) = 0 and (count($names[2]/../preceding-sibling::subpath)+1)=2))">
                            <xsl:choose>
                                <xsl:when test="($names[2]/ancestor::line/@name) = ($names[2]/../../following::station/ancestor::line/@name)">
                                    <xsl:value-of select="$x_coordinate - (100*(count($names[2]/following-sibling::station)))"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$x_coordinate - (100*(count($names[2]/preceding::subpath[1]//following-sibling::station)-1))"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="
                            if(boolean($names[1]/../ancestor::bifur) != boolean($names[2]/../ancestor::bifur))
                            then $x_coordinate + $offset + $jumpBifur 
                            else $x_coordinate + $offset"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>