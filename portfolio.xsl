<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:func="http://exslt.org/functions"
    extension-element-prefixes="date func">
    
    <xsl:output indent="yes" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
    <xsl:template match="portfolio">
            <xsl:for-each select="activity/projects/project">
                <xsl:result-document href="{slug}.html">
                    <html>
                        <head>
                            <title><xsl:value-of select="/portfolio/contact-info/name"/> - <xsl:value-of select="nav"/></title>
                            <xsl:call-template name="head"></xsl:call-template>
                        </head>
                        <body>
                            <xsl:call-template name="header" />
                            <xsl:call-template name="navigation">
                                <xsl:with-param name="page" select="slug"/>
                            </xsl:call-template>
                            <div class="project">
								<h3><xsl:value-of select="nav" /></h3>
                                <div class="client">
                                <xsl:choose>
                                    <xsl:when test="ancestor::activity/@type='work'">
                                        <span class="caption">CLIENT:</span>
                                        <h4><xsl:value-of select="ancestor::activity/employer"/></h4>
                                    </xsl:when>
                                    <xsl:when test="ancestor::activity/@type='education'">
                                        <span class="caption">PROJECT AT:</span>
                                        <h4><xsl:value-of select="ancestor::activity/school-short-name"/></h4>
                                    </xsl:when>
                                </xsl:choose>
                                </div>    
                                <div class="dates">
                                    <span class="caption">DATES:</span><br />
                                    <xsl:value-of select="dates"/>
                                </div>
                                <div class="story"><xsl:apply-templates select="story" /></div>
                            </div>
<xsl:call-template name="analytics" />
                        </body>
                    </html>
                </xsl:result-document>
            </xsl:for-each>
            <xsl:result-document href="resume.html">
                <html>
                    <head>
                        <title><xsl:value-of select="/portfolio/contact-info/name"/> - Resume</title>
                        <xsl:call-template name="head" />
                    </head>
                    <body>
                        <xsl:call-template name="header" />
                        <xsl:call-template name="navigation">
                            <xsl:with-param name="page" select="'resume'"/>
                        </xsl:call-template>
                        <div class="resume">
                            <h3>Resume</h3>
                            <div class="print"><a href="macarthur_resume.pdf">Printable PDF Version</a></div>
			    <div class="education">
                                <h4>Education</h4>
                                <xsl:for-each select="activity[@type='education']">
                                    <div class="activity">
                                        <div class="degree"><xsl:value-of select="degree"/></div>
                                        <div class="school"><xsl:value-of select="school"/></div>
                                        <div class="timing"><xsl:value-of select="timing"/><br /><xsl:value-of select="locality"/>, <xsl:value-of select="region"/></div>
					<div class="highlight"><xsl:value-of select="highlight"/></div>
                                        <div class="focus">Focus: <xsl:value-of select="focus"/></div>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div class="experience">
                                <h4>Experience</h4>
                                <xsl:for-each select="activity[@type='work']">
                                    <div class="activity">
					<div class="title"><xsl:value-of select="title"/></div>
					<div class="employer"><xsl:value-of select="employer"/></div>
                                        <div class="timing"><xsl:value-of select="@start-text"/><br /><xsl:value-of select="locality"/>, <xsl:value-of select="region"/></div>
                                        <div class="description">
                                                <xsl:copy-of select="description"/>
                                        </div>
                                    </div>
                                </xsl:for-each>
                            </div>
                            
                            <div class="skills">
                                <h4>Skills</h4>
                                <xsl:for-each select="skills/group">
                                    <div class="skill-group">
                                        <span class="skill-group-name">
                                            <xsl:value-of select="@name"/>: 
                                        </span>
                                        <xsl:value-of select="skill" separator=", " />
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
<xsl:call-template name="analytics" />
                    </body>
                </html>
            </xsl:result-document>

            <xsl:result-document href="index.html">
                <html>
                    <head>
                        <title><xsl:value-of select="/portfolio/contact-info/name"/> - Resume</title>
                        <xsl:call-template name="head" />
                        <style>
                            body {background-image:url(images/index.jpg); background-attachment: fixed;}
                        </style>
                    </head>
                    <body>
                        <xsl:call-template name="header" />
                        <xsl:call-template name="navigation">
                            <xsl:with-param name="page" select="'home'"/>
                        </xsl:call-template>
                        <div class="home">
							<div class="text">
								I use research to help people doing good do even better.
								<div style="padding-top:20px;">I'd love to help you.</div>
								<div style="padding-top:25px; font-size:0.5em;">Email: <a href="mailto:colinpmacarthur@fastmail.fm" style="color:white;">colinpmacarthur@fastmail.fm</a></div>
								<div style="padding-top:5px; font-size:0.5em;">Phone: (505) 310-3082</div>
							</div>
                            
                            <div class="picture">
								<img width="300" height="450" src="images/colin.jpeg"/>
                            </div>
                            
                        </div>
                    </body>
<xsl:call-template name="analytics" />
                </html>
            </xsl:result-document>
    </xsl:template>
    <xsl:template match="section">
        <div class="section">
            <div class="caption"><xsl:value-of select="type"/>:</div>
            <h4 class="header"><xsl:value-of select="header"/></h4>
            <div class="body {if(attachments)then('narrow')else('')}">
                <xsl:apply-templates select="body" mode="inline"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="image" mode="inline">
        <figure style="float:{@float}; width:{@width};" >
            <img src="{@url}" alt="{title}"/>
            <figcaption>
                <xsl:value-of select="title"/>
                <xsl:if test="caption">: <xsl:value-of select="caption"/></xsl:if>
            </figcaption>
        </figure>
    </xsl:template>
    <xsl:template name="header">
        <div class="header">
			<a href="index.html" style="color:white; text-decoration:none;">
            <h1><xsl:value-of select="/portfolio/contact-info/name"/></h1>
            <h2><xsl:value-of select="/portfolio/title"/></h2>
            </a>
            <div class="contact_info">
				<div>
					<xsl:value-of select="/portfolio/contact-info/address" />
				</div>
				<div>
					<xsl:value-of select="/portfolio/contact-info/phone" /> - <xsl:value-of select="/portfolio/contact-info/email" />
				</div>
				<div>
					<a href="{/portfolio/contact-info/website}"><xsl:value-of select="/portfolio/contact-info/website" /></a>
				</div>				
            </div>
        </div>
    </xsl:template>
    <xsl:template name="navigation">
        <xsl:param name="page"/>
        <div class="navigation">
            <ul>
                <li class=""><a href="index.html">Contact Me</a></li>
                <li class="{if ($page='resume') then 'active' else 'non-active'}"><a href="resume.html">Resume</a></li>
                <li class="divider">Selected Projects:</li>
                <xsl:for-each select="/portfolio/activity/projects/project">
                    <li class="{if (slug=$page) then 'active' else 'non-active'}">
                        <xsl:if test="slug=$page"></xsl:if>
                        <a href="{slug}.html"><xsl:value-of select="nav"/></a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    <xsl:template name="head">
        <link rel="stylesheet" type="text/css" href="style.css" />
    </xsl:template>
    <xsl:template name="analytics">
    </xsl:template>
</xsl:stylesheet>
