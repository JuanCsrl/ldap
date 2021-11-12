# LDAP
LDAP lab:
###### O que é?
Um ambiente de testes LDAP.

###### Como subir?
Após clonar esse repositorio, digite o seguinte comando no seu termianal:
```
sudo ./deploy
```
> Esse comando ira subir o container em que é rodado o LDAP server.

Espere o conatiner subir, e rode o comando:
```
sudo docker ps
```
> Esse comando mostra quais conatiners estão rodando na sua maquina

Pegue o ID ou no Name do container que você precisa acessar:
>imagem

Use o comando:
```
sudo docker exec -it cointainer_id ou container_name /bin/sh
```
> com esse comando sera possivel acessar o container

Dentro do container, execute o script `init.sh` e defina a senha do admin do ldap:
```
./init.sh
``` 
>image

Agora podemos mexer os arquivos `ldif` usados para a configuração do servidor, são os unicos arquivos em que será feita alguma modificação. 
> É preciso ter um conhecimento previo de como funciona o editor vi

Use o comando:
```
vi db.ldif
```
No arquivo `db.ldif` configuramos o user administrador do ldap:
>image
No campo `olcRootPW` (linha 14) subistitua o valor `hash` pela a senha de admin, configurada anteriormente.
>image
para salvar user as altereções:
aperte `esc`, depois apete `:`, aperte `w` e por fim `q`

>Obs edite quaisquer valores que façam sentido para o seu cenario, bem como o arquivo monitor.ldif, caso você tenha alterado o nome do user admin.

Agora iremos adicinar as mudanças feitas ao nosso servidor ldap:
```
ldapmodify -H ldapi:/// -f db.ldif
ldapmodify -H ldapi:/// -f monitor.ldif
```
Agora iremos configurar o banco de dados do ldap e importar os schemas:
```
./databse.sh
```
Por fim iremos criar as estrutura da arvore do diretorio, para isso basta editar o arquivo `base.ldif`
>É preciso ter um conhecimento prevido sobre ldap

Agora iremos aplicar o arquvi `base.ldif` ao nosso servidor:
```
ldapadd -x -W -D "cn=admin,dc=caragua,dc=com" -f base.ldif
```
> Ira pedir a senha de admin que você configurou no incio

Agora iremos testar nosso servidor:
```
ldapsearch -x cn=juan -b dc=caragua,dc=com
```
>Realizamos a busca pelo user juan, com base eu seu CN
>image