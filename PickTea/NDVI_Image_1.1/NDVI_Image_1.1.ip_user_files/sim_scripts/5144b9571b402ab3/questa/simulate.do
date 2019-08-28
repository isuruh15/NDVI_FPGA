onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib 5144b9571b402ab3_opt

do {wave.do}

view wave
view structure
view signals

do {5144b9571b402ab3.udo}

run -all

quit -force
