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
:punch:__Conventions for this lecture__:
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


