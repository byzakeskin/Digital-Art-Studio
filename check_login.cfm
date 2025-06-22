<cfif structKeyExists(form, "EMAIL") AND structKeyExists(form, "PASSWORD")>
    <cfquery name="Get_User" datasource="workcube_odev">
        SELECT * FROM USERS 
        WHERE EMAIL = <cfqueryparam value="#form.EMAIL#" cfsqltype="cf_sql_varchar">
        AND PASSWORD = <cfqueryparam value="#form.PASSWORD#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif Get_User.recordCount EQ 1>
        <cfset session.USER_ID = Get_User.ID>
        <cfset session.FULLNAME = Get_User.FULLNAME>
        <cfset session.EMAIL = Get_User.EMAIL>

        <cflocation url="my_pano.cfm" addtoken="no">
    <cfelse>
        <cfoutput>
            <div style="color:red; text-align:center; margin-top:20px;">
                E-posta veya şifre hatalı. <a href="log_in.cfm">Geri dön!</a>
            </div>
        </cfoutput>
    </cfif>
<cfelse>
    <cflocation url="log_in.cfm" addtoken="no">
</cfif>
