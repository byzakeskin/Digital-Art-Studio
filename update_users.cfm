<cfquery name="Get_Users" datasource="workcube_odev">
    SELECT ID, FULLNAME, EMAIL, PASSWORD, CREATE_DATE FROM USERS ORDER BY CREATE_DATE DESC
</cfquery>

<cfif structKeyExists(URL, "islem") AND URL.islem EQ "sil" AND structKeyExists(URL, "id")>
    <cfquery name="DeleteUser" datasource="workcube_odev">
        DELETE FROM USERS WHERE ID = <cfqueryparam value="#URL.id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cflocation url="update_users.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(FORM, "islem") AND FORM.islem EQ "guncelle">
    <cfquery name="UpdateUser" datasource="workcube_odev">
        UPDATE USERS
        SET 
            FULLNAME = <cfqueryparam value="#FORM.update_fullname#" cfsqltype="cf_sql_varchar">,
            EMAIL = <cfqueryparam value="#FORM.update_email#" cfsqltype="cf_sql_varchar">,
            PASSWORD = <cfqueryparam value="#FORM.update_password#" cfsqltype="cf_sql_varchar">
        WHERE ID = <cfqueryparam value="#FORM.update_id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cflocation url="update_users.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(FORM, "islem") AND FORM.islem EQ "ekle">
    <cfquery name="InsertUser" datasource="workcube_odev">
        INSERT INTO USERS (FULLNAME, EMAIL, PASSWORD, CREATE_DATE)
        VALUES (
            <cfqueryparam value="#FORM.fullname#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#FORM.email#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#FORM.password#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
        )
    </cfquery>
    <cflocation url="update_users.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kullanıcı Ekle - Dijital Sanat Sergisi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #002c1b;
            font-family: 'Courier New', Courier, monospace;
            color: white;
        }

        .top-navbar {
            background-color: #011c11;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            color: white;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
        }

        .top-navbar .logo {
            font-size: 1.2em;
            font-weight: bold;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            margin-top: 20px;
        }

        .btn-home {
            padding: 10px 20px;
            font-size: 0.9em;
            border-radius: 8px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .btn-home:hover {
            background-color: #79b574;
            color: #002c1b;
        }

        .btn-delete {
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .btn-delete:hover {
            background-color: #ff5050;
            color: #733f3f;
        }

        .btn-update {
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .btn-update:hover {
            background-color: #fac0c0;
            color: #733f3f;
        }

        .password-mask {
            cursor: pointer;
            color: white;
            font-family: monospace;
        }
        .password-mask:hover {
            color: #ff5050;
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


    </style>
</head>
<body>
<div class="top-navbar">
    <div class="logo">DİJİTAL SANAT SERGİSİ</div>
</div>
<div class="top-bar">
    <h4>Merhaba, bu sayfa kullanıcı düzenleme sayfasıdır.<br>
    Eklemek istediğiniz kullanıcının bilgilerini eksiksiz doldurunuz!
    </h4>
    
    <a href="my_pano.cfm" class="btn btn-home">Geri</a>
</div>

<div class="container mt-5">
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th>Ad Soyad</th>
                <th>Email</th>
                <th>Şifre</th>
                <th>Kayıt Tarihi</th>
                <th>İşlemler</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="Get_Users">
            <tr>
                <td>#CurrentRow#</td>
                <td>#FULLNAME#</td>
                <td>#EMAIL#</td>
                <td>
                    <span class="password-mask" data-password="#PASSWORD#" onclick="togglePassword(this)">
                      ••••••••
                    </span>
                  </td>
                <td>#DateFormat(CREATE_DATE, "dd.mm.yyyy")#</td>
                <td>
                    <button class="btn btn-update" data-bs-toggle="modal" data-bs-target="##modal_#ID#">
                        Güncelle
                    </button>
                    <a href="update_users.cfm?islem=sil&id=#ID#" class="btn btn-delete" onclick="return confirm('Kullanıcıyı silmek istediğinizden emin misiniz?')">
                        Sil
                    </a>
                </td>
            </tr>
            </cfoutput>
        </tbody>
    </table>
</div>

<cfoutput query="Get_Users">
<cfset modalId = "modal_#ID#">
<div class="modal fade" id="#modalId#" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content text-dark">
      <form method="post" action="update_users.cfm">
        <div class="modal-header">
          <h5 class="modal-title">Kullanıcı Güncelle</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="update_id" value="#ID#">
          <div class="mb-3">
            <label>Ad Soyad</label>
            <input type="text" name="update_fullname" value="#FULLNAME#" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Email</label>
            <input type="email" name="update_email" value="#EMAIL#" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Şifre</label>
            <input type="text" name="update_password" value="#PASSWORD#" class="form-control" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" name="islem" value="guncelle" class="btn btn-success">Kaydet</button>
        </div>
      </form>
    </div>
  </div>
</div>
</cfoutput>

<div class="container mt-5">
    <h4>Yeni Kullanıcı Ekle</h4>
    <form method="post" action="update_users.cfm" class="row g-3 mt-2">
        <input type="hidden" name="islem" value="ekle">
        <div class="col-md-4">
            <label>Ad Soyad</label>
            <input type="text" name="fullname" class="form-control" required>
        </div>
        <div class="col-md-4">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="col-md-4">
            <label>Şifre</label>
            <input type="text" name="password" class="form-control" required>
        </div>
        <div class="col-12 mt-3">
            <button type="submit" class="btn btn-update">Kullanıcı Ekle</button>
        </div>
    </form>
</div>

<footer class="mt-5 text-center text-light">
    <a href="https://www.linkedin.com/in/beyza-nur-keskin/" target="_blank">LinkedIn</a>|
    <a href="https://github.com/byzakeskin" target="_blank">GitHub</a>|
    <a href="https://www.youtube.com/@plscallmeLuna" target="_blank">YouTube</a>
    <div style="margin-top: 10px;">
        © 2025 Dijital Sanat Sergisi - Tüm Hakları Saklıdır.
    </div>
</footer>

<script>
    function togglePassword(element) {
        const currentText = element.textContent;
        const realPassword = element.getAttribute("data-password");
    
        if (currentText === '••••••••' || currentText === '********') {
            element.textContent = realPassword;
        } else {
            element.textContent = '••••••••';
        }
    }
    </script>
    
</body>
</html>
