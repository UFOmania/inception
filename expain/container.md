


the event horizon


this is the structure of an app deployed inside of a vm.
 ------ ------ ------
| app  | app  | app  |
 ------ ------ ------
| deps | deps | deps |
 ------ ------ ------
|  OS  |  OS  |  OS  |
 --------------------
|         HW         |
 --------------------

what is OS: operating system
- user mode: is what the user user to interact with the machine (login, desktop,...)
- kernal mode: is what talks with the hardware

what is HW: hardware
is the physial hardware in the host machine

imagine running muiltiple vm of our app,
you will notice the OS will be duplicated,
we will have waised resourses.

so the idea is how to use one OS (kernal mode only) to save resources.

-> user the already existing OS (kernal) in the host operating machine

 ------ ------ ------
| app  | app  | app  |
 ------ ------ ------
| deps | deps | deps |
 ------ ------ ------
|         OS         |
 --------------------
|         HW         |
 --------------------



--------------------------------------------------------------------------


<title>



- the concept behind containers is to user Hosts kernal and add some user mode specifications if needed, then on top install deps the main service . just like layers.

- this is container image - aka image - and works just like vm-template

ex:
     ---------------------------------------
    | app                 ->  main service  |
    | deps                ->  runtime       |
    | user specifications ->  bash          |
    | kernal              ->  from the host |
     ---------------------------------------

- the container image is the `overlay`
    what layers? 
        a layer is any change (add, delete, edit) from the layer benith.
        ex:
            add D                   -> layer4
            Edit B                  -> layer3       
            delete A                -> layer2                   
            create file A, B, C     -> layer1                
        final result      B', C, D  -> image




-----------------------------------------------------------

# how the container can be isolated ?

- cgroups:  monitor and assign resources (ram, cpu, network, file system, ...) to a process and its children.

- name spaces:  monitor and control the hierarchy of process and deal with it as one isolated unit.

 -----------------------------  ------------------------------
|    proc1 -> proc2           ||    proc6 -> proc7            |
|         |                   ||         |                    |
|         -> proc3 -> proc3   ||         -> proc8 -> proc9    |
 -----------------------------  ------------------------------

# containers life purpose 
keep the main process -pid 1- alive
main process die, container dies with it












