FROM jojomi/hugo:latest AS makesite
COPY modmappings /src
RUN /usr/local/sbin/hugo --source /src -D -d /tmp/output/ -v

FROM nginx:latest
COPY --from=makesite /tmp/output/ /usr/share/nginx/html/

