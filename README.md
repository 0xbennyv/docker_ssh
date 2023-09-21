# docker_ssh
I needed SSH access into an AWS ECS Fargate Service, so my quick simple solution was to drop an image into the cluster and SSH into it. 

### Instructions
Change line 19 in the docker file from my github to your source of public key.
curl  -L  https://github.com/0xBennyV.keys  -o  /home/bennyv/.ssh/authorized_keys  &&  \

Build the container:
```bash
docker build -t docker-ssh .
```
Run the container:
```bash
docker run -d -p 2222:22 ubuntu-ssh
```
SSH to the container:
```bash
ssh -p 2222 ubuntu@localhost
```
