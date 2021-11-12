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
![image](https://user-images.githubusercontent.com/32464161/141482774-473b4e0c-21e8-4562-8958-0b5e167316df.png)

Use o comando:
```
sudo docker exec -it cointainer_id ou container_name /bin/sh
```
> com esse comando sera possivel acessar o container

Dentro do container, execute o script `init.sh` e defina a senha do admin do ldap:
```
./init.sh
``` 
![image](https://user-images.githubusercontent.com/32464161/141483034-5782af2d-1ca2-43c6-bf7b-1b080138004a.png)


Agora podemos mexer os arquivos `ldif` usados para a configuração do servidor, são os unicos arquivos em que será feita alguma modificação. 
> É preciso ter um conhecimento previo de como funciona o editor vi

Use o comando:
```
vi db.ldif
```
No arquivo `db.ldif` configuramos o user administrador do ldap:
![image](https://user-images.githubusercontent.com/32464161/141483123-3271d71e-9833-4b1e-803f-0f5cef92face.png) 


No campo `olcRootPW` (linha 14) subistitua o valor `hash` pela a senha de admin, configurada anteriormente.
![image](https://user-images.githubusercontent.com/32464161/141483224-5132869e-c1ff-403c-a538-e8c067631e19.png)

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
