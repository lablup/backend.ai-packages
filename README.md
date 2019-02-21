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
