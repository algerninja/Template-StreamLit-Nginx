# Streamlit + Nginx Template

This project aims to facilitate the configuration of Nginx and Streamlit for deployment to Production using Docker on a VPS and also has the addition of being able to test the domain locally to test the connection to the domains.

## Configuration for a single app

### First step

Develop your StreamLit application as seen in `apps/streamlitApp1` with its dockerfile and its respective configuration.

### Second step

Let's go to the file located in the following location apps/streamlitApp1/.streamlit/config.toml

and add the domain that we will use as the following example

```bash
[browser]
serverAddress = “miaplicacion.local” # Change for the domain you will use
gatherUsageStats = false
```

Already having this configuration we are only going to add and verify the domain that we will use in the application for that we are going to go to the following file ./nginx.conf

```bash
server {

    listen 80; # Listen on port 80
    server_name miaplicacion.local; # Change this for your local domain

    location / {
        proxy_pass http://streamlit:8501; # verify that the name 'streamlit' is the same as the service docker-compose.yml:4
        ... more configuration
    }
    ... more configuration
}
```

### Third Step

Now we just add the domain to our /etc/hosts

for that we execute as sudo the file add_host.sh as the following example

```bash
sudo ./add_host.sh 127.0.0.1 miaplicacion.local
```

### Fourth step

Para finalizar solo ejecutamos el docker compose y accedemos al dominio que configuramos en este caso accedemos a miaplicacion.local

## Configuration for two or more apps

### First step

Develop your StreamLit applications as seen in `apps/streamlitApp1` and `apps/streamlitApp1` with their respective dockerfile and configuration.

### Second step

We go to the file located at the following location `apps/streamlitApp1/.streamlit/config.toml` and `apps/streamlitApp2/.streamlit/config.toml`
and add the domain that we will use as the following example

```apps/streamlitApp1/.streamlit/config.toml
[browser]
serverAddress = “miaplicacion.local” # Change to the domain we will use
gatherUsageStats = false
```

```apps/streamlitApp2/.streamlit/config.toml
[browser]
serverAddress = “miaplicacion2.local” # Change to the domain we will use
gatherUsageStats = false
```

Already having this configuration we are only going to uncomment our service from the ./docker-compose.yml:10

when we finish configuring the docker-compose.yml we only need to add and verify the domain that we will use in the applications for that we are going to go to the following file ./nginx.conf

```bash
server {

    listen 80; # Listen on port 80
    server_name miaplicacion.local; # Change this to your local domain

    location / {
        proxy_pass http://streamlit:8501; # verify that the name 'streamlit' is the same as the service docker-compose.yml:4
        ... more configuration
    }
    ... more configuration
}
```

and uncomment what is after this line in ./nginx.conf:45 and verify that the server_name is the correct domain and that proxy_pass contains the same name as the docker-compose service example.

```./nginx.conf:45
server {

    listen 80; # listen on port 80
    server_name miaplicacion2.local; # Change this to your local domain

    location / {
        proxy_pass http://streamlit2:8501; # verify that the name 'streamlit' is the same as the service docker-compose.yml:10
        ... more configuration
    }
    ... more configuration
}
```

### Third Step

Now we only have to add the domain to our `/etc/hosts`

for this we execute as sudo the file add_host.sh as the following example

```bash
sudo ./add_host.sh 127.0.0.1 miaplicacion.local
sudo ./add_host.sh 127.0.0.1 miaplicacion2.local
```

### Fourth step

To finish we just run the docker compose and access the domain we configured in this case we access miaplicacion.local and miaplicacion2.local

## Deployment

To deploy this project run

```bash
  docker compose up --build -d
```

and access <http://miaplicacion.local> or <http://miaplicacion2.local>

## Authors

- [@algerninja](https://github.com/algerninja)
