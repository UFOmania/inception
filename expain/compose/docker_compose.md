what is compose?
is a tool allows you to define and run muiltiple containers with a single command

```ini
docker compose up
```

mariadb example :
```ini
    services:           # this holds our containers
        mariadb:        # service name 
            container_name: mariadb  # compose by default gives a generec name to the container, but here we spesify a name 
            build: requirements/mariadb/.  # if you have a custom image tell compose where to find Dockerfile do build it
            image: mariadb:mariadb # specify the image name and tag do run the container
            
            networks: # connect this container to 'myNet' custom network
                -   myNet
            volumes: # maps a volume to a path inside of the container
                -   mariadb_vol:/var/lib/mysql

            environment: # this creates env variables inside of the container, in this case creates DB_NAME and assign ${DB_NAME} from .env
                -   DB_NAME=${DB_NAME}
                -   DB_USER=${DB_USER}
            secrets: # insert secret tiles to the container '/run/secrets/<my_secret>'
                -   DB_USER_PASS

    networks: # creates a network
        myNet:

    volumes: 
        mariadb_vol: # here you create volumes
            driver: local # here specefy where to find the volume is it local or from another server
            driver_opts: 
                type: none # ?
                device: /home/massrayb/data/mariadb # volume location on host
                o: bind # ?

    secrets: # create secrets
    DB_USER_PASS: # secret name
        file: ../secrect/BD_USER_PASSWORD # secret path on host
```


what does it do ?
    - build images by calling there disagnated dockerconfig
    ```ini
        docker compose build
    ```

    - run containers
    ```ini
        docker compose up
    ```

manual commands to what compose do


    - build images
    ```ini
        docker build -t image_1 .
        docker build -t image_2 .
        docker build -t image_3 .
    ```
    - run containers
    ```ini
        docker run --name service_1 image_1
        docker run --name service_2 image_2
        docker run --name service_3 image_3
    ```

    - create volumes
    ```ini
        docker volume create <vol_name>
        docker run -v vol_name:mount_point_in_container
    ```

    - create networks
    ```ini
        docker networks create <net_name>
        docker run --network net_name
    ```

    - map ports
    ```ini
        docker run -p 8080:80  #host:container
    ```

    - manage secrets
    ```ini
        docker build --secret id=NAME,src=PATH .
    ```

    - assign env
    ```ini
        docker run -e ENV_NAME=VALUE
    ```


