#!/bin/bash

echo "Copying html"
\cp -R html/* tomcat/webapps/ROOT
echo "Copying tags"
\cp config/tags/* tomcat/webapps/ROOT/WEB-INF/tags/
echo "Copying jarfile"
\cp invasion.jar tomcat/webapps/ROOT/WEB-INF/lib/
echo "Copying templates"
\cp -R config/templates/* tomcat/webapps/ROOT/WEB-INF/templates/
