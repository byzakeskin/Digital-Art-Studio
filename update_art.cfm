<cfif NOT structKeyExists(session, "USER_ID")>
    <cflocation url="log_in.cfm">
</cfif>

<cfif structKeyExists(form, "ID") AND structKeyExists(form, "TITLE")>

    <cfset finalCategory = form.CATEGORY>
    <cfif form.CATEGORY EQ "__new__" AND len(trim(form.NEW_CATEGORY))>
        <cfset finalCategory = trim(form.NEW_CATEGORY)>

        <cfquery name="CheckCategory" datasource="workcube_odev">
            SELECT 1 FROM CATEGORIES WHERE CATEGORY_NAME = <cfqueryparam value="#finalCategory#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif CheckCategory.recordCount EQ 0>
            <cfquery datasource="workcube_odev">
                INSERT INTO CATEGORIES (CATEGORY_NAME) VALUES (
                    <cfqueryparam value="#finalCategory#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>
        </cfif>
    </cfif>

    <cfquery datasource="workcube_odev">
        UPDATE ARTS
        SET 
            TITLE = <cfqueryparam value="#form.TITLE#" cfsqltype="cf_sql_varchar">,
            DESCRIPTION = <cfqueryparam value="#form.DESCRIPTION#" cfsqltype="cf_sql_varchar" null="#iif(trim(form.DESCRIPTION) EQ '', 'true', 'false')#">,
            CATEGORY = <cfqueryparam value="#finalCategory#" cfsqltype="cf_sql_varchar">
        WHERE ID = <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_integer">
        AND USER_ID = <cfqueryparam value="#session.USER_ID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="my_pano.cfm?updated=true">

<cfelse>
    <p>Eksik veri gönderildi.</p>
</cfif>
