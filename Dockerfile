FROM alpine/git
COPY rlambert3.com /rlambert3.com
WORKDIR /rlambert3.com
RUN rm -rf themes/*
RUN git clone https://github.com/aerohub/hugo-orbit-theme.git themes/hugo-orbit-theme

FROM skyscrapers/hugo:0.46
COPY --from=0 /rlambert3.com /rlambert3.com
WORKDIR /rlambert3.com
RUN hugo

FROM mysocialobservations/docker-tdewolff-minify
COPY --from=1 /rlambert3.com/public /rlambert3.com/public
WORKDIR /rlambert3.com
RUN minify --recursive --verbose \
        --match=\.*.js$ \
        --type=js \
        --output public/ \
        public/

RUN minify --recursive --verbose \
        --match=\.*.css$ \
        --type=css \
        --output public/ \
        public/

RUN minify --recursive --verbose \
        --match=\.*.html$ \
        --type=html \
        --output public/ \
        public/

FROM nginx:alpine
COPY --from=2 /rlambert3.com/public /usr/share/nginx/html