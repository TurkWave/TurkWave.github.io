---
layout: app-index
permalink: /beton-maliyeti-hesaplayici/
is_app_index: true
title: "Beton Maliyeti Hesaplayıcı"

# ======================================================================
#  APP-INDEX PAGE
#
#  The whole page is built from this front matter. The Markdown body
#  below the closing "---" is NOT shown on the page and is not used for
#  anything. Put real content in the keys here.
#
#  HOW TO READ THIS FILE
#  Each block has two parts:
#    1. an EXPLANATION of what the key is and how it renders;
#    2. an "e.g." FILLED EXAMPLE showing a real value (all "e.g." lines
#       are comments - copy them onto the real key below to use them).
#  Then comes the real key, left empty. An empty value ("" or [])
#  hides that section; a filled value shows it.
#
#  A brand-new app with nothing filled in shows just the app name, the
#  auto-generated Legal links, Contact, and the Copyright line.
# ======================================================================


# --- Section switches: the one control block ---------------------------
#  EXPLANATION
#  Turn any block of this page off from here without touching its
#  content below. Value  on  (or deleting the line) shows a section;
#  off  / false  hides it. There is no on-page toggle - this is edited
#  in the source only. A section with no content stays hidden whatever
#  the switch says.
#
#  e.g. hide the reviews and pricing blocks, keep the rest:
#         reviews: off
#         pricing: off
sections:
  slogan: on
  screenshots: on
  sub_slogan: on
  stores: off
  reviews: off
  pricing: off
  faq: on
  legal: on
  #  Per-document switches for the "Legal & support" list. Key is
  #  legal_<doc-file-name> with hyphens -> underscores
  #  (third-party.md -> legal_third_party). off  drops just that link;
  #  legal: off  above hides the whole section.
  legal_terms: on
  legal_privacy: on
  legal_license: on
  legal_third_party: on
  legal_support: on
  contact: on
  copyright: on


# --- Search description & language -------------------------------------
#  EXPLANATION
#  "description" is the one sentence search engines show under the page
#  title and AI readers use to summarise the app. bin/new-app writes a
#  first version ("<App Name>: privacy policy, terms of use and support
#  documents."); replace it with a real sentence about the app. It must
#  not be empty. It is also the description in the app's structured data.
#
#  "lang" is the language the page text (slogan, FAQ, ...) is written in -
#  exactly one of:
#    en-US   English
#    tr-TR   Turkish
#  It sets <html lang> and og:locale and is published as the app's
#  language in its structured data. bin/new-app cannot guess it, so the
#  metadata check fails until you replace the placeholder below.
#
#  "lang_also" is optional: add it ONLY when the page also carries its text
#  in a second language (the other of the two values). Leave it out
#  otherwise.
#
#  e.g.
#    description: "Note Jar is a fast offline note app for Android - capture a thought in one tap, no account required."
#    lang: en-US
#    lang_also: tr-TR
description: "Beton Maliyeti Hesaplayıcı: kendi malzeme, yakıt ve genel gider rakamlarını girerek betonun m³ başına gerçek maliyetini ve %0'dan %50'ye kâr oranlarındaki satış fiyatlarını hesaplayan Android uygulaması. Tamamen çevrimdışı çalışır, hiçbir izin istemez."
lang: tr-TR


# --- Header logo -----------------------------------------------------
#  EXPLANATION
#  App icon shown large at the top-left of the frame, with the app name
#  to its right. "logo" is a site-absolute path (usually under
#  /assets/img/<slug>/); "logo_alt" is its alt text and defaults to the
#  app name when left empty.
#
#  e.g.
#    logo: "/assets/img/note-jar/logo.svg"
#    logo_alt: "Note Jar app icon"
logo: "/assets/img/beton-maliyeti-hesaplayici/Logo.png"
logo_alt: "Beton Maliyeti Hesaplayıcı uygulama simgesi"


# --- Subtitle -------------------------------------------------------
#  EXPLANATION
#  One free-text line under the app name in the header - smaller and
#  muted. Good for the publisher and the platforms.
#
#  e.g.
#    subtitle: "TurkWave - Mobile & PC"
subtitle: "HybridHabit · Android"


# --- Taglines -----------------------------------------------------
#  EXPLANATION
#  "slogan" is one line shown just under the header. "sub_slogan" is a
#  click-to-open drawer (closed by default) shown just above the
#  "Get the app" buttons - use it for a secondary note.
#
#  e.g.
#    slogan: "Capture a thought before it's gone."
#    sub_slogan: "Works offline. No account, no ads."
slogan: "Beton Maliyeti Hesaplayıcı; Maliyetini çıkar, kârını gör, fiyatını ver."
sub_slogan: |
  "Bir m³ beton bana kaça mal oluyor ?" sorusunun net bir cevabı çoğu zaman yoktur. Malzeme, işçilik, amortisman, elektrik ve saha taşıması ayrı defterlerde durur. Hazır hesaplayıcılar ise bir dökümün hacmini alıp sabit bir birim fiyatla çarpar; üreticinin gider yapısını değil, alıcının metrajını hesaplar. Geriye Excel tablosu ve karmaşık işlemler kalır.

  Beton Maliyeti Hesaplayıcı bu işi tersten kurar. Kendi dönem rakamlarını girersin, uygulama sana m³ başına gerçek maliyeti ve her kâr oranında satış fiyatını verir.

  Hesap üç akıştan oluşur. Beton sınıfını seçersin (C20/25'ten C45/55'e altı sınıf) ve o sınıfın bir m³'üne giren çimento, agrega, katkı, su miktarlarını yazarsın. Her sınıf kendi reçetesini ayrı tutar; sınıflar arasında sekmeyle ya da kaydırmayla geçersin ve maliyet anında o sınıfa göre yenilenir. Genel gider kalemlerinin dönem toplamını, o dönemde döktüğün m³'e bölerek m³ başına gideri bulur. Yakıtı taşıma maliyeti olarak alır: km başına yakılan litre, ortalama sefer mesafesi ve yakıt fiyatından m³ başına nakliyeyi çıkarır. Üçünün toplamı gerçek maliyetindir; %0'dan %50'ye altı satış fiyatı bu toplamdan hesaplanır. Standart dört malzemenin yanına kendi hammadde ve gider kalemlerini eklersin, hammadde fiyatını kiloya ya da tona göre girersin.

  Arayüz üç ekrandır: solda ayarlar, ortada veri girişi, sağda sonuç. Aralarında kaydırarak geçersin; menü çubuğu ya da gezinme yoktur, ekranın dibindeki nokta şeridi nerede olduğunu gösterir. Uygulama seçtiğin tema ve kontrastta, açılışta renk sıçraması olmadan açılır. Türkçe ile İngilizce arasında anında geçersin ve girdiğin veriler yerinde kalır. Her değişiklik anında kaydedilir, kaydet düğmesi yoktur.

  Uygulama tamamen çevrimdışıdır, hiçbir izin istemez ve verilerin cihazdan çıkmaz bu yüzden çerçeve ya da hesap sunucusu yoktur.


# --- Screenshots / video strip ----------------------------------
#  EXPLANATION
#  Horizontal media strip at a fixed height (drag / swipe / wheel /
#  arrow keys). Portrait, landscape and mixed sizes all fit - nothing
#  is cropped or resized while scrolling. Each entry is one of:
#    - image:  { src: "/assets/img/<slug>/1.png", alt: "..." }
#    - video:  { youtube: "<11-char id>", alt: "..." }
#  A video shows its YouTube cover image and loads the player only on
#  click; add  poster: "/assets/img/<slug>/x.jpg"  for a local cover.
#
#  e.g.
#    screenshots:
#      - { src: "/assets/img/note-jar/home.png", alt: "Home screen" }
#      - { src: "/assets/img/note-jar/editor.png", alt: "Note editor" }
#      - { youtube: "dQw4w9WgXcQ", alt: "One-minute tour" }
screenshots:
  - { src: "/assets/img/beton-maliyeti-hesaplayici/splash.jpg", alt: "Splash screen" }
  - { src: "/assets/img/beton-maliyeti-hesaplayici/resim0.jpg", alt: "First page" }
  - { src: "/assets/img/beton-maliyeti-hesaplayici/resim2.jpg", alt: "Second page" }
  - { src: "/assets/img/beton-maliyeti-hesaplayici/settings.jpg", alt: "Settings menu" }

# --- Store buttons ------------------------------------------------
#  EXPLANATION
#  The "Get the app" buttons. Known stores get a canonical label:
#  google-play, app-store, microsoft-store. Anything else is a free
#  pair  { label: "...", url: "..." }.
#
#  e.g.
#    store_links:
#      - { store: "google-play", url: "https://play.google.com/store/apps/details?id=com.turkwave.notejar" }
#      - { store: "app-store", url: "https://apps.apple.com/app/id1234567890" }
#      - { label: "Download for Windows", url: "https://turkwave.github.io/note-jar/win" }
store_links: []


# --- Where the app lives ---------------------------------------
#  EXPLANATION
#  "platform" shows under the app name on the site home page.
#  "app_url" is the app's own address: it becomes a "Website" button in
#  the store row, the "Open app" link on every document page, and is
#  shown next to "platform" on the home page.
#
#  e.g.
#    platform: "Android, iOS, Windows"
#    app_url: "https://turkwave.github.io/note-jar/"
platform: "Android"
app_url: ""


# --- Reviews / social proof ----------------------------------
#  EXPLANATION
#  Omit any single piece to hide it; omit all of them to hide the whole
#  Reviews section.
#    rating       { value:, max: (defaults to 5), count: }
#    downloads    free text
#    reviews      list of { author:, rating:, date:, text: }
#    reviews_url  link behind the "Read more reviews" line
#
#  e.g.
#    rating: { value: 4.7, max: 5, count: 312 }
#    downloads: "10,000+"
#    reviews:
#      - author: "A. Yilmaz"
#        rating: 5
#        date: "2026-07-14"
#        text: "Opens instantly and has never lost a note."
#    reviews_url: "https://play.google.com/store/apps/details?id=com.turkwave.notejar&showAllReviews=true"
reviews: []
reviews_url: ""


# --- Price line (header) ----------------------------------
#  EXPLANATION
#  Short price text shown in the header, right under the subtitle.
#  Printed verbatim (no forced "Pricing -" prefix), mid-sized and not
#  muted. Links down to the Pricing section when that section has
#  content; hidden together with it when sections.pricing = off.
#
#  e.g.
#    price_line: "Free - optional Pro unlock"
price_line: "Tek seferlik ödeme - 1000₺"


# --- Pricing (section) ----------------------------------
#  EXPLANATION
#  A Markdown block - the detail behind the header's price line.
#
#  e.g.
#    pricing: |
#      Free to download and use.
#      A one-time **Pro** unlock (US$4.99) adds sync and themes.
pricing: "Google Play Store aracılığı ile yapılıyor tek seferlik ödeme tüm satın alma ve geri ödeme işlemleri Play Store tarafından yapılmaktadır."


# --- FAQ ---------------------------------------------
#  EXPLANATION
#  An ordered list. Two shapes, mix them freely:
#    - { q: "...", a: "..." }   a question (the answer is Markdown)
#    - { title: "..." }         a heading grouping the questions below it
#  Write just the text: the layout prefixes each question with a bold
#  "Q -" and each answer with a bold "A -" - do not type those. Question
#  and answer text render in the same quiet style; only the markers are
#  bold. The first TWO QUESTIONS show directly; the rest - with their
#  headings - fold into a "Read more FAQs" toggle. Headings never count
#  toward that two, so a heading alone can't push a question into the
#  toggle.
#
#  e.g.
#    faq:
#      - title: "Getting started"
#      - q: "Do I need an account?"
#        a: "No. Note Jar works fully offline with no sign-in."
#      - q: "Where are my notes stored?"
#        a: "On your device only, unless you turn on Pro sync."
#      - title: "Billing"
#      - q: "Is the Pro unlock a subscription?"
#        a: "No - it is a one-time purchase."
faq:
- q: "Uygulamayı açtığımda ne görüyorum ve ekranlar arasında nasıl geçiş yapıyorum?"
  a: "Uygulama, Yakıt, Hammadde fiyatları ve Genel Giderler bölümlerinin bulunduğu hesaplama giriş ekranında açılır. Ekranlar arasında yana kaydırarak geçiş yaparsınız. Ayarlar için sola kaydırın. Hesaplama Sonucu ekranı için sağa kaydırın. Her ekranın altındaki küçük noktalardan oluşan sıra, üç ekrandan hangisinde olduğunuzu gösterir ve dişli şeklinde çizilmiş en soldaki nokta Ayarlar'ı belirtir. Menü düğmesi veya gezinme çubuğu yoktur. Android'de geri düğmesi sizi giriş ekranına döndürür ve orada tekrar basılması uygulamayı kapatır."
- q: "Yakıt, malzeme ve genel gider rakamlarını nereye giriyorum?"
  a: "Her şey uygulamanın açıldığı hesaplama giriş ekranına girilir. Ekranda yukarıdan aşağıya sıralanmış üç bölüm vardır ve bunlara ulaşmak için dikey olarak kaydırırsınız. Yakıt bölümünde yakıt fiyatı, kilometre cinsinden mesafe, litre/kilometre oranı ve kendiliğinden doldurulan litre/metreküp değeri bulunur. Hammadde fiyatları bölümünde çimento, agrega, katkı maddesi ve su fiyatlarının yanı sıra eklediğiniz diğer malzemeler bulunur. Genel Giderler bölümünde ise metreküp cinsinden dökülen beton hacmi ile işçilik, genel gider, amortisman ve elektrik gibi maliyet kalemleri bulunur."
- q: "Sonuçlar ve kâr marjı fiyatları nerede?"
  a: "Giriş ekranından Hesaplama Sonucu ekranına sağa kaydırın. Ekranın üst kısmındaki Beton Karışım Oranları bölümü, seçtiğiniz beton sınıfı için çimento, agrega, katkı maddesi ve su maliyetlerini ve betonun toplam maliyetini gösterir. Alt kısmındaki Hesaplama Sonucu bölümü ise mazot maliyetini, beton maliyetini, metreküp başına her genel gider maliyetini ve toplam maliyeti gösterir. Bunun altında, %0'dan %50'ye kadar her kâr marjındaki satış fiyatlarını listeleyen bir tablo bulunur. Bu ekranın altında iki düğme vardır: Raporu Paylaş/Kaydet ve Yedekle / Geri Yükle."
- q: "C20/25 ile C45/55 arasındaki beton sınıfları arasında nasıl geçiş yaparım?"
  a: "Hesaplama Sonucu ekranında, Beton Karışım Oranları bölümü altı sekmeden oluşan bir satırla başlar: C20/25, C25/30, C30/37, C35/45, C40/50 ve C45/55. Sınıfı değiştirmek için bir sekmeye dokunun. Ayrıca bir sınıftan diğerine geçmek için bu bölümün içinde yana doğru kaydırabilirsiniz. Seçilen sekme vurgulanır, kendi miktar alanları gösterilir ve maliyet satırları ile toplamlar anında o sınıfa göre güncellenir. Uygulama en son baktığınız sınıfı hatırlar ve uygulamayı bir sonraki açışınızda tekrar gösterir."
- q: "Ayarlar nerede ve neleri içeriyor?"
  a: "Giriş ekranından Ayarlar'ı açmak için sola kaydırın. Ayarlar, kaydırılabilir tek bir listedir. Dil, uygulamayı Türkçe ve İngilizce arasında değiştirir. Görünüm, temayı Sistem, Açık veya Koyu olarak ayarlar ve yüksek kontrastı Düşük, Normal veya Yüksek olarak belirler. Kâr Marjları, sonuç ekranında kaç kâr marjı satırının görüneceğini kontrol eden bir kaydırıcıya sahiptir. Veriler, Her Şeyi Sıfırla düğmesini içerir. Hakkında bölümü uygulama sürümünü ve GitHub ile Mail düğmelerini gösterir. Ayrıntılar, Kullanım Koşulları, Gizlilik Politikası, Lisans ve Üçüncü Taraf Lisansları metinlerini açar."
- q: "Kullanım Koşulları, Gizlilik Politikası ve lisans metinlerini nerede bulabilirim?"
  a: "Ayarlar'ı açın ve Ayrıntılar grubuna kaydırın. Burada dört satır vardır: Kullanım Koşulları, Gizlilik Politikası, Lisans ve Üçüncü Taraf Lisansları. Bir satıra dokunduğunuzda tam metin ekranın önünde açılan bir pencerede gösterilir. Pencereyi Kapat düğmesiyle, Android geri düğmesiyle veya pencerenin dışına dokunarak kapatabilirsiniz. Kullanım Koşulları, Gizlilik Politikası ve Lisans hem Türkçe hem İngilizce yazılmıştır ve uygulamanın dilini takip eder. Üçüncü Taraf Lisansları metni yalnızca İngilizce gösterilir."
- q: "Bir hesaba veya internet bağlantısına ihtiyacım var mı?"
  a: "Her ikisi için de hayır. Kayıt olma, giriş yapma veya hesap yoktur. Uygulama internete bağlanmaz ve internet izni istemez; bu nedenle tamamen çevrimdışı çalışır ve tüm hesaplamalar cihazınızda yapılır. Bilgiler yalnızca sizin seçiminizle uygulamadan çıkar: Raporu Paylaş/Kaydet düğmesine dokunup raporu göndermek için bir uygulama seçtiğinizde veya GitHub ya da Mail düğmesine dokunduğunuzda; bu düğmeler tarayıcınıza veya e-posta uygulamanıza geçiş yapar."
- q: "Yakıt fiyatı, Kilometre ve litre (L/km) alanları ne işe yarıyor ve \"litre/m³\" alanı nedir?"
  a: "Buraya üç değer girersiniz. Yakıt fiyatı bir litre yakıtın fiyatıdır. Kilometre bir mesafedir. Litre (L/km), her kilometrede kullanılan litre miktarıdır ve başlangıçta 0,15 olarak doldurulur; bunu değiştirebilirsiniz. Uygulama Kilometre değerini L/km oranıyla çarpar ve sonucu litre/m³ alanına yerleştirir. Bu alan sizin tarafınızdan doldurulur ve içine yazılamaz. Daha sonra uygulama bu litre değerini yakıt fiyatıyla çarpar ve sonuç Hesaplama Sonucu ekranında mazot maliyeti olarak görünür ve toplam maliyete eklenir."
- q: "Dört hammadde fiyat alanı ne işe yarıyor?"
  a: "Bunlar dört standart bileşenin birim fiyatlarıdır: çimento ve agrega ton başına, katkı maddesi ve su ise kilogram başına fiyatlandırılır. Her fiyat tek başına herhangi bir işlem yapmaz. Uygulama bunu, görüntülemekte olduğunuz sınıf için Beton Karışım Oranları ekranında o bileşen için girdiğiniz miktarla eşleştirir ve bir maliyet hesaplar. Çimento ve agrega maliyetlerinde, fiyat ton başına olduğu için kilogram cinsindeki miktar 1000'e bölünür. Dört maliyet, Beton Karışım Oranları bölümünde gösterilir ve o sınıfın beton toplamına eklenir."
- q: "Hammaddelerin altında bulunan \"+ Öğe Ekle\" ne işe yarıyor ve kg / ton fiyat birimi ne anlama geliyor?"
  a: "Dört standart malzemeye ek olarak kendi hammaddenizi ekler. Buna dokunun, bir isim yazın ve fiyatının kilogram başına mı yoksa ton başına mı olduğunu seçin. Uygulama daha sonra Hammadde fiyatları bölümüne bunun için bir fiyat alanı ve Beton Karışım Oranları ekranındaki her beton sınıfına bunun için bir miktar alanı ekler. Maliyeti standart malzemelerle aynı şekilde hesaplanır ve o sınıfın beton toplamına eklenir. Seçtiğiniz fiyat birimi sabittir. Kilogram ile ton arasında geçiş yapmak için malzemeyi silip yeniden eklemeniz gerekir; uygulama malzemeyi oluştururken bu uyarıyı gösterir."
- q: "\"Dökülen beton (m³)\" alanı neyi etkiler?"
  a: "Genel gider maliyetlerinin dağıtıldığı toplam beton hacmidir. Uygulama, Genel Giderler bölümündeki her tutarı bu değere böler ve metreküp başına maliyeti bulur; bu metreküp başına tutarlar toplama eklenir. Bu alan boş veya sıfırsa, her genel gider kalemi sıfır olarak kabul edilir ve toplam bunları içermez. Bu alan çimento, agrega, katkı maddesi, su veya mazot değerlerini değiştirmez. Yalnızca genel gider kısmını etkiler."
- q: "Dört genel gider kalemi ve Genel Giderler altındaki \"+ Öğe Ekle\" ne işe yarıyor?"
  a: "Her genel gider kalemi, işçilik, genel gider, amortisman veya elektrik gibi girdiğiniz toplu bir tutardır. Uygulama her birini dökülen beton hacmine böler ve metreküp başına maliyeti hesaplar; bunlar Hesaplama Sonucu ekranında listelenir ve toplama eklenir. + Öğe Ekle kendi genel gider satırınızı oluşturmanızı sağlar: dokunun, bir isim yazın ve ardından tutarı girin. Eklenen öğeler dört standart öğeyle tamamen aynı şekilde çalışır. Her Şeyi Sıfırla'yı kullanırsanız dört standart isim geri gelir, ancak sizin eklediğiniz öğeler geri gelmez."
- q: "Eklediğim bir öğeyi nasıl kaldırırım?"
  a: "Genel Giderler listesinde dört standart öğe de dahil olmak üzere her öğenin tutarının yanında küçük bir ✕ bulunur. Hammadde fiyatlarında ise yalnızca sizin eklediğiniz malzemelerin yanında ✕ bulunur. Çimento, agrega, katkı maddesi ve su fiyat alanları sabittir ve kaldırılamaz. ✕ işaretine dokunduğunuzda satır herhangi bir onay alınmadan hemen kaldırılır. Bir malzemeyi kaldırmak, o malzemenin miktar alanlarını tüm beton sınıflarından da kaldırır. Toplamlar anında güncellenir ve geri alma özelliği yoktur."
- q: "Karışım sayfasındaki Çimento, Agrega, Katkı Maddesi ve Su \"miktar (kg)\" alanları ne işe yarıyor?"
  a: "Her beton sınıfının kendine ait dört miktar alanı vardır: o sınıfın bir metreküpüne giren çimento, agrega, katkı maddesi ve suyun kaç kilogram olduğu. Uygulama bunları kendisi doldurmaz. Her alan başlangıçta boştur ve rakamları kendiniz girersiniz. Uygulama her miktarı Hammadde fiyatları bölümündeki karşılık gelen fiyatla çarpar, o bileşenin maliyetini bulur, bunları toplar ve aynı bölümde sınıfın toplamını gösterir. Sınıf değiştirmek o sınıfa ait kendi miktarlarını gösterir; bunlar ayrı ayrı kaydedildiğinden C20/25 ve C40/50 farklı sayılara sahip olabilir."
- q: "\"Raporu Paylaş/Kaydet\" ne oluşturur ve nereye gider?"
  a: "Ekranda o anda bulunan değerlerden düz metin biçiminde bir rapor oluşturur: görüntülediğiniz sınıfa ait yakıt, malzeme, karışım, genel gider ve sonuç değerlerinin yanı sıra gösterilmesi ayarlanmış kâr marjı satırlarını içerir. Android'de sistem paylaşım ekranını açar; böylece raporu başka bir uygulamaya gönderebilir veya dosya ya da bulut uygulamanız aracılığıyla metin dosyası olarak kaydedebilirsiniz. Dosya concrete-cost-report benzeri bir ad ve geçerli tarih ile adlandırılır. Uygulamanın kendisi bir kopya saklamaz. Paylaşım ekranını herhangi bir şey seçmeden kapatmak hata değildir ve bu durumda hiçbir şey kaydedilmez."
- q: "\"Yedekle / Geri Yükle\" ne işe yarıyor ve \"Yeni Yedekleme\" nedir?"
  a: "Düğme, kaydettiğiniz anlık görüntüleri isim ve tarihleriyle ve on yuvadan kaçının kullanıldığını gösteren bir sayaçla listeleyen Yedeklemeler penceresini açar. Yeni Yedekleme, şu anda girdiğiniz her şeyi altı sınıfın tamamındaki fiyatları, miktarları ve maliyet kalemlerini alır ve cihazda isimlendirilmiş tek bir kayıt olarak saklar. Sizden bir isim istenir ve Backup 1 gibi varsayılan bir isim sunulur. Görünüm ayarlarınız ve kâr marjı kaydırıcısı yedeğin bir parçası değildir. On yuvanın tamamı dolduğunda, listeden birini silene kadar Yeni Yedekleme reddedilir."
- q: "Bir yedeği geri yüklediğimde ne olur?"
  a: "Geri yükleme, şu anda ekranda bulunan her şeyi o yedeğin içeriğiyle değiştirir. Uygulama önce tüm alanları ve öğe listelerini temizler, ardından kaydedilen fiyatları, miktarları ve öğeleri yükler ve C20/25 sınıfına geçer. İşlem gerçekleşmeden önce bir onay kutusu mevcut verilerin değiştirileceğini bildirir. Geri yüklenen veriler mevcut verileriniz olarak da kaydedilir; dolayısıyla uygulamayı bir sonraki açışınızda gördüğünüz veriler bunlar olur. Bu işlem yedeği silmez ve görünüm ayarlarını değiştirmez; ancak önceki ekran girdileriniz başka bir yedek olarak kaydedilmediyse kaybolur."
- q: "Bir yedeği nasıl silerim?"
  a: "Yedekle / Geri Yükle düğmesinden Yedeklemeler penceresini açın. Her yedek satırının yanında bir çöp kutusu simgesi bulunur. Buna dokunun ve açılan kutuda onaylayın. Kutu, silme işleminin geri alınamayacağını belirtir. Yalnızca o yedek kaldırılır. Ekrandaki mevcut girişleriniz ve diğer yedekleriniz olduğu gibi bırakılır. Bir yedeği silmek, on yuvadan birini boşaltır."
- q: "\"Uygulama dili\" ayarı neyi değiştiriyor?"
  a: "Uygulamadaki her etiketi, başlığı, düğmeyi ve mesajı Türkçe ile İngilizce arasında değiştirir ve ekranı hemen günceller. Dört standart maliyet kaleminin adları ve standart malzeme adları da değişir; kendiniz yazdığınız adlar yazdığınız şekilde kalır. Yedeklemeler penceresindeki ve rapordaki tarihler seçilen dili takip eder. Seçim kaydedilir; böylece uygulama bir sonraki açılışta o dilde açılır. Üçüncü Taraf Lisansları metni her iki durumda da İngilizce kalır."
- q: "Tema ve Yüksek kontrast ayarları ne işe yarıyor?"
  a: "İkisi de yalnızca uygulamanın görünümünü değiştirir ve başka hiçbir şeyi değiştirmez. Tema renk şemasını belirler: Sistem, cihazınızın açık veya koyu ayarını takip eder; Açık ve Koyu ise bunu sabitler. Seçim ayrıca ekranın üst kısmındaki durum çubuğunun rengini de belirler. Yüksek kontrast renkleri daha güçlü veya daha yumuşak yapar: Düşük, Normal veya Yüksek. Yalnızca renkleri değiştirir; ayarın kendisinde de belirtildiği gibi metin boyutu ve kalınlığı aynı kalır. Her iki seçim de kaydedilir ve uygulama açıldığı anda, herhangi bir şey çizilmeden önce uygulanır."
- q: "\"Görünen kâr marjları\" kaydırıcısı ne işe yarıyor?"
  a: "Hesaplama Sonucu ekranında gösterilen en yüksek kâr marjını belirler. Ölçek %0 ile %50 arasında altı adımdan oluşur: %0, %10, %20, %30, %40, %50. Bunu %20'ye ayarlarsanız sonuç tablosu %0, %10 ve %20 satırlarını listeler ve geri kalanını gizler. Kârınızı belirlemez veya herhangi bir rakamı değiştirmez. Altı satış fiyatının tamamı her zaman hesaplanır; kaydırıcı yalnızca kaç tanesinin listeleneceğini kontrol eder ve ayrıca ortak rapora hangi satırların gideceğini belirler. Ayar kaydedilir."
- q: "\"Her Şeyi Sıfırla\" ne yapar?"
  a: "Onayladıktan sonra hesaplama verilerini temizler. Girdiğiniz her fiyat ve miktar boşaltılır, özel malzemeler kaldırılır ve genel gider listesi boş değerlerle dört standart öğeye geri döner. Kilometre başına litre alanı 0,15'e ve seçili sınıf C20/25'e geri döner. Önce bir onay kutusu uyarır ve işlem geri alınamaz. Yedeklerinizi silmez ve dil, tema, kontrast veya kâr marjı ayarlarını değiştirmez. Yedekleri de kaldırmak için onları tek tek silin veya uygulamayı kaldırın."
- q: "Verilerim nerede saklanıyor ve herhangi bir şey çevrimiçi gönderiliyor mu?"
  a: "Her şey cihazınızda, uygulamanın kendi yerel depolama alanında kalır. Buna girdiğiniz fiyatlar, miktarlar ve maliyet kalemleri, kaydettiğiniz yedekler ve dil, tema, kontrast ve kâr marjı kaydırıcısı ayarlarınız dahildir; bunların her biri kendi adı altında tutulur. Hiçbir şey bir sunucuya gönderilmez. Uygulama internet bağlantısı kurmaz ve internet izni istemez; bu nedenle hesap, senkronizasyon veya bulut kopyası yoktur. Bilgilerin uygulamadan çıkmasının tek yolları sizin gerçekleştirdiğiniz işlemlerdir: sistem paylaşım ekranı aracılığıyla bir raporu paylaşmak veya kaydetmek ya da GitHub veya Mail düğmesine dokunmak; bunlar tarayıcınızı veya e-posta uygulamanızı sabit bir adreste açar. Cihazınızdaki veriler Android'in kendisi tarafından diğer uygulamalardan ayrı tutulur."
- q: "Verilerim ne zaman kaydediliyor?"
  a: "Otomatik olarak, siz kullandıkça. Bir alanı her değiştirdiğinizde, bir öğe eklediğinizde veya kaldırdığınızda ya da beton sınıfını değiştirdiğinizde uygulama mevcut durumun tamamını hemen yerel depolamaya yazar. Kaydet düğmesi veya onay adımı yoktur. Yedekler ayrıdır: bir yedek yalnızca Yeni Yedekleme'ye dokunduğunuzda yazılır. Ayarlar seçtiğiniz anda kaydedilir. Cihazın depolaması kapalıysa veya doluysa uygulama oturumun geri kalanında çalışmaya devam eder ancak hiçbir şey yazamaz; bu nedenle bu girişler uygulamayı kapattığınızda kaybolur."
- q: "Uygulama beton maliyetini nasıl hesaplıyor?"
  a: "Her metreküp için üç kısmı bir araya getirir. Birincisi karışım maliyetidir: görüntülediğiniz beton sınıfı için çimento, agrega, katkı maddesi, su ve eklediğiniz diğer malzemelerin maliyeti. İkincisi, girdiğiniz yakıt fiyatı, mesafe ve orandan hesaplanan mazot maliyetidir. Üçüncüsü genel gider maliyetidir: Genel Giderler bölümündeki her tutarın dökülen beton hacmine bölünmesiyle metreküp başına hesaplanır. Hesaplama Sonucu ekranında gösterilen toplam, bu üçünün toplanmasıdır. Her değer, girdiğiniz sayılar üzerinde yapılan basit aritmetiktir. Hiçbir şey aranmaz veya varsayılmaz. Bir alan boşsa sıfır olarak kabul edilir ve herhangi bir şeyi değiştirdiğinizde toplam güncellenir. Sonuç bir tahmindir ve yalnızca girdiğiniz değerler kadar iyidir."
- q: "Kâr marjı satış fiyatları nasıl hesaplanıyor?"
  a: "Kâr marjı tablosundaki her satır, toplam maliyete o yüzdelik oranın eklenmesidir. %0 satırı toplam maliyetin kendisidir. %20 satırı toplam maliyetin 1,2 ile çarpılmasıdır ve %50'ye kadar bu şekilde devam eder. Altı satırın tamamı her zaman mevcut toplam üzerinden hesaplanır. Ayarlar'daki kaydırıcı yalnızca kaç tanesinin gösterileceğini belirler; rakamları değiştirmez. Her fiyat toplam maliyetten oluşturulduğundan, hesaplama ekranındaki herhangi bir giriş değiştiği anda fiyat da değişir."
- q: "Oturumlar arasında neler saklanıyor?"
  a: "Neredeyse her şey. Uygulamayı yeniden açtığınızda en son girdiğiniz fiyatlar, miktarlar ve maliyet kalemleri, görüntülediğiniz beton sınıfı, yedekleriniz ve dil, tema, kontrast ve kâr marjı ayarlarınız geri yüklenir. Kaldığınız yerden, hesaplama giriş ekranında başlarsınız. Saklanmayan şeyler, uygulamanın herhangi bir kopyasını tutmaması nedeniyle paylaştığınız veya kaydettiğiniz raporlar ile cihaz depolaması kullanılamaz durumdayken girdiğiniz her şeydir. Bozuk veya okunamayan bir kayıt yükleme sırasında atlanır ve uygulama hata vermek yerine boş alanlarla açılır."
- q: "Yedekler nasıl çalışıyor ve ayarlarım bunların bir parçası mı?"
  a: "Yedek, tek bir andaki hesaplama verilerinizin tam bir kopyasıdır: altı sınıfın tamamındaki her fiyat, miktar ve maliyet kalemi bir isim ve tarih ile kaydedilir. Bunlar cihazda mevcut verilerinizin yanında ancak onlardan ayrı olarak saklanır. En fazla on tane tutabilirsiniz. En yenisi listenin en üstünde gösterilir. Bir yedek oluşturmak ekranda ne olduğunu değiştirmez. Bir yedeği geri yüklemek ekrandakilerin yerine geçer ve mevcut veriniz olur. Ayarlarınız, dil, tema, kontrast ve kâr marjı kaydırıcısı hiçbir zaman yedeğin parçası değildir; bu nedenle eski bir yedeği geri yüklemek uygulamanın görünümünü değiştirmez. Bir yedeği silmek yalnızca o yedeği kaldırır."
- q: "Dışa aktarılan raporda neler bulunuyor?"
  a: "Görüntülemekte olduğunuz beton sınıfı için düz metin biçiminde bir rapordur. Başlık ve geçerli tarih ve saat ile başlar, ardından bölümler halinde şunları listeler: yakıt değerleri; eklediğiniz malzemeler dahil hammadde fiyatları; o sınıfa ait karışım miktarları; karışım maliyetleri ve sınıf toplamı; dökülen hacim ve her genel gider tutarı; metreküp başına hesaplama sonucu, yani mazot maliyeti, beton maliyeti, her genel gider maliyeti ve toplam maliyet; ve gösterilmesi ayarlanmış her kâr marjındaki satış fiyatları. Değerler o andaki ekrandan kopyalandığı için rapor uygulamayla tamamen aynıdır. Boş alanlar tire olarak görünür. Görüntü veya biçimlendirme içermeyen tek bir metin dosyasıdır."
- q: "Kaç yedek veya öğeye sahip olabileceğim konusunda sınırlar var mı?"
  a: "Yedekler on ile sınırlandırılmıştır. On tane olduğunda, birini silene kadar Yeni Yedekleme reddedilir ve kırk karakterden uzun bir yedek adı kısaltılır. Kaç tane maliyet kalemi veya ek malzeme ekleyebileceğiniz konusunda belirlenmiş bir sınır yoktur; eklemeye devam edebilirsiniz. Kâr marjı tablosu %0 ile %50 arasındaki altı adımda sabittir. Girdiğiniz öğe ve malzeme adlarının uzunluğu sınırlı değildir. Her eklenen malzemenin altı beton sınıfının tamamına bir miktar alanı eklediğini unutmayın; bu nedenle uzun bir liste, karışım ekranını daha uzun ve kaydırmayı daha fazla gerektiren hale getirir."
- q: "Uygulamanın cihazımdan neye ihtiyacı var?"
  a: "Çok az şeye. Uygulama hiçbir izin istemez: internet, konum, depolama erişimi veya kişiler yoktur. Tamamen çevrimdışı çalışır. Bir raporu paylaşmak, cihazınızın kendi paylaşım özelliğini ve dosya işlemlerini kullanır; uygulama bunları doğrudan çağırır ve bunun için izin gerekmez. Telefonlarda ekran dikey olarak kilitlidir. Uygulama hiçbir zaman çevrimiçi olmadığından ve tüm verileri kendi depolamasında tuttuğundan Google hesabına veya herhangi bir kuruluma ihtiyaç duymaz. Google Play'den yüklenen bir Android uygulamasıdır."
- q: "Uygulama ücretli mi ve geri ödemeler nasıl ele alınıyor?"
  a: "Uygulamanın kendi Kullanım Koşullarına göre Google Play üzerinden tek seferlik satın alma olarak satılır. Abonelik, otomatik yenileme veya uygulama içi satın alma yoktur. Ödeme ve faturalandırma tamamen Google tarafından gerçekleştirilir. Geliştirici ödeme bilgilerinizi görmez veya saklamaz. Geri ödemeler, o sırada geçerli olan Google Play geri ödeme politikası kapsamında Google tarafından ele alınır ve Kullanım Koşulları zorunlu tüketici haklarınızın etkilenmediğini belirtir. Bunların tamamını Ayarlar > Ayrıntılar > Kullanım Koşulları bölümünden okuyabilirsiniz."
- q: "Fiyatı ne kadar ve nereden alabilirim?"
  a: "Fiyat uygulamanın hiçbir yerinde belirtilmez. Kullanım Koşulları, uygulamanın Google Play üzerinden dağıtıldığını belirtir; dolayısıyla güncel fiyat ve varsa bölgesel farklılıklar Google Play listelemesinde gösterilir. Satın alma, indirme ve güncelleme işlemlerinin tamamı Google Play üzerinden yapılır. Play Store fiyatı daha sonra değişirse Kullanım Koşulları bunun daha önce satın aldığınız bir kopyayı etkilemeyeceğini belirtir."
- q: "\"Litre/m³\" alanına neden değer yazamıyorum?"
  a: "Bu alan sizin tarafınızdan değil, uygulama tarafından doldurulur; bu nedenle kilitlidir. Değeri, üstündeki Kilometre değerinin litre (L/km) oranıyla çarpılmasıyla elde edilir. Bunlardan herhangi birini değiştirdiğinizde bu alan kendiliğinden güncellenir. Etiketi litre/m³ olsa da gösterdiği sayı bu iki girdiden elde edilen toplam litre miktarıdır ve uygulamanın mazot maliyetini bulmak için yakıt fiyatıyla çarptığı litre toplamı budur. Değer yanlış görünüyorsa Kilometre veya L/km oranını düzeltin."
- q: "Uygulamayı İngilizceye geçirdikten sonra sayılar neden hâlâ ondalık için virgül kullanıyor?"
  a: "Sayı biçimi dile göre değişmez. Hangi dili seçerseniz seçin uygulama sayıları Türkçe biçiminde yazar ve bekler: binlik ayırıcı için nokta ve ondalık için virgül kullanılır; yani bir buçuk 1,5 ve bin 1.000 şeklindedir. Bu, girdiğiniz her miktar ve gösterilen her sonuç için geçerlidir. İngilizceye geçmek kelimeleri, tarih biçimini ve yüzde işaretinin konumunu değiştirir, ancak sayıların nasıl yazıldığını değiştirmez. Ondalık değerlerden önce virgül kullanarak rakamlarınızı girin."
- q: "Bir hammaddenin fiyat birimini (kg veya ton) ekledikten sonra değiştirebilir miyim?"
  a: "Hayır. Malzemeyi oluşturduğunuzda kilogram veya ton seçimini bir kez yaparsınız ve sonrasında bunu düzenlemenin bir yolu yoktur. Uygulama, malzemeyi eklediğiniz anda bu uyarıyı gösterir. Birimi değiştirmek için o malzemeyi silin ve diğer birimle yeniden ekleyin. Silmek, her beton sınıfında bunun için girdiğiniz miktarları da temizler; dolayısıyla bunları tekrar girmeniz gerekir. Fiyat alanının etiketi mevcut birimi gösterir; örneğin Kireç fiyatı (TL/ton), böylece hangisinin ayarlı olduğunu kontrol edebilirsiniz."
- q: "\"Raporu Paylaş/Kaydet\" raporun bir kopyasını uygulama içinde saklıyor mu?"
  a: "Hayır. Düğme raporu her seferinde mevcut ekrandan yeniden oluşturur ve cihazınızın paylaşım ekranına gönderir. Buradaki Kaydet ifadesi, dosyayı bu paylaşım ekranı aracılığıyla dosyalarınıza veya bir bulut uygulamasına kaydedebileceğiniz anlamına gelir; uygulamanın kendi arşivini tuttuğu anlamına gelmez. Uygulamada geçmiş raporların listesi veya yeniden açılabilecek bir rapor yoktur. Bir kopya istiyorsanız paylaşım ekranı göründüğünde kaydedin veya gönderin. Bu ekranı hiçbir şey seçmeden kapatmak yalnızca işlemi iptal eder; dosya yazılmaz ve hata oluşmaz."
- q: "Girdiğim verileri veya yedeklerimi ne zaman kaybedebilirim?"
  a: "Verileriniz ve yedekleriniz yalnızca bu cihazda ve yalnızca bu uygulamada bulunur. Google'ın bulut yedeklemesine dahil edilmez ve yeni bir telefon kurduğunuzda aktarılmaz; her ikisi de özellikle kapatılmıştır. Uygulamayı kaldırırsanız veya sistemdeki Verileri temizle seçeneğini kullanırsanız her şeyi kaybedersiniz. Her Şeyi Sıfırla, girdiğiniz verileri siler ancak yedekleri korur. Cihaz kaybolur, bozulur veya silinirse başka hiçbir yerde kopya bulunmaz. Ayrıca cihaz depolaması kapalıysa veya doluysa yeni girişler yalnızca uygulamayı kapatana kadar kalır. Bir şeyi uygulama dışında güvende tutmak için rapor olarak paylaşın veya kaydedin."
- q: "Geliştiriciyle nasıl iletişime geçerim veya bir sorunu nasıl bildiririm?"
  a: "Ayarlar'ı açın, Hakkında grubuna gidin ve Mail'e dokunun. Bu, geliştiricinin adresine yeni bir mesaj içeren e-posta uygulamanızı açar. Kullanım Koşulları ve Gizlilik Politikası, veri talepleri de dahil olmak üzere sorular için bu kanalı gösterir; Gizlilik Politikası bu taleplerin yaklaşık on beş gün içinde ve en geç otuz gün içinde yanıtlandığını belirtir. Uygulamada destek formu veya sohbet yoktur. Cihazınızda e-postayı işleyebilecek hiçbir şey yoksa uygulama herhangi bir şey açmak yerine kısa bir bildirim gösterir."
- q: "GitHub düğmesi ne yapıyor?"
  a: "Tarayıcınızda github.com üzerindeki geliştirici sayfasını açar. Yaptığı tek şey budur. Burası hata bildirmek veya yanıt almak için bir yer değil, kişisel bir sayfadır; bu nedenle yanıtlanması gereken herhangi bir konu için bunun yerine Mail düğmesini kullanın. Cihazınızda bağlantıyı açacak bir tarayıcı yoksa uygulama kısa bir bildirim gösterir."
- q: "Uygulama içinde yardım veya yerleşik bir SSS var mı?"
  a: "Hayır. Uygulamada yardım ekranı, öğretici veya yerleşik SSS yoktur. İçindeki tek açıklayıcı metin, Ayarlar > Ayrıntılar altındaki Kullanım Koşulları ve Gizlilik Politikası ile bazı ayarların yanında bulunan kısa açıklamalardır. Diğer her şey için Ayarlar > Hakkında altındaki Mail düğmesini kullanın."



# --- Contact links -------------------------------
#  EXPLANATION
#  Rows of the "Contact" section, shown just above Copyright. Each row is
#  a  { label:, url: }  pair: "url" is the target, "label" the visible
#  text (defaults to the url). A "url" with no scheme but an "@" is
#  treated as an email and gets a  mailto:  prefix. Empty list
#  ( contact_links: [] ) falls back to the site-wide contact_email as a
#  single mailto. Hide the whole section with  contact: off  above.
#
#  e.g.
#    contact_links:
#      - { label: "E-posta", url: "Turk191906@outlook.com" }
#      - { label: "GitHub", url: "https://github.com/TurkWave" }
contact_links: []


# --- Copyright line -------------------------------
#  EXPLANATION
#  Rights holder for the in-frame copyright line. Left empty it falls
#  back to  "(c) <current year> TurkWave. All rights reserved."
#
#  e.g.
#    copyright: "(c) 2026 TurkWave. Built in Istanbul."
copyright: "© 2026 HybridHabit. All rights reserved."


# --- Redirects (leave out for a new app) --------
#  EXPLANATION
#  Only when this app used to live at a different URL and you want the
#  old one to keep working (jekyll-redirect-from). A brand-new app has
#  no old URL, so this key is normally absent entirely.
#
#  e.g.
#    redirect_from:
#      - /apps/note-jar/
---

{% comment %}
This body is not used and is NOT rendered on the page. The meta description
is the `description` key above; put real content in the front-matter keys,
not here.
{% endcomment %}
