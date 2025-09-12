FROM nginx:alpine
COPY /dist/ng-app/browser /usr/share/nginx/html
EXPOSE 80
