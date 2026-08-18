FROM nginx:alpine
COPY dist/frontend1/browser /usr/share/nginx/html
EXPOSE 80
