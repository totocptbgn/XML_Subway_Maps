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
        <svg xmlns="http://www.w3.org/2000/svg"    width="10000"
        height="10000">
            <xsl:call-template name="test">
                <xsl:with-param name="station" select="descendant::station"/>
            </xsl:call-template>
        </svg>
    </xsl:template>
    <xsl:template name="test">
        <xsl:param name="station" />
        <xsl:param name="previous_x_coordinate" select="0"/>
        <xsl:param name="previous_y_coordinate" select="0"/>
        <xsl:param name="previous_ancestor" select=""/>
        <xsl:param name="count_offset" select="(count($station[1]/preceding::station))"/>
        <xsl:variable name="circleRadius" select="65"/>
        <xsl:variable name="data" select="key('station', $station[1]/id)" />
        <!--   <xsl:value-of select="$previous_x_coordinate"></xsl:value-of>
        <xsl:text> : </xsl:text>
        <xsl:value-of select="$previous_y_coordinate"></xsl:value-of>
        <xsl:text>&#xa;</xsl:text> -->
        <!-- SVG -->
        <xsl:variable name="current_index" select="(count($station[1]/preceding::station)) - $count_offset" />
        <xsl:text>[INDEX ] </xsl:text>
        <xsl:value-of select="$current_index"/>
        <xsl:text>&#xa;</xsl:text>
        <!--   <g transform="translate({$data/@x},{$data/@y + 1000})">
            <circle  r="{$circleRadius}" fill="#006fb6" stroke="black" stroke-width="3" />
        </g> -->
        <xsl:if test="count($station) > 1">
            <xsl:call-template name="test">
                <xsl:with-param name="station" select="$station[position() > 1]"/>
                <xsl:with-param name="previous_x_coordinate" select="$data/@x"/>
                <xsl:with-param name="previous_y_coordinate" select="$data/@y"/>
                <xsl:with-param name="count_offset" select="$count_offset"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>