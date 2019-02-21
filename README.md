# Backend.AI SDK Packages for ubuntu 18.04  
  
------------------------------------  
## How to Install Backend.AI SDK ?
  
1) clone git repository to your local  
````  
$ sudo git clone https://github.com/lablup/backend.ai-packages.git /app/backend.ai   
````  

2) If git-lfs does not exist, install git-lfs. ( You can use ./git-lfs_install.sh for install git-lfs !!)  
````  
$ cd /app/backend.ai  
$ sudo ./git-lfs_install.sh
````  

3) If you want to install backend.AI for agent, you should use git-lfs for download docker images   
````  
$ sudo git lfs install  
$ sudo git lfs pull  
````  

4) Add gpg key and Add apt-source-list ( You can use ./setup.sh for setup !!)  
````  
$ sudo ./setup.sh  
````  

5) Install Backend.AI moduls which you want to use  
````  
$ sudo apt install backend.ai-client  
$ sudo apt install backend.ai-manager  
$ sudo apt install backend.ai-agent  
```` 

## How to Test Backend.AI in my own local PC ?  

1) Setting DB, Etcd by using script for developer  

````  
$ cd /app/backend.ai/dev
$ sudo ./install_backend.ai_dev.sh
````  

2) Run your Backend.AI manager  
````   
$ PATH=$PATH:/app/backend.ai/dev/utils
$ run-with-halfstack.sh python3 -m ai.backend.gateway.server --service-port=8081 --debug  
````  

3) Open other terminal and make virtual folder and run your Backend.AI agent  
````  
$ mkdir scratches
$ sudo run-with-halfstack.sh python3 -m ai.backend.agent.server --scratch-root=`pwd`/scratches --debug --idle-timeout 30   
````  

4) Add API Key pairs to use Backend.AI !!
````  
export BACKEND_ENDPOINT=http://127.0.0.1:8081/  
export BACKEND_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE  
export BACKEND_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY  
````  

5) Use Backend.AI !!
````  
$ backend.ai run lablup/python:3.6-ubuntu18.04 -c 'print("hello")'
````  
