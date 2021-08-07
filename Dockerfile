FROM php:alpine


RUN apk add --no-cache gcc g++ make autoconf git subversion libzip-dev  zip \
    # Instal PHP AST extension
    && git clone https://github.com/nikic/php-ast.git \
    && cd php-ast \
    && phpize \
    && ./configure \
    && make install \
    && echo 'extension=ast.so' >/usr/local/etc/php/php.ini \
    && cd .. \
    && rm -rf php-ast \
    # Remove unneeded packages
    && apk del gcc g++ make autoconf \
    # ZLib
    && docker-php-ext-install zip \
    # Composer & phan
    && apk add --no-cache composer && composer global require phan/phan

# Add composer binaries to path
ENV PATH=$PATH:/root/.composer/vendor/bin


CMD ["phan", "--progress-bar"]
