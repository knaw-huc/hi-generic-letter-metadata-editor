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
                                <cmdp:identifier>{normalize-space($r/c[@n='nodegoatID'])}</cmdp:identifier>
                                <cmdp:holdingInstitution>NODEGOAT</cmdp:holdingInstitution>
                            </cmdp:Identifier>
                            <cmdp:Identifier>
                                <cmdp:identifier>{normalize-space($r/c[@n='shelfmark'])}</cmdp:identifier>
                                <cmdp:holdingInstitution>Utrecht University Library</cmdp:holdingInstitution>
                            </cmdp:Identifier>
                            <cmdp:SourceBasicMetadata>
                                <cmdp:nameOrTitle xml:lang="en">{normalize-space($r/c[@n='Letter-title'])}</cmdp:nameOrTitle>
                                <cmdp:additionalType>letter</cmdp:additionalType>
                                <cmdp:landingPage>https://doi.org/10.24416/UU01-DZFKZX</cmdp:landingPage>
                            </cmdp:SourceBasicMetadata>
                            <cmdp:Sender>
                                <cmdp:correspondenceAction>sending</cmdp:correspondenceAction>
                                <cmdp:SenderObservation>
                                    <cmdp:senderAsText>{normalize-space($r/c[@n='Sender'])}</cmdp:senderAsText>
                                </cmdp:SenderObservation>
                                <cmdp:LinkToReconstruction>
                                    <cmdp:CuratedPersons>
                                        <cmdp:normalizedName>{($r/c[@n='relation-sender'])}</cmdp:normalizedName>
                                    </cmdp:CuratedPersons>
                                </cmdp:LinkToReconstruction>
                            </cmdp:Sender>
                            <cmdp:Receiver>
                                <cmdp:correspondenceAction>receiving</cmdp:correspondenceAction>
                                <cmdp:ReceiverObservation>
                                    <cmdp:receiverAsText>{normalize-space($r/c[@n='Recipient'])}</cmdp:receiverAsText>
                                </cmdp:ReceiverObservation>
                                <cmdp:LinkToReconstruction>
                                    <cmdp:CuratedPersons>
                                        <cmdp:normalizedName>{($r/c[@n='relation-recipient'])}</cmdp:normalizedName>
                                    </cmdp:CuratedPersons>
                                </cmdp:LinkToReconstruction>                            
                            </cmdp:Receiver>
                            <cmdp:DateSent>
                                <cmdp:DateObservation>
                                    <cmdp:dateAsWritten>{($r/c[@n='Date'])}</cmdp:dateAsWritten>
                                </cmdp:DateObservation>
                                <cmdp:Confidence>
                                    <cmdp:confidenceValue>{($r/c[@n='DateUncertain'])}</cmdp:confidenceValue>
                                </cmdp:Confidence>
                            </cmdp:DateSent>
                        </cmdp:Letter>
                    </cmd:Components>
                </cmd:CMD>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>