<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:pg="http://ws.apache.org/ns/synapse"
    xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
    xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
	xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"
	xmlns:sp="http://docs.oasis-open.org/ws-sx/ws-securitypolicy/200702"
    version="1.0">

    <xsl:output method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>
    
    <xsl:strip-space elements="*"/>

    <xsl:param name="defNS">http://ws.apache.org/ns/synapse</xsl:param>
    <xsl:param name="defFaultMsg"></xsl:param>
        
    <!-- 
        copy all the elements & attributes by default 
    -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <!-- 
        Check if the <policy/> element is present under <resources/>; if it is empty, remove the element, else retain it.
    -->        
    <xsl:template match="/pg:service/pg:resources">    	
        <xsl:element name="resources" namespace="{$defNS}">
            <xsl:choose>
                <xsl:when test="count(pg:policy/*)=0">                   
                    <!-- select everything except the policy element -->
                    <xsl:apply-templates select="*[not(self::pg:policy)]"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- just copy everything as is -->
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

	<!-- 
	SMGME-1616  This is done  as older version of VSD contains invalid policy element
	This is fixed in neethi-3.0.2 which is used by Mediator 9.0.
	To support older VSD and older CentraSite (8.2.2) this prefix of the Policy changed to wsp
	-->
    <xsl:template match="/pg:service/pg:resources/pg:policy/wsp:Policy/wsp:ExactlyOne/wsp:All/sp:Wss10/sp:Policy">
        <xsl:element name="wsp:{local-name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    	
    <!-- 
        check if the <outSequence/> contains the <send/> element, if not add it as the last element
    -->
    <xsl:template match="pg:outSequence">
        <xsl:choose>
            <xsl:when test="count(pg:send)=0">
                <xsl:element name="outSequence" namespace="{$defNS}">
                    <xsl:apply-templates select="node()|@*"/>
                    <xsl:element name="send" namespace="{$defNS}"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="outSequence" namespace="{$defNS}">
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    <!-- check if the makefault element is present; if yes, check if <code> and <reason> are present
        if they are missing add them and set their value depending on the value of the makefault
        version attribute;
        If <send/> is missing add it as the last element
    -->
    
    <xsl:template match="pg:faultSequence/pg:makefault">
        <xsl:element name="makefault" namespace="{$defNS}">
            <xsl:copy-of select="@*"/>        <!-- write out attributes as is -->
            
            <xsl:choose>
                <!-- is code element missing? -->
                <xsl:when test="not(pg:code)">      
                    <xsl:choose>
                        <xsl:when test="contains(@version, 'soap11')">
                            <xsl:text disable-output-escaping="yes">
                    &lt;code xmlns="http://ws.apache.org/ns/synapse" value="env:Server" xmlns:env="http://schemas.xmlsoap.org/soap/envelope"/&gt;
                            </xsl:text>
                        </xsl:when>
                        <xsl:when test="contains(@version, 'soap12')">
                            <xsl:text disable-output-escaping="yes">
                    &lt;code xmlns="http://ws.apache.org/ns/synapse" value="env:Receiver" xmlns:env="http://www.w3.org/2003/05/soap-envelope"/&gt;
                            </xsl:text>
                        </xsl:when>
                    </xsl:choose>                    
                    
                </xsl:when>
                
                <!-- else copy as is -->
                <xsl:otherwise><xsl:copy-of select="pg:code"/></xsl:otherwise>
                
            </xsl:choose>
            
            <xsl:choose>
                <!-- is reason element missing? -->
                                <xsl:when test="not(pg:reason)">    
                  <xsl:text disable-output-escaping="yes">
                  &lt;reason xmlns="http://ws.apache.org/ns/synapse" value=""/&gt;
                   </xsl:text>
                </xsl:when>
            
                <!-- else select the 'reason' template to do further processing -->
                <xsl:otherwise>
                <xsl:apply-templates select="pg:reason"/>
                </xsl:otherwise>
                 
            </xsl:choose>           
            
            
        </xsl:element> 
        
        
        <!-- is send element missing? we check if there is any send element following the 'makefault' element -->
        <xsl:if test="not(following::pg:send)">            
            <xsl:element name="send" namespace="{$defNS}"/>
        </xsl:if>       

    </xsl:template>
    
      
    <!-- let's deal with the 'reason' element -->
    
    <xsl:template match="pg:reason">
        <xsl:element name="reason" namespace="{$defNS}">
            <xsl:choose>            
                <!-- This is for the case when <reason> element is present, but its value is not part of the attribute 'value' and instead
                    is the text value of the element
                    We take the text value and put it in the attribute 'value' -->
                <xsl:when test="not(@value)">
                    <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="string-length(text())!=0">
                                <xsl:apply-templates select="text()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$defFaultMsg"/>
                            </xsl:otherwise>                        
                        </xsl:choose>
                    </xsl:attribute>                
                </xsl:when>
               
                <!-- if the value attribute is empty -->            
                <xsl:when test="string-length(@value)=0">               
                    <xsl:attribute name="value">
                        <xsl:value-of select="$defFaultMsg"/>
                    </xsl:attribute>
                </xsl:when>
                
                <xsl:otherwise>   <!-- copy whatever value is present as is -->
                   <xsl:copy-of select="node()|@*"/>
                </xsl:otherwise>
            </xsl:choose>            
        </xsl:element>
        
    </xsl:template>
       
    
    <!-- if the wsdl <soap:address/> element does not specify a valid protocol -->
    
    <xsl:template match="//wsdl:port/soap:address/@location">
        
        <xsl:choose>
            <xsl:when test="not(starts-with(., 'http')) and not(starts-with(., 'https'))
                            and not(starts-with(., 'jms')) ">
                
                <xsl:variable name="transports" select="//pg:service/@transports"/>
                
                <xsl:attribute name="location">
                    <xsl:value-of select="$transports"/>
                    <xsl:choose>
                        <xsl:when test="starts-with($transports, 'http') or starts-with($transports, 'https')">
                            <xsl:text>://</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>:</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose> 
                </xsl:attribute>            
            </xsl:when>
            
            <xsl:otherwise>    <!-- copy the value present -->
                <xsl:copy/>
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
    
    <!-- This is a work-around to allow CentraSite users to declare protocol header expressions as custom context -->
    <!-- variables, so CS developers do not have to change the UI -->
    <xsl:template match="pg:variables/pg:variable[starts-with(@name,'mx:PROTOCOL_HEADERS')]">
    	<!--  no 'appy-templates' here will ensure this declaration is not included -->
    </xsl:template>

    <xsl:template match="pg:property">  		
    	<xsl:variable name="pText" select="child::text()" /> 
    	<xsl:choose>
    	<xsl:when test="starts-with($pText,'mx:PROTOCOL_HEADERS')">
	       <xsl:element name="property" namespace = "{$defNS}">
	         <xsl:attribute name="name">variable</xsl:attribute>
	         <xsl:value-of select="substring-after(text(),':')" />	                  
	       </xsl:element>	       
    	</xsl:when>
    	<xsl:otherwise>
			<xsl:copy>
				<xsl:apply-templates select="@* | node()" />
			</xsl:copy>
    	</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
    <!-- end of ProtocolHeaders workaround -->

</xsl:stylesheet>
