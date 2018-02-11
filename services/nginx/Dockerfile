FROM nginx

RUN rm -v /etc/nginx/conf.d/default.conf
# Append "daemon off;" to the beginning of the configuration
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# ADD flask.conf /etc/nginx/conf.d/
ADD sinatra.conf /etc/nginx/conf.d/

# Expose Ports
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
