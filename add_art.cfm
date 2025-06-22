<cfif NOT structKeyExists(session, "USER_ID")>
    <cflocation url="log_in.cfm">
</cfif>

<cfset title = trim(form.TITLE)>
<cfset description = trim(form.DESCRIPTION)>
<cfset category = form.CATEGORY>
<cfset newCategory = trim(form.NEW_CATEGORY)>
<cfset imageUrl = trim(form.IMAGE_URL)>
<cfset imageFolder = "">


<cfif category EQ "__new__" AND len(newCategory)>
    <cfset category = newCategory>

    <cfquery name="CheckCategory" datasource="workcube_odev">
        SELECT 1 FROM CATEGORIES WHERE CATEGORY_NAME = <cfqueryparam value="#category#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif CheckCategory.recordCount EQ 0>
        <cfquery datasource="workcube_odev">
            INSERT INTO CATEGORIES (CATEGORY_NAME)
            VALUES (<cfqueryparam value="#category#" cfsqltype="cf_sql_varchar">)
        </cfquery>
    </cfif>
</cfif>


<cfif structKeyExists(form, "IMAGE_FILE") AND len(form.IMAGE_FILE)>
    <cfset uploadDir = expandPath("./uploads/")>
    <cfset uploadResult = fileUpload(uploadDir, "IMAGE_FILE", "image/*", "makeUnique")>
    <cfset imageFolder = "uploads/#uploadResult.serverFile#">
</cfif>


<cfquery datasource="workcube_odev">
    INSERT INTO ARTS (
        USER_ID,
        TITLE,
        DESCRIPTION,
        CATEGORY,
        IMAGE_URL,
        IMAGE_FOLDER,
        ADD_DATE
    ) VALUES (
        <cfqueryparam value="#session.USER_ID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#title#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#description#" cfsqltype="cf_sql_varchar" null="#iif(len(description) EQ 0, 'true', 'false')#">,
        <cfqueryparam value="#category#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#imageUrl#" cfsqltype="cf_sql_varchar" null="#iif(len(imageFolder), 'true', 'false')#">,
        <cfqueryparam value="#imageFolder#" cfsqltype="cf_sql_varchar" null="#iif(len(imageFolder), 'false', 'true')#">,
        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
    )
</cfquery>

<cflocation url="my_pano.cfm?added=true">
