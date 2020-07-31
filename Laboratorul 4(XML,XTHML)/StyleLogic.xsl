<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
<xsl:template match="/"> 
 <html>
 <head>
  <link href="style.css" type="text/css" rel="stylesheet"/>
 </head>
 <body> 
  <h1 align="center">List Of Books</h1> 
   <table>
    <thead>
     <tr> 
      <th>Title</th> 
      <th>Author</th>
      <th>Category</th> 
      <th>Year</th>
      <th>Isbn</th>
     </tr> 
   </thead>
   <tbody>
    <xsl:for-each select="ListOfBooks/Book">
    <xsl:sort select="category"/> 
    <xsl:sort select="title"/> 

   <tr> 
    <td><xsl:value-of select="title"/></td> 
    <td><xsl:value-of select="author"/></td>
    <xsl:if test="category = 'Informatics'">
     <td class="informatics">
      <xsl:value-of select="category"/>
     </td>
    </xsl:if>
    <xsl:if test="category = 'Fantasy'">
     <td class="fantasy">
     <xsl:value-of select="category"/>
     </td>
    </xsl:if>
    <xsl:if test="category = 'Action'">
     <td class="action">
     <xsl:value-of select="category"/>
     </td>
    </xsl:if>
    <xsl:if test="category = 'Mistery'">
     <td class="mistery">
     <xsl:value-of select="category"/>
     </td>
    </xsl:if>
    <xsl:if test="category = 'Horror'">
     <td class="horror">
     <xsl:value-of select="category"/>
     </td>
    </xsl:if>
    <td><xsl:value-of select="year"/></td>
    <td><xsl:value-of select="isbn"/></td>  
   </tr> 
    </xsl:for-each>
   </tbody>
  </table>

</body> 
</html> 
</xsl:template> 
</xsl:stylesheet>