<cfif structKeyExists(form, "EMAIL") AND structKeyExists(form, "PASSWORD")>
    <cfquery name="checkUser" datasource="workcube_odev">
        SELECT ID FROM USERS WHERE EMAIL = <cfqueryparam value="#form.EMAIL#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkUser.recordCount EQ 0>
        <cfquery name="insertUser" datasource="workcube_odev">
            INSERT INTO USERS (FULLNAME, EMAIL, PASSWORD)
            VALUES (
                <cfqueryparam value="#form.FULLNAME#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.EMAIL#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.PASSWORD#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <cflocation url="log_in.cfm?success=1" addtoken="no">
    <cfelse>
        <cfoutput>
            <p style="color:red;">Bu mail adresi daha önce kayıt olmuş!</p>
            <a href="log_in.cfm">Geri</a>
        </cfoutput>
    </cfif>

<cfelse>
    <cfoutput>
        <p style="color:red;">Eksik bilgi gönderildi. Lütfen tüm alanları doldurun!</p>
        <a href="signup.cfm">Geri</a>
    </cfoutput>
</cfif>
