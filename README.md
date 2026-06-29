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


