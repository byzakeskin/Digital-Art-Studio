<cfif NOT structKeyExists(session, "USER_ID")>
    <cflocation url="log_in.cfm">
</cfif>

<cfquery name="Get_My_Arts" datasource="workcube_odev">
    SELECT * FROM ARTS
    WHERE USER_ID = <cfqueryparam value="#session.USER_ID#" cfsqltype="cf_sql_integer">
    ORDER BY ADD_DATE ASC
</cfquery>

<cfquery name="Get_Categories" datasource="workcube_odev">
    SELECT DISTINCT CATEGORY_NAME FROM CATEGORIES
</cfquery>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Eserlerim - Dijital Sanat Sergisi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #04210d;
            font-family: 'Courier New', cursive;
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
        .art-card {
            background-color: #3d594c;
            border-radius: 20px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.4);
        }
        .art-img {
            max-width: 100%;
            border-radius: 10px;
        }
        .my-update-btn, .my-delete-btn, .my-navbar-btn {
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .my-sucess-btn {
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            border: 1px solid white;
            background-color: transparent;
            color: white;
            transition: 0.3s;
        }

        .my-update-btn:hover {
            background-color: #fac0c0;
            color: #733f3f;
        }
        .my-delete-btn:hover {
            background-color: #ff5050;
            color: #733f3f;
        }
        .my-navbar-btn:hover {
            background-color: #79b574;
            color: #002c1b;
        }

        .my-sucess-btn:hover {
            background-color: #fac0c0;
            color: #733f3f;
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
    <div>
        <cfif session.USER_ID EQ 1><a href="update_users.cfm" class="btn btn-sm my-navbar-btn" >Kullanıcı Ekle</a></cfif>
        <button class="btn btn-sm my-navbar-btn" data-bs-toggle="modal" data-bs-target="#addArtModal">ESER EKLE</button>
        <a href="log_in.cfm" class="btn btn-sm my-navbar-btn">Çıkış Yap</a>
    </div>
</div>
<div class="top-bar">
    <h3 style="color:#fffff;"><cfoutput>#session.FULLNAME#</cfoutput>'in Sergisi</h3>
</div>

<div class="container">
    <div class="row g-4">
        <cfoutput query="Get_My_Arts">
            <cfset imageSource = len(IMAGE_FOLDER) ? IMAGE_FOLDER : IMAGE_URL>
            <div class="col-md-4">
                <div class="art-card">
                    <img src="#imageSource#" alt="#TITLE#" class="art-img mb-2">
                    <h5>#TITLE#</h5>
                    <p><small>#CATEGORY#</small></p>
                    <div class="d-flex gap-2 mt-2">
                        <form method="post" action="delete_art.cfm" onsubmit="return confirm('Bu eseri silmek istediginizden emin misiniz?');">
                            <input type="hidden" name="ID" value="#ID#">
                            <button type="submit" class="btn btn-sm my-delete-btn">Sil</button>
                        </form>
                        <button class="btn btn-sm my-update-btn" data-bs-toggle="modal" data-bs-target="##modal_#ID#">Güncelle</button>
                    </div>
                </div>
            </div>
        </cfoutput>
    </div>
</div>

<cfoutput query="Get_My_Arts">
<cfset modalId = "modal_#ID#">
<div class="modal fade" id="#modalId#" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background-color: rgba(61, 89, 76, 0.95); color: white; border-radius: 20px;">
      <div class="modal-header">
        <h5 class="modal-title">Eseri Güncelle</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form method="post" action="update_art.cfm">
        <div class="modal-body">
          <input type="hidden" name="ID" value="#ID#">
          <div class="mb-3">
            <label class="form-label">Başlık</label>
            <input type="text" class="form-control" name="TITLE" value="#TITLE#" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Açıklama</label>
            <textarea class="form-control" name="DESCRIPTION" rows="3">#DESCRIPTION#</textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Kategori</label>
            <select class="form-select category-select" name="CATEGORY" data-id="#ID#" required>
                <cfloop query="Get_Categories">
                    <option value="#CATEGORY_NAME#" <cfif CATEGORY_NAME EQ Get_My_Arts.CATEGORY>selected</cfif>>#CATEGORY_NAME#</option>
                </cfloop>
                <option value="__new__">Yeni Kategori Ekle</option>
            </select>            
            <input type="text" class="form-control mt-2 new-category-input" name="NEW_CATEGORY" id="newCategory_#ID#" style="display: none;" placeholder="Yeni kategori girin">
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-sm my-sucess-btn">Kaydet</button>
        </div>
      </form>
    </div>
  </div>
</div>
</cfoutput>

<div class="modal fade" id="addArtModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background-color: rgba(61, 89, 76, 0.95); color: white; border-radius: 20px;">
      <div class="modal-header">
        <h5 class="modal-title">Yeni Sanat Eseri Ekle</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form method="post" action="add_art.cfm" enctype="multipart/form-data">
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">Başlık</label>
            <input type="text" class="form-control" name="TITLE" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Açıklama</label>
            <textarea class="form-control" name="DESCRIPTION" rows="3"></textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Kategori</label>
            <cfoutput>
                <select class="form-select category-select" name="CATEGORY" data-id="add" required>
                    <cfloop query="Get_Categories">
                        <option value="#CATEGORY_NAME#">#CATEGORY_NAME#</option>
                    </cfloop>
                    <option value="__new__">Yeni Kategori Ekle</option>
                </select>
                </cfoutput>          
            <input type="text" class="form-control mt-2 new-category-input" name="NEW_CATEGORY" id="newCategory_add" style="display: none;" placeholder="Yeni kategori girin">
          </div>
          <div class="mb-3">
            <label class="form-label">Görsel URL</label>
            <input type="text" class="form-control" name="IMAGE_URL" placeholder="https://..." />
          </div>
          <div class="mb-3">
            <label class="form-label">Bilgisayardan Görsel Yükle</label>
            <input type="file" class="form-control" name="IMAGE_FILE" accept="image/*" />
            <small class="text-warning">Eğer hem URL hem dosya girersen sadece dosya kullanılır.</small>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-sm my-sucess-btn">Kaydet</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const selects = document.querySelectorAll(".category-select");
    selects.forEach(function (select) {
      select.addEventListener("change", function () {
        const id = select.getAttribute("data-id");
        const input = document.getElementById("newCategory_" + id);
        if (select.value === "__new__") {
          input.style.display = "block";
          input.setAttribute("required", "required");
        } else {
          input.style.display = "none";
          input.removeAttribute("required");
        }
      });
    });
  });
</script>


<footer>
  <a href="https://www.linkedin.com/in/beyza-nur-keskin/" target="_blank">LinkedIn</a>|
  <a href="https://github.com/byzakeskin" target="_blank">GitHub</a>|
  <a href="https://www.youtube.com/@plscallmeLuna" target="_blank">YouTube</a>
  <div style="margin-top: 10px;">
      © 2025 Dijital Sanat Sergisi - Tüm Hakları Saklıdır.
  </div>
</footer>
</body>
</html>
