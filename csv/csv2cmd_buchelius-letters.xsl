<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:csv="https://di.huc.knaw.nl/ns/csv"
    exclude-result-prefixes="xs math csv"
    version="3.0">
    
    <xsl:import href="csv2xml.xsl"/>
    
    <xsl:param name="csv" select="'letters.csv'"/>    
    <xsl:param name="user" select="'Liliana'"/>
    <xsl:param name="out" select="'./output'"></xsl:param>
    
    <xsl:template name="main">
        <xsl:for-each select="csv:getCSV($csv)//r">
            <xsl:variable name="r" select="."/>
            <xsl:result-document href="{$out}/record-{number($r/@l) - 1}.xml" expand-text="yes">
                <cmd:CMD xmlns:cmd="http://www.clarin.eu/cmd/1"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.clarin.eu/cmd/1 https://infra.clarin.eu/CMDI/1.x/xsd/cmd-envelop.xsd http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1761816151556 http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/1.2/profiles/clarin.eu:cr1:p_1761816151556/xsd"
                    CMDVersion="1.2">
                    <cmd:Header>
                        <cmd:MdCreator>{$user}</cmd:MdCreator>
                        <cmd:MdCreationDate>
                            <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                        </cmd:MdCreationDate>
                        <cmd:MdSelfLink>unl://{number($r/@l) - 1}</cmd:MdSelfLink>
                        <cmd:MdProfile>clarin.eu:cr1:p_1761816151556</cmd:MdProfile>
                        <cmd:MdCollectionDisplayName/>
                    </cmd:Header>
                    <cmd:Resources>
                        <cmd:ResourceProxyList/>
                        <cmd:JournalFileProxyList/>
                        <cmd:ResourceRelationList/>
                        <cmd:IsPartOfList/>
                    </cmd:Resources>
                    <cmd:Components>
                        <cmdp:Letter xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1761816151556">
                            <cmdp:Identifier>
                                <cmdp:identifierType>"Local-identifier"</cmdp:identifierType>
                                <cmdp:identifierLabel>{normalize-space($r/c[@n='nodegoatID'])}</cmdp:identifierLabel>
                                <cmdp:schemeAgency>"NODEGOAT"</cmdp:schemeAgency>
                            </cmdp:Identifier>
                            <cmdp:Identifier>
                                <cmdp:identifierType>"Local-identifier"</cmdp:identifierType>                                
                                <cmdp:labelOrNotation>{normalize-space($r/c[@n='shelfmark'])}</cmdp:labelOrNotation>
                                <cmdp:sourceUrl>"UBU: Utrecht University Library"</cmdp:sourceUrl>                                
                            </cmdp:Identifier>                            
                            <cmdp:SourceBasicMetadata>
                                <cmdp:nameOrTitle xml:lang="en">{normalize-space($r/c[@n='Letter-title'])}</cmdp:nameOrTitle>
                                <cmdp:additionalType>"letter"</cmdp:additionalType>
                                <cmdp:landingPage>"https://doi.org/10.24416/UU01-DZFKZX"</cmdp:landingPage>
                            </cmdp:SourceBasicMetadata>
                            <cmdp:Sender>
                                <cmdp:correspondenceAction>"sending"</cmdp:correspondenceAction>
                                <cmdp:PersonObservation>
                                    <cmdp:personAsText>{normalize-space($r/c[@n='Sender'])}</cmdp:personAsText>
                                </cmdp:PersonObservation>
                                <cmdp:LinkToReconstruction>
                                    <cmdp:Relationship>
                                        <cmdp:to>{($r/c[@n='relation-sender'])}</cmdp:to>
                                    </cmdp:Relationship>
                                </cmdp:LinkToReconstruction>
                            </cmdp:Sender>
                            <cmdp:Receiver>
                                <cmdp:correspondenceAction>"receiving"</cmdp:correspondenceAction>
                                <cmdp:PersonObservation>
                                    <cmdp:personAsText>{normalize-space($r/c[@n='Recipient'])}</cmdp:personAsText>
                                </cmdp:PersonObservation>
                                <cmdp:LinkToReconstruction>
                                    <cmdp:Relationship>
                                        <cmdp:to>{($r/c[@n='relation-recipient'])}</cmdp:to>
                                    </cmdp:Relationship>
                                </cmdp:LinkToReconstruction>                            </cmdp:Receiver>
                        </cmdp:Letter>
                    </cmd:Components>
                </cmd:CMD>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>