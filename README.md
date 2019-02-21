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
$ sudo ./setup.sh  
````  

3) Add gpg key and Add apt-source-list ( You can use ./setup.sh for setup !!)  
````  
$ sudo ./setup.sh  
````  

4) Install Backend.AI moduls which you want to use  
````  
$ sudo apt install backend.ai-client  
$ sudo apt install backend.ai-manager  
$ sudo apt install backend.ai-agent  
````  
