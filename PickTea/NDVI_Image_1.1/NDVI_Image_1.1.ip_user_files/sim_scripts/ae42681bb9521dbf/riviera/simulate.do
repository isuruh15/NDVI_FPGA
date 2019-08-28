onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ae42681bb9521dbf -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ae42681bb9521dbf xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ae42681bb9521dbf.udo}

run -all

endsim

quit -force
