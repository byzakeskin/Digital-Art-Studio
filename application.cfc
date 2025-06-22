<cfcomponent>
    <cfset this.name = "beyza_w3_odev_app">

    <cfset this.sessionManagement = true>

    <cfset this.applicationTimeout = createTimeSpan(0,1,0,0)>

    <cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
</cfcomponent>
