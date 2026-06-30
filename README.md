# layers

layers are read-only snapshots of the file system.

any instaraction in the dokerfile that edits in the file system automaticaly generates a new layer

```ini
 ------------------------------------------------------------------------------------ 
| FROM <base_image_name>  -->           [file_B, file_C, file_D]     <-- layer       |
| COPY ./fileA .          -->  [file_A]                              <-- layer       | 
| RUN  rm /fileB          -->           [file_B]                     <-- layer       |
| RUN  echo /file_D                                     [file_D]     <-- layer       |
| CMD ["bash"]            -->                                        <-- metadata    |
 ------------------------------------------------------------------------------------
| final image                  [file_A,          file_C, file_D]                     |
 ------------------------------------------------------------------------------------
```

each layer contains the diffirential data from previous layer (snapshot)


## layers and docker

each generated layer docker will give it a 64bit hash base 16
that makes each layer unique so docker can use the same layer if needed

example 

- image_1
```ini
    FROM alpine:3.23.4          <- sha256:123abcd... #unique
    RUN apk install maraiadb    <- sha256:65ca76i... #unique
```
- image_2
```ini
    FROM alpine:3.23.4          <- sha256:123abcd... #existed
    RUN apk install nginx       <- sha256:aaf886i... #unique
```

after building `image_1` we will end with two unique layers (`sha256:23abcd...` and `sha256:65ca76i...`).

and docker will register them localy.

now when building `image_2` layer one will be already built it, and docker will just use the existig one, and build the second layer only (`sha256:aaf886i...`).

at the end if we look at docker register
we will see that he has three layers

`sha256:123abcd`
`sha256:65ca76i`
`sha256:aaf886i`





