<cfprocessingdirective pageEncoding="utf-8">

<cfset userFilter = "">
<cfset categoryFilter = "">

<cfif structKeyExists(url, "user_id")>
    <cfset userFilter = trim(url.user_id)>
</cfif>

<cfif structKeyExists(url, "category")>
    <cfset categoryFilter = trim(url.category)>
</cfif>

<cfquery name="Get_All_Arts" datasource="workcube_odev">
    SELECT A.*, U.FULLNAME
    FROM ARTS A
    INNER JOIN USERS U ON A.USER_ID = U.ID
    ORDER BY A.ADD_DATE ASC
</cfquery>

<cfquery name="Get_Arts" datasource="workcube_odev">
    SELECT A.*, U.FULLNAME
    FROM ARTS A
    INNER JOIN USERS U ON A.USER_ID = U.ID
    WHERE 1=1
    <cfif len(userFilter)>
        AND U.ID = <cfqueryparam value="#userFilter#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif len(categoryFilter)>
        AND A.CATEGORY = <cfqueryparam value="#categoryFilter#" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY A.ADD_DATE ASC
</cfquery>

<cfquery name="Get_Users" datasource="workcube_odev">
    SELECT ID, FULLNAME FROM USERS ORDER BY FULLNAME ASC
</cfquery>

<cfquery name="Get_Categories" datasource="workcube_odev">
    SELECT ID, CATEGORY_NAME FROM CATEGORIES ORDER BY CATEGORY_NAME ASC
</cfquery>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Dijital Sanat Sergisi</title>
    <style>
        body {
            background-color: #002c1b;
            color: white;
            font-family: 'Courier New', monospace;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .top-navbar {
            background-color: #011c11;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .top-navbar .logo {
            font-size: 1.1em;
            font-weight: bold;
        }

        .top-navbar .nav-links {
            display: flex;
            align-items: center;
        }

        .top-navbar .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 10px;
            font-size: 1em;
        }

        .top-navbar .nav-links .login-button {
            padding: 10px 20px;
            font-size: 0.9em;
            border-radius: 8px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .top-navbar .nav-links .login-button:hover {
            background-color: #79b574;
            color: #002c1b;
        }

        .dot {
            display: inline-block;
            width: 6px;
            height: 6px;
            background-color: #79b574;
            border-radius: 50%;
            margin: 0 10px;
            vertical-align: middle;
        }

        .gallery-wrapper {
            margin-top: 30px;
        }

        .gallery-track {
            display: flex;
            gap: 30px;
            animation: scrollGallery 60s linear infinite;
            width: fit-content;
        }

        .gallery-track img {
            width: 300px;
            height: 300px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            cursor: pointer;
        }

        @keyframes scrollGallery {
            0% {
                transform: translateX(0);
            }
            100% {
                transform: translateX(-50%);
            }
        }

        .filter-bar {
            background-color: #011c11;
            color: white;
            padding: 30px 40px;
            margin: 0 auto;
            margin-bottom: 50px;
            margin-top: 50px;
            text-align: center;
            font-family: 'Courier New', monospace;
            border-top: 1px solid #355c3f;
            border-bottom: 1px solid #355c3f;
        }

        .filter-bar label {
            margin: 0 10px;
            font-weight: bold;
            font-size: 1em;
        }

        .filter-bar select {
            background-color: #002c1b;
            color: white;
            border: 1px solid #79b574;
            border-radius: 8px;
            padding: 8px 14px;
            margin: 0 20px 10px 5px;
            font-family: 'Courier New', monospace;
            font-size: 0.95em;
            transition: 0.3s;
        }

        .filter-bar select:hover,
        .filter-bar select:focus {
            border-color: #a4e3a1;
            outline: none;
        }

        .filter-button,
        .reset-button {
            background-color: transparent;
            color: white;
            border: 1px solid #79b574;
            padding: 10px 20px;
            margin: 10px 8px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 0.95em;
            cursor: pointer;
            transition: 0.3s;
        }

        .filter-button:hover,
        .reset-button:hover {
            background-color: #79b574;
            color: #002c1b;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            column-gap: 80px;
            row-gap: 160px;
            padding: 60px 20px;
            max-width: 1200px;
            margin: 0 auto;
            justify-content: center;
            justify-items: center;
        }

        .flip-card {
            background-color: transparent;
            width: 400px;
            height: 400px;
            perspective: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .flip-inner {
            position: relative;
            width: 100%;
            height: 100%;
            transform-style: preserve-3d;
            transition: transform 0.8s ease-in-out;
        }

        .flip-card.flipped .flip-inner {
            transform: rotateY(180deg);
        }

        .flip-front, .flip-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 15px;
            overflow: hidden;
        }

        .flip-front img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .flip-back {
            background: linear-gradient(135deg, #2a4a37, #1e3828);
            color: #f0f0f0;
            transform: rotateY(180deg);
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            text-align: left;
            border: 1px solid #4a6a57;
            overflow-y: auto;
            height: 100%;
            box-sizing: border-box;
        }

        .art-info {
            position: absolute;
            bottom: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            text-align: center;
            padding: 10px 5px;
            font-size: 0.9em;
            font-weight: bold;
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }

        .flip-card:hover .art-info {
            opacity: 1;
            pointer-events: auto;
        }

        footer {
            background-color: #011c12;
            padding: 20px;
            text-align: center;
            color: #ccc;
        }

        footer a {
            color: #79b574;
            text-decoration: none;
            margin: 0 10px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .tooltip {
            position: relative;
            cursor: pointer;
            color: white;
            text-decoration: none;
        }

        .tooltip .tooltiptext {
            visibility: hidden;
            width: 180px;
            background-color: #79b574;
            color: #fff;
            text-align: center;
            padding: 6px 10px;
            border-radius: 6px;
            position: absolute;
            z-index: 100;
            top: 125%;
            left: 50%;
            transform: translateX(-50%);
            opacity: 0;
            transition: opacity 0.3s;
            pointer-events: none;
        }

        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
            pointer-events: auto;
        }

        .tooltip .tooltiptext::after {
            content: "";
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 6px;
            border-style: solid;
            border-color: transparent transparent #79b574 transparent;
        }
    </style>
</head>
<body>

<div class="top-navbar">
    <div class="logo">DİJİTAL SANAT SERGİSİ</div>
    <div class="nav-links">
        <div class="tooltip">
            <a href="#" class="nav-link">Sanatçılar</a>
            <div class="tooltiptext">
                <cfoutput query="Get_Users">
                    <div class="artist-name">#FULLNAME#</div>
                </cfoutput>
            </div>
        </div>
        <span class="dot"></span>
        <div class="tooltip">
            <a href="#">Hakkımızda</a>
            <div class="tooltiptext">Burası bir sanatçının eserlerini sergilemesi için oluşturulmuş web sitesidir</div>
        </div>
        <span class="dot"></span>
        <div class="tooltip">
            <a href="#">Nasıl Sergi Oluştururum?</a>
            <div class="tooltiptext">Sergi oluşturmak için e-postanızla birlikte bizimle iletişime geçin, size vereceğimiz şifre ile birlikte e-postanızı kullanarak giriş yapabilir ve kendi serginizi oluşturabilirsiniz</div>
        </div>
        <a href="log_in.cfm" class="login-button">Giriş Yap</a>
    </div>
</div>

<div class="gallery-wrapper">
    <div class="gallery-track">
        <cfoutput query="Get_All_Arts">
            <img src="#IMAGE_URL# #IMAGE_FOLDER#" alt="#TITLE#" onclick="scrollToArt('art#ID#')">
        </cfoutput>
        <cfoutput query="Get_All_Arts">
            <img src="#IMAGE_URL# #IMAGE_FOLDER#" alt="#TITLE#" onclick="scrollToArt('art#ID#')">
        </cfoutput>
    </div>
</div>

<div class="filter-bar">
    <form id="filterForm" method="get">
        <label for="userFilter">Sanatçı:</label>
        <select id="userFilter" name="user_id">
            <option value="">Hepsi</option>
            <cfoutput query="Get_Users">
                <option value="#ID#" <cfif structKeyExists(URL, "user_id") AND URL.user_id EQ ID>selected</cfif>>#FULLNAME#</option>
            </cfoutput>
        </select>

        <label for="categoryFilter">Kategori:</label>
        <select id="categoryFilter" name="category">
            <option value="">Hepsi</option>
            <cfoutput query="Get_Categories">
                <option value="#CATEGORY_NAME#" <cfif structKeyExists(URL, "category") AND URL.category EQ CATEGORY_NAME>selected</cfif>>#CATEGORY_NAME#</option>
            </cfoutput>
        </select>

        <button type="submit" class="filter-button">Filtrele</button>
        <button type="button" class="reset-button" onclick="window.location.href='index.cfm'">Sıfırla</button>
    </form>
</div>

<div class="cards-container">
    <cfoutput query="Get_Arts">
        <div id="art#ID#" class="flip-card" onclick="this.classList.toggle('flipped')">
            <div class="flip-inner">
                <div class="flip-front">
                    <img src="#IMAGE_URL# #IMAGE_FOLDER#" alt="#TITLE#">
                    <div class="art-info">
                        <strong>#TITLE#</strong>
                        <div>#FULLNAME# | #CATEGORY#</div>
                    </div>
                </div>
                <div class="flip-back">
                    <h3 class="art-title-back">#TITLE#</h3>
                    <p class="art-description">#DESCRIPTION#</p>
                </div>
            </div>
        </div>
    </cfoutput>
</div>

<footer>
    <a href="https://www.linkedin.com/in/beyza-nur-keskin/" target="_blank">LinkedIn</a>|
    <a href="https://github.com/byzakeskin" target="_blank">GitHub</a>|
    <a href="https://www.youtube.com/@plscallmeLuna" target="_blank">YouTube</a>
    <div style="margin-top: 10px;">
        © 2025 Dijital Sanat Sergisi - Tüm Hakları Saklıdır.
    </div>
</footer>

<script>
    function scrollToArt(id) {
        const element = document.getElementById(id);
        if (element) {
            element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
</script>

</body>
</html>
