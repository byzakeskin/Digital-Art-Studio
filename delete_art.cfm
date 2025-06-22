<cfif structKeyExists(form, "ID")>
    <cfquery datasource="workcube_odev">
        DELETE FROM ARTS WHERE ID = <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cflocation url="my_pano.cfm">
</cfif>

