IVERILOG=iverilog
GTKWAVE=gtkwave

.PHONY: run
run:
	iverilog -o simv -g2012 *sv
	./simv
