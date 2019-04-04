## Kit number
> **5CSEMA5F31C6**


## Switches on back
<p align="center">
    <img src="https://i.imgur.com/z9PxFfZ.png">
</p>


## Entity description
```vhdl
entity <entity_name> is
port (
<name>: in <type>;
<name>: in <type> := <default_value>;
<name>: out <type>;
<name>: out <type>
);
end entity <entity_name>;
```
  
## :punch: **Entity** Conventions for this lecture:  

> Entity Name: **e_<entity_name>**  
> Top Level Entity: **e_my_<entity_name>**  
> Only **ONE** Entity per VHDL file  
  
  
  
## Architecture description
```vhdl
architecture <arch_name> of <entity_name> is
--Declarations (optional)
begin
--Assignments, Processes, …
end architecture <arch_name>;
```
  
## :punch: Conventions for this lecture 
> Architecture will be named **a_<entity_name>[_x]** where _x is used if more than one description exists  
> Possibly more than **ONE** architecture per VHDL file  
  
  
  
##Configuration description
```vhdl
configuration <config_name> of <entity_name> is
for <arch_name> end for;
end configuration <config_name>;
```
  
## :punch: Conventions for this lecture
> Configuration will be named **c_<entity_name>**  
  
  
## Signals
`signal <sig_name>: <type> [:= <default_value>];`  
`std_logic_vector(0 to 7)` **OR** `std_logic_vector(7 downto0)`
  
## :punch: Convention for this lecture
> **sl_<sig_name>** for type std_logic  
> **slv_<sig_name>** for std_logic_vector  
> **b_<sig_name>** for bit  
> **bv_<sig_name>** for bit_vector  
> **B_<sig_name>** for Boolean  




