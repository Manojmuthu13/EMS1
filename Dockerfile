FROM manoj3214/mytomcat:latest
LABEL maintainer="manoj"
ADD ./target/*.war /usr/local/tomcat/webapps/
EXPOSE 8090
CMD ["catalina.sh", "run"]
