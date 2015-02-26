# Health Trigger Script
Trigger a windower script based on the targets health percentage. By using scripts, 
the addon can issue multiple commands to the game with a simple and easy to use syntax. 

### Liscense
This addon uses the BSD liscense so that it may eventually be included in Windower's addons repository. 

### Requirements
This addon uses the Windower-Lua API so you'll need a working copy of Windower installed on your computer. 
In addition, the script you want to run must be in HST's directory and not in Windower's script directory. 

### Loading the addon
To load the addon use the command `//lua load hst`. 

### Using the addon

Runs the script `script-name` once when the target's health reaches `health-level`.
```
hst health-level [script-name] [run-once]
```

Runs the script `default.txt` once when the target's health reaches 10 percent. 
```
hst 10
```

Runs the script `myscript.txt` once when the target's health reaches 10 percent. 
```
hst 10 myscript.txt
```

Runs the script `myscript.txt` as long as the target's health is 10 percent or below. 
```
hst 10 myscript.txt false
```
