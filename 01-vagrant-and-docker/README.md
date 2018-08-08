01-vagrant-and-docker
=====================

Yêu cầu
-------

* Virtualbox 5.2 (https://www.virtualbox.org/wiki/Downloads)
* Vagrant 2.1.2 (https://www.vagrantup.com/downloads.html)

Các bước thực hiện
------------------

```
cd 01-vagrant-and-docker
vagrant up # Khởi động máy ảo

vagrant ssh # Vào shell của máy ảo (Unbutu)
cd /vagrant/01-vagrant-and-docker/scripts/dev  # vào shared folder của Vagrant
./services-up.sh  # Chạy các sub-system (hiện tại: MongoDB 3.6)
```

Cụ thể hơn:
* vagrant up: Mở hoặc tạo máy ảo (dev machine) dựa vào thông tin của Vagrantfile

  [01](https://i.imgur.com/I95eobL.png)

* Vagrant sẽ pull image Ubuntu 16.04 (ubuntu/xenial64) về và cài đặt máy Ubuntu đó giúp chúng ta trên nền một máy ảo của Virtualbox.
* Vagrant chạy script vagrant-provision.sh để cài thêm Docker vào máy Ubuntu
* Ta vagrant ssh để vào shell của Ubuntu.

  [02](https://i.imgur.com/RqxOe19.png)

* cd /vagrant/01-vagrant-and-docker/scripts/dev và chạy lệnh ./services-up.sh
  để nó gọi docker-compose up 

  [03](https://i.imgur.com/tTSe1W0.png)

  Chú ý:Dùng Docker Compose cho phép liệt kê các service cần cho việc chỉ trong 1 file duy nhất docker-compose.yml thay vì phải chạy docker-run mongodb, docker run mysql... nhiều lần để start cho đủ các service.

Nội dung
--------

Giả tử ta cần một xây dựng một môi trường dev, cụ thể hơn là dựng môt máy server dev (gọi là dev machine) cài đặt các thứ cần thiết cung cấp cho quá trình phát triển.

* Một môi trường dev có 1 sub-system là MongoDB 3.6 (cần cho việc phát triển backend).
  
  * Môi trường này là Ubuntu 16.04 được chạy trên một máy ảo của Virtualbox được tạo nhanh bằng Vagrant.
  * MongoDB được cài vào máy ảo này dưới dạng Docker thay vì cài trực tiếp.

Một số ý chính:

* Vagrantfile:   
  
  * Chỉ định địa chỉ IP cho máy ảo Vagrant (host ip của dev machine)

    ```
    config.vm.network "private_network", ip: "172.16.1.71"
    ```

* vagrant-provision.sh

  Đây là shell script phụ, chạy nó để cài Docker lúc khởi động (vagrant up) lần đầu.

* Sử dụng Docker Compose để khởi động các sub-system, các service (sub-system) được định nghĩa trong docker-compose.yml

  ```
  version: "2"
  services:
  mongo:
    image: mongo:3.6
    ports:
      - "27017:27017"
    volumes:
      - mongodb-data:/data/db"
    restart: always
  volumes:
    mongodb-data:

  Ví dụ như trong file docker-compose.yml hiện tại tạo 1 service có tên là *mongo*, sử dụng base image mongo:3.6 (được lưu trên Docker Hub), sau đó chỉ định để thông port qua "27017:27017" cũng như một số thiết lập khác.

  Chạy script services-up.sh: script này sẽ gọi lệnh docker-compose up để chạy các service đã được nghĩa trong docker-compose.yml lên!
  ```

* Chức năng shared folder của Vagrant

  Tại thư mục chứa Vagrantfile, toàn bộ nội dung của nó được share giữa máy host và máy ảo Vagrant này. Để kiếm chứng, cd tại thư mục chứa Vagrantfile (01-vagrant-and-docker) trong cmd, gõ 
  
  ```
  vagrant ssh  # Vào shell của Ubuntu

  cd /vagrant # 
  ls # Sẽ thấy toàn bộ nội dung của thư mục 01-vagrant-and-docker vì nó đang share với máy host ở ngoài, ngoài máy dev chính (host) thay đổi file gì thì bên trong máy dev ảo này cũng thấy (2 chiều)!
  
  ```

