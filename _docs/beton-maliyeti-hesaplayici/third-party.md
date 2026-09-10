---
title: Third-Party Licenses
effective_date: 2026-09-10
last_updated: 2026-09-10
---

# Third-Party Licenses / Üçüncü Taraf Lisansları

Beton Maliyeti Hesaplayıcı (`com.betonmaliyeti.hesaplayici`) uygulamasının kendisi
tescillidir (bkz. `README.md`). Aşağıdaki üçüncü taraf bileşenler kendi
lisansları altında dağıtılır ve bu lisansların telif/izin bildirimleri
uygulamayla birlikte dağıtılmak zorundadır.

The application itself is proprietary (see `README.md`). The third-party
components listed below are distributed under their own licenses; their
copyright and permission notices are reproduced here in full as those
licenses require.

## Kullanılan bileşenler / Components

| Paket | Sürüm | Lisans | Kapsam |
|---|---|---|---|
| `@capacitor/core` | 7.6.8 | MIT | Uygulamayla dağıtılır (APK/AAB) |
| `@capacitor/android` | 7.6.8 | MIT | Uygulamayla dağıtılır (APK/AAB) |
| `@capacitor/filesystem` | 7.1.8 | MIT | Uygulamayla dağıtılır (APK/AAB) |
| `@capacitor/share` | 7.0.4 | MIT | Uygulamayla dağıtılır (APK/AAB) |
| `@capacitor/synapse` | 1.0.4 | MIT (paket LICENSE.md); `package.json` alanı `ISC` | Uygulamayla dağıtılır (`@capacitor/filesystem` bağımlılığı) |
| `@capacitor/cli` | 7.6.8 | MIT | Yalnızca geliştirme aracı (`devDependencies`), uygulamayla dağıtılmaz |

Not: `@capacitor/synapse@1.0.4` paketinin `package.json` dosyası lisansı `ISC`
olarak beyan ederken, paketin içinde gönderilen `LICENSE.md` dosyası MIT
lisans metnini içerir. Her iki bildirim de aşağıda olduğu gibi kaydedilmiştir;
paketle birlikte gelen gerçek metin MIT'tir ve aşağıda birebir verilmiştir.

---

## @capacitor/core, @capacitor/android, @capacitor/cli (7.6.8)

```
MIT License

Copyright (c) 2017-present Drifty Co.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## @capacitor/filesystem (7.1.8) ve @capacitor/synapse (1.0.4)

```
MIT License

Copyright (c) 2025 Ionic

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## @capacitor/share (7.0.4)

```
Copyright 2020-present Ionic
https://ionic.io

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
