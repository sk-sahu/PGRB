# A basic docker guide

Docker is a tool which helps you create light weight **containers**, which are portable.

You can think a container as a Computer system where all you tools are installed and ready to use.

The logic to make a container can be write in a **Dockerfile**

An example Dockerfile

```docker
FROM ubuntu:19.10

RUN apt-get update
RUN apt-get install -y fastqc 
```

Built the docker image

```bash
cd docker
docker build -t fastqc:latest .
```

Run the docker container

```bash
docker run --rm fastqc:latest fastqc --help
```

You should see the `fastqc` help menu