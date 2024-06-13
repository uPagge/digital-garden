---
tags:
  - зрелость/🌱
date: "2023-09-04"
linked:
---
Этот сервер позволяет

```yaml
noteshare-migrate:
    image: upagge/noteshare-migrations:latest
    networks:
      note-share:
    volumes:
      - ./noteshare/database:/database/
    environment:
      - DATABASE_URL=file:/database/db.sqlite

# Backend server for managing saved notes 
  noteshare-backend:
    image: upagge/noteshare-backend:latest
    restart: always
    hostname: noteshare-backend
    container_name: noteshare-backend
    networks:
      note-share:
    volumes:
      - ./noteshare/database:/database/
    environment:
      - DATABASE_URL=file:/database/db.sqlite
      - FRONTEND_URL=https://notes.struchkov.dev
      - CLEANUP_INTERVAL_SECONDS=600
      - NODE_ENV=production
      # Rate limit for uploading notes
      - POST_LIMIT_WINDOW_SECONDS=86400
      - POST_LIMIT=50
      # Rate limit for downloading notes
      - GET_LIMIT_WINDOW_SECONDS=60
      - GET_LIMIT=20
    depends_on:
      - noteshare-migrate

  noteshare-frontend:
    image: upagge/noteshare-frontend:latest
    restart: always
    hostname: noteshare-frontend
    container_name: noteshare-frontend
    networks:
      note-share:
    environment:
      - NODE_ENV=production
    depends_on:
      - noteshare-backend
```

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name notes.struchkov.dev;

    location ~ /.well-known/acme-challenge {
            allow all;
            root /temp;
    }

    location / {
        return 301 https://notes.struchkov.dev$request_uri;
    }
}

#server {
#    server_name www.struchkov.dev;
#    return 301 $scheme://struchkov.dev$request_uri;
#}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name notes.struchkov.dev;

    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header Referrer-Policy "no-referrer";
    add_header Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()";
    add_header X-Content-Type-Options "nosniff"; 
    add_header X-Frame-Options "sameorigin";
    add_header X-Xss-Protection "1; mode=block";
    proxy_hide_header X-Powered-By;

    ssl_certificate /etc/letsencrypt/live/struchkov.dev/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/struchkov.dev/privkey.pem;
    ssl_buffer_size 4k;
    ssl_dhparam /etc/nginx/ssl/dhparam-notes.pem;
    ssl_protocols SSLv3 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_ecdh_curve secp384r1;

    ssl_stapling on;
    ssl_stapling_verify on;

    ssl_session_cache shared:SSL:5m;
    ssl_session_timeout 24h;
    ssl_session_tickets off;

    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  X-Forwarded-Proto   $scheme;
        proxy_connect_timeout                 90;
        proxy_send_timeout                    90;
        proxy_read_timeout                    90;

        proxy_cache nginxcash;
        proxy_cache_valid 1d;
        proxy_cache_valid 404 1h;
        proxy_cache_revalidate on;
        proxy_buffering on;
        proxy_cache_background_update on;
        proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
        proxy_cache_min_uses 2;

        client_body_buffer_size               128k;

        proxy_pass http://noteshare-frontend:3000;
    }

    location = /api/note {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  X-Forwarded-Proto   $scheme;
        proxy_connect_timeout                 90;
        proxy_send_timeout                    90;
        proxy_read_timeout                    90;

        proxy_cache nginxcash;
        proxy_cache_valid 1d;
        proxy_cache_valid 404 1h;
        proxy_cache_revalidate on;
        proxy_buffering on;
        proxy_cache_background_update on;
        proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
        proxy_cache_min_uses 2;

        client_body_buffer_size               128k;

        limit_except GET POST DELETE {
            deny all;
        }

        proxy_pass http://noteshare-backend:8080/api/note;
    }

}
```