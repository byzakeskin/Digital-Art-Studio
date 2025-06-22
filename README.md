## 🎨 Dijital Sanat Sergisi
Kullanıcının dijital sanat eserlerini sergileyebildiği, ve yönetebildiği web tabanlı bir platform.

💻 Özellikler
- Sanat eserlerini listeleme ve detaylarını görüntüleme
- Kullanıcı, admin giriş/çıkış sistemi
- Admin yetkisi ile (isteğe bağlı) kullanıcı ekleme, bilgileri düzenleme alanı
- Sanatçılara ve kategorilere göre filtreleme alanı
- Bootstrap modalları ile sanat eserlerini güncelleme
- Şifre gizleme/gösterme fonksiyonu
- Responsive tasarım

⚙️ Projemin detayları ve çalışma fonksiyonları; 

Microsoft SQL Server (MS SQL) veritabanı kullanılarak, 

Adobe ColdFusion kurulu bir sunucuda geliştirilmiştir. 

## Ekran Görüntüleri

![Ana Ekran Özellikleri](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/ANA%20EKRAN%20-%201.png)

Projenin ana ekranı, kullanıcı dostu ve estetik olarak zengin bir dijital sanat galerisi arayüzü sunar. Aşağıda ekran bileşenleri detaylandırılmıştır:

🔝 Üst Menü (Top Bar)
Başlık: DİJİTAL SANAT SERGİSİ başlığı, kullanıcıyı karşılar.

Gezinme Linkleri:

SANATÇILAR: Sergisi olan bütün sanatçıların isimlerini gösterir.

HAKKIMIZDA: Proje hakkında tanıtıcı metin içerir.

NASIL SERGİ OLUŞTURURUM?: Kullanıcılara rehberlik eden bilgilendirme alanı.

Giriş Yap Butonu: Kullanıcının hesabına erişmesini sağlar (oturum açma sayfasına yönlendirir).

Ana sayfa üzerinde yer alan sanat eserleri yatay olarak kayan kartlar şeklinde sunulur.

Her sanat eseri, görsel olarak vurgulanmış bir kart içerisinde gösterilir.

Kart köşeleri yuvarlatılmış ve CSS ile stilize edilmiştir (estetik bütünlük için).

🎨 Filtreleme Alanı
Sayfanın alt kısmında, kullanıcıların sanat eserlerini filtreleyebileceği bir alan bulunur:

Sanatçı Seçimi (Dropdown):
Kullanıcı, sanatçılardan birini seçerek sadece o sanatçıya ait eserleri listeleyebilir.

Kategori Seçimi (Dropdown):
Sanat eserlerinin türlerine göre (örneğin: illüstrasyon, 3D, fotoğraf vb.) filtreleme yapılabilir.

Filtrele Butonu:
Seçilen sanatçı ve kategoriye göre galeri yeniden yüklenir, ilgili filtre uygulanır.

Sıfırla Butonu:
Tüm filtreleri temizleyerek varsayılan (tüm sanat eserleri) görünümüne geri döner.
<br>
.
<br>
.

![Ana Ekran Sergi Bölümü](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/ANA%20EKRAN%20-%202.png)

🖼️ Sanat Eserlerinin Kartlarla Sergilendiği Alan
Ana ekranda yer alan sanat eserleri, kullanıcıya görsel olarak güçlü bir deneyim sunmak amacıyla kart tasarımı ile gösterilmektedir. Bu kartlar modern CSS animasyonları ile etkileşimlidir.

🎴 Kart Yapısı
Her sanat eseri, yuvarlatılmış köşelere ve gölgelere sahip bir görsel kart şeklinde listelenir.

Kartın altında şu bilgiler yer alır:

Eser Başlığı

Sanatçı Adı

Kategori

🔄 Kart Ters Çevirme Özelliği (Flip Card)
Kartlara tıklandığında, CSS ile hazırlanmış bir animasyon sayesinde kart çevrilir.

Kartın arka yüzünde, esere dair kısa bir açıklama görüntülenir.
.
.

![Giriş Ekranı](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/G%C4%B0R%C4%B0%C5%9E%20EKRANI.png)

Kullanıcı dostu basitleştirilmiş giriş ekranı
.
.

![Kişiye Özel Alan](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/%C3%96ZEL%20SERG%C4%B0%20PANOSU.png)

👤 Admin Paneli ve Kişiye Özel Sergi Alanı
Proje, giriş yapan kullanıcının yetkisine göre farklı içerikler sunar. (Özellikle yönetici (admin) kullanıcı için!)

🖼️ Sanatçıya Özel Sergi Sayfası
Her sanatçının kendine ait bir sayfası vardır.

Bu sayfada sadece o sanatçıya ait sanat eserleri gösterilir.

ESER EKLE: Yeni bir sanat eseri yükleme formunu açar.

ÇIKIŞ YAP: Oturumu sonlandırır.

Eser kartlarının altında aşağıdaki yönetim butonları görünür:

Güncelle: Sanat eserini düzenlemek için modal açar.

Sil: Sanat eserini veritabanından kaldırır.

🔐 Yöneticiye Özel İşlevler
Giriş yapan kullanıcı yönetici yetkisine sahipse, ekranın sağ üst kısmında aşağıdaki butonlar görünür:

KULLANICI EKLE: Yeni bir kullanıcı (sanatçı) ekleme sayfasına yönlendirir.
.
.

![Görsel Yükleme Alanı](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/G%C3%96RSEL%20Y%C3%9CKLEME%20ALANI.png)

Görsel Yükleme Modalı
.
.
![Admin Kontrol Sayfası](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/ADM%C4%B0N%20KONTROL%20PANEL%C4%B0.png)

👤 Kullanıcı Yönetim Paneli
Bu panel, Dijital Sanat Sergisi projesinin yönetici arayüzünde kullanıcıları görüntüleme, düzenleme, silme ve yeni kullanıcı ekleme işlemleri için hazırlanmıştır.

🔧 Özellikler
Mevcut kullanıcıları tablo halinde listeler.

Bilgiler: Ad Soyad, Email, Şifre (maskeli), Kayıt Tarihi.

Her kullanıcı için iki işlem:

Güncelle: Bilgileri düzenlemek için kullanılır.

Sil: Kullanıcıyı sistemden kaldırır.

Yeni kullanıcı eklemek için:

Alt bölümde yer alan form aracılığıyla Ad Soyad, Email ve Şifre bilgileri girilerek kullanıcı oluşturulabilir.
.
.

![Görsel Güncelleme Alanı](https://github.com/byzakeskin/Digital-Art-Studio/blob/main/ESER%20G%C3%9CNCELLEME%20ALANI.png)

🎨 Eser Güncelleme Paneli
Bu panel, dijital sanat eserlerinin bilgilerini düzenlemek ve isteğe bağlı olarak yeni kategoriler eklemek için kullanılır.

✏️ Özellikler
Başlık: Eserin ismini düzenlemek için metin alanı.

Açıklama: Eser hakkında detaylı bilgi girilebilecek açıklama alanı.

Kategori: Açılır liste (dropdown) biçiminde mevcut kategorilerden seçim yapılabilir.

➕ Yeni Kategori Ekleme
Kategori listesinin en altındaki "Yeni Kategori Ekle" seçeneği sayesinde sistemde bulunmayan bir kategori manuel olarak tanımlanabilir. Bu özellik:

Kullanıcıya esnek içerik yönetimi sunar.

Dinamik kategori listesi oluşturulmasına olanak tanır.
