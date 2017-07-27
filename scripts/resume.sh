#!/usr/bin/env fish
while true; 
    sleep .5; 
    and nmcli c u US_East; 
    and break; 
end
