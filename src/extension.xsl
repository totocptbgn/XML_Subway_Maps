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
    <xsl:key name="lineColour" match="data/line" use="@name" />
    <xsl:param name="line"/>
    <xsl:template match="root">
        <svg xmlns="http://www.w3.org/2000/svg"    width="10000"
        height="10000">
            <xsl:apply-templates select="lines/line">
                <xsl:with-param name="station" select="descendant::station"/>
            </xsl:apply-templates>
        </svg>
    </xsl:template>
    <xsl:template match="line">
        <xsl:param name="station" />
        <xsl:variable name="data" select="key('lineColour', @name)" />
        <xsl:call-template name="test">
            <xsl:with-param name="station" select="./descendant::station"/>
            <xsl:with-param name="offset" select="(count(preceding::station))"/>
            <xsl:with-param name="colour" select="$data/color"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="test">
        <xsl:param name="station"/>
        <xsl:param name="previous_x_coordinate" select="0"/>
        <xsl:param name="previous_y_coordinate" select="0"/>
        <xsl:param name="offset"/>
        <xsl:variable name="circleRadius" select="25"/>
        <xsl:variable name="data" select="key('station', $station[1]/id)" />
        <xsl:variable name="index" select ="((count($station[1]/preceding::station)) - $offset)+1"/>
        <xsl:value-of select="$index"/>
        <xsl:variable name="x" select="$data/@x"/>
        <xsl:variable name="y" select="$data/@y"/>
        <!--  -->
        <xsl:choose>
            <xsl:when test ="($index = 1)">
                <g transform="translate({$data/@x },{$data/@y})">
                    <circle  r="{$circleRadius}" fill="black" stroke="black" stroke-width="3" />
                </g>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="(count($station[1]/../preceding-sibling::subpath)+1)=1">
                    <path d="M {$x} {$y} {$previous_x_coordinate} {$previous_y_coordinate}" style="stroke:black;stroke-width:8" />
                </xsl:if>
                <g transform="translate({$data/@x },{$data/@y})">
                    <circle  r="{$circleRadius}" fill="black" stroke="black" stroke-width="3" />
                </g>
                <xsl:if test="((count($station[1]/../preceding-sibling::subpath)+1)=2)
                and (count(($station[1]/preceding-sibling::station)) != 0)">
                    <path d="M {$x} {$y} {$previous_x_coordinate} {$previous_y_coordinate}" style="stroke:black;stroke-width:8" />
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="count($station) > 1">
            <xsl:call-template name="test">
                <xsl:with-param name="station" select="$station[position() > 1]"/>
                <xsl:with-param name="previous_x_coordinate" select="$data/@x"/>
                <xsl:with-param name="previous_y_coordinate" select="$data/@y"/>
                <xsl:with-param name="offset" select="$offset"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>