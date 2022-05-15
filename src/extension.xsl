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
                <xsl:with-param name="station" select="lines/line[@name=$line]/descendant::station"/>
            </xsl:call-template>
        </svg>
    </xsl:template>
    <xsl:template name="test">
        <xsl:param name="station" />
        <xsl:param name="previous_x_coordinate" select="0"/>
        <xsl:param name="previous_y_coordinate" select="0"/>
        <xsl:variable name="data" select="key('station', $station[1]/id)" />
        <xsl:value-of select="$previous_x_coordinate"></xsl:value-of>
        <xsl:text> : </xsl:text>
        <xsl:value-of select="$previous_y_coordinate"></xsl:value-of>
        <xsl:text>&#xa;</xsl:text>
        <xsl:if test="count($station) > 1">
            <xsl:call-template name="test">
                <xsl:with-param name="previous_x_coordinate" select="$data/@lon"/>
                <xsl:with-param name="previous_y_coordinate" select="$data/@lat"/>
                <xsl:with-param name="station" select="$station[position() > 1]"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>