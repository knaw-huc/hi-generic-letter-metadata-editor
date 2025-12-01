<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:csv="https://di.huc.knaw.nl/ns/csv"
    exclude-result-prefixes="xs math csv"
    version="3.0">
    
    <xsl:import href="csv2xml.xsl"/>
    
    <xsl:param name="csv" select="'persons.csv'"/>    
    <xsl:param name="user" select="'liliana'"/>
    <xsl:param name="out" select="'./output'"></xsl:param>
    
    <xsl:template name="main">
        <xsl:for-each select="csv:getCSV($csv)//r">
            <xsl:variable name="r" select="."/>
            <xsl:result-document href="{$out}/record-{number($r/@l) - 1}.xml" expand-text="yes">
                <cmd:CMD xmlns:cmd="http://www.clarin.eu/cmd/1"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.clarin.eu/cmd/1 https://infra.clarin.eu/CMDI/1.x/xsd/cmd-envelop.xsd http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:1758888743558 http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/1.2/profiles/clarin.eu:cr1:p_1758888743558/xsd"
                    CMDVersion="1.2">
                    <cmd:Header>
                        <cmd:MdCreator>{$user}</cmd:MdCreator>
                        <cmd:MdCreationDate>
                            <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                        </cmd:MdCreationDate>
                        <cmd:MdSelfLink>unl://{number($r/@l) - 1}</cmd:MdSelfLink>
                        <cmd:MdProfile>clarin.eu:cr1:p_1758888743558</cmd:MdProfile>
                        <cmd:MdCollectionDisplayName/>
                    </cmd:Header>
                    <cmd:Resources>
                        <cmd:ResourceProxyList/>
                        <cmd:JournalFileProxyList/>
                        <cmd:ResourceRelationList/>
                        <cmd:IsPartOfList/>
                    </cmd:Resources>
                    <cmd:Components>
                        <cmdp:Person xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1758888743558">
                            <cmdp:Identifier>
                                <cmdp:identifierType>{normalize-space($r/c[@n='identifierType1'])}</cmdp:identifierType>
                                <cmdp:identifierLabel>{normalize-space($r/c[@n='localId'])}</cmdp:identifierLabel>
                                <cmdp:schemeAgency>"Liliana-curation"</cmdp:schemeAgency>
                            </cmdp:Identifier>
                            <cmdp:Identifier>
                                <cmdp:identifierType>{normalize-space($r/c[@n='identifierType2'])}</cmdp:identifierType>                                
                                <cmdp:identifierLabel>{normalize-space($r/c[@n='wikidataId'])}</cmdp:identifierLabel>
                                <cmdp:schemeAgency>{normalize-space($r/c[@n='identifier2-agency'])}</cmdp:schemeAgency>                                
                            </cmdp:Identifier>                            
                            <cmdp:PersonName>
                                <cmdp:fullName xml:lang="en">{normalize-space($r/c[@n='personNameCleaned'])}</cmdp:fullName>
                            </cmdp:PersonName>
                            <cmdp:PersonData>
                                <cmdp:BirthDate>
                                    <cmdp:DateReconstruction>
                                        <cmdp:dateStart xml:lang="en">{normalize-space($r/c[@n='date of birth'])}</cmdp:dateStart>    
                                        <cmdp:Confidence>
                                            <cmdp:confidenceValue xml:lang="en">{normalize-space($r/c[@n='confidenceValue'])}</cmdp:confidenceValue>
                                        </cmdp:Confidence>
                                    </cmdp:DateReconstruction>
                                </cmdp:BirthDate>
                                <cmdp:DeathDate>
                                    <cmdp:DateReconstruction>
                                        <cmdp:dateStart xml:lang="en">{normalize-space($r/c[@n='date of death'])}</cmdp:dateStart>    
                                        <cmdp:Confidence>
                                            <cmdp:confidenceValue xml:lang="en">{normalize-space($r/c[@n='confidenceValue'])}</cmdp:confidenceValue>
                                        </cmdp:Confidence>
                                    </cmdp:DateReconstruction>
                                </cmdp:DeathDate>                                                     
                            </cmdp:PersonData>
                        </cmdp:Person>
                    </cmd:Components>
                </cmd:CMD>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>