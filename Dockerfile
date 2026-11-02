FROM nginx:alpine

# Copie de la page d'accueil par defaut
COPY index.html /usr/share/nginx/html/index.html
COPY index.html /var/www/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
