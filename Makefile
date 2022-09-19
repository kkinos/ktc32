TESTDIRS=test board/arty_s7/test

.PHONY: all $(TESTDIRS)
all: $(TESTDIRS)

$(TESTDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: clean $(TESTDIRS)
clean: $(TESTDIRS)
