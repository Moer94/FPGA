Kit number: 
> 5CSEMA5F31C6

Switches on the back should look like **[THIS](https://drive.google.com/file/d/1lKUxznqdU5AkAaFCIW5_UOV_Fr8vCqHY/view?usp=sharing)** .


**Entity description** 
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
:punch: __Conventions for this lecture__:
> Entity Name: __e_<entity_name>__  
> Top Level Entity: e_my_<entity_name>  
> Only one Entity per VHDL file  
  
  
**Architecture description**
```vhdl
architecture <arch_name> of <entity_name> is
--Declarations (optional)
begin
--Assignments, Processes, …
end architecture <arch_name>;
```

:punch: __Conventions for this lecture__:
> Architecture will be named a_<entity_name>[_x] where _x is used if more than one description exists  
> Possibly more than __one__ architecture per VHDL file  

**Configuration description**
```vhdl
configuration <config_name> of <entity_name> is
for <arch_name> end for;
end configuration <config_name>;
```
  
:punch: __Conventions for this lecture__:
> Configuration will be named c_<entity_name>  





