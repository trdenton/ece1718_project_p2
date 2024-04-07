IVERILOG=iverilog
GTKWAVE=gtkwave

.PHONY: run
run:
	iverilog -g2012 *sv -o simv
	./simv
	gtkwave out.vcd
