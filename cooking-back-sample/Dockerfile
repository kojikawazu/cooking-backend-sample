# PHP 8.1の公式イメージをベースとする
FROM php:8.1-fpm

# 作業ディレクトリを設定
WORKDIR /var/www/html

# Laravelの要件に必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    zip \
    unzip \
    curl \
    git \
    vim \
    postgresql-client \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerをインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Laravelアプリケーションのソースコードをコンテナにコピー
COPY . /var/www/html

# Composerを使ってPHP依存関係をインストール
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Laravelのストレージとキャッシュディレクトリの権限を設定
RUN chown -R www-data:www-data /var/www/html/storage \
    && chmod -R 775 /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/bootstrap/cache

# DBマイグレーション
RUN php artisan migrate; \
    # キャッシュの削除
    php artisan cache:clear; \
    # キャッシュの再生成
    php artisan config:cache

# コンテナがリッスンするポートを指定
EXPOSE 8000

# 開発サーバーの起動コマンド
CMD php artisan cache:clear; \
    php artisan config:cache; \
    php artisan serve --host=0.0.0.0 --port=8000