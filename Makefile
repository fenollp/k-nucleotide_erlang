ERL ?= erl
ERLC ?= erlc
K = knucleotide

all: $(K).beam

knucleotide.beam: $(K).erl
	$(ERLC) +native +'{hipe, [o3]}' $^

test: all
	time $(ERL) -smp enable -noshell -run $(K) main 0 <$(K)-input0.txt 2>&1 \
	  | tee $(K)-input0-$(shell hostname -f).txt
	git --no-pager diff -- $(K)-input0-*.txt
	[ '0' = "$$(git status --porcelain -- $(K)-input0-*.txt)" ]
