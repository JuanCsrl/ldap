cd /usr/share/openldap-servers
cp DB_CONFIG.example /var/lib/ldap/DB_CONFIG
cd /var/lib/ldap/ 
chown ldap:ldap DB_CONFIG
echo "Database criado"
cd /etc/openldap/schema/
ldapadd -H ldapi:/// -f cosine.ldif
ldapadd -H ldapi:/// -f inetorgperson.ldif
ldapadd -H ldapi:/// -f nis.ldif
echo "schemas importadados"
