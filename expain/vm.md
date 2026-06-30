virtual machine

- uses Virtualization technology to Virtualize the hardware 
ex:
    real hardware : 10Core CPU, 100GB RAM
    virtualzation: [2Core, 30GB] [4Core, 50GB] [4Core, 20GB]

- that's possible bcs of the Hypervisor
it's a software that sets on top of the phsical hardware and create muiltiple virtual hardware - aka virtualization -.
it works like a translation layer to talk with the real hardware.

|-------|-------|------|
|2Core  |4Core  |4Core |
|30GB   |50GB   |20GB  |
| ..... | ..... | .... |
|  vm1  |  vm2  |  vm3 |
-----------------------
|      Hypervisor      |
-----------------------
|       HARDWARE       |
|   CPU         RAM    |
|  10Core      100GB   |
|______________________|

- now each virtual machine have its own `esolated` hardware to work with (cpu, ram ,rom ,network , OS, ...)

- next deploy your 1M $ app (backend, database, frontend,...) inside of the virtual machines , and you will become the new Gabe Newell.

- surprise surprise VM TAX :
virtual machine tax are the waisted resurses to run the vm.
like what? 
each vm is like a bare empty hardware ,
it cannot run your application directly,
it needs an operating system.
the os it self need a dependencies to run, so more resurses are gonna be waisted.
it also needs the kernal to comiunicate with the hardware (virtual hardware).

 ----------  ----------  ---------- 
|app : 12GB||app : 12GB||app : 12GB|
|os  : 4GB ||os  : 4GB ||os  : 4GB | => 12GB waised on os
 ----------  ----------  ---------- 
|vm  16GB  ||vm  16GB  ||vm  16GB  |
 ----------  ----------  ---------- 
|            HYPERVISOR            |
 ----------------------------------
|         Hardware 128GB           |
 ----------------------------------

your buisness got scaled and suddenly you now need to run a 100 vm (backend, databases, ...), the VM tax will be soo hard on your wallet. 

ALSO each OS may need a license and maintenance.

- what is a VM template ?
to deploy an application in a vm you need first to configure the vm config (ssh, firewall, ...), then install the app's dependencies.
to run from do it for each vm.
you make a vm that's well configured and make it as a `template`.
`template = configured vm + application dependencies`.

- how to VM template works?

for example we have a the base image:
    
    contains the os and basic configuration as a template => 20 GB

    to use this template we can make a full copy (20 GB) then work with it. 
    but there is a best way.

    don't make a copy
    use differential copy which will contains only the changes you made on the base image; => 1 GB
    benifits: 
        smaller in size.
        easy to fall back in case of a miss.
    
    BASE TEMPLATE => 10GB
    |
     -->  differential copy 1 => 1 GB
          |
           --> differential copy 2 => 200 MB