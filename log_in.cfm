<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giriş Yap - Dijital Sanat Sergisi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #002c1b; 
            font-family: 'Courier New', Courier, monospace; 
            color: white; 
        }

        .logo-img {
            height: 40px;
            margin-right: 10px;
            vertical-align: middle;
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

        .top-navbar .nav-links a {
            color: white;
            text-decoration: none; 
            margin-left: 25px;
        }

        .top-navbar .nav-links a:hover {
            color: #79b574; 
        }

        .top-navbar .nav-links span {
            color: white;
            margin-left: 25px;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            margin-top: 20px;
        }

        .top-bar h3 {
            margin: 0;
            font-size: 1.3em;
        }

        .btn-back {
            padding: 10px 20px;
            font-size: 0.9em;
            border-radius: 8px;
            border: 1px solid white;
            background-color: transparent; 
            color: white;
            transition: 0.3s; 
        }

        .btn-back:hover {
            background-color: #79b574;
            color: #002c1b;
        }

        .login-container {
            min-height: calc(100vh - 170px);
            display: flex;
            align-items: center;
            justify-content: center; 
            padding: 40px;
            flex-wrap: wrap; 
        }

        .left-image {
            flex: 1; 
            display: flex;
            justify-content: center; 
            align-items: center;
            padding: 20px; 
        }
        .left-image img {
            max-width: 100%; 
            max-height: 400px; 
            border-radius: 15px;
            object-fit: cover; 
        }

        .right-form {
            width: 450px; 
            background-color: #3c5449; 
            padding: 40px; 
            border-radius: 30px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); 
        }

        .form-control {
            background-color: transparent; 
            color: white; 
            border: none;
            border-bottom: 2px solid #79b574; 
            border-radius: 0;
            padding: 10px 0;
            margin-bottom: 25px; 
            font-size: 1.1em; 
            -webkit-box-shadow: none; 
            box-shadow: none; 
            outline: none; 
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .form-control:focus {
            box-shadow: none; 
            border-color: #dc758f;
            outline: none; 
        }

        .btn-login {
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            border: 1px solid white;
            background-color: transparent; 
            color: white;
            transition: 0.3s; 
        }
        .btn-login:hover {
            background-color: #79b574;
            color: #002c1b; 
            transform: translateY(-2px); 
        }

        a {
            color: #79b574; 
            text-decoration: none;
            transition: 0.3s;
        }
        a:hover {
            color: #79b574; 
        }

        h2.mb-4 {
            margin-bottom: 40px !important; 
            font-size: 2em; 
            color: #79b574;
        }
       
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column; 
            }
            .left-image {
                order: 2; 
                margin-top: 30px;
            }
            .right-form {
                width: 90%; 
                max-width: 450px; 
                order: 1; 
            }
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            .top-bar h3 {
                margin-bottom: 15px;
            }
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
    <h3>Merhaba, kişisel serginize ulaşmak için lütfen giriş yapınız!</h3>
    <a href="index.cfm" class="btn btn-back">Anasayfa</a>
</div>


<div class="login-container">
    <div class="right-form">
        <h2 class="mb-4">Giriş Yap</h2>
        <form action="check_login.cfm" method="post">
            <div class="mb-3">
                <input type="email" name="EMAIL" class="form-control" placeholder="E-posta" required />
            </div>
            <div class="mb-4">
                <input type="password" name="PASSWORD" class="form-control" placeholder="Şifre" required />
            </div>
            <button type="submit" class="btn btn-login mb-3">Giriş</button>
        </form>
    </div>
    <div class="left-image">
        <img src="wiwiw.png"  class="img-fluid rounded" />
    </div>
</div>

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