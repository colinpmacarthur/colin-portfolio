export CLASSPATH=$CLASSPATH:/usr/share/java/saxonb.jar
java net.sf.saxon.Transform -ext:on -o:portfolio.html -s:portfolio.xml -xsl:portfolio.xsl
weasyprint resume.html macarthur_resume.pdf --stylesheet weasy.css
