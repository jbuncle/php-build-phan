FROM php:alpine


RUN apk add --no-cache gcc g++ make autoconf git \
    && git clone https://github.com/nikic/php-ast.git \
    && cd php-ast \
    && phpize \
    && ./configure \
    && make install \
    && echo 'extension=ast.so' >/usr/local/etc/php/php.ini \
    && cd .. \
    && rm -rf php-ast \
    && apk del gcc g++ make autoconf git

    
RUN apk add  --no-cache composer && composer global require phan/phan
ENV PATH=$PATH:/root/.composer/vendor/bin


CMD ["phan", "--progress-bar"]