onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ae42681bb9521dbf_opt

do {wave.do}

view wave
view structure
view signals

do {ae42681bb9521dbf.udo}

run -all

quit -force
