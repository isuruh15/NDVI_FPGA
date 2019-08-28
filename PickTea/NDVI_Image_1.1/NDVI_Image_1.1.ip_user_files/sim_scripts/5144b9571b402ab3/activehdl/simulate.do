onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+5144b9571b402ab3 -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.5144b9571b402ab3 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {5144b9571b402ab3.udo}

run -all

endsim

quit -force
