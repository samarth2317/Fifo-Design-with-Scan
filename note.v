
FIFO_NOSCAN FILE FIFO WITHOUT SCAN

CODE- fifo.v
TESTBENCH- tb.v

TO GENERATE REPORTS:
1-  vcs +v2k fifo.v tb,v
2-  ./simv
3-  dc_shell -f synthesis.script | tee synres.txt







FSCAN HAS FIFO WITH SCAN

CODE- fscan.v
TESTBENCH- tb.v

TO GENERATE REPORTS:
1-  vcs +v2k fscan.v tb,v
2-  ./simv
3-  dc_shell -f synthesis.script | tee synres.txt
