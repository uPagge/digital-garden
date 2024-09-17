---
tags:
  - maturity/🌱
date: 2023-11-20
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents: 
linked:
---
> [!DANGER]
> Так лучше не делать, но иногда нужно проигнорировать ошибки связанные с сертификатом сайта.

```java
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

/**
 * @author upagge 03.02.2021
 */
@Slf4j
@UtilityClass
public class OkHttpUtil {

    private static OkHttpClient client = new OkHttpClient.Builder().build();

    public static OkHttpClient getClient() {
        return client;
    }
    
    public static void init(boolean ignoreCertificate) {
        OkHttpClient.Builder builder = new OkHttpClient.Builder();
        log.info("Initialising httpUtil with default configuration");
        if (ignoreCertificate) {
            builder = configureToIgnoreCertificate(builder);
        }
        //Other application specific configuration

        client = builder.build();
    }

    //Setting testMode configuration. If set as testMode, the connection will skip certification check
    private static OkHttpClient.Builder configureToIgnoreCertificate(OkHttpClient.Builder builder) {
        log.warn("Ignore Ssl Certificate");
        try {

            // Create a trust manager that does not validate certificate chains
            final TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        @Override
                        public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) {
                        }
                        @Override
                        public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) {
                        }

                        @Override
                        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                            return new java.security.cert.X509Certificate[]{};
                        }
                    }
            };

            final SSLContext sslContext = SSLContext.getInstance("SSL");
            sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
            final SSLSocketFactory sslSocketFactory = sslContext.getSocketFactory();

            builder.sslSocketFactory(sslSocketFactory, (X509TrustManager) trustAllCerts[0]);
            builder.hostnameVerifier((hostname, session) -> true);
        } catch (Exception e) {
            log.warn("Exception while configuring IgnoreSslCertificate" + e, e);
        }
        return builder;
    }

}
```
## Как это использовать?
Перед получением `OkHttpClient` необходимо инициализировать настройки игнорирования сертификатов. Для этого вызываем метод:

```java
OkHttpUtil.init(true);
```

После этого можете получить `OkHttpClient`:
```java
OkHttpUtil.getClient();
```

Или вот так:
```java
public class HttpParse {

    static {
        OkHttpUtil.init(true);
    }

    private static final OkHttpClient client = OkHttpUtil.getClient();

    // ... ... ... ... ...

}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-11-20]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
